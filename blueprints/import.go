package blueprints

import (
	"database/sql"
	"io"
	"time"

	"github.com/lflux/eve-sdeloader/statements"
	"github.com/lflux/eve-sdeloader/utils"
	"github.com/pkg/errors"
)

type ActivityID int

const (
	ManufacturingID    ActivityID = 1
	ResearchTimeID     ActivityID = 3
	ResearchMaterialID ActivityID = 4
	CopyingID          ActivityID = 5
	InventionID        ActivityID = 8
	ReactionID         ActivityID = 11
)

type Activity interface {
	GetTime() int64
	ActivityID() ActivityID
}

type ProductionActivity interface {
	Activity
	GetMaterials() []Material
	GetProducts() []Material
	GetSkills() []Skill
}

type Skill struct {
	Level  int64
	TypeID int64 `yaml:"typeID"`
}

type Material struct {
	Probability *float64
	Quantity    int64
	TypeID      int64 `yaml:"typeID"`
}

type Activities struct {
	Copying          *Copying
	Invention        *Invention
	Manufacturing    *Manufacturing
	Reaction         *Reaction
	ResearchMaterial *ResearchMaterial `yaml:"research_material"`
	ResearchTime     *ResearchTime     `yaml:"research_time"`
}

type Blueprint struct {
	Activities         Activities
	TypeID             int64 `yaml:"blueprintTypeID"`
	MaxProductionLimit int64 `yaml:"maxProductionLimit"`
}

var (
	stmts     = make(map[string]*statements.Statement, 0)
	stmtFuncs = map[string]statements.StatementGenerator{
		"insertBlueprints":            statements.InsertIndustryBlueprintsStmt,
		"insertIndustryActivities":    statements.InsertIndustryActivitiesStmt,
		"insertActivityMaterials":     statements.InsertActivityMaterialsStmt,
		"insertActivityProbabilities": statements.InsertActivityProbabilitiesStmt,
		"insertActivityProducts":      statements.InsertActivityProductsStmt,
		"insertActivitySkills":        statements.InsertActivitySkillsStmt,
	}
)

func insertIndustryActivity(entryID string, a Activity) error {
	_, err := stmts["insertIndustryActivities"].Stmt.Exec(entryID, a.ActivityID(), a.GetTime())
	return err
}

func insertProductionActivity(entryID string, a ProductionActivity) error {
	var err error
	for _, material := range a.GetMaterials() {
		_, err = stmts["insertActivityMaterials"].Stmt.Exec(entryID, a.ActivityID(), material.TypeID, material.Quantity)
		if err != nil {
			return err
		}
	}

	for _, product := range a.GetProducts() {
		_, err = stmts["insertActivityProducts"].Stmt.Exec(entryID, a.ActivityID(), product.TypeID, product.Quantity)
		if err != nil {
			return err
		}
		if product.Probability != nil {
			_, err = stmts["insertActivityProbabilities"].Stmt.Exec(entryID, a.ActivityID(), product.TypeID, *product.Probability)
		}
	}

	for _, skill := range a.GetSkills() {
		_, err = stmts["insertActivitySkills"].Stmt.Exec(entryID, a.ActivityID(), skill.TypeID, skill.Level)
		if err != nil {
			return err
		}
	}

	return nil
}

func Import(db *sql.DB, r io.Reader) error {
	defer utils.TimeTrack(time.Now(), "blueprints")

	entries := make(map[string]*Blueprint)

	err := utils.LoadFromReader(r, entries)
	if err != nil {
		return err
	}

	err = statements.Prepare(db, stmtFuncs, stmts)
	if err != nil {
		return err
	}

	for entryID, entry := range entries {
		_, err = stmts["insertBlueprints"].Stmt.Exec(entryID, entry.MaxProductionLimit)
		if err != nil {
			return errors.Wrap(err, "blueprints: error inserting blueprint")
		}

		a := entry.Activities
		if a.Copying != nil {
			err = insertIndustryActivity(entryID, a.Copying)
			if err != nil {
				return errors.Wrap(err, "blueprints: error inserting industry activity")
			}
		}

		if a.ResearchMaterial != nil {
			err = insertIndustryActivity(entryID, a.ResearchMaterial)
			if err != nil {
				return err
			}
		}

		if a.ResearchTime != nil {
			err = insertIndustryActivity(entryID, a.ResearchTime)
			if err != nil {
				return err
			}
		}

		if a.Invention != nil {
			err = insertIndustryActivity(entryID, a.Invention)
			if err != nil {
				return err
			}

			err = insertProductionActivity(entryID, a.Invention)
			if err != nil {
				return err
			}
		}

		if a.Manufacturing != nil {
			err = insertIndustryActivity(entryID, a.Manufacturing)
			if err != nil {
				return err
			}

			err = insertProductionActivity(entryID, a.Manufacturing)
			if err != nil {
				return err
			}
		}

		if a.Reaction != nil {
			err = insertIndustryActivity(entryID, a.Reaction)
			if err != nil {
				return err
			}

			err = insertProductionActivity(entryID, a.Reaction)
			if err != nil {
				return err
			}
		}
	}

	return statements.Finalize(stmts)
}

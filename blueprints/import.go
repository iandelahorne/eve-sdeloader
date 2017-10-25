package blueprints

import (
	"database/sql"
	"io"

	"github.com/lflux/eve-sdeloader/statements"
	"github.com/lflux/eve-sdeloader/utils"
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

func insertIndustryActivity(entryID string, a Activity) error {
	_, err := insertIndustryActivities.Exec(entryID, a.ActivityID(), a.GetTime())
	return err
}

func insertProductionActivity(entryID string, a ProductionActivity) error {
	var err error
	for _, material := range a.GetMaterials() {
		_, err = insertActivityMaterials.Exec(entryID, a.ActivityID(), material.TypeID, material.Quantity)
		if err != nil {
			return err
		}
	}

	for _, product := range a.GetProducts() {
		_, err = insertActivityProducts.Exec(entryID, a.ActivityID(), product.TypeID, product.Quantity)
		if err != nil {
			return err
		}
		if product.Probability != nil {
			_, err = insertActivityProbabilities.Exec(entryID, a.ActivityID(), product.TypeID, *product.Probability)
		}
	}

	for _, skill := range a.GetSkills() {
		_, err = insertActivitySkills.Exec(entryID, a.ActivityID(), skill.TypeID, skill.Level)
		if err != nil {
			return err
		}
	}

	return nil
}

var (
	insertActivityProducts      *sql.Stmt
	insertIndustryActivities    *sql.Stmt
	insertActivityMaterials     *sql.Stmt
	insertActivityProbabilities *sql.Stmt
	insertActivitySkills        *sql.Stmt
	insertBlueprints            *sql.Stmt
)

func prepareStatements(tx *sql.Tx) error {
	var err error
	insertBlueprints, err = statements.InsertIndustryBlueprintsStmt(tx)
	if err != nil {
		return err
	}

	insertIndustryActivities, err = statements.InsertIndustryActivitiesStmt(tx)
	if err != nil {
		return err
	}

	insertActivityMaterials, err = statements.InsertActivityMaterialsStmt(tx)
	if err != nil {
		return err
	}

	insertActivityProbabilities, err = statements.InsertActivityProbabilitiesStmt(tx)
	if err != nil {
		return err
	}

	insertActivityProducts, err = statements.InsertActivityProductsStmt(tx)
	if err != nil {
		return err
	}

	insertActivitySkills, err = statements.InsertActivitySkillsStmt(tx)

	return err
}

func Import(db *sql.DB, r io.Reader) error {
	entries := make(map[string]*Blueprint)

	err := utils.LoadFromReader(r, entries)
	if err != nil {
		return err
	}

	tx, err := db.Begin()
	if err != nil {
		return err
	}

	err = prepareStatements(tx)
	if err != nil {
		return err
	}

	for entryID, entry := range entries {
		_, err = insertBlueprints.Exec(entryID, entry.MaxProductionLimit)
		if err != nil {
			return err
		}

		a := entry.Activities
		if a.Copying != nil {
			err = insertIndustryActivity(entryID, a.Copying)
			if err != nil {
				return err
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

	return tx.Commit()
}

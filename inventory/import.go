package inventory

import (
	"database/sql"
	"io"
	"sort"
	"time"

	"github.com/lflux/eve-sdeloader/statements"
	"github.com/lflux/eve-sdeloader/utils"
)

type int64arr []int64

func (a int64arr) Len() int {
	return len(a)
}

func (a int64arr) Swap(i, j int) {
	a[i], a[j] = a[j], a[i]
}

func (a int64arr) Less(i, j int) bool {
	return a[i] < a[j]
}

var (
	TypeIDs map[int64]*Type
)

var (
	stmts     = make(map[string]*statements.Statement, 0)
	stmtFuncs = map[string]statements.StatementGenerator{
		"invType":      statements.InsertInvTypeStatement,
		"certMastery":  statements.InsertCertMasteryStatement,
		"translations": statements.CopyTrnTranslationsStmt,
	}
)

func InsertBonuses(stmt *sql.Stmt, typeID, skillID int64, bonuses []Bonus) error {
	for _, bonus := range bonuses {
		var traitID int
		err := stmt.QueryRow(typeID,
			skillID,
			bonus.Amount,
			bonus.UnitID,
			bonus.BonusText["en"]).Scan(&traitID)
		if err != nil {
			return err
		}

		for lang, val := range bonus.BonusText {
			_, err = stmts["translations"].Stmt.Exec(1002, traitID, lang, val)
			if err != nil {
				return err
			}
		}
	}
	return nil
}

// Import imports from a reader containing typeID YAML to the table `invtypes`
func Import(db *sql.DB, r io.Reader) error {
	defer utils.TimeTrack(time.Now(), "inventory")
	entries := make(map[int64]*Type)

	err := utils.LoadFromReader(r, entries)
	if err != nil {
		return err
	}
	TypeIDs = entries

	tx, err := db.Begin()
	if err != nil {
		return err
	}

	traitStmt, err := statements.InsertTraitStatement(tx)
	if err != nil {
		return err
	}

	err = statements.Prepare(db, stmtFuncs, stmts)
	if err != nil {
		return err
	}

	keys := make(int64arr, 0, len(entries))
	for typeID := range entries {
		keys = append(keys, typeID)
	}

	// This sorting is to make the insert order closer to the python loader
	sort.Sort(keys)
	for _, typeID := range keys {
		entry := entries[typeID]
		vals := []interface{}{
			typeID,
			entry.GroupID,
			entry.Name["en"],
			entry.Description["en"],
			entry.Mass,
			entry.Volume,
			entry.Capacity,
			entry.PortionSize,
			entry.RaceID,
			entry.BasePrice,
			entry.Published,
			entry.MarketGroupID,
			entry.GraphicID,
			entry.IconID,
			entry.SoundID,
		}
		_, err = stmts["invType"].Stmt.Exec(vals...)
		if err != nil {
			return err
		}

		for level, masteries := range entry.Masteries {
			for _, certID := range masteries {
				_, err = stmts["certMastery"].Stmt.Exec(typeID, level, certID)
				if err != nil {
					return err
				}
			}
		}

		if entry.Traits != nil {
			skills := make(int64arr, 0, len(entry.Traits.Types))
			for skill := range entry.Traits.Types {
				skills = append(skills, skill)
			}
			sort.Sort(skills)
			for _, skill := range skills {
				typeBonus := entry.Traits.Types[skill]
				err = InsertBonuses(traitStmt, typeID, skill, typeBonus)
				if err != nil {
					return err
				}
			}
			err = InsertBonuses(traitStmt, typeID, -1, entry.Traits.RoleBonuses)
			if err != nil {
				return err
			}
		}

		if len(entry.Name) > 0 {
			for lang, val := range entry.Name {
				_, err = stmts["translations"].Stmt.Exec(8, typeID, lang, val)
				if err != nil {
					return err
				}
			}
		}

		if len(entry.Description) > 0 {
			for lang, val := range entry.Description {
				_, err = stmts["translations"].Stmt.Exec(33, typeID, lang, val)
			}
			if err != nil {
				return err
			}
		}
	}

	err = traitStmt.Close()
	if err != nil {
		return err
	}
	err = tx.Commit()
	if err != nil {
		return err
	}

	return statements.Finalize(stmts)
}

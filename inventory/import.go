package inventory

import (
	"database/sql"
	"fmt"
	"io"
	"strings"

	"github.com/lflux/eve-sdeloader/utils"
)

var (
	invCols = []string{
		"typeid",
		"groupid",
		"typename",
		"description",
		"mass",
		"capacity",
		"portionsize",
		"raceid",
		"published",
		"marketgroupid",
		"graphicid",
		"iconid",
		"soundid",
	}
)

func InsertBonuses(stmt *sql.Stmt, typeID string, skillID int64, bonuses []Bonus) error {
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
	}
	return nil
}

func InsertInvTypeStatement(tx *sql.Tx) (*sql.Stmt, error) {
	// TODO investigate if we can perform multiple CopyIn in the same transaction
	// return txn.Prepare(pq.CopyIn("invtypes", invCols...))

	return tx.Prepare(fmt.Sprintf(`INSERT INTO invtypes (%s) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13)`,
		strings.Join(invCols, ",")))
}

func InsertCertMasteryStatement(tx *sql.Tx) (*sql.Stmt, error) {
	return tx.Prepare(`INSERT INTO certmasteries (typeid, masterylevel, certid) VALUES ($1, $2, $3)`)
}

func InsertTraitStatement(tx *sql.Tx) (*sql.Stmt, error) {
	return tx.Prepare(`INSERT INTO invtraits (typeid, skillid, bonus, unitid, bonustext) VALUES ($1, $2, $3, $4, $5) RETURNING traitid`)
}

// Import imports from a reader containing typeID YAML to the table `invtypes`
func Import(db *sql.DB, r io.Reader) error {
	entries := make(map[string]*Type)

	err := utils.LoadFromReader(r, entries)
	if err != nil {
		return err
	}

	txn, err := db.Begin()
	if err != nil {
		return err
	}

	invStmt, err := InsertInvTypeStatement(txn)
	if err != nil {
		return err
	}

	// mastStmt, err := txn2.Prepare(pq.CopyIn("certmasteries", "typeid", "masterylevel", "certid"))
	mastStmt, err := InsertCertMasteryStatement(txn)
	if err != nil {
		return err
	}

	traitStmt, err := InsertTraitStatement(txn)
	if err != nil {
		return err
	}

	for typeID, entry := range entries {
		vals := []interface{}{
			typeID,
			entry.GroupID,
			entry.Name["en"],
			entry.Description["en"],
			entry.Mass,
			entry.Capacity,
			entry.PortionSize,
			entry.RaceID,
			entry.Published,
			entry.MarketGroupID,
			entry.GraphicID,
			entry.IconID,
			entry.SoundID,
		}
		_, err = invStmt.Exec(vals...)
		if err != nil {
			return err
		}

		for level, masteries := range entry.Masteries {
			for _, certID := range masteries {
				_, err = mastStmt.Exec(typeID, level, certID)
				if err != nil {
					return err
				}
			}
		}

		if entry.Traits != nil {
			for skill, typeBonus := range entry.Traits.Types {
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
	}

	err = invStmt.Close()
	if err != nil {
		return err
	}
	err = mastStmt.Close()
	if err != nil {
		return err
	}
	err = traitStmt.Close()
	if err != nil {
		return err
	}

	return txn.Commit()
}

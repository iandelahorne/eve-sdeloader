package inventory

import (
	"database/sql"
	"fmt"
	"io"
	"io/ioutil"
	"os"
	"strings"

	"github.com/mitchellh/mapstructure"
	yaml "gopkg.in/yaml.v2"
)

func insertBonuses(stmt *sql.Stmt, typeID string, skillID int64, bonuses []map[string]interface{}) error {
	for _, bonus := range bonuses {
		var decodedBonus Bonus
		err := mapstructure.Decode(bonus, &decodedBonus)
		if err != nil {
			return err
		}
		var traitID int
		err = stmt.QueryRow(typeID,
			skillID,
			decodedBonus.Amount,
			decodedBonus.UnitID,
			decodedBonus.BonusText["en"]).Scan(&traitID)
		if err != nil {
			return err
		}
	}
	return nil
}

// ImportFile imports a file at path to the table `invtypes`
func ImportFile(db *sql.DB, path string) error {
	f, err := os.Open(path)

	if err != nil {
		return err
	}
	defer func() {
		_ = f.Close()
	}()

	return Import(db, f)
}

func loadFromReader(r io.Reader) (map[string]*Type, error) {
	buf, err := ioutil.ReadAll(r)
	if err != nil {
		return nil, err
	}

	entries := make(map[string]*Type)
	err = yaml.Unmarshal(buf, entries)
	if err != nil {
		return nil, err
	}

	return entries, nil

}

// Import imports from a reader containing typeID YAML to the table `invtypes`
func Import(db *sql.DB, r io.Reader) error {
	var invCols = []string{
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

	entries, err := loadFromReader(r)
	if err != nil {
		return err
	}

	txn, err := db.Begin()
	if err != nil {
		return err
	}

	// TODO investigate if we can perform multiple CopyIn in the same transaction
	// invStmt, err := txn.Prepare(pq.CopyIn("invtypes", invCols...))
	invStmt, err := txn.Prepare(fmt.Sprintf(`INSERT INTO invtypes (%s) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13)`,
		strings.Join(invCols, ",")))

	if err != nil {
		return err
	}

	// mastStmt, err := txn2.Prepare(pq.CopyIn("certmasteries", "typeid", "masterylevel", "certid"))
	mastStmt, err := txn.Prepare(`INSERT INTO certmasteries (typeid, masterylevel, certid) VALUES ($1, $2, $3)`)
	if err != nil {
		return err
	}

	traitStmt, err := txn.Prepare(`INSERT INTO invtraits (typeid, skillid, bonus, unitid, bonustext) VALUES ($1, $2, $3, $4, $5) RETURNING traitid`)
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
				err = insertBonuses(traitStmt, typeID, skill, typeBonus)
				if err != nil {
					return err
				}
			}
			err = insertBonuses(traitStmt, typeID, -1, entry.Traits.RoleBonuses)
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

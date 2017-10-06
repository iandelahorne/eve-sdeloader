package groups

import (
	"database/sql"
	"io"

	"github.com/lflux/eve-sdeloader/utils"
)

func InsertGroupStmt(tx *sql.Tx) (*sql.Stmt, error) {
	return tx.Prepare(`INSERT INTO invgroups VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9)`)
}

func Import(db *sql.DB, r io.Reader) error {
	entries := make(map[string]*Group)
	err := utils.LoadFromReader(r, entries)

	if err != nil {
		return err
	}

	tx, err := db.Begin()
	if err != nil {
		return err
	}

	stmt, err := InsertGroupStmt(tx)
	if err != nil {
		return err
	}
	insertTrnTranslations, err := utils.InsertTrnTranslations(tx)
	for groupID, group := range entries {
		_, err = stmt.Exec(groupID, group.CategoryID, group.Name["en"], group.IconID, group.UseBasePrice, group.Anchored, group.Anchorable, group.FittableNonSingleton, group.Published)
		if err != nil {
			return err
		}
		for lang, val := range group.Name {
			_, err = insertTrnTranslations.Exec(7, groupID, lang, val)
			if err != nil {
				return err
			}
		}
	}

	err = insertTrnTranslations.Close()
	if err != nil {
		return err
	}

	err = stmt.Close()
	if err != nil {
		return err
	}

	return tx.Commit()
}

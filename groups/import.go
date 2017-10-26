package groups

import (
	"database/sql"
	"io"
	"time"

	"github.com/lflux/eve-sdeloader/statements"
	"github.com/lflux/eve-sdeloader/utils"
)

func Import(db *sql.DB, r io.Reader) error {
	defer utils.TimeTrack(time.Now(), "groups")

	entries := make(map[string]*Group)
	err := utils.LoadFromReader(r, entries)

	if err != nil {
		return err
	}

	tx, err := db.Begin()
	if err != nil {
		return err
	}

	stmt, err := statements.InsertGroupStmt(tx)
	if err != nil {
		return err
	}
	insertTrnTranslations, err := statements.InsertTrnTranslationsStmt(tx)
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

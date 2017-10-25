package categories

import (
	"database/sql"
	"io"

	"github.com/lflux/eve-sdeloader/statements"
	"github.com/lflux/eve-sdeloader/utils"
)

type Category struct {
	Name      map[string]string
	IconID    *int `yaml:"iconID"`
	Published bool
}

func Import(db *sql.DB, r io.Reader) error {
	entries := make(map[string]*Category)

	err := utils.LoadFromReader(r, entries)
	if err != nil {
		return err
	}

	tx, err := db.Begin()
	if err != nil {
		return err
	}

	stmt, err := statements.InsertCategoryStmt(tx)
	if err != nil {
		return err
	}

	insertTrnTranslations, err := statements.InsertTrnTranslationsStmt(tx)
	if err != nil {
		return err
	}

	for categoryID, category := range entries {
		_, err = stmt.Exec(categoryID, category.Name["en"], category.IconID, category.Published)
		if err != nil {
			return err
		}
		for lang, val := range category.Name {
			_, err = insertTrnTranslations.Exec(6, categoryID, lang, val)
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

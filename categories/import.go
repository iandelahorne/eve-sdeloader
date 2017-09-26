package categories

import (
	"database/sql"
	"io"
	"os"

	"github.com/lflux/eve-sdeloader/utils"
)

type Category struct {
	Name      map[string]string
	IconID    int `yaml:"iconID"`
	Published bool
}

func InsertCategoryStmt(tx *sql.Tx) (*sql.Stmt, error) {
	return tx.Prepare(`INSERT INTO invcategories VALUES ($1, $2, $3, $4)`)
}

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

	stmt, err := InsertCategoryStmt(tx)
	if err != nil {
		return err
	}

	for categoryID, category := range entries {
		_, err = stmt.Exec(categoryID, category.Name["en"], category.IconID, category.Published)
		if err != nil {
			return err
		}
	}

	err = stmt.Close()
	if err != nil {
		return err
	}

	return tx.Commit()
}
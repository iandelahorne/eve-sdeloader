package icons

import (
	"database/sql"
	"io"
	"io/ioutil"
	"os"

	yaml "gopkg.in/yaml.v2"
)

const iconDDL = `CREATE TABLE IF NOT EXISTS eveicons (
    iconid integer NOT NULL,
    iconfile text,
    description text
);`

func CreateTables(db *sql.DB) error {
	tx, err := db.Begin()
	if err != nil {
		return err
	}

	_, err = tx.Exec(iconDDL)
	if err != nil {
		return err
	}

	return tx.Commit()
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

func loadFromReader(r io.Reader) (map[int64]*Icon, error) {
	buf, err := ioutil.ReadAll(r)
	if err != nil {
		return nil, err
	}

	entries := make(map[int64]*Icon)
	err = yaml.Unmarshal(buf, entries)
	if err != nil {
		return nil, err
	}

	return entries, nil
}

func Import(db *sql.DB, r io.Reader) error {
	entries, err := loadFromReader(r)
	if err != nil {
		return err
	}

	tx, err := db.Begin()
	if err != nil {
		return err
	}

	stmt, err := tx.Prepare(`INSERT INTO eveicons (iconid, iconfile, description) VALUES ($1, $2, $3)`)
	if err != nil {
		return err
	}

	for iconID, icon := range entries {
		_, err = stmt.Exec(iconID, icon.IconFile, icon.Description)
		if err != nil {
			return err
		}
	}

	err = stmt.Close()
	return tx.Commit()
}

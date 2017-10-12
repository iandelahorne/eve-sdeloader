package universe

import (
	"database/sql"
	"log"
	"path/filepath"
)

func getItemNameByID(db *sql.DB, itemID int64) (string, error) {
	var name string

	row := db.QueryRow(`SELECT itemname from sdeyaml.invnames where itemid = $1`, itemID)
	err := row.Scan(&name)
	if err != nil {
		return "", nil
	}

	return name, nil
}

func Import(db *sql.DB, path string) error {
	regions, err := filepath.Glob(filepath.Join(path, "*", "*", "region.staticdata"))

	if err != nil {
		return err
	}
	for _, regionFile := range regions {
		log.Println(regionFile)
		err = ImportRegion(db, regionFile)
		if err != nil {
			return err
		}
	}

	return nil
}

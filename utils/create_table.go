package utils

import "database/sql"

func CreateTable(db *sql.DB, ddl string) error {
	tx, err := db.Begin()
	if err != nil {
		return err
	}

	_, err = tx.Exec(ddl)
	if err != nil {
		return err
	}

	return tx.Commit()
}

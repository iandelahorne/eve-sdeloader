package utils

import "database/sql"

// TODO refactor this to a general 'Exec'
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

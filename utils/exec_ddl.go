package utils

import (
	"database/sql"
	"io/ioutil"
	"os"
)

// ExecDDLFromFile reads a DDL file from path and executes it in a transaction
func ExecDDLFromFile(db *sql.DB, path string) error {
	f, err := os.Open(path)
	if err != nil {
		return err
	}

	defer f.Close()
	ddl, err := ioutil.ReadAll(f)
	if err != nil {
		return err
	}

	tx, err := db.Begin()
	if err != nil {
		return err
	}

	_, err = tx.Exec(string(ddl))
	if err != nil {
		return err
	}

	return tx.Commit()
}

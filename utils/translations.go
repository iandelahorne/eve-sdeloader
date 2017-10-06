package utils

import "database/sql"

func InsertTrnTranslations(tx *sql.Tx) (*sql.Stmt, error) {
	return tx.Prepare(`INSERT INTO trntranslations (tcid, keyid, languageid, text) VALUES ($1, $2, $3, $4)`)
}

package translations

import "database/sql"

const trnTranslationsDDL = `CREATE TABLE IF NOT EXISTS trntranslations (
    tcid integer NOT NULL,
    keyid integer NOT NULL,
    languageid character varying(50) NOT NULL,
    text text NOT NULL
)
`

func CreateTables(db *sql.DB) error {
	tx, err := db.Begin()
	if err != nil {
		return err
	}
	_, err = tx.Exec(trnTranslationsDDL)
	if err != nil {
		return err
	}

	return tx.Commit()
}

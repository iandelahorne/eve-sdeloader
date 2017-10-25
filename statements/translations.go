package statements

import "database/sql"

func InsertTrnTranslationsStmt(tx *sql.Tx) (*sql.Stmt, error) {
	return tx.Prepare(`INSERT INTO "trnTranslations" ("tcID", "keyID", "languageID", text) VALUES ($1, $2, $3, $4)`)
}

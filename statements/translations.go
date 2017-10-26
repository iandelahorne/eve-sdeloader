package statements

import (
	"database/sql"

	"github.com/lib/pq"
)

func InsertTrnTranslationsStmt(tx *sql.Tx) (*sql.Stmt, error) {
	return tx.Prepare(`INSERT INTO "trnTranslations" ("tcID", "keyID", "languageID", text) VALUES ($1, $2, $3, $4)`)
}

func CopyTrnTranslationsStmt(tx *sql.Tx) (*sql.Stmt, error) {
	return tx.Prepare(pq.CopyIn("trnTranslations", "tcID", "keyID", "languageID", "text"))
}

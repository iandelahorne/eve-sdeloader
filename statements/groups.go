package statements

import "database/sql"

func InsertGroupStmt(tx *sql.Tx) (*sql.Stmt, error) {
	return tx.Prepare(`INSERT INTO "invGroups" VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9)`)
}

package statements

import "database/sql"

func InsertGraphicStmt(tx *sql.Tx) (*sql.Stmt, error) {
	return tx.Prepare(`INSERT INTO "eveGraphics" VALUES ($1, $2, $3, $4, $5, $6)`)
}

package statements

import "database/sql"

func InsertCategoryStmt(tx *sql.Tx) (*sql.Stmt, error) {
	return tx.Prepare(`INSERT INTO "invCategories" VALUES ($1, $2, $3, $4)`)
}

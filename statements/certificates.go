package statements

import "database/sql"

func InsertCertCertsStmt(tx *sql.Tx) (*sql.Stmt, error) {
	return tx.Prepare(`INSERT INTO "certCerts" ("certID", description, "groupID", name) VALUES ($1, $2, $3, $4)`)
}

func InsertCertSkillsStmt(tx *sql.Tx) (*sql.Stmt, error) {
	return tx.Prepare(`INSERT INTO "certSkills" ("certID", "skillID", "certLevelInt", "certLevelText", "skillLevel") VALUES ($1, $2, $3, $4, $5)`)
}

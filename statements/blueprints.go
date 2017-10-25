package statements

import "database/sql"

func InsertIndustryBlueprintsStmt(tx *sql.Tx) (*sql.Stmt, error) {
	return tx.Prepare(`INSERT INTO "industryBlueprints" VALUES ($1, $2)`)
}

func InsertIndustryActivitiesStmt(tx *sql.Tx) (*sql.Stmt, error) {
	return tx.Prepare(`INSERT INTO "industryActivity" VALUES ($1, $2, $3)`)
}

func InsertActivityMaterialsStmt(tx *sql.Tx) (*sql.Stmt, error) {
	return tx.Prepare(`INSERT INTO "industryActivitySkills" VALUES ($1, $2, $3, $4)`)
}

func InsertActivityProbabilitiesStmt(tx *sql.Tx) (*sql.Stmt, error) {
	return tx.Prepare(`INSERT INTO "industryActivityProbabilities" VALUES ($1, $2, $3, $4)`)
}

func InsertActivityProductsStmt(tx *sql.Tx) (*sql.Stmt, error) {
	return tx.Prepare(`INSERT INTO "industryActivityProducts" VALUES ($1, $2, $3, $4)`)
}

func InsertActivitySkillsStmt(tx *sql.Tx) (*sql.Stmt, error) {
	return tx.Prepare(`INSERT INTO "industryActivitySkills" VALUES ($1, $2, $3, $4)`)
}

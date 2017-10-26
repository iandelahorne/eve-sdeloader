package statements

import (
	"database/sql"

	"github.com/lib/pq"
)

func InsertIndustryBlueprintsStmt(tx *sql.Tx) (*sql.Stmt, error) {
	return tx.Prepare(pq.CopyIn("industryBlueprints", "typeID", "maxProductionLimit"))
}

func InsertIndustryActivitiesStmt(tx *sql.Tx) (*sql.Stmt, error) {
	return tx.Prepare(pq.CopyIn("industryActivity",
		"typeID",
		"activityID",
		"time"))
}

func InsertActivityMaterialsStmt(tx *sql.Tx) (*sql.Stmt, error) {
	return tx.Prepare(pq.CopyIn("industryActivityMaterials",
		"typeID",
		"activityID",
		"materialTypeID",
		"quantity"))
}

func InsertActivityProbabilitiesStmt(tx *sql.Tx) (*sql.Stmt, error) {
	return tx.Prepare(pq.CopyIn("industryActivityProbabilities",
		"typeID",
		"activityID",
		"productTypeID",
		"probability"))
}

func InsertActivityProductsStmt(tx *sql.Tx) (*sql.Stmt, error) {
	return tx.Prepare(pq.CopyIn("industryActivityProducts",
		"typeID",
		"activityID",
		"productTypeID",
		"quantity"))
}

func InsertActivitySkillsStmt(tx *sql.Tx) (*sql.Stmt, error) {
	return tx.Prepare(pq.CopyIn("industryActivitySkills",
		"typeID",
		"activityID",
		"skillID",
		"level"))
}

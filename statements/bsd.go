package statements

import (
	"database/sql"

	"github.com/lib/pq"
)

func InsertDgmTypeAttributesStmt(tx *sql.Tx) (*sql.Stmt, error) {
	return tx.Prepare(pq.CopyIn("dgmTypeAttributes",
		"typeID",
		"attributeID",
		"valueInt",
		"valueFloat"))
}

func InsertInvNamesStmt(tx *sql.Tx) (*sql.Stmt, error) {
	return tx.Prepare(pq.CopyIn("invNames",
		"itemID",
		"itemName"))
}

func InsertInvItemsStmt(tx *sql.Tx) (*sql.Stmt, error) {
	return tx.Prepare(pq.CopyIn("invItems",
		"itemID",
		"typeID",
		"ownerID",
		"locationID",
		"flagID",
		"quantity"))
}

func InsertInvPositionsStmt(tx *sql.Tx) (*sql.Stmt, error) {
	return tx.Prepare(pq.CopyIn("invPositions",
		"itemID",
		"x",
		"y",
		"z",
		"yaw",
		"pitch",
		"roll"))
}

func InsertInvUniqueNamesStmt(tx *sql.Tx) (*sql.Stmt, error) {
	return tx.Prepare(pq.CopyIn("invUniqueNames",
		"itemID",
		"itemName",
		"groupID"))
}

package statements

import "database/sql"

func InsertLicenseStmt(tx *sql.Tx) (*sql.Stmt, error) {
	return tx.Prepare(`INSERT INTO "skinLicense" VALUES ($1, $2, $3)`)
}

func InsertMaterialStmt(tx *sql.Tx) (*sql.Stmt, error) {
	return tx.Prepare(`INSERT INTO "skinMaterials" VALUES ($1, $2, $3)`)
}

func InsertSkinStmt(tx *sql.Tx) (*sql.Stmt, error) {
	return tx.Prepare(`INSERT INTO skins VALUES ($1, $2, $3)`)
}

func InsertSkinShipStmt(tx *sql.Tx) (*sql.Stmt, error) {
	return tx.Prepare(`INSERT INTO "skinShip" VALUES ($1, $2)`)
}

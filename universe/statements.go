package universe

import "database/sql"

func InsertRegionStmt(tx *sql.Tx) (*sql.Stmt, error) {
	return tx.Prepare(`INSERT INTO mapregions (regionid, regionname, x,y,z, "xMax", ymax, zmax, "xMin", ymin, zmin, factionid) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12)`)
}

func InsertMapDenormalizeStmt(tx *sql.Tx) (*sql.Stmt, error) {
	return tx.Prepare(`INSERT INTO mapdenormalize (itemid, typeid, groupid, itemname, x, y, z) VALUES ($1, $2, $3, $4, $5, $6, $7)`)
}

func InsertRegionMapDenormalizeStmt(tx *sql.Tx) (*sql.Stmt, error) {
	return tx.Prepare(`INSERT INTO mapdenormalize (itemid, regionid, typeid, groupid, itemname, x, y, z) VALUES ($1, $2, $3, $4, $5, $6, $7, $8)`)
}

func InsertMapLocationScenesStmt(tx *sql.Tx) (*sql.Stmt, error) {
	return tx.Prepare(`INSERT INTO maplocationscenes (locationid, graphicid) VALUES ($1, $2)`)
}

func InsertMapWHClassesStmt(tx *sql.Tx) (*sql.Stmt, error) {
	return tx.Prepare(`INSERT INTO maplocationwormholeclasses (locationid, wormholeclassid) VALUES ($1, $2)`)
}

func InsertConstellationsStmt(tx *sql.Tx) (*sql.Stmt, error) {
	return tx.Prepare(`INSERT INTO mapConstellations (regionid, constellationid, constellationname, x,y,z, "xMax", ymax, zmax, "xMin", ymin, zmin, radius, factionid) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14)`)
}

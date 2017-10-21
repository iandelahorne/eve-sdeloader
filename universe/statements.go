package universe

import "database/sql"

func InsertRegionStmt(tx *sql.Tx) (*sql.Stmt, error) {
	return tx.Prepare(`INSERT INTO mapregions (regionid, regionname, x,y,z, "xMax", ymax, zmax, "xMin", ymin, zmin, factionid) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12)`)
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

func InsertMapJumpStmt(tx *sql.Tx) (*sql.Stmt, error) {
	return tx.Prepare(`INSERT INTO mapJumps (stargateid, destinationid) VALUES ($1, $2)`)
}

func InsertSolarSystemStmt(tx *sql.Tx) (*sql.Stmt, error) {
	stmt := `
INSERT INTO mapSolarSystems (
	regionid,
	constellationid,
	solarsystemid,
	solarsystemname,
	x,
	y,
	z,
	"xMax",
	ymax,
	zmax,
	"xMin",
	ymin,
	zmin,
	luminosity,
	border,
	fringe,
	corridor,
	hub,
	international,
	regional,
	security,
	factionid,
	radius,
	suntypeid,
	securityclass) 
VALUES (
	$1, $2, $3, $4, $5,
	$6, $7, $8, $9, $10,
	$11, $12, $13, $14, $15,
	$16, $17, $18, $19, $20,
	$21, $22, $23, $24, $25
)`
	return tx.Prepare(stmt)
}

func InsertCelestialStatsStmt(tx *sql.Tx) (*sql.Stmt, error) {
	stmt := `
INSERT INTO mapCelestialStatistics (
	celestialid,
	temperature,
	spectralclass,
	luminosity,
	age,
	life,
	orbitradius,
	eccentricity,
	massdust,
	massgas,
	fragmented,
	density,
	surfacegravity,
	escapevelocity,
	orbitperiod,
	rotationrate,
	locked,
	pressure,
	radius,
	mass
) VALUES (
	$1, $2, $3, $4, $5,
	$6, $7, $8, $9, $10,
	$11, $12, $13, $14, $15,
	$16, $17, $18, $19, $20
)`
	return tx.Prepare(stmt)
}

func InsertOrbitalDenormStmt(tx *sql.Tx) (*sql.Stmt, error) {
	const stmt = `
INSERT INTO mapDenormalize (
	itemID,
	typeID,
	groupID,
	solarSystemID,
	constellationID,
	regionID,
	orbitID,
	x,
	y,
	z,
	radius,
	itemName,
	security,
	celestialIndex,
	orbitIndex
) VALUES (
	$1, $2, $3, $4, $5,
	$6, $7, $8, $9, $10,
	$11, $12, $13, $14, $15
)
`
	return tx.Prepare(stmt)
}

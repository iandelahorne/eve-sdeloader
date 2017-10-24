package universe

import "database/sql"

func InsertRegionStmt(tx *sql.Tx) (*sql.Stmt, error) {
	stmt := `
INSERT INTO "mapRegions" (
	"regionID",
	"regionName",
	x,
	y,
	z,
	"xMax",
	"yMax",
	"zMax",
	"xMin",
	"yMin",
	"zMin",
	"factionID")
VALUES (
	$1, $2, $3, $4, $5,
	$6, $7, $8, $9, $10,
	$11, $12)`
	return tx.Prepare(stmt)
}

func InsertMapLocationScenesStmt(tx *sql.Tx) (*sql.Stmt, error) {
	return tx.Prepare(`INSERT INTO "mapLocationScenes" ("locationID", "graphicID") VALUES ($1, $2)`)
}

func InsertMapWHClassesStmt(tx *sql.Tx) (*sql.Stmt, error) {
	return tx.Prepare(`INSERT INTO "mapLocationWormholeClasses" ("locationID", "wormholeClassID") VALUES ($1, $2)`)
}

func InsertConstellationsStmt(tx *sql.Tx) (*sql.Stmt, error) {
	stmt := `
INSERT INTO "mapConstellations" (
	"regionID",
	"constellationID",
	"constellationName",
	x,
	y,
	z,
	"xMax",
	"yMax",
	"zMax",
	"xMin",
	"yMin",
	"zMin",
	radius,
	"factionID")
VALUES (
	$1, $2, $3, $4, $5,
	$6, $7, $8, $9, $10,
	$11, $12, $13, $14)`
	return tx.Prepare(stmt)
}

func InsertMapJumpStmt(tx *sql.Tx) (*sql.Stmt, error) {
	return tx.Prepare(`INSERT INTO "mapJumps" ("stargateID", "destinationID") VALUES ($1, $2)`)
}

func InsertSolarSystemStmt(tx *sql.Tx) (*sql.Stmt, error) {
	stmt := `
INSERT INTO "mapSolarSystems" (
	"regionID",
	"constellationID",
	"solarSystemID",
	"solarSystemName",
	x,
	y,
	z,
	"xMax",
	"yMax",
	"zMax",
	"xMin",
	"yMin",
	"zMin",
	luminosity,
	border,
	fringe,
	corridor,
	hub,
	international,
	regional,
	security,
	"factionID",
	radius,
	"sunTypeID",
	"securityClass") 
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
INSERT INTO "mapCelestialStatistics" (
	"celestialID",
	temperature,
	"spectralClass",
	luminosity,
	age,
	life,
	"orbitRadius",
	eccentricity,
	"massDust",
	"massGas",
	fragmented,
	density,
	"surfaceGravity",
	"escapeVelocity",
	"orbitPeriod",
	"rotationRate",
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
INSERT INTO "mapDenormalize" (
	"itemID",
	"typeID",
	"groupID",
	"solarSystemID",
	"constellationID",
	"regionID",
	"orbitID",
	"x",
	"y",
	"z",
	"radius",
	"itemName",
	"security",
	"celestialIndex",
	"orbitIndex"
) VALUES (
	$1, $2, $3, $4, $5,
	$6, $7, $8, $9, $10,
	$11, $12, $13, $14, $15
)
`
	return tx.Prepare(stmt)
}

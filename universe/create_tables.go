package universe

import (
	"database/sql"

	"github.com/lflux/eve-sdeloader/utils"
)

const (
	mapCelestialStatisticsDDL = ``
	mapConstellationsDDL      = ``
	mapDenormalizeDDL         = `
	CREATE TABLE IF NOT EXISTS mapdenormalize (
		itemid integer NOT NULL,
		typeid integer,
		groupid integer,
		solarsystemid integer,
		constellationid integer,
		regionid integer,
		orbitid integer,
		x double precision,
		y double precision,
		z double precision,
		radius double precision,
		itemname character varying(100),
		security double precision,
		celestialindex integer,
		orbitindex integer
	)`
	mapRegionsDDL = `
	CREATE TABLE IF NOT EXISTS mapregions (
		regionid integer NOT NULL,
		regionname character varying(100),
		x double precision,
		y double precision,
		z double precision,
		"xMin" double precision,
		"xMax" double precision,
		ymin double precision,
		ymax double precision,
		zmin double precision,
		zmax double precision,
		factionid integer,
		radius double precision
	)`
	mapSolarSystemsDDL = `
	CREATE TABLE IF NOT EXISTS mapsolarsystems (
		regionid integer,
		constellationid integer,
		solarsystemid integer NOT NULL,
		solarsystemname character varying(100),
		x double precision,
		y double precision,
		z double precision,
		"xMin" double precision,
		"xMax" double precision,
		ymin double precision,
		ymax double precision,
		zmin double precision,
		zmax double precision,
		luminosity double precision,
		border boolean,
		fringe boolean,
		corridor boolean,
		hub boolean,
		international boolean,
		regional boolean,
		constellation boolean,
		security double precision,
		factionid integer,
		radius double precision,
		suntypeid integer,
		securityclass character varying(2)
	)`
	mapJumpsDDL = `
	CREATE TABLE IF NOT EXISTS mapjumps (
		stargateid integer NOT NULL,
		destinationid integer
	)`
	mapLocationScenesDDL = `
	CREATE TABLE IF NOT EXISTS maplocationscenes (
		locationid integer NOT NULL,
		graphicid integer
	)`
)

func CreateTables(db *sql.DB) error {
	ddls := []string{
		mapCelestialStatisticsDDL,
		mapConstellationsDDL,
		mapDenormalizeDDL,
		mapRegionsDDL,
		mapSolarSystemsDDL,
		mapJumpsDDL,
		mapLocationScenesDDL,
	}

	for _, ddl := range ddls {
		err := utils.CreateTable(db, ddl)
		if err != nil {
			return err
		}
	}

	return nil
}

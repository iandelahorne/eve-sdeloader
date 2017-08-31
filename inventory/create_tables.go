package inventory

import (
	"database/sql"

	"github.com/lflux/eve-sdeloader/utils"
)

const invTypeDDL = `CREATE TABLE IF NOT EXISTS invtypes (
    typeid integer NOT NULL,
    groupid integer,
    typename varchar,
    description text,
    mass double precision,
    volume double precision,
    capacity double precision,
    portionsize integer,
    raceid integer,
    baseprice numeric(19,4),
    published boolean,
    marketgroupid integer,
    iconid integer,
    soundid integer,
	graphicid integer
)
`

const certMasteriesDDL = `CREATE TABLE IF NOT EXISTS certmasteries (
    typeid integer,
    masterylevel integer,
	certid integer
)
`

const invTraitsDDL = `CREATE TABLE IF NOT EXISTS invtraits (
    traitid serial,
    typeid integer,
    skillid integer,
    bonus double precision,
    bonustext text,
    unitid integer
);`

// CreateTables creates the tables for invtypes
func CreateTables(db *sql.DB) error {
	err := utils.CreateTable(db, invTypeDDL)
	if err != nil {
		return err
	}

	err = utils.CreateTable(db, certMasteriesDDL)
	if err != nil {
		return err
	}

	return utils.CreateTable(db, invTraitsDDL)
}

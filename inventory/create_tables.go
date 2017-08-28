package inventory

import "database/sql"

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
	tx, err := db.Begin()
	if err != nil {
		return err
	}

	_, err = tx.Exec(invTypeDDL)
	if err != nil {
		return err
	}

	_, err = tx.Exec(certMasteriesDDL)
	if err != nil {
		return err
	}

	_, err = tx.Exec(invTraitsDDL)
	if err != nil {
		return err
	}

	return tx.Commit()
}

package groups

import (
	"database/sql"

	"github.com/lflux/eve-sdeloader/utils"
)

const groupsDDL = `CREATE TABLE IF NOT EXISTS invgroups (
	groupid integer NOT NULL,
    categoryid integer,
    groupname character varying(100),
    iconid integer,
    usebaseprice boolean,
    anchored boolean,
    anchorable boolean,
    fittablenonsingleton boolean,
    published boolean
)
`

func CreateTables(db *sql.DB) error {
	return utils.CreateTable(db, groupsDDL)
}

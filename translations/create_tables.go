package translations

import (
	"database/sql"

	"github.com/lflux/eve-sdeloader/utils"
)

const trnTranslationsDDL = `CREATE TABLE IF NOT EXISTS trntranslations (
    tcid integer NOT NULL,
    keyid integer NOT NULL,
    languageid character varying(50) NOT NULL,
    text text NOT NULL
)
`

func CreateTables(db *sql.DB) error {
	return utils.CreateTable(db, trnTranslationsDDL)
}

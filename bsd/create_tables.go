package bsd

import (
	"database/sql"
	"io/ioutil"
	"os"

	"github.com/lflux/eve-sdeloader/utils"
)

func CreateTables(db *sql.DB, path string) error {
	f, err := os.Open(path)
	if err != nil {
		return err
	}
	defer f.Close()
	buf, err := ioutil.ReadAll(f)
	if err != nil {
		return err
	}

	return utils.CreateTable(db, string(buf))
}

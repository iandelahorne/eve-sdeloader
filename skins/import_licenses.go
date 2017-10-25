package skins

import (
	"database/sql"
	"io"

	"github.com/lflux/eve-sdeloader/statements"
	"github.com/lflux/eve-sdeloader/utils"
)

type SkinLicense struct {
	Duration int64
	TypeID   int64 `yaml:"licenseTypeID"`
	SkinID   int64 `yaml:"skinID"`
}

func ImportLicenses(db *sql.DB, r io.Reader) error {

	entries := make(map[string]*SkinLicense)

	err := utils.LoadFromReader(r, entries)
	if err != nil {
		return err
	}

	tx, err := db.Begin()
	if err != nil {
		return err
	}

	stmt, err := statements.InsertLicenseStmt(tx)
	if err != nil {
		return err
	}

	for licenseID, license := range entries {
		_, err = stmt.Exec(licenseID, license.Duration, license.SkinID)
		if err != nil {
			return err
		}
	}

	return tx.Commit()
}

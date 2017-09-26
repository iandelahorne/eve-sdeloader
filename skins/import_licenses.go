package skins

import (
	"database/sql"
	"io"

	"github.com/lflux/eve-sdeloader/utils"
)

type SkinLicense struct {
	Duration int64
	TypeID   int64 `yaml:"licenseTypeID"`
	SkinID   int64 `yaml:"skinID"`
}

func InsertLicenseStmt(tx *sql.Tx) (*sql.Stmt, error) {
	return tx.Prepare(`INSERT INTO skinLicense VALUES ($1, $2, $3)`)
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

	stmt, err := InsertLicenseStmt(tx)
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

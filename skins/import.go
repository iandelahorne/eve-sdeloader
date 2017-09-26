package skins

import (
	"database/sql"
	"io"

	"github.com/lflux/eve-sdeloader/utils"
)

type Skin struct {
	AllowCCPDevs       bool
	InternalName       string `yaml:"internalName"`
	SkinID             int64  `yaml:"skinID"`
	MaterialID         string `yaml:"skinMaterialID"`
	Types              []int64
	VisibleSerenity    bool
	VisibleTranquility bool
}

func InsertSkinStmt(tx *sql.Tx) (*sql.Stmt, error) {
	return tx.Prepare(`INSERT INTO skins VALUES ($1, $2, $3)`)
}

func ImportSkin(db *sql.DB, r io.Reader) error {

	entries := make(map[string]*Skin)

	err := utils.LoadFromReader(r, entries)
	if err != nil {
		return err
	}

	tx, err := db.Begin()
	if err != nil {
		return err
	}

	stmt, err := InsertSkinStmt(tx)
	if err != nil {
		return err
	}

	for skinID, skin := range entries {
		_, err = stmt.Exec(skinID, skin.InternalName, skin.MaterialID)
		if err != nil {
			return err
		}
	}

	return tx.Commit()
}

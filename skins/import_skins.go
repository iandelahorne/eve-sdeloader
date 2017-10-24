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

func InsertSkinShipStmt(tx *sql.Tx) (*sql.Stmt, error) {
	return tx.Prepare(`INSERT INTO "skinShip" VALUES ($1, $2)`)
}
func ImportSkins(db *sql.DB, r io.Reader) error {

	entries := make(map[string]*Skin)

	err := utils.LoadFromReader(r, entries)
	if err != nil {
		return err
	}

	tx, err := db.Begin()
	if err != nil {
		return err
	}

	skinStmt, err := InsertSkinStmt(tx)
	if err != nil {
		return err
	}

	skinShipStmt, err := InsertSkinShipStmt(tx)
	if err != nil {
		return err
	}

	for skinID, skin := range entries {
		_, err = skinStmt.Exec(skinID, skin.InternalName, skin.MaterialID)
		if err != nil {
			return err
		}
		for _, typeID := range skin.Types {
			_, err = skinShipStmt.Exec(skinID, typeID)
			if err != nil {
				return err
			}
		}
	}

	return tx.Commit()
}

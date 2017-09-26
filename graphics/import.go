package graphics

import (
	"database/sql"
	"io"

	"github.com/lflux/eve-sdeloader/utils"
)

type Graphic struct {
	Description string
	File        string `yaml:"graphicFile"`
	IconFolder  string
	Faction     string `yaml:"sofFactionName"`
	Hull        string `yaml:"sofHullName"`
	Race        string `yaml:"sofRaceName"`
}

func InsertGraphicStmt(tx *sql.Tx) (*sql.Stmt, error) {
	return tx.Prepare(`INSERT INTO evegraphics VALUES ($1, $2, $3, $4, $5, $6)`)
}

func Import(db *sql.DB, r io.Reader) error {
	entries := make(map[string]*Graphic)
	err := utils.LoadFromReader(r, entries)

	if err != nil {
		return err
	}

	tx, err := db.Begin()
	if err != nil {
		return err
	}

	stmt, err := InsertGraphicStmt(tx)
	if err != nil {
		return err
	}

	for graphicID, graphic := range entries {
		_, err = stmt.Exec(graphicID, graphic.Faction, graphic.File, graphic.Hull, graphic.Race, graphic.Description)
		if err != nil {
			return err
		}
	}

	err = stmt.Close()
	if err != nil {
		return err
	}

	return tx.Commit()
}

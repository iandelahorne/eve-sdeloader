package icons

import (
	"database/sql"
	"io"

	"github.com/lflux/eve-sdeloader/utils"
)

func Import(db *sql.DB, r io.Reader) error {
	entries := make(map[int64]*Icon)

	err := utils.LoadFromReader(r, entries)
	if err != nil {
		return err
	}

	tx, err := db.Begin()
	if err != nil {
		return err
	}

	stmt, err := tx.Prepare(`INSERT INTO eveicons (iconid, iconfile, description) VALUES ($1, $2, $3)`)
	if err != nil {
		return err
	}

	for iconID, icon := range entries {
		_, err = stmt.Exec(iconID, icon.IconFile, icon.Description)
		if err != nil {
			return err
		}
	}

	err = stmt.Close()
	return tx.Commit()
}

package bsd

import (
	"database/sql"
	"io"

	"github.com/lflux/eve-sdeloader/statements"
	"github.com/lflux/eve-sdeloader/utils"
)

func importInvPositions(db *sql.DB, r io.Reader) error {
	var err error
	tx, err := db.Begin()
	if err != nil {
		return err
	}

	stmt, err := statements.InsertInvPositionsStmt(tx)
	if err != nil {
		return err
	}

	entries := make([]invPosition, 0)
	err = utils.LoadFromReader(r, &entries)
	if err != nil {
		return err
	}

	for _, entry := range entries {
		_, err = stmt.Exec(entry.ItemID,
			entry.X,
			entry.Y,
			entry.Z,
			entry.Yaw,
			entry.Pitch,
			entry.Roll)
		if err != nil {
			return err
		}
	}

	_, err = stmt.Exec()
	if err != nil {
		return err
	}

	err = stmt.Close()
	if err != nil {
		return err
	}

	return tx.Commit()
}

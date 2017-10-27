package bsd

import (
	"database/sql"
	"io"

	"github.com/lflux/eve-sdeloader/statements"
	"github.com/lflux/eve-sdeloader/utils"
)

type invItem struct {
	FlagID     int64 `yaml:"flagID"`
	ItemID     int64 `yaml:"itemID"`
	LocationID int64 `yaml:"locationID"`
	OwnerID    int64 `yaml:"ownerID"`
	Quantity   int64 `yaml:"quantity"`
	TypeID     int64 `yaml:"typeID"`
}

func importInvItems(db *sql.DB, r io.Reader) error {
	var err error
	tx, err := db.Begin()
	if err != nil {
		return err
	}

	stmt, err := statements.InsertInvItemsStmt(tx)
	if err != nil {
		return err
	}
	entries := make([]invItem, 0)
	err = utils.LoadFromReader(r, &entries)
	if err != nil {
		return err
	}

	for _, entry := range entries {
		_, err = stmt.Exec(entry.ItemID,
			entry.TypeID,
			entry.OwnerID,
			entry.LocationID,
			entry.FlagID,
			entry.Quantity)
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

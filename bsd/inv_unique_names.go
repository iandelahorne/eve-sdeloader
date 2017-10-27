package bsd

import (
	"database/sql"
	"io"

	"github.com/lflux/eve-sdeloader/statements"
	"github.com/lflux/eve-sdeloader/utils"
)

type invUniqueName struct {
	GroupID  int64  `yaml:"groupID"`
	ItemID   int64  `yaml:"itemID"`
	ItemName string `yaml:"itemName"`
}

func importInvUniqueNames(db *sql.DB, r io.Reader) error {
	var err error
	tx, err := db.Begin()
	if err != nil {
		return err
	}

	stmt, err := statements.InsertInvUniqueNamesStmt(tx)
	if err != nil {
		return err
	}

	entries := make([]invUniqueName, 0)
	err = utils.LoadFromReader(r, &entries)
	if err != nil {
		return err
	}

	for _, entry := range entries {
		_, err = stmt.Exec(entry.ItemID,
			entry.ItemName,
			entry.GroupID)
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

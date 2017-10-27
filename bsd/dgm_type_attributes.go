package bsd

import (
	"database/sql"
	"io"

	"github.com/lflux/eve-sdeloader/statements"
	"github.com/lflux/eve-sdeloader/utils"
)

type dgmTypeAttribute struct {
	AttributeID int64    `yaml:"attributeID"`
	TypeID      int64    `yaml:"typeID"`
	ValueInt    *int64   `yaml:"valueInt"`
	ValueFloat  *float64 `yaml:"valueFloat"`
}

func importDgmTypeAttributes(db *sql.DB, r io.Reader) error {
	var err error
	tx, err := db.Begin()
	if err != nil {
		return err
	}

	stmt, err := statements.InsertDgmTypeAttributesStmt(tx)
	if err != nil {
		return err
	}

	entries := make([]dgmTypeAttribute, 0)
	err = utils.LoadFromReader(r, &entries)
	if err != nil {
		return err
	}
	for _, entry := range entries {
		_, err = stmt.Exec(entry.TypeID, entry.AttributeID, entry.ValueInt, entry.ValueFloat)
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

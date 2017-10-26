package statements

import (
	"database/sql"

	"github.com/pkg/errors"
)

type StatementGenerator func(*sql.Tx) (*sql.Stmt, error)

type Statement struct {
	Stmt *sql.Stmt
	Tx   *sql.Tx
}

func Prepare(db *sql.DB, stmtFuncMap map[string]StatementGenerator, stmts map[string]*Statement) error {
	var err error
	for name, fn := range stmtFuncMap {
		var s Statement

		s.Tx, err = db.Begin()
		if err != nil {
			return errors.Wrap(err, "error starting transaction for "+name)
		}

		s.Stmt, err = fn(s.Tx)
		if err != nil {
			return errors.Wrap(err, "error preparing statement for "+name)
		}
		stmts[name] = &s
	}

	return err
}

func Finalize(stmts map[string]*Statement) error {
	var err error
	for name, s := range stmts {
		_, err = s.Stmt.Exec()
		if err != nil {
			return errors.Wrap(err, "error finalizing "+name)
		}
		err = s.Stmt.Close()
		if err != nil {
			return errors.Wrap(err, "error closing "+name)
		}
		err = s.Tx.Commit()
		if err != nil {
			return errors.Wrap(err, "error commiting "+name)
		}
	}

	return err
}

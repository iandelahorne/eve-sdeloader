package bsd

import (
	"database/sql"
	"errors"
	"fmt"
	"io"
	"io/ioutil"
	"log"
	"os"
	"path"
	"sort"
	"strings"

	"github.com/lib/pq"
	"gopkg.in/yaml.v2"
)

type Importer struct {
	DB            *sql.DB
	dontLowerCase bool
	statements    map[string]*sql.Stmt
}

func (i *Importer) fixPostgresColumns(colname string) string {
	if !i.dontLowerCase {
		colname = strings.ToLower(colname)

		switch colname {
		case "zmax":
			return "z_max"
		case "zmin":
			return "z_min"
		case "xmax":
			return "x_max"
		case "xmin":
			return "x_min"
		case "ymax":
			return "y_max"
		case "ymin":
			return "y_min"
		default:
			return colname
		}
	}
	return colname
}

func (i *Importer) statement(tx *sql.Tx, tableName string, keys []string) (*sql.Stmt, error) {
	splattedKeys := strings.Join(keys, ",")
	stmt, ok := i.statements[splattedKeys]
	if ok {
		return stmt, nil
	}
	var placeholders string
	for idx := range keys {
		if idx > 0 {
			placeholders += ", "
		}
		placeholders += fmt.Sprintf("$%d", idx+1)
	}

	query := fmt.Sprintf("INSERT INTO %s (%s) VALUES (%s)",
		pq.QuoteIdentifier(tableName),
		splattedKeys,
		placeholders,
	)
	// TODO cache statements
	stmt, err := tx.Prepare(query)

	if err != nil {
		log.Printf("Error preparing query  `%s`: %s", query, err)
		return nil, err
	}
	i.statements[splattedKeys] = stmt
	return stmt, nil
}

func (i *Importer) importToTable(tableName string, r io.Reader) error {
	i.statements = make(map[string]*sql.Stmt)

	buf, err := ioutil.ReadAll(r)
	if err != nil {
		return err
	}

	rows := make([]map[string]string, 0)
	err = yaml.Unmarshal(buf, &rows)
	if err != nil {
		return err
	}

	tx, err := i.DB.Begin()
	if err != nil {
		return err
	}

	for _, row := range rows {
		keys := make([]string, 0, len(row))
		dbKeys := make([]string, 0, len(row))
		vals := make([]interface{}, 0, len(row))

		for k := range row {
			keys = append(keys, k)
		}

		sort.Strings(keys)
		for _, k := range keys {
			v := row[k]
			key := i.fixPostgresColumns(k)
			dbKeys = append(dbKeys, pq.QuoteIdentifier(key))
			vals = append(vals, v)
		}
		stmt, err := i.statement(tx, tableName, dbKeys)
		if err != nil {
			return err
		}
		_, err = stmt.Exec(vals...)
		if err != nil {
			log.Printf("Error executing insert on table %s for vals: %v", tableName, vals)
			return err
		}
	}

	for _, s := range i.statements {
		s.Close()
	}
	return tx.Commit()
}

func (i *Importer) importFile(root, fileName string) error {
	parts := strings.Split(fileName, ".")
	tableName := parts[0]
	if !i.dontLowerCase {
		tableName = strings.ToLower(tableName)
	}

	log.Printf("Importing %s into %s", fileName, tableName)
	f, err := os.Open(path.Join(root, fileName))
	if err != nil {
		return err
	}

	err = i.importToTable(tableName, f)
	if err != nil {
		return err
	}

	return nil
}

func (i *Importer) Import(root, singleFile string) error {
	if i.DB == nil {
		return errors.New("Nil database pointer")
	}
	i.dontLowerCase = true
	files, err := ioutil.ReadDir(root)
	if err != nil {
		return err
	}

	for _, file := range files {
		if singleFile == "" || (singleFile != "" && file.Name() == singleFile) {
			err = i.importFile(root, file.Name())
			if err != nil {
				return err
			}
		}
	}

	return nil
}

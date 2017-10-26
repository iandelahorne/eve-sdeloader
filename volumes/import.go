package volumes

import (
	"database/sql"
	"encoding/csv"
	"os"
	"time"

	"github.com/lflux/eve-sdeloader/utils"
)

const vol1Stmt = `INSERT INTO "invVolumes" (
	"typeID",
	volume
)
SELECT
	"typeID",
	$1
FROM
	"invTypes"
WHERE
	"groupID" = $2
`

const vol2Stmt = `INSERT INTO "invVolumes" (
	"typeID",
	volume
) VALUES (
	$1, $2
)
`

func readCSV(path string) ([][]string, error) {
	f, err := os.Open(path)
	if err != nil {
		return [][]string{}, err
	}
	defer f.Close()
	cr := csv.NewReader(f)

	records, err := cr.ReadAll()
	if err != nil {
		return [][]string{}, err
	}
	return records, nil
}

func ImportVolume1(db *sql.DB, path string) error {
	defer utils.TimeTrack(time.Now(), "volume1")

	records, err := readCSV(path)
	if err != nil {
		return err
	}

	tx, err := db.Begin()
	if err != nil {
		return err
	}
	stmt, err := tx.Prepare(vol1Stmt)
	if err != nil {
		return err
	}
	for _, record := range records {
		_, err = stmt.Exec(record[0], record[1])
		if err != nil {
			return err
		}
	}
	return tx.Commit()
}

func ImportVolume2(db *sql.DB, path string) error {
	defer utils.TimeTrack(time.Now(), "volume2")

	records, err := readCSV(path)
	if err != nil {
		return err
	}

	tx, err := db.Begin()
	if err != nil {
		return err
	}
	stmt, err := tx.Prepare(vol2Stmt)
	if err != nil {
		return err
	}
	for _, record := range records {
		_, err = stmt.Exec(record[1], record[0])
		if err != nil {
			return err
		}
	}
	return tx.Commit()
}

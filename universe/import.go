package universe

import (
	"database/sql"
	"log"
	"os"
	"path/filepath"

	"github.com/lflux/eve-sdeloader/utils"
)

type Region struct {
	Center          []float64
	Max             []float64
	Min             []float64
	DescriptionID   *int64 `yaml:"descriptionID"`
	FactionID       *int64 `yaml:"factionID"`
	NameID          int64  `yaml:"nameID"`
	Nebula          int64
	RegionID        int64 `yaml:"regionID"`
	WormholeClassID int64 `yaml:"wormholeClassID"`
}

func InsertRegionStmt(tx *sql.Tx) (*sql.Stmt, error) {
	return tx.Prepare(`INSERT INTO mapregions (regionid, regionname, x,y,z, "xMax", ymax, zmax, "xMin", ymin, zmin, factionid) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12)`)
}

func InsertMapDenormalizeStmt(tx *sql.Tx) (*sql.Stmt, error) {
	return tx.Prepare(`INSERT INTO mapdenormalize (regionid, typeid, groupid, itemname, x, y, z) VALUES ($1, $2, $3, $4, $5, $6, $7)`)
}

func getRegionName(regionID int64, db *sql.DB) (string, error) {
	var regionName string

	row := db.QueryRow(`SELECT itemname from sdeyaml.invnames where itemid = $1`, regionID)
	err := row.Scan(&regionName)
	if err != nil {
		return "", nil
	}

	return regionName, nil
}

func ImportRegion(db *sql.DB, path string) error {
	f, err := os.Open(path)
	if err != nil {
		return err
	}
	defer f.Close()

	var region Region

	err = utils.LoadFromReader(f, &region)
	if err != nil {
		return err
	}

	regionName, err := getRegionName(region.RegionID, db)
	if err != nil {
		return err
	}

	tx, err := db.Begin()
	if err != nil {
		return err
	}

	stmt, err := InsertRegionStmt(tx)
	if err != nil {
		return err
	}
	_, err = stmt.Exec(region.RegionID,
		regionName,
		region.Center[0],
		region.Center[1],
		region.Center[2],
		region.Max[0],
		region.Max[1],
		region.Max[2],
		region.Min[0],
		region.Min[1],
		region.Min[2],
		region.FactionID)
	if err != nil {
		return err
	}
	// load region.staticdata
	// get region name from invNames
	return tx.Commit()
}

func Import(db *sql.DB, path string) error {
	regions, err := filepath.Glob(filepath.Join(path, "*", "*", "region.staticdata"))

	if err != nil {
		return err
	}
	for _, regionFile := range regions {
		log.Println(regionFile)
		err = ImportRegion(db, regionFile)
		if err != nil {
			return err
		}
	}

	return nil
}

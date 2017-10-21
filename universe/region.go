package universe

import (
	"database/sql"
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
	path            string
	tx              *sql.Tx
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

	regionName, err := getItemNameByID(region.RegionID)
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
	denormStmt, err := InsertOrbitalDenormStmt(tx)
	if err != nil {
		return err
	}

	locStmt, err := InsertMapLocationScenesStmt(tx)
	if err != nil {
		return err
	}

	whClassStmt, err := InsertMapWHClassesStmt(tx)
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

	_, err = denormStmt.Exec(
		region.RegionID, //itemID
		3,               // typeID
		3,               // groupID
		nil,
		nil,
		nil,
		nil,
		region.Center[0], // x
		region.Center[1], // y
		region.Center[2], // z
		nil,
		regionName, // itemName
		nil,
		nil,
		nil,
	)
	if err != nil {
		return err
	}

	_, err = locStmt.Exec(region.RegionID, region.Nebula)
	if err != nil {
		return err
	}

	if region.WormholeClassID != 0 {
		_, err = whClassStmt.Exec(region.RegionID, region.WormholeClassID)
		if err != nil {
			return err
		}
	}

	region.path, _ = filepath.Split(path)
	region.tx = tx
	err = region.ImportConstellations()
	if err != nil {
		return err
	}
	return tx.Commit()
}

package universe

import (
	"database/sql"
	"log"
	"os"
	"path/filepath"

	"github.com/davecgh/go-spew/spew"
	"github.com/lflux/eve-sdeloader/utils"
)

type SolarSystem struct {
	Center []float64
	Max    []float64
	Min    []float64
	Radius float64
}

type Constellation struct {
	ConstellationID int64 `yaml:"constellationID"`
	Center          []float64
	Max             []float64
	Min             []float64
	NameID          int64 `yaml:"nameID"`
	Radius          float64
	FactionID       *int64 `yaml:"factionID"`
}

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
	db              *sql.DB
	path            string
	tx              *sql.Tx
}

func getItemNameByID(db *sql.DB, itemID int64) (string, error) {
	var name string

	row := db.QueryRow(`SELECT itemname from sdeyaml.invnames where itemid = $1`, itemID)
	err := row.Scan(&name)
	if err != nil {
		return "", nil
	}

	return name, nil
}

func (r *Region) ImportConstellation(path string) error {
	f, err := os.Open(path)
	if err != nil {
		return err
	}
	defer f.Close()

	var c Constellation

	err = utils.LoadFromReader(f, &c)
	if err != nil {
		return err
	}

	constStmt, err := InsertConstellationsStmt(r.tx)
	if err != nil {
		return err
	}

	log.Println(path)
	spew.Dump(c)

	constellationName, err := getItemNameByID(r.db, c.ConstellationID)
	if err != nil {
		return err
	}

	var factionID *int64
	if c.FactionID != nil {
		factionID = c.FactionID
	} else {
		factionID = r.FactionID
	}
	_, err = constStmt.Exec(r.RegionID,
		c.ConstellationID,
		constellationName,
		c.Center[0],
		c.Center[1],
		c.Center[2],
		c.Max[0],
		c.Max[1],
		c.Max[2],
		c.Min[0],
		c.Min[1],
		c.Min[2],
		c.Radius,
		factionID,
	)
	if err != nil {
		return err
	}
	return nil
}

func (r *Region) ImportConstellations() error {
	constellations, err := filepath.Glob(filepath.Join(r.path, "*", "constellation.staticdata"))
	if err != nil {
		return err
	}

	for _, constellationFile := range constellations {
		err = r.ImportConstellation(constellationFile)
		if err != nil {
			return err
		}
	}

	return nil
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

	regionName, err := getItemNameByID(db, region.RegionID)
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
	denormStmt, err := InsertMapDenormalizeStmt(tx)
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

	_, err = denormStmt.Exec(region.RegionID,
		3,
		3,
		regionName,
		region.Center[0],
		region.Center[1],
		region.Center[2],
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

	region.db = db
	region.path, _ = filepath.Split(path)
	region.tx = tx
	err = region.ImportConstellations()
	if err != nil {
		return err
	}
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

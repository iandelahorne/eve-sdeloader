package universe

import (
	"database/sql"
	"os"
	"path/filepath"

	"github.com/lflux/eve-sdeloader/utils"
)

type Constellation struct {
	ConstellationID int64 `yaml:"constellationID"`
	Center          []float64
	Max             []float64
	Min             []float64
	NameID          int64 `yaml:"nameID"`
	Radius          float64
	FactionID       *int64 `yaml:"factionID"`
	WormholeClassID int64  `yaml:"wormholeClassID"`
	tx              *sql.Tx
	path            string
	region          *Region
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

	constellationName, err := getItemNameByID(c.ConstellationID)
	if err != nil {
		return err
	}

	denormStmt, err := InsertRegionMapDenormalizeStmt(r.tx)
	if err != nil {
		return err
	}

	whClassStmt, err := InsertMapWHClassesStmt(r.tx)
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

	// XXX change this to use the bigger denormalize statement
	_, err = denormStmt.Exec(c.ConstellationID,
		r.RegionID,
		4,
		4,
		constellationName,
		// XXX This should be c.Center but the python importer uses the region center.
		r.Center[0],
		r.Center[1],
		r.Center[2],
	)
	if err != nil {
		return err
	}

	if c.WormholeClassID != 0 {
		_, err = whClassStmt.Exec(c.ConstellationID, c.WormholeClassID)
		if err != nil {
			return err
		}
	}

	c.tx = r.tx
	c.path, _ = filepath.Split(path)
	c.region = r
	err = c.ImportSystems()
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

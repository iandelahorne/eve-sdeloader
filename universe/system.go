package universe

import (
	"os"
	"path/filepath"

	"github.com/lflux/eve-sdeloader/utils"
)

type StarStatistics struct {
	Age           float64
	Life          float64
	Luminosity    float64
	Radius        float64
	SpectralClass string `yaml:"spectralClass"`
	Temperature   float64
}

type Star struct {
	ID         int64
	Radius     int64
	TypeID     int64 `yaml:"typeID"`
	Statistics StarStatistics
}

type SecondarySun struct {
	EffectBeaconTypeID int64 `yaml:"effectBeaconTypeID"`
	ItemID             int64 `yaml:"itemID"`
	Position           []float64
	TypeID             int64 `yaml:"typeID"`
}

type Stargate struct {
	Destination int64
	Position    []float64
	TypeID      int64 `yaml:"typeID"`
}

type AsteroidBelt struct {
	Position []float64
	TypeID   int64 `yaml:"typeID"`
}

type Moon struct {
	Position []float64
	Radius   int64
	TypeID   int64 `yaml:"typeID"`
}

type Planet struct {
	AsteroidBelts  map[int64]AsteroidBelt `yaml:"asteroidBelts"`
	Moons          map[int64]Moon
	CelestialIndex int64 `yaml:"celestialIndex"`
	Position       []float64
	TypeID         int64 `yaml:"typeID"`
	Radius         float64
}

type SolarSystem struct {
	Border          bool
	Center          []float64
	Corridor        bool
	FactionID       *float64 `yaml:"factionID"`
	Fringe          bool
	Hub             bool
	International   bool
	Luminosity      float64
	Max             []float64
	Min             []float64
	Radius          float64
	Regional        bool
	SecondarySun    *SecondarySun `yaml:"secondarySun"`
	Security        float64
	SecurityClass   string `yaml:"securityClass"`
	SolarSystemID   int64  `yaml:"solarSystemID"`
	Stargates       map[int64]Stargate
	Planets         map[int64]Planet
	Star            Star
	SunTypeID       int64 `yaml:"sunTypeID"`
	WormHoleClassID int64 `yaml:"wormholeClassID"`
}

func (c *Constellation) ImportSystem(path string) error {
	f, err := os.Open(path)
	if err != nil {
		return err
	}
	defer f.Close()

	var s SolarSystem
	err = utils.LoadFromReader(f, &s)
	if err != nil {
		return err
	}
	// solarSystemName, err := getItemNameByID(c.db, s.SolarSystemID)
	// if err != nil {
	// 	return err
	// }
	starName, err := getItemNameByID(c.db, s.Star.ID)
	if err != nil {
		return err
	}

	starDenormStmt, err := InsertStarDenormalizeStmt(c.tx)
	if err != nil {
		return err
	}

	_, err = starDenormStmt.Exec(
		s.Star.ID,
		s.Star.TypeID,
		6,
		s.SolarSystemID,
		c.region.RegionID,
		c.ConstellationID,
		0,
		0,
		0,
		s.Star.Radius,
		starName,
		s.Security)
	if err != nil {
		return err
	}

	if s.SecondarySun != nil {
		_, err = starDenormStmt.Exec(
			s.SecondarySun.ItemID,
			s.SecondarySun.TypeID,
			995,
			s.SolarSystemID,
			c.region.RegionID,
			c.ConstellationID,
			s.SecondarySun.Position[0],
			s.SecondarySun.Position[1],
			s.SecondarySun.Position[2],
			nil,
			"Unknown Anomaly",
			0)
		if err != nil {
			return err
		}
	}

	return nil
}

func (c *Constellation) ImportSystems() error {
	systems, err := filepath.Glob(filepath.Join(c.path, "*", "solarsystem.staticdata"))
	if err != nil {
		return err
	}

	for _, systemFile := range systems {
		err = c.ImportSystem(systemFile)
		if err != nil {
			return err
		}
	}

	return nil

}

package universe

import (
	"fmt"
	"os"
	"path/filepath"

	"github.com/pkg/errors"

	"github.com/lflux/eve-sdeloader/utils"
)

type Star struct {
	ID         int64
	Radius     int64
	TypeID     int64 `yaml:"typeID"`
	Statistics CelestialStatistics
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
	FactionID       *int64 `yaml:"factionID"`
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
	SecurityClass   *string `yaml:"securityClass"`
	SolarSystemID   int64   `yaml:"solarSystemID"`
	Stargates       map[int64]Stargate
	Planets         map[int64]Planet
	Star            Star
	SunTypeID       int64 `yaml:"sunTypeID"`
	WormholeClassID int64 `yaml:"wormholeClassID"`
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

	solarSystemName, err := getItemNameByID(c.db, s.SolarSystemID)
	if err != nil {
		return err
	}

	starName, err := getItemNameByID(c.db, s.Star.ID)
	if err != nil {
		return err
	}

	starDenormStmt, err := InsertStarDenormalizeStmt(c.tx)
	if err != nil {
		return err
	}

	solarSystemStmt, err := InsertSolarSystemStmt(c.tx)
	if err != nil {
		return errors.Wrap(err, "Error creating solar system statement")
	}

	whClassStmt, err := InsertMapWHClassesStmt(c.tx)
	if err != nil {
		return errors.Wrap(err, "Error creating InsertMapWHClassesStmt")
	}

	celestialStmt, err := InsertCelestialStatsStmt(c.tx)
	if err != nil {
		return errors.Wrap(err, "Error creating InsertCelestialStatsStmt")
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
		return errors.Wrap(err, fmt.Sprintf("Error inserting star data for system %s", solarSystemName))
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
			return errors.Wrap(err, fmt.Sprintf("Error inserting secondary sun for system %s", solarSystemName))
		}
	}

	var factionID *int64
	if s.FactionID != nil {
		factionID = s.FactionID
	} else if c.FactionID != nil {
		factionID = c.FactionID
	} else {
		factionID = c.region.FactionID
	}

	_, err = solarSystemStmt.Exec(
		c.region.RegionID,
		c.ConstellationID,
		s.SolarSystemID,
		solarSystemName,
		s.Center[0],
		s.Center[1],
		s.Center[2],
		s.Max[0],
		s.Max[1],
		s.Max[2],
		s.Min[0],
		s.Min[1],
		s.Min[2],
		s.Luminosity,
		s.Border,
		s.Fringe,
		s.Corridor,
		s.Hub,
		s.International,
		s.Regional,
		s.Security,
		factionID,
		s.Radius,
		s.SunTypeID,
		s.SecurityClass,
	)

	if err != nil {
		return errors.Wrap(err, fmt.Sprintf("Error inserting solar system %s", solarSystemName))
	}

	if s.WormholeClassID != 0 {
		_, err = whClassStmt.Exec(s.SolarSystemID, s.WormholeClassID)
		if err != nil {
			return errors.Wrap(err, fmt.Sprintf("Error inserting wormhole data for solar system %s", solarSystemName))
		}
	}

	_, err = celestialStmt.Exec(
		s.Star.ID,
		s.Star.Statistics.Temperature,
		s.Star.Statistics.SpectralClass,
		s.Star.Statistics.Luminosity,
		s.Star.Statistics.Age,
		s.Star.Statistics.Life,
		s.Star.Statistics.OrbitRadius,
		s.Star.Statistics.Eccentricity,
		s.Star.Statistics.MassDust,
		s.Star.Statistics.MassGas,
		s.Star.Statistics.Fragmented,
		s.Star.Statistics.Density,
		s.Star.Statistics.SurfaceGravity,
		s.Star.Statistics.EscapeVelocity,
		s.Star.Statistics.OrbitPeriod,
		s.Star.Statistics.RotationRate,
		s.Star.Statistics.Locked,
		s.Star.Statistics.Pressure,
		s.Star.Statistics.Radius,
		nil,
	)
	if err != nil {
		return errors.Wrap(err, fmt.Sprintf("Error inserting statistics data for solar system %s", solarSystemName))
	}

	err = s.ImportPlanets()
	if err != nil {
		return errors.Wrap(err, fmt.Sprintf("Error inserting planet data for solar system %s", solarSystemName))
	}

	err = s.ImportStargates()
	if err != nil {
		return errors.Wrap(err, fmt.Sprintf("Error inserting stargate data for solar system %s", solarSystemName))
	}

	return nil
}

func (s *SolarSystem) ImportPlanets() error {
	return nil
}

func (s *SolarSystem) ImportStargates() error {
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

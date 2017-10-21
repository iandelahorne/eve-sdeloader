package universe

import (
	"database/sql"
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

type Moon struct {
	Position    []float64
	Radius      int64
	TypeID      int64                `yaml:"typeID"`
	NPCStations map[int64]NPCStation `yaml:"npcStations"`
}

type NPCStation struct {
	GraphicID                int64 `yaml:"graphicID"`
	GroupID                  int64 `yaml:"groupID"`
	IsConquerable            bool  `yaml:"isConquerable"`
	OwnerID                  int64 `yaml:"ownerID"`
	Position                 []float64
	ReprocessingEfficiency   float64 `yaml:"reprocessingEfficiency"`
	ReprocessingHangarFlag   int64   `yaml:"reprocessingHangarFlag"`
	ReprocessingStationsTake float64 `yaml:"reprocessingStationsTake"`
	TypeID                   int64   `yaml:"typeID"`
	UseOperationName         bool    `yaml:"useOperationName"`
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
	NPCStations     map[int64]NPCStation `yaml:"npcStations"`
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
	constellation   *Constellation
	name            string
	denormStmt      *sql.Stmt
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

	solarSystemName, err := getItemNameByID(s.SolarSystemID)
	if err != nil {
		return err
	}

	starName, err := getItemNameByID(s.Star.ID)
	if err != nil {
		return err
	}

	s.denormStmt, err = InsertOrbitalDenormStmt(c.tx)
	if err != nil {
		return errors.Wrap(err, "Error creating OrbitalDenormalize statement")
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

	mapJumpStmt, err := InsertMapJumpStmt(c.tx)

	_, err = s.denormStmt.Exec(
		s.Star.ID,
		s.Star.TypeID,
		6,
		s.SolarSystemID,
		c.ConstellationID,
		c.region.RegionID,
		nil,
		0,
		0,
		0,
		s.Star.Radius,
		starName,
		s.Security,
		nil,
		nil)
	if err != nil {
		return errors.Wrap(err, fmt.Sprintf("Error inserting star data for system %s", solarSystemName))
	}

	if s.SecondarySun != nil {
		_, err = s.denormStmt.Exec(
			s.SecondarySun.ItemID,
			s.SecondarySun.TypeID,
			995,
			s.SolarSystemID,
			c.ConstellationID,
			c.region.RegionID,
			nil,
			s.SecondarySun.Position[0],
			s.SecondarySun.Position[1],
			s.SecondarySun.Position[2],
			nil,
			"Unknown Anomaly",
			0,
			nil,
			nil)
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

	_, err = s.denormStmt.Exec(
		s.SolarSystemID,
		5,
		5,
		nil,
		c.ConstellationID,
		c.region.RegionID,
		nil,
		s.Center[0],
		s.Center[1],
		s.Center[2],
		s.Radius,
		solarSystemName,
		s.Security,
		nil,
		nil,
	)
	if err != nil {
		return errors.Wrap(err, fmt.Sprintf("Error inserting solar system denormalize %s", solarSystemName))
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

	for stargateID, stargate := range s.Stargates {
		var groupID int64
		groupID, err = getGroupIDByTypeID(stargate.TypeID)
		if err != nil {
			return errors.Wrap(err, fmt.Sprintf("Error fetching groupID for stargate %d for solar system %s", stargateID, solarSystemName))
		}

		_, err = mapJumpStmt.Exec(stargateID, stargate.Destination)
		if err != nil {
			return errors.Wrap(err, fmt.Sprintf("Error inserting stargate %d for solar system %s", stargateID, solarSystemName))
		}
		_, err = s.denormStmt.Exec(
			stargateID,
			stargate.TypeID,
			groupID,
			s.SolarSystemID,
			c.ConstellationID,
			c.region.RegionID,
			nil,
			stargate.Position[0],
			stargate.Position[1],
			stargate.Position[2],
			nil,
			nil,
			s.Security,
			nil,
			nil,
		)
	}

	if err != nil {
		return errors.Wrap(err, fmt.Sprintf("Error inserting stargate data for solar system %s", solarSystemName))
	}

	s.constellation = c
	s.name = solarSystemName
	err = s.ImportPlanets()
	if err != nil {
		return errors.Wrap(err, fmt.Sprintf("Error inserting planet data for solar system %s", solarSystemName))
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

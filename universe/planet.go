package universe

import (
	"fmt"

	"github.com/pkg/errors"
)

type AsteroidBelt struct {
	Position   []float64
	Statistics CelestialStatistics
	TypeID     int64 `yaml:"typeID"`
}

type Planet struct {
	AsteroidBelts  map[int64]AsteroidBelt `yaml:"asteroidBelts"`
	Moons          map[int64]Moon
	NPCStations    map[int64]NPCStation `yaml:"npcStations"`
	CelestialIndex int64                `yaml:"celestialIndex"`
	Position       []float64
	TypeID         int64 `yaml:"typeID"`
	Radius         float64
	Statistics     CelestialStatistics
	solarSystem    *SolarSystem
	name           string
	groupID        int64
	planetID       int64
}

func (s *SolarSystem) ImportPlanet(planetID int64, planet Planet) error {
	var err error
	planet.name, err = getItemNameByID(planetID)
	if err != nil {
		return errors.Wrap(err, fmt.Sprintf("Error fetching planet name for planet %d, solar system %s",
			planetID, s.name))
	}

	planet.groupID, err = getGroupIDByTypeID(planet.TypeID)
	if err != nil {
		return errors.Wrap(err, fmt.Sprintf("Error fetching group ID for planet %s (%d), solar system %s",
			planet.name, planetID, s.name))
	}

	_, err = s.denormStmt.Exec(
		planetID,
		planet.TypeID,
		planet.groupID,
		s.SolarSystemID,
		s.constellation.ConstellationID,
		s.constellation.region.RegionID,
		s.Star.ID,
		planet.Position[0],
		planet.Position[1],
		planet.Position[2],
		planet.Radius,
		planet.name,
		s.Security,
		planet.CelestialIndex,
		nil,
	)
	if err != nil {
		return errors.Wrap(err, fmt.Sprintf("Error inserting mapDenormalize for planet %s, solar system %s",
			planet.name, s.name))
	}

	err = insertCelestialStatistics(s.celestialStmt, planetID, planet.Statistics)
	if err != nil {
		return errors.Wrap(err, fmt.Sprintf("Error inserting mapCelestial for planet %s, solar system %s",
			planet.name, s.name))
	}

	err = planet.ImportBelts()
	if err != nil {
		return err
	}

	err = planet.ImportMoons()
	if err != nil {
		return err
	}

	for stationID, station := range planet.NPCStations {
		stationName, err := getItemNameByID(stationID)
		if err != nil {
			return errors.Wrap(err, fmt.Sprintf("Error fetching station name for station %d, solar system %s",
				stationID, s.name))
		}
		stationGroupID, err := getGroupIDByTypeID(station.TypeID)
		if err != nil {
			return errors.Wrap(err, fmt.Sprintf("Error fetching station groupid for station %s, solar system %s",
				stationName, s.name))
		}

		_, err = s.denormStmt.Exec(
			stationID,
			station.TypeID,
			stationGroupID,
			s.SolarSystemID,
			s.constellation.ConstellationID,
			s.constellation.region.RegionID,
			planetID,
			station.Position[0],
			station.Position[1],
			station.Position[2],
			nil,
			stationName,
			s.Security,
			nil,
			nil,
		)
		if err != nil {
			return errors.Wrap(err, fmt.Sprintf("Error inserting NPC station %s", stationName))
		}
	}
	return nil
}

func (p *Planet) ImportBelts() error {
	for beltID, belt := range p.AsteroidBelts {
		beltName, err := getItemNameByID(beltID)
		if err != nil {
			return errors.Wrap(err, fmt.Sprintf("Error fetching belt name for belt %d, planet %s, solar system %s",
				beltID,
				p.name,
				p.solarSystem.name))
		}

		beltGroupID, err := getGroupIDByTypeID(belt.TypeID)
		if err != nil {
			return errors.Wrap(err, fmt.Sprintf("Error fetching group ID for belt %s (%d) planet %s (%d), solar system %s",
				beltName, beltGroupID,
				p.name, p.planetID, p.solarSystem.name))
		}

		_, err = p.solarSystem.denormStmt.Exec(
			beltID,
			belt.TypeID,
			beltGroupID,
			p.solarSystem.SolarSystemID,
			p.solarSystem.constellation.ConstellationID,
			p.solarSystem.constellation.region.RegionID,
			p.planetID,
			belt.Position[0],
			belt.Position[1],
			belt.Position[2],
			1,
			beltName,
			p.solarSystem.Security,
			p.CelestialIndex,
			nil, // XXX need to fix orbit index
		)

		if err != nil {
			return errors.Wrap(err, fmt.Sprintf("Error inserting belt mapDenormalize for belt %s, planet %s, solar system %s",
				beltName, p.name, p.solarSystem.name))
		}

		err = insertCelestialStatistics(p.solarSystem.celestialStmt, beltID, belt.Statistics)
		if err != nil {
			return errors.Wrap(err, fmt.Sprintf("Error inserting belt mapCelestialStatistics for belt %s, planet %s, solar system %s",
				beltName, p.name, p.solarSystem.name))
		}

	}

	return nil
}

func (p *Planet) ImportMoons() error {
	for moonID, moon := range p.Moons {
		moonName, err := getItemNameByID(moonID)
		if err != nil {
			return errors.Wrap(err, fmt.Sprintf("Error fetching moon name for moon %d, planet %s, solar system %s",
				moonID,
				p.name,
				p.solarSystem.name))
		}

		moonGroupID, err := getGroupIDByTypeID(moon.TypeID)
		if err != nil {
			return errors.Wrap(err, fmt.Sprintf("Error fetching group ID for moon %s (%d) planet %s (%d), solar system %s",
				moonName, moonGroupID,
				p.name, p.planetID, p.solarSystem.name))
		}

		_, err = p.solarSystem.denormStmt.Exec(
			moonID,
			moon.TypeID,
			moonGroupID,
			p.solarSystem.SolarSystemID,
			p.solarSystem.constellation.ConstellationID,
			p.solarSystem.constellation.region.RegionID,
			p.planetID,
			moon.Position[0],
			moon.Position[1],
			moon.Position[2],
			moon.Radius,
			moonName,
			p.solarSystem.Security,
			p.CelestialIndex,
			nil, // XXX need to fix orbit index
		)

		if err != nil {
			return err
		}

		err = insertCelestialStatistics(p.solarSystem.celestialStmt, moonID, moon.Statistics)
		if err != nil {
			return err
		}

		for stationID, station := range moon.NPCStations {
			stationName, err := getItemNameByID(stationID)
			if err != nil {
				return errors.Wrap(err, fmt.Sprintf("Error fetching station name for station %d, solar system %s",
					stationID, p.solarSystem.name))
			}
			stationGroupID, err := getGroupIDByTypeID(station.TypeID)
			if err != nil {
				return errors.Wrap(err, fmt.Sprintf("Error fetching station groupid for station %s, solar system %s",
					stationName, p.solarSystem.name))
			}

			_, err = p.solarSystem.denormStmt.Exec(
				stationID,
				station.TypeID,
				stationGroupID,
				p.solarSystem.SolarSystemID,
				p.solarSystem.constellation.ConstellationID,
				p.solarSystem.constellation.region.RegionID,
				moonID,
				station.Position[0],
				station.Position[1],
				station.Position[2],
				nil,
				stationName,
				p.solarSystem.Security,
				nil,
				nil,
			)
			if err != nil {
				return errors.Wrap(err, fmt.Sprintf("Error inserting NPC station %s", stationName))
			}
		}
	}
	return nil
}

func (s *SolarSystem) ImportPlanets() error {
	var err error
	for planetID, planet := range s.Planets {
		planet.planetID = planetID
		planet.solarSystem = s
		err = s.ImportPlanet(planetID, planet)
		if err != nil {
			return err
		}
	}

	return nil
}

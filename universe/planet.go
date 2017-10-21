package universe

import (
	"fmt"
	"sort"

	"github.com/pkg/errors"
)

type AsteroidBelt struct {
	Position   []float64
	Statistics CelestialStatistics
	TypeID     int64 `yaml:"typeID"`
	beltID     int64
	groupID    int64
	name       string
	planet     *Planet
}
type AsteroidBelts []AsteroidBelt

func (b AsteroidBelts) Len() int {
	return len(b)
}
func (b AsteroidBelts) Swap(i, j int) {
	b[i], b[j] = b[j], b[i]
}

func (b AsteroidBelts) Less(i, j int) bool {
	return distance(b[i].Position, b[i].planet.Position) < distance(b[j].Position, b[j].planet.Position)
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
	var err error
	var belts = make(AsteroidBelts, 0, len(p.AsteroidBelts))
	for beltID, belt := range p.AsteroidBelts {
		belt.planet = p
		belt.beltID = beltID
		belt.name, err = getItemNameByID(beltID)
		if err != nil {
			return errors.Wrap(err, fmt.Sprintf("Error fetching belt name for belt %d, planet %s, solar system %s",
				beltID,
				p.name,
				p.solarSystem.name))
		}

		belt.groupID, err = getGroupIDByTypeID(belt.TypeID)
		if err != nil {
			return errors.Wrap(err, fmt.Sprintf("Error fetching group ID for belt %s (%d) planet %s (%d), solar system %s",
				belt.name, belt.groupID,
				p.name, p.planetID, p.solarSystem.name))
		}
		err = insertCelestialStatistics(p.solarSystem.celestialStmt, beltID, belt.Statistics)
		if err != nil {
			return errors.Wrap(err, fmt.Sprintf("Error inserting belt mapCelestialStatistics for belt %s, planet %s, solar system %s",
				belt.name, p.name, p.solarSystem.name))
		}
		belts = append(belts, belt)
	}

	sort.Sort(belts)
	for index, belt := range belts {
		_, err = p.solarSystem.denormStmt.Exec(
			belt.beltID,
			belt.TypeID,
			belt.groupID,
			p.solarSystem.SolarSystemID,
			p.solarSystem.constellation.ConstellationID,
			p.solarSystem.constellation.region.RegionID,
			p.planetID,
			belt.Position[0],
			belt.Position[1],
			belt.Position[2],
			1,
			belt.name,
			p.solarSystem.Security,
			p.CelestialIndex,
			index+1,
		)

		if err != nil {
			return errors.Wrap(err, fmt.Sprintf("Error inserting belt mapDenormalize for belt %s, planet %s, solar system %s",
				belt.name, p.name, p.solarSystem.name))
		}
	}

	return nil
}

func (p *Planet) ImportMoons() error {
	var moons = make(Moons, 0, len(p.Moons))
	var err error
	for moonID, moon := range p.Moons {
		moon.moonID = moonID
		moon.planet = p
		moon.name, err = getItemNameByID(moonID)
		if err != nil {
			return errors.Wrap(err, fmt.Sprintf("Error fetching moon name for moon %d, planet %s, solar system %s",
				moonID,
				p.name,
				p.solarSystem.name))
		}

		moon.groupID, err = getGroupIDByTypeID(moon.TypeID)
		if err != nil {
			return errors.Wrap(err, fmt.Sprintf("Error fetching group ID for moon %s (%d) planet %s (%d), solar system %s",
				moon.name, moonID,
				p.name, p.planetID, p.solarSystem.name))
		}

		err = insertCelestialStatistics(p.solarSystem.celestialStmt, moonID, moon.Statistics)
		if err != nil {
			return err
		}

		for stationID, station := range moon.NPCStations {
			var stationName string
			stationName, err = getItemNameByID(stationID)
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
		moons = append(moons, moon)
	}

	sort.Sort(moons)
	for index, moon := range moons {
		_, err = p.solarSystem.denormStmt.Exec(
			moon.moonID,
			moon.TypeID,
			moon.groupID,
			p.solarSystem.SolarSystemID,
			p.solarSystem.constellation.ConstellationID,
			p.solarSystem.constellation.region.RegionID,
			p.planetID,
			moon.Position[0],
			moon.Position[1],
			moon.Position[2],
			moon.Radius,
			moon.name,
			p.solarSystem.Security,
			p.CelestialIndex,
			index+1, // XXX need to fix orbit index
		)

		if err != nil {
			return errors.Wrap(err, fmt.Sprintf("Error inserting moon %s (%d)", moon.name, moon.moonID))
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

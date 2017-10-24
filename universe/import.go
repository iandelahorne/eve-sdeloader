package universe

import (
	"database/sql"
	"fmt"
	"log"
	"os"
	"path/filepath"
	"strconv"

	"github.com/lflux/eve-sdeloader/inventory"
	"github.com/lflux/eve-sdeloader/utils"
	"github.com/pkg/errors"
)

type InvName struct {
	ID   int64  `yaml:"itemID"`
	Name string `yaml:"itemName"`
}

var invNames map[int64]string

type CelestialStatistics struct {
	Age            *float64
	Density        *float64
	Eccentricity   *float64
	EscapeVelocity *float64 `yaml:"escapeVelocity"`
	Fragmented     *bool
	Life           *float64
	Locked         *bool
	Luminosity     *float64
	MassDust       *float64 `yaml:"massDust"`
	MassGas        *float64 `yaml:"massGas"`
	OrbitPeriod    *float64 `yaml:"orbitPeriod"`
	OrbitRadius    *float64 `yaml:"orbitRadius"`
	Pressure       *float64
	Radius         *float64
	RotationRate   *float64 `yaml:"rotationRate"`
	SpectralClass  *string  `yaml:"spectralClass"`
	SurfaceGravity *float64 `yaml:"surfaceGravity"`
	Temperature    *float64
}

func getItemNameByID(itemID int64) (string, error) {
	if len(invNames) == 0 {
		return "", errors.New("invNames not populated")
	}
	var ok bool
	var name string
	if name, ok = invNames[itemID]; ok {
		return name, nil
	}

	return "", fmt.Errorf("No invName entry found for %d", itemID)

}

func getGroupIDByTypeID(typeID int64) (int64, error) {
	if len(inventory.TypeIDs) == 0 {
		return 0, errors.New("Inventory must be imported before universe")
	}
	id := strconv.FormatInt(typeID, 10)
	if e, ok := inventory.TypeIDs[id]; ok {
		return e.GroupID, nil
	}

	return 0, fmt.Errorf("No inventory ID found for %d", typeID)
}

func distance(a, b []float64) float64 {
	var norm float64
	for i, v := range a {
		diff := b[i] - v
		norm += diff * diff
	}

	return norm
}

func insertCelestialStatistics(stmt *sql.Stmt, id int64, stats CelestialStatistics) error {
	var err error
	_, err = stmt.Exec(
		id,
		stats.Temperature,
		stats.SpectralClass,
		stats.Luminosity,
		stats.Age,
		stats.Life,
		stats.OrbitRadius,
		stats.Eccentricity,
		stats.MassDust,
		stats.MassGas,
		stats.Fragmented,
		stats.Density,
		stats.SurfaceGravity,
		stats.EscapeVelocity,
		stats.OrbitPeriod,
		stats.RotationRate,
		stats.Locked,
		stats.Pressure,
		stats.Radius,
		nil,
	)
	return err
}

func fixStationNames(db *sql.DB) error {
	stmt := `
UPDATE
	staStations
SET
	stationName = (
		SELECT
			itemName
		FROM
			invNames
		WHERE
			staStations.stationID = itemID
	)
`
	_, err := db.Exec(stmt)
	return err
}
func Import(db *sql.DB, regionPath, invNamePath string) error {
	regions, err := filepath.Glob(filepath.Join(regionPath, "*", "*", "region.staticdata"))

	if err != nil {
		return err
	}

	f, err := os.Open(invNamePath)
	if err != nil {
		return err
	}
	defer f.Close()

	entries := make([]InvName, 0)
	err = utils.LoadFromReader(f, &entries)
	if err != nil {
		return err
	}

	invNames = make(map[int64]string, len(entries))
	for _, entry := range entries {
		invNames[entry.ID] = entry.Name
	}

	for _, regionFile := range regions {
		log.Println(regionFile)
		err = ImportRegion(db, regionFile)
		if err != nil {
			return err
		}
	}

	err = FixMapJumps(db)
	if err != nil {
		return err
	}

	return fixStationNames(db)
}

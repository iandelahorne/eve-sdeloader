package universe

import (
	"database/sql"
	"log"
	"path/filepath"
)

type CelestialStatistics struct {
	Age            *float64
	Density        *float64
	Eccentricity   *float64
	EscapeVelocity *float64 `yaml:"escapeVelocity"`
	Fragmented     *bool
	Life           *float64
	Locked         bool
	Luminosity     *float64
	MassDust       *float64 `yaml:"massDust"`
	MassGas        *float64 `yaml:"massGas"`
	OrbitPeriod    *float64 `yaml:"orbitPeriod"`
	OrbitRadius    *float64 `yaml:"orbitRadius"`
	Pressure       *int64
	Radius         *int64
	RotationRate   *float64 `yaml:"rotationRate"`
	SpectralClass  *string  `yaml:"spectralClass"`
	SurfaceGravity *float64 `yaml:"surfaceGravity"`
	Temperature    *float64
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

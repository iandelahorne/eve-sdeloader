package main

import (
	"database/sql"
	"flag"
	"fmt"
	"log"
	"path/filepath"

	_ "github.com/lib/pq"

	"github.com/lflux/eve-sdeloader/groups"
	"github.com/lflux/eve-sdeloader/icons"
	"github.com/lflux/eve-sdeloader/inventory"
	"github.com/lflux/eve-sdeloader/translations"
)

const (
	typeIDFile   = `fsd/typeIDs.yaml`
	iconFile     = `fsd/iconIDs.yaml`
	groupsIDFile = `fsd/groupIDs.yaml`
)

var (
	dbUser, dbName, dbHost, dbPassword string
	dbPort                             int
	sdeDirectory                       string
)

func init() {
	flag.IntVar(&dbPort, "dbport", 5432, "Database port")
	flag.StringVar(&dbUser, "dbuser", "sdetest", "Database username")
	flag.StringVar(&dbHost, "dbhost", "localhost", "Database host")
	flag.StringVar(&dbName, "dbname", "sdetest", "Database name")
	flag.StringVar(&dbPassword, "dbpassword", "", "Database password")
	flag.StringVar(&sdeDirectory, "sdedirectory", "./sde", "Directory containing an unzipped EVE SDE YAML dump")
}

func main() {
	flag.Parse()
	connStr := fmt.Sprintf("user=%s dbname=%s host=%s port=%d sslmode=disable",
		dbUser,
		dbName,
		dbHost,
		dbPort,
	)
	if dbPassword != "" {
		connStr += " password=" + dbPassword
	}

	db, err := sql.Open("postgres", connStr)
	if err != nil {
		log.Fatalf("Could not connect to database with connection string `%s`: %s", connStr, err)
	}
	defer func() {
		_ = db.Close()
	}()

	err = icons.CreateTables(db)
	if err != nil {
		log.Fatalf("could not create icon tables: %s", err)
	}

	err = inventory.CreateTables(db)
	if err != nil {
		log.Fatalf("could not create inventory tables: %s", err)
	}
	err = translations.CreateTables(db)
	if err != nil {
		log.Fatalf("could not create translation tables: %s", err)
	}
	err = groups.CreateTables(db)
	if err != nil {
		log.Fatalf("could not create translation tables: %s", err)
	}

	iconPath := filepath.Join(sdeDirectory, iconFile)

	log.Println("Importing icons from ", iconPath)
	err = icons.ImportFile(db, iconPath)
	if err != nil {
		log.Fatalf("Error importing icons: %s", err)
	}

	groupsPath := filepath.Join(sdeDirectory, groupsIDFile)
	log.Println("Importing groups from ", groupsPath)
	err = groups.ImportFile(db, groupsPath)
	if err != nil {
		log.Fatalf("Error importing groups: %s", err)
	}

	typePath := filepath.Join(sdeDirectory, typeIDFile)

	log.Println("Importing invtypes from ", typePath)
	err = inventory.ImportFile(db, typePath)
	if err != nil {
		log.Fatalf("Error importing invtypes: %s", err)
	}
	log.Println("Import finished")

}

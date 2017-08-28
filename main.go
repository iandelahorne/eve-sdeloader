package main

import (
	"database/sql"
	"flag"
	"fmt"
	"log"
	"path/filepath"

	_ "github.com/lib/pq"

	"github.com/lflux/eve-sdeloader/inventory"
	"github.com/lflux/eve-sdeloader/translations"
)

const typeIDFile = `fsd/typeIDs.yaml`

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

	err = inventory.CreateTables(db)
	if err != nil {
		log.Fatalf("could not create inventory tables: %s", err)
	}
	err = translations.CreateTables(db)
	if err != nil {
		log.Fatalf("could not create translation tables: %s", err)
	}

	path := filepath.Join(sdeDirectory, typeIDFile)

	log.Println("Importing invtypes from ", path)
	err = inventory.ImportFile(db, path)
	if err != nil {
		log.Fatalf("Error importing invtypes: %s", err)
	}
	log.Println("Import finished")
}

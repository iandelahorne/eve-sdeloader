package main

import (
	"database/sql"
	"flag"
	"fmt"
	"log"
	"os"
	"path/filepath"
	"runtime"
	"runtime/pprof"

	"github.com/lflux/eve-sdeloader/utils"

	_ "github.com/lib/pq"

	"github.com/lflux/eve-sdeloader/bsd"
	"github.com/lflux/eve-sdeloader/groups"
	"github.com/lflux/eve-sdeloader/icons"
	"github.com/lflux/eve-sdeloader/inventory"
)

const (
	typeIDFile   = `fsd/typeIDs.yaml`
	iconFile     = `fsd/iconIDs.yaml`
	groupsIDFile = `fsd/groupIDs.yaml`
)

var (
	cpuprofile, memprofile             string
	dbUser, dbName, dbHost, dbPassword string
	dbPort                             int
	sdeDirectory                       string
)

func init() {
	flag.StringVar(&cpuprofile, "cpuprofile", "", "write cpu profile `file`")
	flag.StringVar(&memprofile, "memprofile", "", "write memory profile to `file`")

	flag.IntVar(&dbPort, "dbport", 5432, "Database port")
	flag.StringVar(&dbUser, "dbuser", "sdetest", "Database username")
	flag.StringVar(&dbHost, "dbhost", "localhost", "Database host")
	flag.StringVar(&dbName, "dbname", "sdetest", "Database name")
	flag.StringVar(&dbPassword, "dbpassword", "", "Database password")
	flag.StringVar(&sdeDirectory, "sdedirectory", "./sde", "Directory containing an unzipped EVE SDE YAML dump")
}

func main() {
	flag.Parse()

	if cpuprofile != "" {
		f, err := os.Create(cpuprofile)
		if err != nil {
			log.Fatal("could not create CPU profile: ", err)
		}
		if err := pprof.StartCPUProfile(f); err != nil {
			log.Fatal("could not start CPU profile: ", err)
		}
		defer pprof.StopCPUProfile()
	}

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

	utils.ExecDDLFromFile(db, "schema.sql")
	bsdImporter := &bsd.Importer{DB: db}
	err = bsdImporter.Import(filepath.Join(sdeDirectory, "bsd"), "")
	if err != nil {
		log.Fatalf("Error importing BSD data: %s", err)
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

	if memprofile != "" {
		f, err := os.Create(memprofile)
		if err != nil {
			log.Fatal("could not create memory profile: ", err)
		}
		runtime.GC() // get up-to-date statistics
		if err := pprof.WriteHeapProfile(f); err != nil {
			log.Fatal("could not write memory profile: ", err)
		}
		f.Close()
	}
}

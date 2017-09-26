package main

import (
	"database/sql"
	"flag"
	"fmt"
	"io"
	"log"
	"os"
	"path/filepath"
	"runtime"
	"runtime/pprof"

	"github.com/lflux/eve-sdeloader/bsd"
	"github.com/lflux/eve-sdeloader/graphics"
	"github.com/lflux/eve-sdeloader/groups"
	"github.com/lflux/eve-sdeloader/icons"
	"github.com/lflux/eve-sdeloader/inventory"
	"github.com/lflux/eve-sdeloader/utils"

	_ "github.com/lib/pq"

	"github.com/lflux/eve-sdeloader/categories"
)

type Importer func(*sql.DB, io.Reader) error

const (
	categoryIDFile = `fsd/categoryIDs.yaml`
	graphicIDFile  = `fsd/graphicIDs.yaml`
	groupsIDFile   = `fsd/groupIDs.yaml`
	iconFile       = `fsd/iconIDs.yaml`
	typeIDFile     = `fsd/typeIDs.yaml`
)

var (
	cpuprofile, memprofile             string
	dbUser, dbName, dbHost, dbPassword string
	dbPort                             int
	sdeDirectory                       string
	fsdImporters                       = map[string]Importer{
		"categoryIDs.yaml": categories.Import,
		"graphicIDS.yaml":  graphics.Import,
		"groupIDs.yaml":    groups.Import,
		"iconIDs.yaml":     icons.Import,
		"typeIDs.yaml":     inventory.Import,
	}
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

	err = utils.ExecDDLFromFile(db, "schema.sql")
	if err != nil {
		log.Fatalf("Could import schema.sql: %s", err)
	}

	bsdImporter := &bsd.Importer{DB: db}
	err = bsdImporter.Import(filepath.Join(sdeDirectory, "bsd"), "")
	if err != nil {
		log.Fatalf("Error importing BSD data: %s", err)
	}

	for filename, importer := range fsdImporters {
		path := filepath.Join(sdeDirectory, "fsd", filename)
		log.Println("Importing ", path)
		f, err := os.Open(path)
		if err != nil {
			log.Fatalf("Error importing %s: %s", path, err)
		}
		defer f.Close()

		err = importer(db, f)
		if err != nil {
			log.Fatalf("Error importing %s: %s", path, err)
		}
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

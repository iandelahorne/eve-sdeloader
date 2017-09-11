package main

import (
	"database/sql"
	"flag"
	"fmt"
	"log"
	"os"
	"runtime"
	"runtime/pprof"

	"github.com/lflux/eve-sdeloader/bsd"
)

var (
	cpuprofile string
	dbPort     int
	dbUser     string
	dbHost     string
	dbName     string
	dbPassword string
	memprofile string
	singleFile string
)

func init() {
	flag.IntVar(&dbPort, "dbport", 5432, "Database port")
	flag.StringVar(&dbUser, "dbuser", "sdetest", "Database username")
	flag.StringVar(&dbHost, "dbhost", "localhost", "Database host")
	flag.StringVar(&dbName, "dbname", "sdetest", "Database name")
	flag.StringVar(&dbPassword, "dbpassword", "", "Database password")
	flag.StringVar(&singleFile, "singlefile", "", "Import only one file")
	flag.StringVar(&cpuprofile, "cpuprofile", "", "write cpu profile `file`")
	flag.StringVar(&memprofile, "memprofile", "", "write memory profile to `file`")

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
	i := bsd.Importer{DB: db}
	err = i.Import("/Users/ian/go/src/github.com/lflux/eve-sdeloader/sde/bsd", singleFile)
	if err != nil {
		log.Fatal(err)
	}

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

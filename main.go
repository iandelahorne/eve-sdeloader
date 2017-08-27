package main

import (
	"database/sql"
	"flag"
	"fmt"
	"io/ioutil"
	"log"
	"os"
	"path/filepath"

	"github.com/lib/pq"
	yaml "gopkg.in/yaml.v2"

	"github.com/lflux/eve-sdeloader/inventory"
)

const typeIDFile = `fsd/typeIDs.yaml`
const invTypeDDL = `CREATE TABLE IF NOT EXISTS invtypes (
    typeid integer NOT NULL,
    groupid integer,
    typename varchar,
    description text,
    mass double precision,
    volume double precision,
    capacity double precision,
    portionsize integer,
    raceid integer,
    baseprice numeric(19,4),
    published boolean,
    marketgroupid integer,
    iconid integer,
    soundid integer,
	graphicid integer
)
`

const certMasteriesDDL = `CREATE TABLE IF NOT EXISTS certmasteries (
    typeid integer,
    masterylevel integer,
	certid integer
)
`

var (
	dbUser, dbName, dbHost, dbPassword string
	dbPort                             int
	sdeDirectory                       string
)

func importInventoryTypes(db *sql.DB, entries map[string]*inventory.Type) {
	var invCols = []string{
		"typeid",
		"groupid",
		"typename",
		"description",
		"mass",
		"capacity",
		"portionsize",
		"raceid",
		"published",
		"marketgroupid",
		"graphicid",
		"iconid",
		"soundid",
	}

	txn, err := db.Begin()
	if err != nil {
		log.Fatal(err)
	}
	// There's something weird with multiple pq.CopyIn in the same transaction. Investigate.
	txn2, err := db.Begin()
	if err != nil {
		log.Fatal(err)
	}

	invStmt, err := txn.Prepare(pq.CopyIn("invtypes", invCols...))
	if err != nil {
		log.Fatal(err)
	}

	mastStmt, err := txn2.Prepare(pq.CopyIn("certmasteries", "typeid", "masterylevel", "certid"))
	if err != nil {
		log.Fatal(err)
	}
	log.Println("about to run")
	for typeID, entry := range entries {
		vals := []interface{}{
			typeID,
			entry.GroupID,
			entry.Name["en"],
			entry.Description["en"],
			entry.Mass,
			entry.Capacity,
			entry.PortionSize,
			entry.RaceID,
			entry.Published,
			entry.MarketGroupID,
			entry.GraphicID,
			entry.IconID,
			entry.SoundID,
		}
		_, err = invStmt.Exec(vals...)
		if err != nil {
			log.Fatal(err)
		}
		if len(entry.Masteries) > 0 {
			for level, masteries := range entry.Masteries {
				for _, certID := range masteries {
					_, err = mastStmt.Exec(typeID, level, certID)
					if err != nil {
						log.Fatal(err)
					}
					//					log.Printf("added mastery (%s %s %d)", typeID, level, certID)
				}
			}
		}

	}

	_, err = invStmt.Exec()
	if err != nil {
		log.Fatal(err)
	}
	_, err = mastStmt.Exec()
	if err != nil {
		log.Fatal(err)
	}
	err = invStmt.Close()
	if err != nil {
		log.Fatal(err)
	}
	err = mastStmt.Close()
	if err != nil {
		log.Fatal(err)
	}

	err = txn.Commit()
	if err != nil {
		log.Fatal(err)
	}
	err = txn2.Commit()
	if err != nil {
		log.Fatal(err)
	}

}

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

	// TODO move this to it's own function
	_, err = db.Exec(invTypeDDL)
	if err != nil {
		log.Fatalf("Could not create table: %s", err)
	}

	_, err = db.Exec(certMasteriesDDL)
	if err != nil {
		log.Fatalf("Could not create table: %s", err)
	}

	path := filepath.Join(sdeDirectory, typeIDFile)
	f, err := os.Open(path)

	if err != nil {
		log.Fatalf("Could not open %s: %s", path, err)
	}
	defer func() {
		_ = f.Close()
	}()

	buf, err := ioutil.ReadAll(f)
	if err != nil {
		log.Fatalf("Could not read %s: %s", path, err)
	}

	log.Println("Parsing invtypes from ", path)
	entries := make(map[string]*inventory.Type)
	err = yaml.Unmarshal(buf, entries)
	if err != nil {
		log.Fatalf("Could not parse %s: %s", path, err)
	}
	log.Println("Starting invtypes import")
	importInventoryTypes(db, entries)
	log.Println("Import finished")
}

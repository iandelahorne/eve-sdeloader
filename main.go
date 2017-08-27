package main

import (
	"database/sql"
	"flag"
	"fmt"
	"io/ioutil"
	"log"
	"os"

	"github.com/lib/pq"
	yaml "gopkg.in/yaml.v2"

	"github.com/lflux/eve-sdeloader/inventory"
)

const typeIDFile = `sde/fsd/typeIDs.yaml`
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

var (
	dbUser, dbName, dbHost, dbPassword string
	dbPort                             int
)

func importInventoryTypes(db *sql.DB, entries map[string]*inventory.Type) {
	var columns = []string{
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

	stmt, err := txn.Prepare(pq.CopyIn("invtypes", columns...))
	if err != nil {
		log.Fatal(err)
	}

	for key, entry := range entries {
		vals := []interface{}{
			key,
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
		_, err = stmt.Exec(vals...)
		if err != nil {
			log.Fatal(err)
		}
	}
	_, err = stmt.Exec()
	if err != nil {
		log.Fatal(err)
	}
	err = stmt.Close()
	if err != nil {
		log.Fatal(err)
	}
	err = txn.Commit()
	if err != nil {
		log.Fatal(err)
	}

}

func init() {
	flag.IntVar(&dbPort, "dbport", 5432, "Database port")
	flag.StringVar(&dbUser, "dbuser", "", "Database username")
	flag.StringVar(&dbHost, "dbhost", "localhost", "Database host")
	flag.StringVar(&dbName, "dbname", "sdetest", "Database name")
	flag.StringVar(&dbPassword, "dbpassword", "", "Database password")
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

	_, err = db.Exec(invTypeDDL)
	if err != nil {
		log.Fatalf("Could not create table: %s", err)
	}

	f, err := os.Open(typeIDFile)

	if err != nil {
		log.Fatalf("Could not open %s: %s", typeIDFile, err)
	}
	defer func() {
		_ = f.Close()
	}()

	buf, err := ioutil.ReadAll(f)
	if err != nil {
		log.Fatalf("Could not read %s: %s", typeIDFile, err)
	}

	entries := make(map[string]*inventory.Type)
	err = yaml.Unmarshal(buf, entries)
	if err != nil {
		log.Fatalf("Could not parse %s: %s", typeIDFile, err)
	}

	importInventoryTypes(db, entries)
}

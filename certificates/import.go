package certificates

import (
	"database/sql"
	"io"
	"log"

	"github.com/lflux/eve-sdeloader/utils"
)

var skillLevelMap = map[string]int{
	"basic":    0,
	"standard": 1,
	"improved": 2,
	"advanced": 3,
	"elite":    4,
}

type Certificate struct {
	Description    string
	GroupID        int64 `yaml:"groupID"`
	Name           string
	RecommendedFor []int64                     `yaml:"recommendedFor"`
	SkillTypes     map[string]map[string]int64 `yaml:"skillTypes"`
}

func InsertCertCertsStmt(tx *sql.Tx) (*sql.Stmt, error) {
	return tx.Prepare(`INSERT INTO certcerts (certid, description, groupid, name) VALUES ($1, $2, $3, $4)`)
}

func InsertCertSkillsStmt(tx *sql.Tx) (*sql.Stmt, error) {
	return tx.Prepare(`INSERT INTO certskills (certid, skillid, certlevelint, certleveltext, skilllevel) VALUES ($1, $2, $3, $4, $5)`)
}

func Import(db *sql.DB, r io.Reader) error {
	entries := make(map[string]*Certificate)

	err := utils.LoadFromReader(r, entries)
	if err != nil {
		return err
	}

	tx, err := db.Begin()
	if err != nil {
		return err
	}

	insertCertCerts, err := InsertCertCertsStmt(tx)
	if err != nil {
		return err
	}

	insertCertSkills, err := InsertCertSkillsStmt(tx)
	if err != nil {
		return err
	}

	for certID, cert := range entries {
		log.Println(certID)
		_, err = insertCertCerts.Exec(certID, cert.Description, cert.GroupID, cert.Name)
		if err != nil {
			return err
		}

		for skillID, skillType := range cert.SkillTypes {
			for skillLevel, value := range skillType {
				log.Println(certID, skillID, skillLevelMap[skillLevel], skillLevel, value)
				_, err = insertCertSkills.Exec(certID, skillID, skillLevelMap[skillLevel], skillLevel, value)
			}
		}
	}

	return tx.Commit()
}

package certificates

import (
	"database/sql"
	"io"
	"time"

	"github.com/lflux/eve-sdeloader/statements"
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

func Import(db *sql.DB, r io.Reader) error {
	defer utils.TimeTrack(time.Now(), "certificates")

	entries := make(map[string]*Certificate)

	err := utils.LoadFromReader(r, entries)
	if err != nil {
		return err
	}

	tx, err := db.Begin()
	if err != nil {
		return err
	}

	insertCertCerts, err := statements.InsertCertCertsStmt(tx)
	if err != nil {
		return err
	}

	insertCertSkills, err := statements.InsertCertSkillsStmt(tx)
	if err != nil {
		return err
	}

	for certID, cert := range entries {
		_, err = insertCertCerts.Exec(certID, cert.Description, cert.GroupID, cert.Name)
		if err != nil {
			return err
		}

		for skillID, skillType := range cert.SkillTypes {
			for skillLevel, value := range skillType {
				_, err = insertCertSkills.Exec(certID, skillID, skillLevelMap[skillLevel], skillLevel, value)
			}
		}
	}

	return tx.Commit()
}

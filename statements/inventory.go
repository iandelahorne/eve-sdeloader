package statements

import (
	"database/sql"

	"github.com/lib/pq"
)

func InsertInvTypeStatement(tx *sql.Tx) (*sql.Stmt, error) {
	return tx.Prepare(pq.CopyIn("invTypes",
		"typeID",
		"groupID",
		"typeName",
		"description",
		"mass",
		"volume",
		"capacity",
		"portionSize",
		"raceID",
		"basePrice",
		"published",
		"marketGroupID",
		"graphicID",
		"iconID",
		"soundID"))
}

func InsertCertMasteryStatement(tx *sql.Tx) (*sql.Stmt, error) {
	return tx.Prepare(pq.CopyIn("certMasteries", "typeID", "masteryLevel", "certID"))
}

func InsertTraitStatement(tx *sql.Tx) (*sql.Stmt, error) {
	return tx.Prepare(`INSERT INTO "invTraits" ("typeID", "skillID", bonus, "unitID", "bonusText") VALUES ($1, $2, $3, $4, $5) RETURNING "traitID"`)
}

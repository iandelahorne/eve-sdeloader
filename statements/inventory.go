package statements

import "database/sql"

func InsertInvTypeStatement(tx *sql.Tx) (*sql.Stmt, error) {
	stmt := `INSERT INTO "invTypes" (
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
	"soundID"
) VALUES (
	$1, $2, $3, $4, $5,
	$6, $7, $8, $9, $10,
	$11, $12, $13, $14, $15)`

	return tx.Prepare(stmt)
}

func InsertCertMasteryStatement(tx *sql.Tx) (*sql.Stmt, error) {
	return tx.Prepare(`INSERT INTO "certMasteries" ("typeID", "masteryLevel", "certID") VALUES ($1, $2, $3)`)
}

func InsertTraitStatement(tx *sql.Tx) (*sql.Stmt, error) {
	return tx.Prepare(`INSERT INTO "invTraits" ("typeID", "skillID", bonus, "unitID", "bonusText") VALUES ($1, $2, $3, $4, $5) RETURNING "traitID"`)
}

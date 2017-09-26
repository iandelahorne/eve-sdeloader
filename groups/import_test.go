package groups_test

import (
	"database/sql"

	"github.com/lflux/eve-sdeloader/groups"
	sqlmock "gopkg.in/DATA-DOG/go-sqlmock.v1"

	. "github.com/onsi/ginkgo"
	. "github.com/onsi/gomega"
)

var _ = Describe("Import", func() {
	var (
		db   *sql.DB
		err  error
		mock sqlmock.Sqlmock
	)
	BeforeEach(func() {
		db, mock, err = sqlmock.New()
	})
	Context("InsertGroupStmt", func() {
		It("returns a prepared statement", func() {
			mock.ExpectBegin()
			mock.ExpectPrepare(`INSERT INTO invgroups VALUES.*`)

			tx, err := db.Begin()
			Expect(err).NotTo(HaveOccurred())

			stmt, err := groups.InsertGroupStmt(tx)
			Expect(err).NotTo(HaveOccurred())
			Expect(stmt).NotTo(BeNil())

			err = mock.ExpectationsWereMet()
			Expect(err).NotTo(HaveOccurred())
		})
		It("returns an error if Prepare fails", func() {
			mock.ExpectBegin()
			tx, err := db.Begin()
			Expect(err).NotTo(HaveOccurred())
			_, err = groups.InsertGroupStmt(tx)
			Expect(err).To(MatchError("all expectations were already fulfilled, call to Prepare 'INSERT INTO invgroups VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9)' query was not expected"))
		})
	})
})

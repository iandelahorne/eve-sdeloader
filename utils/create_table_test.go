package utils_test

import (
	"database/sql"

	"github.com/lflux/eve-sdeloader/utils"

	. "github.com/onsi/ginkgo"
	. "github.com/onsi/gomega"
	sqlmock "gopkg.in/DATA-DOG/go-sqlmock.v1"
)

const (
	ddl = `CREATE TABLE t1 (c1 INT, c2 TEXT)`
)

var _ = Describe("CreateTable", func() {
	var (
		db   *sql.DB
		err  error
		mock sqlmock.Sqlmock
	)
	BeforeEach(func() {
		db, mock, err = sqlmock.New()
		Expect(err).NotTo(HaveOccurred())
	})

	It("Creates a table", func() {
		mock.ExpectBegin()
		mock.ExpectExec(`CREATE TABLE t1 \(c1 INT, c2 TEXT\)`).WillReturnResult(sqlmock.NewResult(1, 1))
		mock.ExpectCommit()

		err = utils.CreateTable(db, ddl)
		Expect(err).NotTo(HaveOccurred())

		err = mock.ExpectationsWereMet()
		Expect(err).NotTo(HaveOccurred())
	})

	It("Fails when creating the transaction", func() {
		err = utils.CreateTable(db, ddl)
		Expect(err).To(MatchError("all expectations were already fulfilled, call to database transaction Begin was not expected"))
	})

	It("Fails when executing the insert", func() {
		mock.ExpectBegin()
		err = utils.CreateTable(db, ddl)
		Expect(err).To(MatchError("all expectations were already fulfilled, call to exec 'CREATE TABLE t1 (c1 INT, c2 TEXT)' query with args [] was not expected"))
	})

	It("Fails when commiting", func() {
		mock.ExpectBegin()
		mock.ExpectExec(`CREATE TABLE t1 \(c1 INT, c2 TEXT\)`).WillReturnResult(sqlmock.NewResult(1, 1))

		err = utils.CreateTable(db, ddl)
		Expect(err).To(MatchError("all expectations were already fulfilled, call to commit transaction was not expected"))
	})

})

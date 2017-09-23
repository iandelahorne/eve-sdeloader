package utils_test

import (
	"database/sql"

	"github.com/lflux/eve-sdeloader/utils"

	sqlmock "gopkg.in/DATA-DOG/go-sqlmock.v1"

	. "github.com/onsi/ginkgo"
	. "github.com/onsi/gomega"
)

var _ = Describe("ExecDDL", func() {
	var (
		db   *sql.DB
		err  error
		mock sqlmock.Sqlmock
	)
	BeforeEach(func() {
		db, mock, err = sqlmock.New()
	})

	It("Fails if a file doesn't exist", func() {
		err = utils.ExecDDLFromFile(db, "foo.sql")
		Expect(err).To(MatchError("open foo.sql: no such file or directory"))
	})

	It("Executes a statement from a file", func() {
		mock.ExpectBegin()
		mock.ExpectExec(`CREATE TABLE t1 \(id int, name varchar\)`).WillReturnResult(sqlmock.NewResult(1, 1))
		mock.ExpectCommit()
		err = utils.ExecDDLFromFile(db, "fixture.sql")
		Expect(err).NotTo(HaveOccurred())

		err = mock.ExpectationsWereMet()
		Expect(err).NotTo(HaveOccurred())
	})

	It("Returns an error from begin", func() {
		err = utils.ExecDDLFromFile(db, "fixture.sql")
		Expect(err).To(MatchError("all expectations were already fulfilled, call to database transaction Begin was not expected"))
	})

	It("Returns an error from exec", func() {
		mock.ExpectBegin()
		err = utils.ExecDDLFromFile(db, "fixture.sql")
		Expect(err).To(MatchError("all expectations were already fulfilled, call to exec 'CREATE TABLE t1 (id int, name varchar)' query with args [] was not expected"))
	})
	It("Returns an error from commit", func() {
		mock.ExpectBegin()
		mock.ExpectExec(`CREATE TABLE t1 \(id int, name varchar\)`).WillReturnResult(sqlmock.NewResult(1, 1))
		err = utils.ExecDDLFromFile(db, "fixture.sql")
		Expect(err).To(MatchError("all expectations were already fulfilled, call to commit transaction was not expected"))
	})
})

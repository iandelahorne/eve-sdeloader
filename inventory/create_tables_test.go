package inventory_test

import (
	. "github.com/lflux/eve-sdeloader/inventory"

	. "github.com/onsi/ginkgo"
	. "github.com/onsi/gomega"
	sqlmock "gopkg.in/DATA-DOG/go-sqlmock.v1"
)

var _ = Describe("CreateTables", func() {
	It("Creates the tables for invtypes", func() {
		db, mock, err := sqlmock.New()
		Expect(err).NotTo(HaveOccurred())
		defer func() {
			_ = db.Close()
		}()

		mock.ExpectBegin()
		mock.ExpectExec(`CREATE TABLE IF NOT EXISTS invtypes .*`).WillReturnResult(sqlmock.NewResult(1, 1))
		mock.ExpectExec(`CREATE TABLE IF NOT EXISTS certmasteries .*`).WillReturnResult(sqlmock.NewResult(1, 1))
		mock.ExpectCommit()

		err = CreateTables(db)
		Expect(err).NotTo(HaveOccurred())

		err = mock.ExpectationsWereMet()
		Expect(err).NotTo(HaveOccurred())
	})
})

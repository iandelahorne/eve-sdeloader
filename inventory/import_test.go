package inventory_test

import (
	. "github.com/lflux/eve-sdeloader/inventory"
	sqlmock "gopkg.in/DATA-DOG/go-sqlmock.v1"

	. "github.com/onsi/ginkgo"
	. "github.com/onsi/gomega"
)

var _ = Describe("Import", func() {
	It("tests importing with a bad file", func() {
		err := ImportFile(nil, "nonexistent.yml")
		Expect(err).To(MatchError("open nonexistent.yml: no such file or directory"))
	})

	It("tests importing invtypes with a file", func() {
		db, mock, err := sqlmock.New()
		Expect(err).NotTo(HaveOccurred())
		defer func() {
			_ = db.Close()
		}()
		mock.MatchExpectationsInOrder(false)

		mock.ExpectBegin()
		inv := mock.ExpectPrepare(`INSERT INTO invtypes .*`)
		masteries := mock.ExpectPrepare(`INSERT INTO certmasteries \(typeid, masterylevel, certid\) VALUES .*`)

		inv.ExpectExec().WithArgs(
			"0",
			324,
			"Hawk",
			sqlmock.AnyArg(), // The actual docstring is way too long to match
			1217000.0,
			300.0,
			0,
			1,
			true,
			434,
			1882,
			0,
			20070,
		).WillReturnResult(sqlmock.NewResult(1, 1))

		for _, level := range []string{"0", "1", "2", "3", "4"} {
			for _, certID := range []int{99, 96, 150, 75, 139, 85, 94} {
				masteries.ExpectExec().WithArgs("0", level, certID).WillReturnResult(sqlmock.NewResult(1, 1))
			}
		}
		masteries.ExpectExec().WithArgs("0", "4", 118).WillReturnResult(sqlmock.NewResult(1, 1))
		mock.ExpectCommit()

		err = ImportFile(db, "fixtures/hawk.yml")
		Expect(err).NotTo(HaveOccurred())

		err = mock.ExpectationsWereMet()
		Expect(err).NotTo(HaveOccurred())
	})
})

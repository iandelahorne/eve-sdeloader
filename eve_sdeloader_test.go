package main

import (
	. "github.com/onsi/ginkgo"
	. "github.com/onsi/gomega"
	sqlmock "gopkg.in/DATA-DOG/go-sqlmock.v1"

	"github.com/lflux/eve-sdeloader/inventory"
	helpers "github.com/lflux/eve-sdeloader/test_helpers"
)

var _ = Describe("EveSdeloader", func() {
	It("tests importing invtypes", func() {
		db, mock, err := sqlmock.New()
		Expect(err).NotTo(HaveOccurred())
		defer func() {
			_ = db.Close()
		}()
		mock.MatchExpectationsInOrder(false)

		entry := helpers.LoadInventory("inventory/fixtures/hawk.yml")
		entries := map[string]*inventory.Type{
			"1": entry,
		}

		mock.ExpectBegin()
		mock.ExpectBegin()
		stmt := mock.ExpectPrepare(`COPY "invtypes" .* FROM STDIN`)
		mast := mock.ExpectPrepare(`COPY "certmasteries" \("typeid", "masterylevel", "certid"\) FROM STDIN`)
		stmt.ExpectExec().WithArgs(
			"1",
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
		stmt.ExpectExec().WillReturnResult(sqlmock.NewResult(0, 1))

		for _, level := range []string{"0", "1", "2", "3", "4"} {
			for _, certID := range []int{99, 96, 150, 75, 139, 85, 94} {
				mast.ExpectExec().WithArgs("1", level, certID).WillReturnResult(sqlmock.NewResult(1, 1))
			}
		}
		mast.ExpectExec().WithArgs("1", "4", 118).WillReturnResult(sqlmock.NewResult(1, 1))

		mast.ExpectExec().WillReturnResult(sqlmock.NewResult(0, 1))
		mock.ExpectCommit()
		mock.ExpectCommit()

		importInventoryTypes(db, entries)

		err = mock.ExpectationsWereMet()
		Expect(err).NotTo(HaveOccurred())
	})
})

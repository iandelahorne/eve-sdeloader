package categories_test

import (
	"database/sql"
	"os"

	"github.com/lflux/eve-sdeloader/categories"
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

	Context("ImportStmt", func() {
		It("returns an import statetment", func() {
			mock.ExpectBegin()
			mock.ExpectPrepare(`INSERT INTO invcategories VALUES.*`)

			tx, err := db.Begin()
			Expect(err).NotTo(HaveOccurred())
			Expect(tx).NotTo(BeNil())

			stmt, err := categories.InsertCategoryStmt(tx)
			Expect(err).NotTo(HaveOccurred())
			Expect(stmt).NotTo(BeNil())

			err = mock.ExpectationsWereMet()
			Expect(err).NotTo(HaveOccurred())

		})
	})

	Context("Import", func() {
		It("Imports a category", func() {
			mock.ExpectBegin()
			mock.ExpectPrepare(`INSERT INTO invcategories VALUES.*`)
			mock.ExpectExec(`INSERT INTO invcategories VALUES.*`).WithArgs("7", "Module", 67, true).WillReturnResult(sqlmock.NewResult(1, 1))
			mock.ExpectCommit()

			f, err := os.Open("fixtures/category.yml")
			Expect(err).NotTo(HaveOccurred())
			defer f.Close()

			err = categories.Import(db, f)
			Expect(err).NotTo(HaveOccurred())

			err = mock.ExpectationsWereMet()
			Expect(err).NotTo(HaveOccurred())

		})
	})
})

package translations_test

import (
	"database/sql"

	"github.com/lflux/eve-sdeloader/translations"

	. "github.com/onsi/ginkgo"
	. "github.com/onsi/gomega"
	sqlmock "gopkg.in/DATA-DOG/go-sqlmock.v1"
)

var _ = Describe("Translations", func() {
	var (
		db   *sql.DB
		err  error
		mock sqlmock.Sqlmock
	)
	BeforeEach(func() {
		db, mock, err = sqlmock.New()
		Expect(err).NotTo(HaveOccurred())
	})

	It("Creates tables", func() {
		mock.ExpectBegin()
		mock.ExpectExec(`CREATE TABLE IF NOT EXISTS trntranslations .*`).WillReturnResult(sqlmock.NewResult(1, 1))
		mock.ExpectCommit()

		err = translations.CreateTables(db)
		Expect(err).NotTo(HaveOccurred())
		err = mock.ExpectationsWereMet()
		Expect(err).NotTo(HaveOccurred())
	})
})

package graphics_test

import (
	"database/sql"
	"os"

	"github.com/lflux/eve-sdeloader/graphics"
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

	It("Imports a graphic", func() {
		mock.ExpectBegin()
		mock.ExpectPrepare(`INSERT INTO evegraphics VALUES.*`)
		mock.ExpectExec(`INSERT INTO evegraphics VALUES.*`).WithArgs("4711", "caldaribase", "res:/dx9/fake.red", "cs1_small", "caldari", "Caldari Station Administrative Small").WillReturnResult(sqlmock.NewResult(1, 1))
		mock.ExpectCommit()

		f, err := os.Open("fixtures/graphic.yaml")
		Expect(err).NotTo(HaveOccurred())
		defer f.Close()

		err = graphics.Import(db, f)
		Expect(err).NotTo(HaveOccurred())

		err = mock.ExpectationsWereMet()
		Expect(err).NotTo(HaveOccurred())
	})
})

package inventory

import (
	"bytes"
	"os"

	sqlmock "gopkg.in/DATA-DOG/go-sqlmock.v1"

	. "github.com/onsi/ginkgo"
	. "github.com/onsi/gomega"
)

var _ = Describe("Import", func() {
	It("tests importing with a bad file", func() {
		err := ImportFile(nil, "nonexistent.yml")
		Expect(err).To(MatchError("open nonexistent.yml: no such file or directory"))
	})

	It("Tests inserting bonuses", func() {
		bonuses := []Bonus{
			{
				Amount: 5,
				BonusText: map[string]string{
					"en": "A bonus",
					"de": "ein bonus",
				},
				Importance: 2,
				UnitID:     104,
			},
		}
		db, mock, err := sqlmock.New()
		Expect(err).NotTo(HaveOccurred())
		columns := []string{"traitid"}
		mock.ExpectBegin()
		s := mock.ExpectPrepare(`INSERT INTO invtraits \(typeid, skillid, bonus, unitid, bonustext\).*`)

		s.ExpectQuery().WithArgs("17", -1, 5, 104, "A bonus").
			WillReturnRows(sqlmock.NewRows(columns).FromCSVString("1"))

		tx, err := db.Begin()
		Expect(err).NotTo(HaveOccurred())

		stmt, err := InsertTraitStatement(tx)
		Expect(err).NotTo(HaveOccurred())

		err = InsertBonuses(stmt, "17", -1, bonuses)
		Expect(err).NotTo(HaveOccurred())

		err = mock.ExpectationsWereMet()
		Expect(err).NotTo(HaveOccurred())
	})

	It("Tests statement creations", func() {
		db, mock, err := sqlmock.New()
		Expect(err).NotTo(HaveOccurred())
		mock.ExpectBegin()
		mock.ExpectPrepare(`INSERT INTO invtypes \(typeid,groupid,typename,description,mass,capacity,portionsize,raceid,published,marketgroupid,graphicid,iconid,soundid\) VALUES .*`)
		mock.ExpectPrepare(`INSERT INTO certmasteries \(typeid, masterylevel, certid\) VALUES .*`)
		mock.ExpectPrepare(`INSERT INTO invtraits \(typeid, skillid, bonus, unitid, bonustext\).*`)

		tx, err := db.Begin()
		Expect(err).NotTo(HaveOccurred())

		_, err = InsertInvTypeStatement(tx)
		Expect(err).NotTo(HaveOccurred())

		_, err = InsertCertMasteryStatement(tx)
		Expect(err).NotTo(HaveOccurred())

		_, err = InsertTraitStatement(tx)
		Expect(err).NotTo(HaveOccurred())

		err = mock.ExpectationsWereMet()
		Expect(err).NotTo(HaveOccurred())
	})

	It("Tests loading from a reader with no data", func() {
		r := bytes.NewReader([]byte{})
		entries, err := loadFromReader(r)
		Expect(err).NotTo(HaveOccurred())
		Expect(len(entries)).To(Equal(0))
	})

	It("Tests loading from a reader with bad yaml", func() {
		r := bytes.NewReader([]byte("asdf"))
		entries, err := loadFromReader(r)

		Expect(err).Should(MatchError("yaml: unmarshal errors:\n  line 1: cannot unmarshal !!str `asdf` into map[string]*inventory.Type"))
		Expect(len(entries)).To(Equal(0))
	})

	Context("loadFromReader", func() {
		It("can parse from a reader with good YAML", func() {
			f, err := os.Open("fixtures/hawk.yml")
			Expect(err).NotTo(HaveOccurred())
			defer func() {
				err := f.Close()
				Expect(err).NotTo(HaveOccurred())
			}()
			entries, err := loadFromReader(f)
			Expect(len(entries)).To(Equal(1))
			Expect(err).NotTo(HaveOccurred())
		})

		It("returns an error from a closed reader", func() {
			f, err := os.Open("fixtures/hawk.yml")
			Expect(err).NotTo(HaveOccurred())
			err = f.Close()
			Expect(err).NotTo(HaveOccurred())

			entries, err := loadFromReader(f)
			Expect(entries).To(BeNil())
			Expect(err).To(MatchError("read fixtures/hawk.yml: file already closed"))

		})
	})
})

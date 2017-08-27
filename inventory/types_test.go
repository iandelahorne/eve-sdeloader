package inventory_test

import (
	"io/ioutil"
	"os"

	. "github.com/onsi/ginkgo"
	. "github.com/onsi/gomega"
	yaml "gopkg.in/yaml.v2"

	. "github.com/lflux/eve-sdeloader/inventory"
)

// parseFixture expects a yaml file to contain the fixture under test under the
// "0" key
func parseFixture(path string) *Type {
	f, err := os.Open(path)
	ExpectWithOffset(1, err).NotTo(HaveOccurred())
	defer func() {
		_ = f.Close()
	}()

	buf, err := ioutil.ReadAll(f)
	ExpectWithOffset(1, err).NotTo(HaveOccurred())

	entries := make(map[string]*Type)
	err = yaml.Unmarshal(buf, entries)
	ExpectWithOffset(1, err).NotTo(HaveOccurred())

	return entries["0"]
}

var _ = Describe("Types", func() {
	It("Parses a Hawk correctly", func() {
		entry := parseFixture("./fixtures/hawk.yml")

		Expect(entry.Capacity).To(Equal(300.0))
		Expect(entry.Description["en"]).To(ContainSubstring("the Hawk relies on tremendously powerful shield systems to see it through combat"))
		Expect(entry.FactionID).To(Equal(int64(500001)))
		Expect(entry.MarketGroupID).To(Equal(int64(434)))
		Expect(entry.SofFactionName).To(Equal("laidai"))
		Expect(entry.Radius).To(Equal(float64(39.0)))
		Expect(entry.Masteries).To(ContainElement([]int64{96, 99, 150, 75, 139, 85, 94}))
		// TODO assert on traits
	})
	It("Parses a Sun correctly", func() {
		entry := parseFixture("./fixtures/sun.yml")

		Expect(entry.Mass).To(Equal(float64(1000000000000000000)))
		Expect(entry.Published).To(Equal(false))
		Expect(entry.Radius).To(Equal(float64(10000)))
		Expect(entry.SoundID).To(Equal(int64(20099)))
	})
})

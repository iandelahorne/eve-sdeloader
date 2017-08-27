package test_helpers

import (
	"io/ioutil"
	"os"

	. "github.com/onsi/gomega"
	yaml "gopkg.in/yaml.v2"

	"github.com/lflux/eve-sdeloader/inventory"
)

// LoadInventory expects a yaml file to contain the fixture under test under the
// "0" key
func LoadInventory(path string) *inventory.Type {
	f, err := os.Open(path)
	ExpectWithOffset(1, err).NotTo(HaveOccurred())
	defer func() {
		_ = f.Close()
	}()

	buf, err := ioutil.ReadAll(f)
	ExpectWithOffset(1, err).NotTo(HaveOccurred())

	entries := make(map[string]*inventory.Type)
	err = yaml.Unmarshal(buf, entries)
	ExpectWithOffset(1, err).NotTo(HaveOccurred())

	return entries["0"]
}

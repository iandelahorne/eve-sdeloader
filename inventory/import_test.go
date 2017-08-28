package inventory_test

import (
	. "github.com/lflux/eve-sdeloader/inventory"

	. "github.com/onsi/ginkgo"
	. "github.com/onsi/gomega"
)

var _ = Describe("Import", func() {
	It("tests importing with a bad file", func() {
		err := ImportFile(nil, "nonexistent.yml")
		Expect(err).To(MatchError("open nonexistent.yml: no such file or directory"))
	})
})

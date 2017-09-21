package utils_test

import (
	"bytes"

	"github.com/lflux/eve-sdeloader/utils"

	. "github.com/onsi/ginkgo"
	. "github.com/onsi/gomega"
)

const (
	goodYAML = `---
foo: bar
baz:
  - 1
  - 2
  - 3
`
	badYAML = `
	ugh
`
)

var _ = Describe("Load", func() {
	var (
		entries map[string]interface{}
		err     error
	)
	BeforeEach(func() {
		entries = make(map[string]interface{})
	})

	It("Unmarshals YAML from a reader", func() {
		buf := bytes.NewBufferString(goodYAML)
		err = utils.LoadFromReader(buf, &entries)
		Expect(err).NotTo(HaveOccurred())

		Expect(entries).To(HaveKey("foo"))
	})

	It("Errors if YAML is invalid", func() {
		buf := bytes.NewBufferString(badYAML)
		err = utils.LoadFromReader(buf, &entries)
		Expect(err).To(MatchError("yaml: line 1: found character that cannot start any token"))
	})
})

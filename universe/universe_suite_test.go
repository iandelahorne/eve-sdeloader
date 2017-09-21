package universe_test

import (
	. "github.com/onsi/ginkgo"
	. "github.com/onsi/gomega"

	"testing"
)

func TestUniverse(t *testing.T) {
	RegisterFailHandler(Fail)
	RunSpecs(t, "Universe Suite")
}

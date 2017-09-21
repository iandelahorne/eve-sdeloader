package icons_test

import (
	. "github.com/onsi/ginkgo"
	. "github.com/onsi/gomega"

	"testing"
)

func TestIcons(t *testing.T) {
	RegisterFailHandler(Fail)
	RunSpecs(t, "Icons Suite")
}

package graphics_test

import (
	. "github.com/onsi/ginkgo"
	. "github.com/onsi/gomega"

	"testing"
)

func TestGraphics(t *testing.T) {
	RegisterFailHandler(Fail)
	RunSpecs(t, "Graphics Suite")
}

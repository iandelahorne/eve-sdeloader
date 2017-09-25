package categories_test

import (
	. "github.com/onsi/ginkgo"
	. "github.com/onsi/gomega"

	"testing"
)

func TestCategories(t *testing.T) {
	RegisterFailHandler(Fail)
	RunSpecs(t, "Categories Suite")
}

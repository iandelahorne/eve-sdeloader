package bsd_test

import (
	. "github.com/onsi/ginkgo"
	. "github.com/onsi/gomega"

	"testing"
)

func TestBsd(t *testing.T) {
	RegisterFailHandler(Fail)
	RunSpecs(t, "Bsd Suite")
}

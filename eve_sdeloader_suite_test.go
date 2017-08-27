package main

import (
	. "github.com/onsi/ginkgo"
	. "github.com/onsi/gomega"

	"testing"
)

func TestEveSdeloader(t *testing.T) {
	RegisterFailHandler(Fail)
	RunSpecs(t, "EveSdeloader Suite")
}

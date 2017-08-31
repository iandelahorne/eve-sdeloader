package utils

import (
	"io"
	"io/ioutil"

	yaml "gopkg.in/yaml.v2"
)

func LoadFromReader(r io.Reader, entries interface{}) error {
	buf, err := ioutil.ReadAll(r)
	if err != nil {
		return err
	}

	return yaml.Unmarshal(buf, entries)
}

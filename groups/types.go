package groups

type Group struct {
	Anchorable           bool
	Anchored             bool
	CategoryID           int64  `yaml:"categoryID"`
	FittableNonSingleton bool   `yaml:"fittableNonSingleton"`
	IconID               *int64 `yaml:"iconID"`
	Name                 map[string]string
	Published            bool
	UseBasePrice         bool `yaml:"useBasePrice"`
}

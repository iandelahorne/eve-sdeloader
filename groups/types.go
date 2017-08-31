package groups

type Group struct {
	Anchorable           bool
	Anchored             bool
	CategoryID           int64
	FittableNonSingleton bool
	IconID               int64
	Name                 map[string]string
	Published            bool
	UseBasePrice         bool
}

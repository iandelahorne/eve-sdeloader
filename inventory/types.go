package inventory

type Traits struct {
	RoleBonuses []Bonus           `yaml:"roleBonuses"`
	Types       map[int64][]Bonus `yaml:"types"`
}

type Type struct {
	BasePrice        *float64 `yaml:"basePrice"`
	Capacity         float64
	Description      map[string]string
	FactionID        *int64 `yaml:"factionID"`
	GraphicID        int64  `yaml:"graphicID"`
	GroupID          int64  `yaml:"groupID"`
	IconID           *int64 `yaml:"iconID"`
	MarketGroupID    *int64 `yaml:"marketGroupID"`
	Mass             float64
	Masteries        map[string][]int64
	Name             map[string]string
	PortionSize      *int64 `yaml:"portionSize"`
	Published        bool
	RaceID           *int64 `yaml:"raceID"`
	Radius           *float64
	SoundID          *int64 `yaml:"soundID"`
	SofFactionName   string `yaml:"sofFactionName"`
	SofMaterialSetID *int64 `yaml:"sofMaterialSetID"`
	Volume           float64
	Traits           *Traits `yaml:"traits"`
}

type Bonus struct {
	Amount     int               `yaml:"bonus"`
	BonusText  map[string]string `yaml:"bonusText"`
	Importance int
	UnitID     int `yaml:"unitID"`
}

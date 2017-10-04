package blueprints

type Invention struct {
	Materials []Material
	Products  []Material
	Skills    []Skill
	Time      int64
}

func (i *Invention) GetTime() int64 {
	return i.Time
}

func (i *Invention) ActivityID() ActivityID {
	return InventionID
}

func (i *Invention) GetMaterials() []Material {
	return i.Materials
}

func (i *Invention) GetProducts() []Material {
	return i.Products
}

func (i *Invention) GetSkills() []Skill {
	return i.Skills
}

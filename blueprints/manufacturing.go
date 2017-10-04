package blueprints

type Manufacturing struct {
	Materials []Material
	Products  []Material
	Skills    []Skill
	Time      int64
}

func (m *Manufacturing) GetTime() int64 {
	return m.Time
}

func (m *Manufacturing) ActivityID() ActivityID {
	return ManufacturingID
}

func (m *Manufacturing) GetMaterials() []Material {
	return m.Materials
}

func (m *Manufacturing) GetProducts() []Material {
	return m.Products
}

func (m *Manufacturing) GetSkills() []Skill {
	return m.Skills
}

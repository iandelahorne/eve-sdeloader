package blueprints

type Reaction struct {
	Materials []Material
	Products  []Material
	Skills    []Skill
	Time      int64
}

func (r *Reaction) GetTime() int64 {
	return r.Time
}

func (r *Reaction) ActivityID() ActivityID {
	return ReactionID
}

func (r *Reaction) GetMaterials() []Material {
	return r.Materials
}

func (r *Reaction) GetProducts() []Material {
	return r.Products
}

func (r *Reaction) GetSkills() []Skill {
	return r.Skills
}

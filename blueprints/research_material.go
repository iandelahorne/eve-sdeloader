package blueprints

type ResearchMaterial struct {
	Time int64
}

func (r *ResearchMaterial) GetTime() int64 {
	return r.Time
}

func (r *ResearchMaterial) ActivityID() ActivityID {
	return ResearchMaterialID
}

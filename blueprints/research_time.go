package blueprints

type ResearchTime struct {
	Time int64
}

func (r *ResearchTime) GetTime() int64 {
	return r.Time
}

func (r *ResearchTime) ActivityID() ActivityID {
	return ResearchTimeID
}

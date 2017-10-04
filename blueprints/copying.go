package blueprints

type Copying struct {
	Time int64
}

func (c *Copying) GetTime() int64 {
	return c.Time
}

func (c *Copying) ActivityID() ActivityID {
	return 5
}

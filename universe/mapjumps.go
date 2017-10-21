package universe

import "database/sql"

var dmls = []string{
	`insert into mapSolarSystemJumps (
    fromRegionID,
    fromConstellationID,
    fromSolarSystemID,
    toRegionID,
    toConstellationID,
    toSolarSystemID
) select 
    f.regionID as RegionID,
    f.constellationID as fromConstellationID,
    f.solarSystemID as fromSolarSystemID,
    t.regionID as toRegionID,
    t.constellationID as toConstellationID,
    t.solarSystemID as toSolarSystemID
from 
    mapJumps 
join 
    mapDenormalize f 
    on 
        mapJumps.stargateID=f.itemID 
join 
    mapDenormalize t 
    on 
		mapJumps.destinationID=t.itemID`,
	`insert into mapRegionJumps
	select 
		distinct f.regionID, t.regionID
	from
		mapJumps 
	join mapDenormalize as f 
		on  mapJumps.stargateID=f.itemID 
	join mapDenormalize as t 
		on mapJumps.destinationID=t.itemID 
	where
		f.regionID != t.regionID`,
	`insert into mapConstellationJumps
		select distinct 
			f.regionID,
			f.constellationID,
			t.constellationID,
			t.regionID
		from 
			mapJumps
		join mapDenormalize as f
			on mapJumps.stargateID = f.itemID
		join mapDenormalize as t
			on mapJumps.destinationID=t.itemID
		where f.constellationID != t.constellationID`,
}

func FixMapJumps(db *sql.DB) error {
	var err error
	for _, dml := range dmls {
		_, err = db.Exec(dml)
		if err != nil {
			return err
		}
	}
	return nil
}

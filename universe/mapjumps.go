package universe

import "database/sql"

var dmls = []string{
	`INSERT INTO "mapSolarSystemJumps" (
    "fromRegionID",
    "fromConstellationID",
    "fromSolarSystemID",
    "toRegionID",
    "toConstellationID",
    "toSolarSystemID"
) SELECT
    f."regionID" AS "regionID",
    f."constellationID" AS "fromConstellationID",
    f."solarSystemID" AS "fromSolarSystemID",
    t."regionID" AS "toRegionID",
    t."constellationID" AS "toConstellationID",
    t."solarSystemID" AS "toSolarSystemID"
FROM
    "mapJumps"
JOIN
    "mapDenormalize" AS f 
    ON 
        "mapJumps"."stargateID"=f."itemID"
JOIN
    "mapDenormalize" AS t 
    ON 
		"mapJumps"."destinationID"=t."itemID"`,
	`INSERT INTO "mapRegionJumps"
	SELECT 
		DISTINCT f."regionID", t."regionID"
	FROM
		"mapJumps"
	JOIN "mapDenormalize" AS f 
		on  "mapJumps"."stargateID"=f."itemID"
	JOIN "mapDenormalize" AS t
	ON
		"mapJumps"."destinationID"=t."itemID"
	WHERE
		f."regionID" != t."regionID"`,
	`INSERT INTO "mapConstellationJumps"
		SELECT DISTINCT 
			f."regionID",
			f."constellationID",
			t."constellationID",
			t."regionID"
		FROM 
			"mapJumps"
		JOIN "mapDenormalize" AS f
			on "mapJumps"."stargateID" = f."itemID"
		JOIN "mapDenormalize" AS t
			on "mapJumps"."destinationID"=t."itemID"
		WHERE f."constellationID" != t."constellationID"`,
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

#!/usr/local/bin/bash
# This requires bash > 4.0

set -ex

foreach() { 
  arr="$(declare -p $1)" ; eval "declare -A f="${arr#*=}; 
  for i in ${!f[@]}; do $2 "$i" "${f[$i]}"; done
}

schemadiff() {
    psql -d sdetest -t -A -F"," -c "SELECT * FROM \"$1\" ORDER BY \"$2\"" > /tmp/diffs/$1.public.csv
    psql -d sdeyaml -t -A -F"," -c "SELECT * FROM \"$1\" ORDER BY \"$2\"" > /tmp/diffs/$1.sdeyaml.csv
}

declare -A tables=(
    [agtAgents]="agentID"
    [agtAgentTypes]="agentTypeID"
    [agtResearchAgents]="agentID\",\"typeID"
    [certCerts]="certID"
    [chrAncestries]="ancestryID"
    [chrAttributes]="attributeID"
    [chrBloodlines]="bloodlineID"
    [chrFactions]="factionID"
    [chrRaces]="raceID"
    [crpActivities]="activityID"
    [crpNPCCorporationDivisions]="corporationID\",\"divisionID"
    [crpNPCCorporationResearchFields]="skillID\",\"corporationID"
    [crpNPCCorporations]="corporationID"
    [crpNPCCorporationTrades]="corporationID\",\"typeID"
    [crpNPCDivisions]="divisionID"
    [dgmAttributeCategories]="categoryID"
    [dgmAttributeTypes]="attributeID"
    [dgmEffects]="effectID"
    [dgmExpressions]="expressionID"
    [dgmTypeAttributes]="typeID\",\"attributeID"
    [dgmTypeEffects]="typeID\",\"effectID"
    [eveGraphics]="graphicID"
    [eveIcons]="iconID"
    [eveUnits]="unitID"
    [industryActivity]="typeID\",\"activityID"
    [industryBlueprints]="typeID"
    [invCategories]="categoryID"
    [invContrabandTypes]="factionID\",\"typeID"
    [invControlTowerResourcePurposes]="purpose"
    [invControlTowerResources]="controlTowerTypeID\",\"resourceTypeID"
    [invFlags]="flagID"
    [invGroups]="groupID"
    [invItems]="itemID"
    [invMarketGroups]="marketGroupID"
    [invMetaGroups]="metaGroupID"
    [invMetaTypes]="typeID"
    [invNames]="itemID"
    [invPositions]="itemID"
    [invTraits]="traitID"
    [invTypeMaterials]="typeID\",\"materialTypeID"
    [invTypeReactions]="reactionTypeID\",\"input\",\"typeID"
    [invTypes]="typeID"
    [invUniqueNames]="itemID"
    [invVolumes]="typeID"
    [mapCelestialStatistics]="celestialID"
    [mapConstellationJumps]="fromConstellationID\",\"toConstellationID"
    [mapConstellations]="constellationID"
    [mapDenormalize]="itemID"
    [mapJumps]="stargateID"
    [mapLandmarks]="landmarkID"
    [mapLocationScenes]="locationID"
    [mapLocationWormholeClasses]="locationID"
    [mapRegionJumps]="fromRegionID\",\"toRegionID"
    [mapRegions]="regionID"
    [mapSolarSystemJumps]="fromSolarSystemID\",\"toSolarSystemID"
    [mapSolarSystems]="solarSystemID"
    [mapUniverse]="universeID"
    [planetSchematics]="schematicID"
    [planetSchematicsPinMap]="schematicID\",\"pinTypeID"
    [planetSchematicsTypeMap]="schematicID\",\"typeID"
    [ramActivities]="activityID"
    [ramAssemblyLineStations]="stationID\",\"assemblyLineTypeID"
    [ramAssemblyLineTypeDetailPerCategory]="assemblyLineTypeID\",\"categoryID"
    [ramAssemblyLineTypeDetailPerGroup]="assemblyLineTypeID\",\"groupID"
    [ramAssemblyLineTypes]="assemblyLineTypeID"
    [ramInstallationTypeContents]="installationTypeID\",\"assemblyLineTypeID"
    [skinLicense]="licenseTypeID"
    [skinMaterials]="skinMaterialID"
    [skins]="skinID"
    [staOperations]="operationID"
    [staOperationServices]="operationID\",\"serviceID"
    [staServices]="serviceID"
    [staStations]="stationID"
    [staStationTypes]="stationTypeID"
    [translationTables]="sourceTable\",\"translatedKey"
    [trnTranslationColumns]="tcID\",\"tcGroupID"
    [trnTranslations]="tcID\",\"keyID\",\"languageID"
    [warCombatZones]="combatZoneID"
    [warCombatZoneSystems]="solarSystemID"
)

foreach tables schemadiff

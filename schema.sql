-- generated with pg_dump --clean --schema-only --no-owner --if-exists sdeyaml > schema.sql
SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

SET search_path = public, pg_catalog;

DROP INDEX IF EXISTS public."mapDenormalize_IX_groupSystem";
DROP INDEX IF EXISTS public."mapDenormalize_IX_groupRegion";
DROP INDEX IF EXISTS public."mapDenormalize_IX_groupConstellation";
DROP INDEX IF EXISTS public."ix_staStations_stationTypeID";
DROP INDEX IF EXISTS public."ix_staStations_solarSystemID";
DROP INDEX IF EXISTS public."ix_staStations_regionID";
DROP INDEX IF EXISTS public."ix_staStations_operationID";
DROP INDEX IF EXISTS public."ix_staStations_corporationID";
DROP INDEX IF EXISTS public."ix_staStations_constellationID";
DROP INDEX IF EXISTS public."ix_skinShip_typeID";
DROP INDEX IF EXISTS public."ix_skinShip_skinID";
DROP INDEX IF EXISTS public."ix_ramAssemblyLineStations_solarSystemID";
DROP INDEX IF EXISTS public."ix_ramAssemblyLineStations_regionID";
DROP INDEX IF EXISTS public."ix_ramAssemblyLineStations_ownerID";
DROP INDEX IF EXISTS public."ix_mapSolarSystems_security";
DROP INDEX IF EXISTS public."ix_mapSolarSystems_regionID";
DROP INDEX IF EXISTS public."ix_mapSolarSystems_constellationID";
DROP INDEX IF EXISTS public."ix_mapDenormalize_typeID";
DROP INDEX IF EXISTS public."ix_mapDenormalize_solarSystemID";
DROP INDEX IF EXISTS public."ix_mapDenormalize_regionID";
DROP INDEX IF EXISTS public."ix_mapDenormalize_orbitID";
DROP INDEX IF EXISTS public."ix_mapDenormalize_constellationID";
DROP INDEX IF EXISTS public."ix_invUniqueNames_itemName";
DROP INDEX IF EXISTS public."ix_invTypes_groupID";
DROP INDEX IF EXISTS public."ix_invItems_locationID";
DROP INDEX IF EXISTS public."ix_invGroups_categoryID";
DROP INDEX IF EXISTS public."ix_invContrabandTypes_typeID";
DROP INDEX IF EXISTS public."ix_industryActivity_activityID";
DROP INDEX IF EXISTS public."ix_industryActivitySkills_typeID";
DROP INDEX IF EXISTS public."ix_industryActivitySkills_skillID";
DROP INDEX IF EXISTS public."ix_industryActivityRaces_typeID";
DROP INDEX IF EXISTS public."ix_industryActivityRaces_productTypeID";
DROP INDEX IF EXISTS public."ix_industryActivityProducts_typeID";
DROP INDEX IF EXISTS public."ix_industryActivityProducts_productTypeID";
DROP INDEX IF EXISTS public."ix_industryActivityProbabilities_typeID";
DROP INDEX IF EXISTS public."ix_industryActivityProbabilities_productTypeID";
DROP INDEX IF EXISTS public."ix_industryActivityMaterials_typeID";
DROP INDEX IF EXISTS public."ix_dgmTypeAttributes_attributeID";
DROP INDEX IF EXISTS public."ix_certSkills_skillID";
DROP INDEX IF EXISTS public."ix_agtResearchAgents_typeID";
DROP INDEX IF EXISTS public."ix_agtAgents_locationID";
DROP INDEX IF EXISTS public."ix_agtAgents_corporationID";
DROP INDEX IF EXISTS public."items_IX_OwnerLocation";
DROP INDEX IF EXISTS public."invUniqueNames_IX_GroupName";
DROP INDEX IF EXISTS public."industryActivitySkills_idx1";
DROP INDEX IF EXISTS public."industryActivityMaterials_idx1";
ALTER TABLE IF EXISTS ONLY public."warCombatZones" DROP CONSTRAINT IF EXISTS "warCombatZones_pkey";
ALTER TABLE IF EXISTS ONLY public."warCombatZoneSystems" DROP CONSTRAINT IF EXISTS "warCombatZoneSystems_pkey";
ALTER TABLE IF EXISTS ONLY public."trnTranslations" DROP CONSTRAINT IF EXISTS "trnTranslations_pkey";
ALTER TABLE IF EXISTS ONLY public."trnTranslationLanguages" DROP CONSTRAINT IF EXISTS "trnTranslationLanguages_pkey";
ALTER TABLE IF EXISTS ONLY public."trnTranslationColumns" DROP CONSTRAINT IF EXISTS "trnTranslationColumns_pkey";
ALTER TABLE IF EXISTS ONLY public."translationTables" DROP CONSTRAINT IF EXISTS "translationTables_pkey";
ALTER TABLE IF EXISTS ONLY public."staStations" DROP CONSTRAINT IF EXISTS "staStations_pkey";
ALTER TABLE IF EXISTS ONLY public."staStationTypes" DROP CONSTRAINT IF EXISTS "staStationTypes_pkey";
ALTER TABLE IF EXISTS ONLY public."staServices" DROP CONSTRAINT IF EXISTS "staServices_pkey";
ALTER TABLE IF EXISTS ONLY public."staOperations" DROP CONSTRAINT IF EXISTS "staOperations_pkey";
ALTER TABLE IF EXISTS ONLY public."staOperationServices" DROP CONSTRAINT IF EXISTS "staOperationServices_pkey";
ALTER TABLE IF EXISTS ONLY public.skins DROP CONSTRAINT IF EXISTS skins_pkey;
ALTER TABLE IF EXISTS ONLY public."skinMaterials" DROP CONSTRAINT IF EXISTS "skinMaterials_pkey";
ALTER TABLE IF EXISTS ONLY public."skinLicense" DROP CONSTRAINT IF EXISTS "skinLicense_pkey";
ALTER TABLE IF EXISTS ONLY public."ramInstallationTypeContents" DROP CONSTRAINT IF EXISTS "ramInstallationTypeContents_pkey";
ALTER TABLE IF EXISTS ONLY public."ramAssemblyLineTypes" DROP CONSTRAINT IF EXISTS "ramAssemblyLineTypes_pkey";
ALTER TABLE IF EXISTS ONLY public."ramAssemblyLineTypeDetailPerGroup" DROP CONSTRAINT IF EXISTS "ramAssemblyLineTypeDetailPerGroup_pkey";
ALTER TABLE IF EXISTS ONLY public."ramAssemblyLineTypeDetailPerCategory" DROP CONSTRAINT IF EXISTS "ramAssemblyLineTypeDetailPerCategory_pkey";
ALTER TABLE IF EXISTS ONLY public."ramAssemblyLineStations" DROP CONSTRAINT IF EXISTS "ramAssemblyLineStations_pkey";
ALTER TABLE IF EXISTS ONLY public."ramActivities" DROP CONSTRAINT IF EXISTS "ramActivities_pkey";
ALTER TABLE IF EXISTS ONLY public."planetSchematics" DROP CONSTRAINT IF EXISTS "planetSchematics_pkey";
ALTER TABLE IF EXISTS ONLY public."planetSchematicsTypeMap" DROP CONSTRAINT IF EXISTS "planetSchematicsTypeMap_pkey";
ALTER TABLE IF EXISTS ONLY public."planetSchematicsPinMap" DROP CONSTRAINT IF EXISTS "planetSchematicsPinMap_pkey";
ALTER TABLE IF EXISTS ONLY public."mapUniverse" DROP CONSTRAINT IF EXISTS "mapUniverse_pkey";
ALTER TABLE IF EXISTS ONLY public."mapSolarSystems" DROP CONSTRAINT IF EXISTS "mapSolarSystems_pkey";
ALTER TABLE IF EXISTS ONLY public."mapSolarSystemJumps" DROP CONSTRAINT IF EXISTS "mapSolarSystemJumps_pkey";
ALTER TABLE IF EXISTS ONLY public."mapRegions" DROP CONSTRAINT IF EXISTS "mapRegions_pkey";
ALTER TABLE IF EXISTS ONLY public."mapRegionJumps" DROP CONSTRAINT IF EXISTS "mapRegionJumps_pkey";
ALTER TABLE IF EXISTS ONLY public."mapLocationWormholeClasses" DROP CONSTRAINT IF EXISTS "mapLocationWormholeClasses_pkey";
ALTER TABLE IF EXISTS ONLY public."mapLocationScenes" DROP CONSTRAINT IF EXISTS "mapLocationScenes_pkey";
ALTER TABLE IF EXISTS ONLY public."mapLandmarks" DROP CONSTRAINT IF EXISTS "mapLandmarks_pkey";
ALTER TABLE IF EXISTS ONLY public."mapJumps" DROP CONSTRAINT IF EXISTS "mapJumps_pkey";
ALTER TABLE IF EXISTS ONLY public."mapDenormalize" DROP CONSTRAINT IF EXISTS "mapDenormalize_pkey";
ALTER TABLE IF EXISTS ONLY public."mapConstellations" DROP CONSTRAINT IF EXISTS "mapConstellations_pkey";
ALTER TABLE IF EXISTS ONLY public."mapConstellationJumps" DROP CONSTRAINT IF EXISTS "mapConstellationJumps_pkey";
ALTER TABLE IF EXISTS ONLY public."mapCelestialStatistics" DROP CONSTRAINT IF EXISTS "mapCelestialStatistics_pkey";
ALTER TABLE IF EXISTS ONLY public."invVolumes" DROP CONSTRAINT IF EXISTS "invVolumes_pkey";
ALTER TABLE IF EXISTS ONLY public."invUniqueNames" DROP CONSTRAINT IF EXISTS "invUniqueNames_pkey";
ALTER TABLE IF EXISTS ONLY public."invTypes" DROP CONSTRAINT IF EXISTS "invTypes_pkey";
ALTER TABLE IF EXISTS ONLY public."invTypeReactions" DROP CONSTRAINT IF EXISTS "invTypeReactions_pkey";
ALTER TABLE IF EXISTS ONLY public."invTypeMaterials" DROP CONSTRAINT IF EXISTS "invTypeMaterials_pkey";
ALTER TABLE IF EXISTS ONLY public."invTraits" DROP CONSTRAINT IF EXISTS "invTraits_pkey";
ALTER TABLE IF EXISTS ONLY public."invPositions" DROP CONSTRAINT IF EXISTS "invPositions_pkey";
ALTER TABLE IF EXISTS ONLY public."invNames" DROP CONSTRAINT IF EXISTS "invNames_pkey";
ALTER TABLE IF EXISTS ONLY public."invMetaTypes" DROP CONSTRAINT IF EXISTS "invMetaTypes_pkey";
ALTER TABLE IF EXISTS ONLY public."invMetaGroups" DROP CONSTRAINT IF EXISTS "invMetaGroups_pkey";
ALTER TABLE IF EXISTS ONLY public."invMarketGroups" DROP CONSTRAINT IF EXISTS "invMarketGroups_pkey";
ALTER TABLE IF EXISTS ONLY public."invItems" DROP CONSTRAINT IF EXISTS "invItems_pkey";
ALTER TABLE IF EXISTS ONLY public."invGroups" DROP CONSTRAINT IF EXISTS "invGroups_pkey";
ALTER TABLE IF EXISTS ONLY public."invFlags" DROP CONSTRAINT IF EXISTS "invFlags_pkey";
ALTER TABLE IF EXISTS ONLY public."invControlTowerResources" DROP CONSTRAINT IF EXISTS "invControlTowerResources_pkey";
ALTER TABLE IF EXISTS ONLY public."invControlTowerResourcePurposes" DROP CONSTRAINT IF EXISTS "invControlTowerResourcePurposes_pkey";
ALTER TABLE IF EXISTS ONLY public."invContrabandTypes" DROP CONSTRAINT IF EXISTS "invContrabandTypes_pkey";
ALTER TABLE IF EXISTS ONLY public."invCategories" DROP CONSTRAINT IF EXISTS "invCategories_pkey";
ALTER TABLE IF EXISTS ONLY public."industryBlueprints" DROP CONSTRAINT IF EXISTS "industryBlueprints_pkey";
ALTER TABLE IF EXISTS ONLY public."industryActivity" DROP CONSTRAINT IF EXISTS "industryActivity_pkey";
ALTER TABLE IF EXISTS ONLY public."eveUnits" DROP CONSTRAINT IF EXISTS "eveUnits_pkey";
ALTER TABLE IF EXISTS ONLY public."eveIcons" DROP CONSTRAINT IF EXISTS "eveIcons_pkey";
ALTER TABLE IF EXISTS ONLY public."eveGraphics" DROP CONSTRAINT IF EXISTS "eveGraphics_pkey";
ALTER TABLE IF EXISTS ONLY public."dgmTypeEffects" DROP CONSTRAINT IF EXISTS "dgmTypeEffects_pkey";
ALTER TABLE IF EXISTS ONLY public."dgmTypeAttributes" DROP CONSTRAINT IF EXISTS "dgmTypeAttributes_pkey";
ALTER TABLE IF EXISTS ONLY public."dgmExpressions" DROP CONSTRAINT IF EXISTS "dgmExpressions_pkey";
ALTER TABLE IF EXISTS ONLY public."dgmEffects" DROP CONSTRAINT IF EXISTS "dgmEffects_pkey";
ALTER TABLE IF EXISTS ONLY public."dgmAttributeTypes" DROP CONSTRAINT IF EXISTS "dgmAttributeTypes_pkey";
ALTER TABLE IF EXISTS ONLY public."dgmAttributeCategories" DROP CONSTRAINT IF EXISTS "dgmAttributeCategories_pkey";
ALTER TABLE IF EXISTS ONLY public."crpNPCDivisions" DROP CONSTRAINT IF EXISTS "crpNPCDivisions_pkey";
ALTER TABLE IF EXISTS ONLY public."crpNPCCorporations" DROP CONSTRAINT IF EXISTS "crpNPCCorporations_pkey";
ALTER TABLE IF EXISTS ONLY public."crpNPCCorporationTrades" DROP CONSTRAINT IF EXISTS "crpNPCCorporationTrades_pkey";
ALTER TABLE IF EXISTS ONLY public."crpNPCCorporationResearchFields" DROP CONSTRAINT IF EXISTS "crpNPCCorporationResearchFields_pkey";
ALTER TABLE IF EXISTS ONLY public."crpNPCCorporationDivisions" DROP CONSTRAINT IF EXISTS "crpNPCCorporationDivisions_pkey";
ALTER TABLE IF EXISTS ONLY public."crpActivities" DROP CONSTRAINT IF EXISTS "crpActivities_pkey";
ALTER TABLE IF EXISTS ONLY public."chrRaces" DROP CONSTRAINT IF EXISTS "chrRaces_pkey";
ALTER TABLE IF EXISTS ONLY public."chrFactions" DROP CONSTRAINT IF EXISTS "chrFactions_pkey";
ALTER TABLE IF EXISTS ONLY public."chrBloodlines" DROP CONSTRAINT IF EXISTS "chrBloodlines_pkey";
ALTER TABLE IF EXISTS ONLY public."chrAttributes" DROP CONSTRAINT IF EXISTS "chrAttributes_pkey";
ALTER TABLE IF EXISTS ONLY public."chrAncestries" DROP CONSTRAINT IF EXISTS "chrAncestries_pkey";
ALTER TABLE IF EXISTS ONLY public."certCerts" DROP CONSTRAINT IF EXISTS "certCerts_pkey";
ALTER TABLE IF EXISTS ONLY public."agtResearchAgents" DROP CONSTRAINT IF EXISTS "agtResearchAgents_pkey";
ALTER TABLE IF EXISTS ONLY public."agtAgents" DROP CONSTRAINT IF EXISTS "agtAgents_pkey";
ALTER TABLE IF EXISTS ONLY public."agtAgentTypes" DROP CONSTRAINT IF EXISTS "agtAgentTypes_pkey";
ALTER TABLE IF EXISTS public."invTraits" ALTER COLUMN "traitID" DROP DEFAULT;
DROP TABLE IF EXISTS public."warCombatZones";
DROP TABLE IF EXISTS public."warCombatZoneSystems";
DROP TABLE IF EXISTS public."trnTranslations";
DROP TABLE IF EXISTS public."trnTranslationLanguages";
DROP TABLE IF EXISTS public."trnTranslationColumns";
DROP TABLE IF EXISTS public."translationTables";
DROP TABLE IF EXISTS public."staStations";
DROP TABLE IF EXISTS public."staStationTypes";
DROP TABLE IF EXISTS public."staServices";
DROP TABLE IF EXISTS public."staOperations";
DROP TABLE IF EXISTS public."staOperationServices";
DROP TABLE IF EXISTS public.skins;
DROP TABLE IF EXISTS public."skinShip";
DROP TABLE IF EXISTS public."skinMaterials";
DROP TABLE IF EXISTS public."skinLicense";
DROP TABLE IF EXISTS public."ramInstallationTypeContents";
DROP TABLE IF EXISTS public."ramAssemblyLineTypes";
DROP TABLE IF EXISTS public."ramAssemblyLineTypeDetailPerGroup";
DROP TABLE IF EXISTS public."ramAssemblyLineTypeDetailPerCategory";
DROP TABLE IF EXISTS public."ramAssemblyLineStations";
DROP TABLE IF EXISTS public."ramActivities";
DROP TABLE IF EXISTS public."planetSchematicsTypeMap";
DROP TABLE IF EXISTS public."planetSchematicsPinMap";
DROP TABLE IF EXISTS public."planetSchematics";
DROP TABLE IF EXISTS public."mapUniverse";
DROP TABLE IF EXISTS public."mapSolarSystems";
DROP TABLE IF EXISTS public."mapSolarSystemJumps";
DROP TABLE IF EXISTS public."mapRegions";
DROP TABLE IF EXISTS public."mapRegionJumps";
DROP TABLE IF EXISTS public."mapLocationWormholeClasses";
DROP TABLE IF EXISTS public."mapLocationScenes";
DROP TABLE IF EXISTS public."mapLandmarks";
DROP TABLE IF EXISTS public."mapJumps";
DROP TABLE IF EXISTS public."mapDenormalize";
DROP TABLE IF EXISTS public."mapConstellations";
DROP TABLE IF EXISTS public."mapConstellationJumps";
DROP TABLE IF EXISTS public."mapCelestialStatistics";
DROP TABLE IF EXISTS public."invVolumes";
DROP TABLE IF EXISTS public."invUniqueNames";
DROP TABLE IF EXISTS public."invTypes";
DROP TABLE IF EXISTS public."invTypeReactions";
DROP TABLE IF EXISTS public."invTypeMaterials";
DROP SEQUENCE IF EXISTS public."invTraits_traitID_seq";
DROP TABLE IF EXISTS public."invTraits";
DROP TABLE IF EXISTS public."invPositions";
DROP TABLE IF EXISTS public."invNames";
DROP TABLE IF EXISTS public."invMetaTypes";
DROP TABLE IF EXISTS public."invMetaGroups";
DROP TABLE IF EXISTS public."invMarketGroups";
DROP TABLE IF EXISTS public."invItems";
DROP TABLE IF EXISTS public."invGroups";
DROP TABLE IF EXISTS public."invFlags";
DROP TABLE IF EXISTS public."invControlTowerResources";
DROP TABLE IF EXISTS public."invControlTowerResourcePurposes";
DROP TABLE IF EXISTS public."invContrabandTypes";
DROP TABLE IF EXISTS public."invCategories";
DROP TABLE IF EXISTS public."industryBlueprints";
DROP TABLE IF EXISTS public."industryActivitySkills";
DROP TABLE IF EXISTS public."industryActivityRaces";
DROP TABLE IF EXISTS public."industryActivityProducts";
DROP TABLE IF EXISTS public."industryActivityProbabilities";
DROP TABLE IF EXISTS public."industryActivityMaterials";
DROP TABLE IF EXISTS public."industryActivity";
DROP TABLE IF EXISTS public."eveUnits";
DROP TABLE IF EXISTS public."eveIcons";
DROP TABLE IF EXISTS public."eveGraphics";
DROP TABLE IF EXISTS public."dgmTypeEffects";
DROP TABLE IF EXISTS public."dgmTypeAttributes";
DROP TABLE IF EXISTS public."dgmExpressions";
DROP TABLE IF EXISTS public."dgmEffects";
DROP TABLE IF EXISTS public."dgmAttributeTypes";
DROP TABLE IF EXISTS public."dgmAttributeCategories";
DROP TABLE IF EXISTS public."crpNPCDivisions";
DROP TABLE IF EXISTS public."crpNPCCorporations";
DROP TABLE IF EXISTS public."crpNPCCorporationTrades";
DROP TABLE IF EXISTS public."crpNPCCorporationResearchFields";
DROP TABLE IF EXISTS public."crpNPCCorporationDivisions";
DROP TABLE IF EXISTS public."crpActivities";
DROP TABLE IF EXISTS public."chrRaces";
DROP TABLE IF EXISTS public."chrFactions";
DROP TABLE IF EXISTS public."chrBloodlines";
DROP TABLE IF EXISTS public."chrAttributes";
DROP TABLE IF EXISTS public."chrAncestries";
DROP TABLE IF EXISTS public."certSkills";
DROP TABLE IF EXISTS public."certMasteries";
DROP TABLE IF EXISTS public."certCerts";
DROP TABLE IF EXISTS public."agtResearchAgents";
DROP TABLE IF EXISTS public."agtAgents";
DROP TABLE IF EXISTS public."agtAgentTypes";
CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;
COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';
SET search_path = public, pg_catalog;
SET default_tablespace = '';
SET default_with_oids = false;

--
-- Name: agtAgentTypes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "agtAgentTypes" (
    "agentTypeID" integer NOT NULL,
    "agentType" character varying(50)
);


--
-- Name: agtAgents; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "agtAgents" (
    "agentID" integer NOT NULL,
    "divisionID" integer,
    "corporationID" integer,
    "locationID" integer,
    level integer,
    quality integer,
    "agentTypeID" integer,
    "isLocator" boolean
);


--
-- Name: agtResearchAgents; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "agtResearchAgents" (
    "agentID" integer NOT NULL,
    "typeID" integer NOT NULL
);


--
-- Name: certCerts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "certCerts" (
    "certID" integer NOT NULL,
    description text,
    "groupID" integer,
    name character varying(255)
);


--
-- Name: certMasteries; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "certMasteries" (
    "typeID" integer,
    "masteryLevel" integer,
    "certID" integer
);


--
-- Name: certSkills; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "certSkills" (
    "certID" integer,
    "skillID" integer,
    "certLevelInt" integer,
    "skillLevel" integer,
    "certLevelText" character varying(8)
);


--
-- Name: chrAncestries; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "chrAncestries" (
    "ancestryID" integer NOT NULL,
    "ancestryName" character varying(100),
    "bloodlineID" integer,
    description character varying(1000),
    perception integer,
    willpower integer,
    charisma integer,
    memory integer,
    intelligence integer,
    "iconID" integer,
    "shortDescription" character varying(500)
);


--
-- Name: chrAttributes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "chrAttributes" (
    "attributeID" integer NOT NULL,
    "attributeName" character varying(100),
    description character varying(1000),
    "iconID" integer,
    "shortDescription" character varying(500),
    notes character varying(500)
);


--
-- Name: chrBloodlines; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "chrBloodlines" (
    "bloodlineID" integer NOT NULL,
    "bloodlineName" character varying(100),
    "raceID" integer,
    description character varying(1000),
    "maleDescription" character varying(1000),
    "femaleDescription" character varying(1000),
    "shipTypeID" integer,
    "corporationID" integer,
    perception integer,
    willpower integer,
    charisma integer,
    memory integer,
    intelligence integer,
    "iconID" integer,
    "shortDescription" character varying(500),
    "shortMaleDescription" character varying(500),
    "shortFemaleDescription" character varying(500)
);


--
-- Name: chrFactions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "chrFactions" (
    "factionID" integer NOT NULL,
    "factionName" character varying(100),
    description character varying(1000),
    "raceIDs" integer,
    "solarSystemID" integer,
    "corporationID" integer,
    "sizeFactor" double precision,
    "stationCount" integer,
    "stationSystemCount" integer,
    "militiaCorporationID" integer,
    "iconID" integer
);


--
-- Name: chrRaces; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "chrRaces" (
    "raceID" integer NOT NULL,
    "raceName" character varying(100),
    description character varying(1000),
    "iconID" integer,
    "shortDescription" character varying(500)
);


--
-- Name: crpActivities; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "crpActivities" (
    "activityID" integer NOT NULL,
    "activityName" character varying(100),
    description character varying(1000)
);


--
-- Name: crpNPCCorporationDivisions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "crpNPCCorporationDivisions" (
    "corporationID" integer NOT NULL,
    "divisionID" integer NOT NULL,
    size integer
);


--
-- Name: crpNPCCorporationResearchFields; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "crpNPCCorporationResearchFields" (
    "skillID" integer NOT NULL,
    "corporationID" integer NOT NULL
);


--
-- Name: crpNPCCorporationTrades; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "crpNPCCorporationTrades" (
    "corporationID" integer NOT NULL,
    "typeID" integer NOT NULL
);


--
-- Name: crpNPCCorporations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "crpNPCCorporations" (
    "corporationID" integer NOT NULL,
    size character(1),
    extent character(1),
    "solarSystemID" integer,
    "investorID1" integer,
    "investorShares1" integer,
    "investorID2" integer,
    "investorShares2" integer,
    "investorID3" integer,
    "investorShares3" integer,
    "investorID4" integer,
    "investorShares4" integer,
    "friendID" integer,
    "enemyID" integer,
    "publicShares" integer,
    "initialPrice" integer,
    "minSecurity" double precision,
    scattered boolean,
    fringe integer,
    corridor integer,
    hub integer,
    border integer,
    "factionID" integer,
    "sizeFactor" double precision,
    "stationCount" integer,
    "stationSystemCount" integer,
    description character varying(4000),
    "iconID" integer
);


--
-- Name: crpNPCDivisions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "crpNPCDivisions" (
    "divisionID" integer NOT NULL,
    "divisionName" character varying(100),
    description character varying(1000),
    "leaderType" character varying(100)
);


--
-- Name: dgmAttributeCategories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "dgmAttributeCategories" (
    "categoryID" integer NOT NULL,
    "categoryName" character varying(50),
    "categoryDescription" character varying(200)
);


--
-- Name: dgmAttributeTypes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "dgmAttributeTypes" (
    "attributeID" integer NOT NULL,
    "attributeName" character varying(100),
    description character varying(1000),
    "iconID" integer,
    "defaultValue" double precision,
    published boolean,
    "displayName" character varying(150),
    "unitID" integer,
    stackable boolean,
    "highIsGood" boolean,
    "categoryID" integer
);


--
-- Name: dgmEffects; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "dgmEffects" (
    "effectID" integer NOT NULL,
    "effectName" character varying(400),
    "effectCategory" integer,
    "preExpression" integer,
    "postExpression" integer,
    description character varying(1000),
    guid character varying(60),
    "iconID" integer,
    "isOffensive" boolean,
    "isAssistance" boolean,
    "durationAttributeID" integer,
    "trackingSpeedAttributeID" integer,
    "dischargeAttributeID" integer,
    "rangeAttributeID" integer,
    "falloffAttributeID" integer,
    "disallowAutoRepeat" boolean,
    published boolean,
    "displayName" character varying(100),
    "isWarpSafe" boolean,
    "rangeChance" boolean,
    "electronicChance" boolean,
    "propulsionChance" boolean,
    distribution integer,
    "sfxName" character varying(20),
    "npcUsageChanceAttributeID" integer,
    "npcActivationChanceAttributeID" integer,
    "fittingUsageChanceAttributeID" integer,
    "modifierInfo" text
);


--
-- Name: dgmExpressions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "dgmExpressions" (
    "expressionID" integer NOT NULL,
    "operandID" integer,
    arg1 integer,
    arg2 integer,
    "expressionValue" character varying(100),
    description character varying(1000),
    "expressionName" character varying(500),
    "expressionTypeID" integer,
    "expressionGroupID" integer,
    "expressionAttributeID" integer
);


--
-- Name: dgmTypeAttributes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "dgmTypeAttributes" (
    "typeID" integer NOT NULL,
    "attributeID" integer NOT NULL,
    "valueInt" integer,
    "valueFloat" double precision
);


--
-- Name: dgmTypeEffects; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "dgmTypeEffects" (
    "typeID" integer NOT NULL,
    "effectID" integer NOT NULL,
    "isDefault" boolean
);


--
-- Name: eveGraphics; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "eveGraphics" (
    "graphicID" integer NOT NULL,
    "sofFactionName" character varying(100),
    "graphicFile" character varying(100),
    "sofHullName" character varying(100),
    "sofRaceName" character varying(100),
    description text
);


--
-- Name: eveIcons; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "eveIcons" (
    "iconID" integer NOT NULL,
    "iconFile" character varying(500),
    description text
);


--
-- Name: eveUnits; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "eveUnits" (
    "unitID" integer NOT NULL,
    "unitName" character varying(100),
    "displayName" character varying(50),
    description character varying(1000)
);


--
-- Name: industryActivity; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "industryActivity" (
    "typeID" integer NOT NULL,
    "activityID" integer NOT NULL,
    "time" integer
);


--
-- Name: industryActivityMaterials; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "industryActivityMaterials" (
    "typeID" integer,
    "activityID" integer,
    "materialTypeID" integer,
    quantity integer
);


--
-- Name: industryActivityProbabilities; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "industryActivityProbabilities" (
    "typeID" integer,
    "activityID" integer,
    "productTypeID" integer,
    probability numeric(3,2)
);


--
-- Name: industryActivityProducts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "industryActivityProducts" (
    "typeID" integer,
    "activityID" integer,
    "productTypeID" integer,
    quantity integer
);


--
-- Name: industryActivityRaces; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "industryActivityRaces" (
    "typeID" integer,
    "activityID" integer,
    "productTypeID" integer,
    "raceID" integer
);


--
-- Name: industryActivitySkills; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "industryActivitySkills" (
    "typeID" integer,
    "activityID" integer,
    "skillID" integer,
    level integer
);


--
-- Name: industryBlueprints; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "industryBlueprints" (
    "typeID" integer NOT NULL,
    "maxProductionLimit" integer
);


--
-- Name: invCategories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "invCategories" (
    "categoryID" integer NOT NULL,
    "categoryName" character varying(100),
    "iconID" integer,
    published boolean
);


--
-- Name: invContrabandTypes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "invContrabandTypes" (
    "factionID" integer NOT NULL,
    "typeID" integer NOT NULL,
    "standingLoss" double precision,
    "confiscateMinSec" double precision,
    "fineByValue" double precision,
    "attackMinSec" double precision
);


--
-- Name: invControlTowerResourcePurposes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "invControlTowerResourcePurposes" (
    purpose integer NOT NULL,
    "purposeText" character varying(100)
);


--
-- Name: invControlTowerResources; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "invControlTowerResources" (
    "controlTowerTypeID" integer NOT NULL,
    "resourceTypeID" integer NOT NULL,
    purpose integer,
    quantity integer,
    "minSecurityLevel" double precision,
    "factionID" integer
);


--
-- Name: invFlags; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "invFlags" (
    "flagID" integer NOT NULL,
    "flagName" character varying(200),
    "flagText" character varying(100),
    "orderID" integer
);


--
-- Name: invGroups; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "invGroups" (
    "groupID" integer NOT NULL,
    "categoryID" integer,
    "groupName" character varying(100),
    "iconID" integer,
    "useBasePrice" boolean,
    anchored boolean,
    anchorable boolean,
    "fittableNonSingleton" boolean,
    published boolean
);


--
-- Name: invItems; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "invItems" (
    "itemID" integer NOT NULL,
    "typeID" integer NOT NULL,
    "ownerID" integer NOT NULL,
    "locationID" integer NOT NULL,
    "flagID" integer NOT NULL,
    quantity integer NOT NULL
);


--
-- Name: invMarketGroups; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "invMarketGroups" (
    "marketGroupID" integer NOT NULL,
    "parentGroupID" integer,
    "marketGroupName" character varying(100),
    description character varying(3000),
    "iconID" integer,
    "hasTypes" boolean
);


--
-- Name: invMetaGroups; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "invMetaGroups" (
    "metaGroupID" integer NOT NULL,
    "metaGroupName" character varying(100),
    description character varying(1000),
    "iconID" integer
);


--
-- Name: invMetaTypes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "invMetaTypes" (
    "typeID" integer NOT NULL,
    "parentTypeID" integer,
    "metaGroupID" integer
);


--
-- Name: invNames; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "invNames" (
    "itemID" integer NOT NULL,
    "itemName" character varying(200) NOT NULL
);


--
-- Name: invPositions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "invPositions" (
    "itemID" integer NOT NULL,
    x double precision NOT NULL,
    y double precision NOT NULL,
    z double precision NOT NULL,
    yaw real,
    pitch real,
    roll real
);


--
-- Name: invTraits; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "invTraits" (
    "traitID" integer NOT NULL,
    "typeID" integer,
    "skillID" integer,
    bonus double precision,
    "bonusText" text,
    "unitID" integer
);


--
-- Name: invTraits_traitID_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "invTraits_traitID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: invTraits_traitID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "invTraits_traitID_seq" OWNED BY "invTraits"."traitID";


--
-- Name: invTypeMaterials; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "invTypeMaterials" (
    "typeID" integer NOT NULL,
    "materialTypeID" integer NOT NULL,
    quantity integer NOT NULL
);


--
-- Name: invTypeReactions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "invTypeReactions" (
    "reactionTypeID" integer NOT NULL,
    input boolean NOT NULL,
    "typeID" integer NOT NULL,
    quantity integer
);


--
-- Name: invTypes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "invTypes" (
    "typeID" integer NOT NULL,
    "groupID" integer,
    "typeName" character varying(100),
    description text,
    mass double precision,
    volume double precision,
    capacity double precision,
    "portionSize" integer,
    "raceID" integer,
    "basePrice" numeric(19,4),
    published boolean,
    "marketGroupID" integer,
    "iconID" integer,
    "soundID" integer,
    "graphicID" integer
);


--
-- Name: invUniqueNames; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "invUniqueNames" (
    "itemID" integer NOT NULL,
    "itemName" character varying(200) NOT NULL,
    "groupID" integer
);


--
-- Name: invVolumes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "invVolumes" (
    "typeID" integer NOT NULL,
    volume integer
);


--
-- Name: mapCelestialStatistics; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "mapCelestialStatistics" (
    "celestialID" integer NOT NULL,
    temperature double precision,
    "spectralClass" character varying(10),
    luminosity double precision,
    age double precision,
    life double precision,
    "orbitRadius" double precision,
    eccentricity double precision,
    "massDust" double precision,
    "massGas" double precision,
    fragmented boolean,
    density double precision,
    "surfaceGravity" double precision,
    "escapeVelocity" double precision,
    "orbitPeriod" double precision,
    "rotationRate" double precision,
    locked boolean,
    pressure double precision,
    radius double precision,
    mass integer
);


--
-- Name: mapConstellationJumps; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "mapConstellationJumps" (
    "fromRegionID" integer,
    "fromConstellationID" integer NOT NULL,
    "toConstellationID" integer NOT NULL,
    "toRegionID" integer
);


--
-- Name: mapConstellations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "mapConstellations" (
    "regionID" integer,
    "constellationID" integer NOT NULL,
    "constellationName" character varying(100),
    x double precision,
    y double precision,
    z double precision,
    "xMin" double precision,
    "xMax" double precision,
    "yMin" double precision,
    "yMax" double precision,
    "zMin" double precision,
    "zMax" double precision,
    "factionID" integer,
    radius double precision
);


--
-- Name: mapDenormalize; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "mapDenormalize" (
    "itemID" integer NOT NULL,
    "typeID" integer,
    "groupID" integer,
    "solarSystemID" integer,
    "constellationID" integer,
    "regionID" integer,
    "orbitID" integer,
    x double precision,
    y double precision,
    z double precision,
    radius double precision,
    "itemName" character varying(100),
    security double precision,
    "celestialIndex" integer,
    "orbitIndex" integer
);


--
-- Name: mapJumps; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "mapJumps" (
    "stargateID" integer NOT NULL,
    "destinationID" integer
);


--
-- Name: mapLandmarks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "mapLandmarks" (
    "landmarkID" integer NOT NULL,
    "landmarkName" character varying(100),
    description text,
    "locationID" integer,
    x double precision,
    y double precision,
    z double precision,
    "iconID" integer
);


--
-- Name: mapLocationScenes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "mapLocationScenes" (
    "locationID" integer NOT NULL,
    "graphicID" integer
);


--
-- Name: mapLocationWormholeClasses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "mapLocationWormholeClasses" (
    "locationID" integer NOT NULL,
    "wormholeClassID" integer
);


--
-- Name: mapRegionJumps; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "mapRegionJumps" (
    "fromRegionID" integer NOT NULL,
    "toRegionID" integer NOT NULL
);


--
-- Name: mapRegions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "mapRegions" (
    "regionID" integer NOT NULL,
    "regionName" character varying(100),
    x double precision,
    y double precision,
    z double precision,
    "xMin" double precision,
    "xMax" double precision,
    "yMin" double precision,
    "yMax" double precision,
    "zMin" double precision,
    "zMax" double precision,
    "factionID" integer,
    radius double precision
);


--
-- Name: mapSolarSystemJumps; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "mapSolarSystemJumps" (
    "fromRegionID" integer,
    "fromConstellationID" integer,
    "fromSolarSystemID" integer NOT NULL,
    "toSolarSystemID" integer NOT NULL,
    "toConstellationID" integer,
    "toRegionID" integer
);


--
-- Name: mapSolarSystems; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "mapSolarSystems" (
    "regionID" integer,
    "constellationID" integer,
    "solarSystemID" integer NOT NULL,
    "solarSystemName" character varying(100),
    x double precision,
    y double precision,
    z double precision,
    "xMin" double precision,
    "xMax" double precision,
    "yMin" double precision,
    "yMax" double precision,
    "zMin" double precision,
    "zMax" double precision,
    luminosity double precision,
    border boolean,
    fringe boolean,
    corridor boolean,
    hub boolean,
    international boolean,
    regional boolean,
    constellation boolean,
    security double precision,
    "factionID" integer,
    radius double precision,
    "sunTypeID" integer,
    "securityClass" character varying(2)
);


--
-- Name: mapUniverse; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "mapUniverse" (
    "universeID" integer NOT NULL,
    "universeName" character varying(100),
    x double precision,
    y double precision,
    z double precision,
    "xMin" double precision,
    "xMax" double precision,
    "yMin" double precision,
    "yMax" double precision,
    "zMin" double precision,
    "zMax" double precision,
    radius double precision
);


--
-- Name: planetSchematics; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "planetSchematics" (
    "schematicID" integer NOT NULL,
    "schematicName" character varying(255),
    "cycleTime" integer
);


--
-- Name: planetSchematicsPinMap; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "planetSchematicsPinMap" (
    "schematicID" integer NOT NULL,
    "pinTypeID" integer NOT NULL
);


--
-- Name: planetSchematicsTypeMap; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "planetSchematicsTypeMap" (
    "schematicID" integer NOT NULL,
    "typeID" integer NOT NULL,
    quantity integer,
    "isInput" boolean
);


--
-- Name: ramActivities; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "ramActivities" (
    "activityID" integer NOT NULL,
    "activityName" character varying(100),
    "iconNo" character varying(5),
    description character varying(1000),
    published boolean
);


--
-- Name: ramAssemblyLineStations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "ramAssemblyLineStations" (
    "stationID" integer NOT NULL,
    "assemblyLineTypeID" integer NOT NULL,
    quantity integer,
    "stationTypeID" integer,
    "ownerID" integer,
    "solarSystemID" integer,
    "regionID" integer
);


--
-- Name: ramAssemblyLineTypeDetailPerCategory; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "ramAssemblyLineTypeDetailPerCategory" (
    "assemblyLineTypeID" integer NOT NULL,
    "categoryID" integer NOT NULL,
    "timeMultiplier" double precision,
    "materialMultiplier" double precision,
    "costMultiplier" double precision
);


--
-- Name: ramAssemblyLineTypeDetailPerGroup; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "ramAssemblyLineTypeDetailPerGroup" (
    "assemblyLineTypeID" integer NOT NULL,
    "groupID" integer NOT NULL,
    "timeMultiplier" double precision,
    "materialMultiplier" double precision,
    "costMultiplier" double precision
);


--
-- Name: ramAssemblyLineTypes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "ramAssemblyLineTypes" (
    "assemblyLineTypeID" integer NOT NULL,
    "assemblyLineTypeName" character varying(100),
    description character varying(1000),
    "baseTimeMultiplier" double precision,
    "baseMaterialMultiplier" double precision,
    "baseCostMultiplier" double precision,
    volume double precision,
    "activityID" integer,
    "minCostPerHour" double precision
);


--
-- Name: ramInstallationTypeContents; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "ramInstallationTypeContents" (
    "installationTypeID" integer NOT NULL,
    "assemblyLineTypeID" integer NOT NULL,
    quantity integer
);


--
-- Name: skinLicense; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "skinLicense" (
    "licenseTypeID" integer NOT NULL,
    duration integer,
    "skinID" integer
);


--
-- Name: skinMaterials; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "skinMaterials" (
    "skinMaterialID" integer NOT NULL,
    "displayNameID" integer,
    "materialSetID" integer
);


--
-- Name: skinShip; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "skinShip" (
    "skinID" integer,
    "typeID" integer
);


--
-- Name: skins; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE skins (
    "skinID" integer NOT NULL,
    "internalName" character varying(70),
    "skinMaterialID" integer
);


--
-- Name: staOperationServices; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "staOperationServices" (
    "operationID" integer NOT NULL,
    "serviceID" integer NOT NULL
);


--
-- Name: staOperations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "staOperations" (
    "activityID" integer,
    "operationID" integer NOT NULL,
    "operationName" character varying(100),
    description character varying(1000),
    fringe integer,
    corridor integer,
    hub integer,
    border integer,
    ratio integer,
    "caldariStationTypeID" integer,
    "minmatarStationTypeID" integer,
    "amarrStationTypeID" integer,
    "gallenteStationTypeID" integer,
    "joveStationTypeID" integer
);


--
-- Name: staServices; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "staServices" (
    "serviceID" integer NOT NULL,
    "serviceName" character varying(100),
    description character varying(1000)
);


--
-- Name: staStationTypes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "staStationTypes" (
    "stationTypeID" integer NOT NULL,
    "dockEntryX" double precision,
    "dockEntryY" double precision,
    "dockEntryZ" double precision,
    "dockOrientationX" double precision,
    "dockOrientationY" double precision,
    "dockOrientationZ" double precision,
    "operationID" integer,
    "officeSlots" integer,
    "reprocessingEfficiency" double precision,
    conquerable boolean
);


--
-- Name: staStations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "staStations" (
    "stationID" bigint NOT NULL,
    security double precision,
    "dockingCostPerVolume" double precision,
    "maxShipVolumeDockable" double precision,
    "officeRentalCost" integer,
    "operationID" integer,
    "stationTypeID" integer,
    "corporationID" integer,
    "solarSystemID" integer,
    "constellationID" integer,
    "regionID" integer,
    "stationName" character varying(100),
    x double precision,
    y double precision,
    z double precision,
    "reprocessingEfficiency" double precision,
    "reprocessingStationsTake" double precision,
    "reprocessingHangarFlag" integer
);


--
-- Name: translationTables; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "translationTables" (
    "sourceTable" character varying(200) NOT NULL,
    "destinationTable" character varying(200),
    "translatedKey" character varying(200) NOT NULL,
    "tcGroupID" integer,
    "tcID" integer
);


--
-- Name: trnTranslationColumns; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "trnTranslationColumns" (
    "tcGroupID" integer,
    "tcID" integer NOT NULL,
    "tableName" character varying(256) NOT NULL,
    "columnName" character varying(128) NOT NULL,
    "masterID" character varying(128)
);


--
-- Name: trnTranslationLanguages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "trnTranslationLanguages" (
    "numericLanguageID" integer NOT NULL,
    "languageID" character varying(50),
    "languageName" character varying(200)
);


--
-- Name: trnTranslations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "trnTranslations" (
    "tcID" integer NOT NULL,
    "keyID" integer NOT NULL,
    "languageID" character varying(50) NOT NULL,
    text text NOT NULL
);


--
-- Name: warCombatZoneSystems; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "warCombatZoneSystems" (
    "solarSystemID" integer NOT NULL,
    "combatZoneID" integer
);


--
-- Name: warCombatZones; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "warCombatZones" (
    "combatZoneID" integer NOT NULL,
    "combatZoneName" character varying(100),
    "factionID" integer,
    "centerSystemID" integer,
    description character varying(500)
);


--
-- Name: invTraits traitID; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "invTraits" ALTER COLUMN "traitID" SET DEFAULT nextval('"invTraits_traitID_seq"'::regclass);


--
-- Name: agtAgentTypes agtAgentTypes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "agtAgentTypes"
    ADD CONSTRAINT "agtAgentTypes_pkey" PRIMARY KEY ("agentTypeID");


--
-- Name: agtAgents agtAgents_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "agtAgents"
    ADD CONSTRAINT "agtAgents_pkey" PRIMARY KEY ("agentID");


--
-- Name: agtResearchAgents agtResearchAgents_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "agtResearchAgents"
    ADD CONSTRAINT "agtResearchAgents_pkey" PRIMARY KEY ("agentID", "typeID");


--
-- Name: certCerts certCerts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "certCerts"
    ADD CONSTRAINT "certCerts_pkey" PRIMARY KEY ("certID");


--
-- Name: chrAncestries chrAncestries_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "chrAncestries"
    ADD CONSTRAINT "chrAncestries_pkey" PRIMARY KEY ("ancestryID");


--
-- Name: chrAttributes chrAttributes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "chrAttributes"
    ADD CONSTRAINT "chrAttributes_pkey" PRIMARY KEY ("attributeID");


--
-- Name: chrBloodlines chrBloodlines_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "chrBloodlines"
    ADD CONSTRAINT "chrBloodlines_pkey" PRIMARY KEY ("bloodlineID");


--
-- Name: chrFactions chrFactions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "chrFactions"
    ADD CONSTRAINT "chrFactions_pkey" PRIMARY KEY ("factionID");


--
-- Name: chrRaces chrRaces_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "chrRaces"
    ADD CONSTRAINT "chrRaces_pkey" PRIMARY KEY ("raceID");


--
-- Name: crpActivities crpActivities_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "crpActivities"
    ADD CONSTRAINT "crpActivities_pkey" PRIMARY KEY ("activityID");


--
-- Name: crpNPCCorporationDivisions crpNPCCorporationDivisions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "crpNPCCorporationDivisions"
    ADD CONSTRAINT "crpNPCCorporationDivisions_pkey" PRIMARY KEY ("corporationID", "divisionID");


--
-- Name: crpNPCCorporationResearchFields crpNPCCorporationResearchFields_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "crpNPCCorporationResearchFields"
    ADD CONSTRAINT "crpNPCCorporationResearchFields_pkey" PRIMARY KEY ("skillID", "corporationID");


--
-- Name: crpNPCCorporationTrades crpNPCCorporationTrades_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "crpNPCCorporationTrades"
    ADD CONSTRAINT "crpNPCCorporationTrades_pkey" PRIMARY KEY ("corporationID", "typeID");


--
-- Name: crpNPCCorporations crpNPCCorporations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "crpNPCCorporations"
    ADD CONSTRAINT "crpNPCCorporations_pkey" PRIMARY KEY ("corporationID");


--
-- Name: crpNPCDivisions crpNPCDivisions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "crpNPCDivisions"
    ADD CONSTRAINT "crpNPCDivisions_pkey" PRIMARY KEY ("divisionID");


--
-- Name: dgmAttributeCategories dgmAttributeCategories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "dgmAttributeCategories"
    ADD CONSTRAINT "dgmAttributeCategories_pkey" PRIMARY KEY ("categoryID");


--
-- Name: dgmAttributeTypes dgmAttributeTypes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "dgmAttributeTypes"
    ADD CONSTRAINT "dgmAttributeTypes_pkey" PRIMARY KEY ("attributeID");


--
-- Name: dgmEffects dgmEffects_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "dgmEffects"
    ADD CONSTRAINT "dgmEffects_pkey" PRIMARY KEY ("effectID");


--
-- Name: dgmExpressions dgmExpressions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "dgmExpressions"
    ADD CONSTRAINT "dgmExpressions_pkey" PRIMARY KEY ("expressionID");


--
-- Name: dgmTypeAttributes dgmTypeAttributes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "dgmTypeAttributes"
    ADD CONSTRAINT "dgmTypeAttributes_pkey" PRIMARY KEY ("typeID", "attributeID");


--
-- Name: dgmTypeEffects dgmTypeEffects_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "dgmTypeEffects"
    ADD CONSTRAINT "dgmTypeEffects_pkey" PRIMARY KEY ("typeID", "effectID");


--
-- Name: eveGraphics eveGraphics_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "eveGraphics"
    ADD CONSTRAINT "eveGraphics_pkey" PRIMARY KEY ("graphicID");


--
-- Name: eveIcons eveIcons_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "eveIcons"
    ADD CONSTRAINT "eveIcons_pkey" PRIMARY KEY ("iconID");


--
-- Name: eveUnits eveUnits_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "eveUnits"
    ADD CONSTRAINT "eveUnits_pkey" PRIMARY KEY ("unitID");


--
-- Name: industryActivity industryActivity_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "industryActivity"
    ADD CONSTRAINT "industryActivity_pkey" PRIMARY KEY ("typeID", "activityID");


--
-- Name: industryBlueprints industryBlueprints_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "industryBlueprints"
    ADD CONSTRAINT "industryBlueprints_pkey" PRIMARY KEY ("typeID");


--
-- Name: invCategories invCategories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "invCategories"
    ADD CONSTRAINT "invCategories_pkey" PRIMARY KEY ("categoryID");


--
-- Name: invContrabandTypes invContrabandTypes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "invContrabandTypes"
    ADD CONSTRAINT "invContrabandTypes_pkey" PRIMARY KEY ("factionID", "typeID");


--
-- Name: invControlTowerResourcePurposes invControlTowerResourcePurposes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "invControlTowerResourcePurposes"
    ADD CONSTRAINT "invControlTowerResourcePurposes_pkey" PRIMARY KEY (purpose);


--
-- Name: invControlTowerResources invControlTowerResources_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "invControlTowerResources"
    ADD CONSTRAINT "invControlTowerResources_pkey" PRIMARY KEY ("controlTowerTypeID", "resourceTypeID");


--
-- Name: invFlags invFlags_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "invFlags"
    ADD CONSTRAINT "invFlags_pkey" PRIMARY KEY ("flagID");


--
-- Name: invGroups invGroups_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "invGroups"
    ADD CONSTRAINT "invGroups_pkey" PRIMARY KEY ("groupID");


--
-- Name: invItems invItems_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "invItems"
    ADD CONSTRAINT "invItems_pkey" PRIMARY KEY ("itemID");


--
-- Name: invMarketGroups invMarketGroups_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "invMarketGroups"
    ADD CONSTRAINT "invMarketGroups_pkey" PRIMARY KEY ("marketGroupID");


--
-- Name: invMetaGroups invMetaGroups_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "invMetaGroups"
    ADD CONSTRAINT "invMetaGroups_pkey" PRIMARY KEY ("metaGroupID");


--
-- Name: invMetaTypes invMetaTypes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "invMetaTypes"
    ADD CONSTRAINT "invMetaTypes_pkey" PRIMARY KEY ("typeID");


--
-- Name: invNames invNames_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "invNames"
    ADD CONSTRAINT "invNames_pkey" PRIMARY KEY ("itemID");


--
-- Name: invPositions invPositions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "invPositions"
    ADD CONSTRAINT "invPositions_pkey" PRIMARY KEY ("itemID");


--
-- Name: invTraits invTraits_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "invTraits"
    ADD CONSTRAINT "invTraits_pkey" PRIMARY KEY ("traitID");


--
-- Name: invTypeMaterials invTypeMaterials_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "invTypeMaterials"
    ADD CONSTRAINT "invTypeMaterials_pkey" PRIMARY KEY ("typeID", "materialTypeID");


--
-- Name: invTypeReactions invTypeReactions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "invTypeReactions"
    ADD CONSTRAINT "invTypeReactions_pkey" PRIMARY KEY ("reactionTypeID", input, "typeID");


--
-- Name: invTypes invTypes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "invTypes"
    ADD CONSTRAINT "invTypes_pkey" PRIMARY KEY ("typeID");


--
-- Name: invUniqueNames invUniqueNames_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "invUniqueNames"
    ADD CONSTRAINT "invUniqueNames_pkey" PRIMARY KEY ("itemID");


--
-- Name: invVolumes invVolumes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "invVolumes"
    ADD CONSTRAINT "invVolumes_pkey" PRIMARY KEY ("typeID");


--
-- Name: mapCelestialStatistics mapCelestialStatistics_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "mapCelestialStatistics"
    ADD CONSTRAINT "mapCelestialStatistics_pkey" PRIMARY KEY ("celestialID");


--
-- Name: mapConstellationJumps mapConstellationJumps_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "mapConstellationJumps"
    ADD CONSTRAINT "mapConstellationJumps_pkey" PRIMARY KEY ("fromConstellationID", "toConstellationID");


--
-- Name: mapConstellations mapConstellations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "mapConstellations"
    ADD CONSTRAINT "mapConstellations_pkey" PRIMARY KEY ("constellationID");


--
-- Name: mapDenormalize mapDenormalize_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "mapDenormalize"
    ADD CONSTRAINT "mapDenormalize_pkey" PRIMARY KEY ("itemID");


--
-- Name: mapJumps mapJumps_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "mapJumps"
    ADD CONSTRAINT "mapJumps_pkey" PRIMARY KEY ("stargateID");


--
-- Name: mapLandmarks mapLandmarks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "mapLandmarks"
    ADD CONSTRAINT "mapLandmarks_pkey" PRIMARY KEY ("landmarkID");


--
-- Name: mapLocationScenes mapLocationScenes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "mapLocationScenes"
    ADD CONSTRAINT "mapLocationScenes_pkey" PRIMARY KEY ("locationID");


--
-- Name: mapLocationWormholeClasses mapLocationWormholeClasses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "mapLocationWormholeClasses"
    ADD CONSTRAINT "mapLocationWormholeClasses_pkey" PRIMARY KEY ("locationID");


--
-- Name: mapRegionJumps mapRegionJumps_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "mapRegionJumps"
    ADD CONSTRAINT "mapRegionJumps_pkey" PRIMARY KEY ("fromRegionID", "toRegionID");


--
-- Name: mapRegions mapRegions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "mapRegions"
    ADD CONSTRAINT "mapRegions_pkey" PRIMARY KEY ("regionID");


--
-- Name: mapSolarSystemJumps mapSolarSystemJumps_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "mapSolarSystemJumps"
    ADD CONSTRAINT "mapSolarSystemJumps_pkey" PRIMARY KEY ("fromSolarSystemID", "toSolarSystemID");


--
-- Name: mapSolarSystems mapSolarSystems_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "mapSolarSystems"
    ADD CONSTRAINT "mapSolarSystems_pkey" PRIMARY KEY ("solarSystemID");


--
-- Name: mapUniverse mapUniverse_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "mapUniverse"
    ADD CONSTRAINT "mapUniverse_pkey" PRIMARY KEY ("universeID");


--
-- Name: planetSchematicsPinMap planetSchematicsPinMap_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "planetSchematicsPinMap"
    ADD CONSTRAINT "planetSchematicsPinMap_pkey" PRIMARY KEY ("schematicID", "pinTypeID");


--
-- Name: planetSchematicsTypeMap planetSchematicsTypeMap_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "planetSchematicsTypeMap"
    ADD CONSTRAINT "planetSchematicsTypeMap_pkey" PRIMARY KEY ("schematicID", "typeID");


--
-- Name: planetSchematics planetSchematics_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "planetSchematics"
    ADD CONSTRAINT "planetSchematics_pkey" PRIMARY KEY ("schematicID");


--
-- Name: ramActivities ramActivities_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "ramActivities"
    ADD CONSTRAINT "ramActivities_pkey" PRIMARY KEY ("activityID");


--
-- Name: ramAssemblyLineStations ramAssemblyLineStations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "ramAssemblyLineStations"
    ADD CONSTRAINT "ramAssemblyLineStations_pkey" PRIMARY KEY ("stationID", "assemblyLineTypeID");


--
-- Name: ramAssemblyLineTypeDetailPerCategory ramAssemblyLineTypeDetailPerCategory_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "ramAssemblyLineTypeDetailPerCategory"
    ADD CONSTRAINT "ramAssemblyLineTypeDetailPerCategory_pkey" PRIMARY KEY ("assemblyLineTypeID", "categoryID");


--
-- Name: ramAssemblyLineTypeDetailPerGroup ramAssemblyLineTypeDetailPerGroup_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "ramAssemblyLineTypeDetailPerGroup"
    ADD CONSTRAINT "ramAssemblyLineTypeDetailPerGroup_pkey" PRIMARY KEY ("assemblyLineTypeID", "groupID");


--
-- Name: ramAssemblyLineTypes ramAssemblyLineTypes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "ramAssemblyLineTypes"
    ADD CONSTRAINT "ramAssemblyLineTypes_pkey" PRIMARY KEY ("assemblyLineTypeID");


--
-- Name: ramInstallationTypeContents ramInstallationTypeContents_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "ramInstallationTypeContents"
    ADD CONSTRAINT "ramInstallationTypeContents_pkey" PRIMARY KEY ("installationTypeID", "assemblyLineTypeID");


--
-- Name: skinLicense skinLicense_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "skinLicense"
    ADD CONSTRAINT "skinLicense_pkey" PRIMARY KEY ("licenseTypeID");


--
-- Name: skinMaterials skinMaterials_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "skinMaterials"
    ADD CONSTRAINT "skinMaterials_pkey" PRIMARY KEY ("skinMaterialID");


--
-- Name: skins skins_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY skins
    ADD CONSTRAINT skins_pkey PRIMARY KEY ("skinID");


--
-- Name: staOperationServices staOperationServices_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "staOperationServices"
    ADD CONSTRAINT "staOperationServices_pkey" PRIMARY KEY ("operationID", "serviceID");


--
-- Name: staOperations staOperations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "staOperations"
    ADD CONSTRAINT "staOperations_pkey" PRIMARY KEY ("operationID");


--
-- Name: staServices staServices_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "staServices"
    ADD CONSTRAINT "staServices_pkey" PRIMARY KEY ("serviceID");


--
-- Name: staStationTypes staStationTypes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "staStationTypes"
    ADD CONSTRAINT "staStationTypes_pkey" PRIMARY KEY ("stationTypeID");


--
-- Name: staStations staStations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "staStations"
    ADD CONSTRAINT "staStations_pkey" PRIMARY KEY ("stationID");


--
-- Name: translationTables translationTables_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "translationTables"
    ADD CONSTRAINT "translationTables_pkey" PRIMARY KEY ("sourceTable", "translatedKey");


--
-- Name: trnTranslationColumns trnTranslationColumns_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "trnTranslationColumns"
    ADD CONSTRAINT "trnTranslationColumns_pkey" PRIMARY KEY ("tcID");


--
-- Name: trnTranslationLanguages trnTranslationLanguages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "trnTranslationLanguages"
    ADD CONSTRAINT "trnTranslationLanguages_pkey" PRIMARY KEY ("numericLanguageID");


--
-- Name: trnTranslations trnTranslations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "trnTranslations"
    ADD CONSTRAINT "trnTranslations_pkey" PRIMARY KEY ("tcID", "keyID", "languageID");


--
-- Name: warCombatZoneSystems warCombatZoneSystems_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "warCombatZoneSystems"
    ADD CONSTRAINT "warCombatZoneSystems_pkey" PRIMARY KEY ("solarSystemID");


--
-- Name: warCombatZones warCombatZones_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "warCombatZones"
    ADD CONSTRAINT "warCombatZones_pkey" PRIMARY KEY ("combatZoneID");


--
-- Name: industryActivityMaterials_idx1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "industryActivityMaterials_idx1" ON "industryActivityMaterials" USING btree ("typeID", "activityID");


--
-- Name: industryActivitySkills_idx1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "industryActivitySkills_idx1" ON "industryActivitySkills" USING btree ("typeID", "activityID");


--
-- Name: invUniqueNames_IX_GroupName; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "invUniqueNames_IX_GroupName" ON "invUniqueNames" USING btree ("groupID", "itemName");


--
-- Name: items_IX_OwnerLocation; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "items_IX_OwnerLocation" ON "invItems" USING btree ("ownerID", "locationID");


--
-- Name: ix_agtAgents_corporationID; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "ix_agtAgents_corporationID" ON "agtAgents" USING btree ("corporationID");


--
-- Name: ix_agtAgents_locationID; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "ix_agtAgents_locationID" ON "agtAgents" USING btree ("locationID");


--
-- Name: ix_agtResearchAgents_typeID; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "ix_agtResearchAgents_typeID" ON "agtResearchAgents" USING btree ("typeID");


--
-- Name: ix_certSkills_skillID; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "ix_certSkills_skillID" ON "certSkills" USING btree ("skillID");


--
-- Name: ix_dgmTypeAttributes_attributeID; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "ix_dgmTypeAttributes_attributeID" ON "dgmTypeAttributes" USING btree ("attributeID");


--
-- Name: ix_industryActivityMaterials_typeID; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "ix_industryActivityMaterials_typeID" ON "industryActivityMaterials" USING btree ("typeID");


--
-- Name: ix_industryActivityProbabilities_productTypeID; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "ix_industryActivityProbabilities_productTypeID" ON "industryActivityProbabilities" USING btree ("productTypeID");


--
-- Name: ix_industryActivityProbabilities_typeID; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "ix_industryActivityProbabilities_typeID" ON "industryActivityProbabilities" USING btree ("typeID");


--
-- Name: ix_industryActivityProducts_productTypeID; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "ix_industryActivityProducts_productTypeID" ON "industryActivityProducts" USING btree ("productTypeID");


--
-- Name: ix_industryActivityProducts_typeID; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "ix_industryActivityProducts_typeID" ON "industryActivityProducts" USING btree ("typeID");


--
-- Name: ix_industryActivityRaces_productTypeID; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "ix_industryActivityRaces_productTypeID" ON "industryActivityRaces" USING btree ("productTypeID");


--
-- Name: ix_industryActivityRaces_typeID; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "ix_industryActivityRaces_typeID" ON "industryActivityRaces" USING btree ("typeID");


--
-- Name: ix_industryActivitySkills_skillID; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "ix_industryActivitySkills_skillID" ON "industryActivitySkills" USING btree ("skillID");


--
-- Name: ix_industryActivitySkills_typeID; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "ix_industryActivitySkills_typeID" ON "industryActivitySkills" USING btree ("typeID");


--
-- Name: ix_industryActivity_activityID; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "ix_industryActivity_activityID" ON "industryActivity" USING btree ("activityID");


--
-- Name: ix_invContrabandTypes_typeID; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "ix_invContrabandTypes_typeID" ON "invContrabandTypes" USING btree ("typeID");


--
-- Name: ix_invGroups_categoryID; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "ix_invGroups_categoryID" ON "invGroups" USING btree ("categoryID");


--
-- Name: ix_invItems_locationID; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "ix_invItems_locationID" ON "invItems" USING btree ("locationID");


--
-- Name: ix_invTypes_groupID; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "ix_invTypes_groupID" ON "invTypes" USING btree ("groupID");


--
-- Name: ix_invUniqueNames_itemName; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "ix_invUniqueNames_itemName" ON "invUniqueNames" USING btree ("itemName");


--
-- Name: ix_mapDenormalize_constellationID; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "ix_mapDenormalize_constellationID" ON "mapDenormalize" USING btree ("constellationID");


--
-- Name: ix_mapDenormalize_orbitID; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "ix_mapDenormalize_orbitID" ON "mapDenormalize" USING btree ("orbitID");


--
-- Name: ix_mapDenormalize_regionID; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "ix_mapDenormalize_regionID" ON "mapDenormalize" USING btree ("regionID");


--
-- Name: ix_mapDenormalize_solarSystemID; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "ix_mapDenormalize_solarSystemID" ON "mapDenormalize" USING btree ("solarSystemID");


--
-- Name: ix_mapDenormalize_typeID; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "ix_mapDenormalize_typeID" ON "mapDenormalize" USING btree ("typeID");


--
-- Name: ix_mapSolarSystems_constellationID; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "ix_mapSolarSystems_constellationID" ON "mapSolarSystems" USING btree ("constellationID");


--
-- Name: ix_mapSolarSystems_regionID; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "ix_mapSolarSystems_regionID" ON "mapSolarSystems" USING btree ("regionID");


--
-- Name: ix_mapSolarSystems_security; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "ix_mapSolarSystems_security" ON "mapSolarSystems" USING btree (security);


--
-- Name: ix_ramAssemblyLineStations_ownerID; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "ix_ramAssemblyLineStations_ownerID" ON "ramAssemblyLineStations" USING btree ("ownerID");


--
-- Name: ix_ramAssemblyLineStations_regionID; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "ix_ramAssemblyLineStations_regionID" ON "ramAssemblyLineStations" USING btree ("regionID");


--
-- Name: ix_ramAssemblyLineStations_solarSystemID; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "ix_ramAssemblyLineStations_solarSystemID" ON "ramAssemblyLineStations" USING btree ("solarSystemID");


--
-- Name: ix_skinShip_skinID; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "ix_skinShip_skinID" ON "skinShip" USING btree ("skinID");


--
-- Name: ix_skinShip_typeID; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "ix_skinShip_typeID" ON "skinShip" USING btree ("typeID");


--
-- Name: ix_staStations_constellationID; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "ix_staStations_constellationID" ON "staStations" USING btree ("constellationID");


--
-- Name: ix_staStations_corporationID; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "ix_staStations_corporationID" ON "staStations" USING btree ("corporationID");


--
-- Name: ix_staStations_operationID; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "ix_staStations_operationID" ON "staStations" USING btree ("operationID");


--
-- Name: ix_staStations_regionID; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "ix_staStations_regionID" ON "staStations" USING btree ("regionID");


--
-- Name: ix_staStations_solarSystemID; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "ix_staStations_solarSystemID" ON "staStations" USING btree ("solarSystemID");


--
-- Name: ix_staStations_stationTypeID; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "ix_staStations_stationTypeID" ON "staStations" USING btree ("stationTypeID");


--
-- Name: mapDenormalize_IX_groupConstellation; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "mapDenormalize_IX_groupConstellation" ON "mapDenormalize" USING btree ("groupID", "constellationID");


--
-- Name: mapDenormalize_IX_groupRegion; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "mapDenormalize_IX_groupRegion" ON "mapDenormalize" USING btree ("groupID", "regionID");


--
-- Name: mapDenormalize_IX_groupSystem; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "mapDenormalize_IX_groupSystem" ON "mapDenormalize" USING btree ("groupID", "solarSystemID");

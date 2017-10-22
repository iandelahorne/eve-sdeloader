--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.3
-- Dumped by pg_dump version 9.6.3

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
ALTER TABLE IF EXISTS ONLY public.warcombatzonesystems DROP CONSTRAINT warcombatzonesystems_pkey;
ALTER TABLE IF EXISTS ONLY public.warcombatzones DROP CONSTRAINT warcombatzones_pkey;
ALTER TABLE IF EXISTS ONLY public.trntranslations DROP CONSTRAINT trntranslations_pkey;
ALTER TABLE IF EXISTS ONLY public.trntranslationlanguages DROP CONSTRAINT trntranslationlanguages_pkey;
ALTER TABLE IF EXISTS ONLY public.trntranslationcolumns DROP CONSTRAINT trntranslationcolumns_pkey;
ALTER TABLE IF EXISTS ONLY public.translationtables DROP CONSTRAINT translationtables_pkey;
ALTER TABLE IF EXISTS ONLY public.stastationtypes DROP CONSTRAINT stastationtypes_pkey;
ALTER TABLE IF EXISTS ONLY public.stastations DROP CONSTRAINT stastations_pkey;
ALTER TABLE IF EXISTS ONLY public.staservices DROP CONSTRAINT staservices_pkey;
ALTER TABLE IF EXISTS ONLY public.staoperationservices DROP CONSTRAINT staoperationservices_pkey;
ALTER TABLE IF EXISTS ONLY public.staoperations DROP CONSTRAINT staoperations_pkey;
ALTER TABLE IF EXISTS ONLY public.skins DROP CONSTRAINT skins_pkey;
ALTER TABLE IF EXISTS ONLY public.skinmaterials DROP CONSTRAINT skinmaterials_pkey;
ALTER TABLE IF EXISTS ONLY public.skinlicense DROP CONSTRAINT skinlicense_pkey;
ALTER TABLE IF EXISTS ONLY public.raminstallationtypecontents DROP CONSTRAINT raminstallationtypecontents_pkey;
ALTER TABLE IF EXISTS ONLY public.ramassemblylinetypes DROP CONSTRAINT ramassemblylinetypes_pkey;
ALTER TABLE IF EXISTS ONLY public.ramassemblylinetypedetailpergroup DROP CONSTRAINT ramassemblylinetypedetailpergroup_pkey;
ALTER TABLE IF EXISTS ONLY public.ramassemblylinetypedetailpercategory DROP CONSTRAINT ramassemblylinetypedetailpercategory_pkey;
ALTER TABLE IF EXISTS ONLY public.ramassemblylinestations DROP CONSTRAINT ramassemblylinestations_pkey;
ALTER TABLE IF EXISTS ONLY public.ramactivities DROP CONSTRAINT ramactivities_pkey;
ALTER TABLE IF EXISTS ONLY public.planetschematicstypemap DROP CONSTRAINT planetschematicstypemap_pkey;
ALTER TABLE IF EXISTS ONLY public.planetschematicspinmap DROP CONSTRAINT planetschematicspinmap_pkey;
ALTER TABLE IF EXISTS ONLY public.planetschematics DROP CONSTRAINT planetschematics_pkey;
ALTER TABLE IF EXISTS ONLY public.mapuniverse DROP CONSTRAINT mapuniverse_pkey;
ALTER TABLE IF EXISTS ONLY public.mapsolarsystems DROP CONSTRAINT mapsolarsystems_pkey;
ALTER TABLE IF EXISTS ONLY public.mapsolarsystemjumps DROP CONSTRAINT mapsolarsystemjumps_pkey;
ALTER TABLE IF EXISTS ONLY public.mapregions DROP CONSTRAINT mapregions_pkey;
ALTER TABLE IF EXISTS ONLY public.mapregionjumps DROP CONSTRAINT mapregionjumps_pkey;
ALTER TABLE IF EXISTS ONLY public.maplocationwormholeclasses DROP CONSTRAINT maplocationwormholeclasses_pkey;
ALTER TABLE IF EXISTS ONLY public.maplocationscenes DROP CONSTRAINT maplocationscenes_pkey;
ALTER TABLE IF EXISTS ONLY public.maplandmarks DROP CONSTRAINT maplandmarks_pkey;
ALTER TABLE IF EXISTS ONLY public.mapjumps DROP CONSTRAINT mapjumps_pkey;
ALTER TABLE IF EXISTS ONLY public.mapdenormalize DROP CONSTRAINT mapdenormalize_pkey;
ALTER TABLE IF EXISTS ONLY public.mapconstellations DROP CONSTRAINT mapconstellations_pkey;
ALTER TABLE IF EXISTS ONLY public.mapconstellationjumps DROP CONSTRAINT mapconstellationjumps_pkey;
ALTER TABLE IF EXISTS ONLY public.mapcelestialstatistics DROP CONSTRAINT mapcelestialstatistics_pkey;
ALTER TABLE IF EXISTS ONLY public.invvolumes DROP CONSTRAINT invvolumes_pkey;
ALTER TABLE IF EXISTS ONLY public.invuniquenames DROP CONSTRAINT invuniquenames_pkey;
ALTER TABLE IF EXISTS ONLY public.invtypes DROP CONSTRAINT invtypes_pkey;
ALTER TABLE IF EXISTS ONLY public.invtypereactions DROP CONSTRAINT invtypereactions_pkey;
ALTER TABLE IF EXISTS ONLY public.invtypematerials DROP CONSTRAINT invtypematerials_pkey;
ALTER TABLE IF EXISTS ONLY public.invtraits DROP CONSTRAINT invtraits_pkey;
ALTER TABLE IF EXISTS ONLY public.invpositions DROP CONSTRAINT invpositions_pkey;
ALTER TABLE IF EXISTS ONLY public.invnames DROP CONSTRAINT invnames_pkey;
ALTER TABLE IF EXISTS ONLY public.invmetatypes DROP CONSTRAINT invmetatypes_pkey;
ALTER TABLE IF EXISTS ONLY public.invmetagroups DROP CONSTRAINT invmetagroups_pkey;
ALTER TABLE IF EXISTS ONLY public.invmarketgroups DROP CONSTRAINT invmarketgroups_pkey;
ALTER TABLE IF EXISTS ONLY public.invitems DROP CONSTRAINT invitems_pkey;
ALTER TABLE IF EXISTS ONLY public.invgroups DROP CONSTRAINT invgroups_pkey;
ALTER TABLE IF EXISTS ONLY public.invflags DROP CONSTRAINT invflags_pkey;
ALTER TABLE IF EXISTS ONLY public.invcontroltowerresources DROP CONSTRAINT invcontroltowerresources_pkey;
ALTER TABLE IF EXISTS ONLY public.invcontroltowerresourcepurposes DROP CONSTRAINT invcontroltowerresourcepurposes_pkey;
ALTER TABLE IF EXISTS ONLY public.invcontrabandtypes DROP CONSTRAINT invcontrabandtypes_pkey;
ALTER TABLE IF EXISTS ONLY public.invcategories DROP CONSTRAINT invcategories_pkey;
ALTER TABLE IF EXISTS ONLY public.industryblueprints DROP CONSTRAINT industryblueprints_pkey;
ALTER TABLE IF EXISTS ONLY public.industryactivity DROP CONSTRAINT industryactivity_pkey;
ALTER TABLE IF EXISTS ONLY public.eveunits DROP CONSTRAINT eveunits_pkey;
ALTER TABLE IF EXISTS ONLY public.eveicons DROP CONSTRAINT eveicons_pkey;
ALTER TABLE IF EXISTS ONLY public.evegraphics DROP CONSTRAINT evegraphics_pkey;
ALTER TABLE IF EXISTS ONLY public.dgmtypeeffects DROP CONSTRAINT dgmtypeeffects_pkey;
ALTER TABLE IF EXISTS ONLY public.dgmtypeattributes DROP CONSTRAINT dgmtypeattributes_pkey;
ALTER TABLE IF EXISTS ONLY public.dgmexpressions DROP CONSTRAINT dgmexpressions_pkey;
ALTER TABLE IF EXISTS ONLY public.dgmeffects DROP CONSTRAINT dgmeffects_pkey;
ALTER TABLE IF EXISTS ONLY public.dgmattributetypes DROP CONSTRAINT dgmattributetypes_pkey;
ALTER TABLE IF EXISTS ONLY public.dgmattributecategories DROP CONSTRAINT dgmattributecategories_pkey;
ALTER TABLE IF EXISTS ONLY public.crpnpcdivisions DROP CONSTRAINT crpnpcdivisions_pkey;
ALTER TABLE IF EXISTS ONLY public.crpnpccorporationtrades DROP CONSTRAINT crpnpccorporationtrades_pkey;
ALTER TABLE IF EXISTS ONLY public.crpnpccorporations DROP CONSTRAINT crpnpccorporations_pkey;
ALTER TABLE IF EXISTS ONLY public.crpnpccorporationresearchfields DROP CONSTRAINT crpnpccorporationresearchfields_pkey;
ALTER TABLE IF EXISTS ONLY public.crpnpccorporationdivisions DROP CONSTRAINT crpnpccorporationdivisions_pkey;
ALTER TABLE IF EXISTS ONLY public.crpactivities DROP CONSTRAINT crpactivities_pkey;
ALTER TABLE IF EXISTS ONLY public.chrraces DROP CONSTRAINT chrraces_pkey;
ALTER TABLE IF EXISTS ONLY public.chrfactions DROP CONSTRAINT chrfactions_pkey;
ALTER TABLE IF EXISTS ONLY public.chrbloodlines DROP CONSTRAINT chrbloodlines_pkey;
ALTER TABLE IF EXISTS ONLY public.chrattributes DROP CONSTRAINT chrattributes_pkey;
ALTER TABLE IF EXISTS ONLY public.chrancestries DROP CONSTRAINT chrancestries_pkey;
ALTER TABLE IF EXISTS ONLY public.certcerts DROP CONSTRAINT certcerts_pkey;
ALTER TABLE IF EXISTS ONLY public.agtresearchagents DROP CONSTRAINT agtresearchagents_pkey;
ALTER TABLE IF EXISTS ONLY public.agtagenttypes DROP CONSTRAINT agtagenttypes_pkey;
ALTER TABLE IF EXISTS ONLY public.agtagents DROP CONSTRAINT agtagents_pkey;
ALTER TABLE IF EXISTS public.invtraits ALTER COLUMN traitid DROP DEFAULT;
DROP TABLE IF EXISTS public.warcombatzonesystems;
DROP TABLE IF EXISTS public.warcombatzones;
DROP TABLE IF EXISTS public.trntranslations;
DROP TABLE IF EXISTS public.trntranslationlanguages;
DROP TABLE IF EXISTS public.trntranslationcolumns;
DROP TABLE IF EXISTS public.translationtables;
DROP TABLE IF EXISTS public.stastationtypes;
DROP TABLE IF EXISTS public.stastations;
DROP TABLE IF EXISTS public.staservices;
DROP TABLE IF EXISTS public.staoperationservices;
DROP TABLE IF EXISTS public.staoperations;
DROP TABLE IF EXISTS public.skinship;
DROP TABLE IF EXISTS public.skins;
DROP TABLE IF EXISTS public.skinmaterials;
DROP TABLE IF EXISTS public.skinlicense;
DROP TABLE IF EXISTS public.raminstallationtypecontents;
DROP TABLE IF EXISTS public.ramassemblylinetypes;
DROP TABLE IF EXISTS public.ramassemblylinetypedetailpergroup;
DROP TABLE IF EXISTS public.ramassemblylinetypedetailpercategory;
DROP TABLE IF EXISTS public.ramassemblylinestations;
DROP TABLE IF EXISTS public.ramactivities;
DROP TABLE IF EXISTS public.planetschematicstypemap;
DROP TABLE IF EXISTS public.planetschematicspinmap;
DROP TABLE IF EXISTS public.planetschematics;
DROP TABLE IF EXISTS public.mapuniverse;
DROP TABLE IF EXISTS public.mapsolarsystems;
DROP TABLE IF EXISTS public.mapsolarsystemjumps;
DROP TABLE IF EXISTS public.mapregions;
DROP TABLE IF EXISTS public.mapregionjumps;
DROP TABLE IF EXISTS public.maplocationwormholeclasses;
DROP TABLE IF EXISTS public.maplocationscenes;
DROP TABLE IF EXISTS public.maplandmarks;
DROP TABLE IF EXISTS public.mapjumps;
DROP TABLE IF EXISTS public.mapdenormalize;
DROP TABLE IF EXISTS public.mapconstellations;
DROP TABLE IF EXISTS public.mapconstellationjumps;
DROP TABLE IF EXISTS public.mapcelestialstatistics;
DROP TABLE IF EXISTS public.invvolumes;
DROP TABLE IF EXISTS public.invuniquenames;
DROP TABLE IF EXISTS public.invtypes;
DROP TABLE IF EXISTS public.invtypereactions;
DROP TABLE IF EXISTS public.invtypematerials;
DROP SEQUENCE IF EXISTS public.invtraits_traitid_seq;
DROP TABLE IF EXISTS public.invtraits;
DROP TABLE IF EXISTS public.invpositions;
DROP TABLE IF EXISTS public.invnames;
DROP TABLE IF EXISTS public.invmetatypes;
DROP TABLE IF EXISTS public.invmetagroups;
DROP TABLE IF EXISTS public.invmarketgroups;
DROP TABLE IF EXISTS public.invitems;
DROP TABLE IF EXISTS public.invgroups;
DROP TABLE IF EXISTS public.invflags;
DROP TABLE IF EXISTS public.invcontroltowerresources;
DROP TABLE IF EXISTS public.invcontroltowerresourcepurposes;
DROP TABLE IF EXISTS public.invcontrabandtypes;
DROP TABLE IF EXISTS public.invcategories;
DROP TABLE IF EXISTS public.industryblueprints;
DROP TABLE IF EXISTS public.industryactivityskills;
DROP TABLE IF EXISTS public.industryactivityraces;
DROP TABLE IF EXISTS public.industryactivityproducts;
DROP TABLE IF EXISTS public.industryactivityprobabilities;
DROP TABLE IF EXISTS public.industryactivitymaterials;
DROP TABLE IF EXISTS public.industryactivity;
DROP TABLE IF EXISTS public.eveunits;
DROP TABLE IF EXISTS public.eveicons;
DROP TABLE IF EXISTS public.evegraphics;
DROP TABLE IF EXISTS public.dgmtypeeffects;
DROP TABLE IF EXISTS public.dgmtypeattributes;
DROP TABLE IF EXISTS public.dgmexpressions;
DROP TABLE IF EXISTS public.dgmeffects;
DROP TABLE IF EXISTS public.dgmattributetypes;
DROP TABLE IF EXISTS public.dgmattributecategories;
DROP TABLE IF EXISTS public.crpnpcdivisions;
DROP TABLE IF EXISTS public.crpnpccorporationtrades;
DROP TABLE IF EXISTS public.crpnpccorporations;
DROP TABLE IF EXISTS public.crpnpccorporationresearchfields;
DROP TABLE IF EXISTS public.crpnpccorporationdivisions;
DROP TABLE IF EXISTS public.crpactivities;
DROP TABLE IF EXISTS public.chrraces;
DROP TABLE IF EXISTS public.chrfactions;
DROP TABLE IF EXISTS public.chrbloodlines;
DROP TABLE IF EXISTS public.chrattributes;
DROP TABLE IF EXISTS public.chrancestries;
DROP TABLE IF EXISTS public.certskills;
DROP TABLE IF EXISTS public.certmasteries;
DROP TABLE IF EXISTS public.certcerts;
DROP TABLE IF EXISTS public.agtresearchagents;
DROP TABLE IF EXISTS public.agtagenttypes;
DROP TABLE IF EXISTS public.agtagents;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: agtagents; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE agtagents (
    agentid integer NOT NULL,
    divisionid integer,
    corporationid integer,
    locationid integer,
    level integer,
    quality integer,
    agenttypeid integer,
    islocator boolean
);


--
-- Name: agtagenttypes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE agtagenttypes (
    agenttypeid integer NOT NULL,
    agenttype character varying(50)
);


--
-- Name: agtresearchagents; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE agtresearchagents (
    agentid integer NOT NULL,
    typeid integer NOT NULL
);


--
-- Name: certcerts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE certcerts (
    certid integer NOT NULL,
    description text,
    groupid integer,
    name character varying(255)
);


--
-- Name: certmasteries; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE certmasteries (
    typeid integer,
    masterylevel integer,
    certid integer
);


--
-- Name: certskills; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE certskills (
    certid integer,
    skillid integer,
    certlevelint integer,
    skilllevel integer,
    certleveltext character varying(8)
);


--
-- Name: chrancestries; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE chrancestries (
    ancestryid integer NOT NULL,
    ancestryname character varying(100),
    bloodlineid integer,
    description character varying(1000),
    perception integer,
    willpower integer,
    charisma integer,
    memory integer,
    intelligence integer,
    iconid integer,
    shortdescription character varying(500)
);


--
-- Name: chrattributes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE chrattributes (
    attributeid integer NOT NULL,
    attributename character varying(100),
    description character varying(1000),
    iconid integer,
    shortdescription character varying(500),
    notes character varying(500)
);


--
-- Name: chrbloodlines; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE chrbloodlines (
    bloodlineid integer NOT NULL,
    bloodlinename character varying(100),
    raceid integer,
    description character varying(1000),
    maledescription character varying(1000),
    femaledescription character varying(1000),
    shiptypeid integer,
    corporationid integer,
    perception integer,
    willpower integer,
    charisma integer,
    memory integer,
    intelligence integer,
    iconid integer,
    shortdescription character varying(500),
    shortmaledescription character varying(500),
    shortfemaledescription character varying(500)
);


--
-- Name: chrfactions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE chrfactions (
    factionid integer NOT NULL,
    factionname character varying(100),
    description character varying(1000),
    raceids integer,
    solarsystemid integer,
    corporationid integer,
    sizefactor double precision,
    stationcount integer,
    stationsystemcount integer,
    militiacorporationid integer,
    iconid integer
);


--
-- Name: chrraces; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE chrraces (
    raceid integer NOT NULL,
    racename character varying(100),
    description character varying(1000),
    iconid integer,
    shortdescription character varying(500)
);


--
-- Name: crpactivities; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE crpactivities (
    activityid integer NOT NULL,
    activityname character varying(100),
    description character varying(1000)
);


--
-- Name: crpnpccorporationdivisions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE crpnpccorporationdivisions (
    corporationid integer NOT NULL,
    divisionid integer NOT NULL,
    size integer
);


--
-- Name: crpnpccorporationresearchfields; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE crpnpccorporationresearchfields (
    skillid integer NOT NULL,
    corporationid integer NOT NULL
);


--
-- Name: crpnpccorporations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE crpnpccorporations (
    corporationid integer NOT NULL,
    size varchar,
    extent varchar,
    solarsystemid integer,
    investorid1 integer,
    investorshares1 integer,
    investorid2 integer,
    investorshares2 integer,
    investorid3 integer,
    investorshares3 integer,
    investorid4 integer,
    investorshares4 integer,
    friendid integer,
    enemyid integer,
    publicshares integer,
    initialprice integer,
    minsecurity double precision,
    scattered boolean,
    fringe integer,
    corridor integer,
    hub integer,
    border integer,
    factionid integer,
    sizefactor double precision,
    stationcount integer,
    stationsystemcount integer,
    description text,
    iconid integer
);


--
-- Name: crpnpccorporationtrades; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE crpnpccorporationtrades (
    corporationid integer NOT NULL,
    typeid integer NOT NULL
);


--
-- Name: crpnpcdivisions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE crpnpcdivisions (
    divisionid integer NOT NULL,
    divisionname character varying(100),
    description character varying(1000),
    leadertype character varying(100)
);


--
-- Name: dgmattributecategories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dgmattributecategories (
    categoryid integer NOT NULL,
    categoryname character varying(50),
    categorydescription character varying(200)
);


--
-- Name: dgmattributetypes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dgmattributetypes (
    attributeid integer NOT NULL,
    attributename character varying(100),
    description character varying(1000),
    iconid integer,
    defaultvalue double precision,
    published boolean,
    displayname character varying(150),
    unitid integer,
    stackable boolean,
    highisgood boolean,
    categoryid integer
);


--
-- Name: dgmeffects; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dgmeffects (
    effectid integer NOT NULL,
    effectname character varying(400),
    effectcategory integer,
    preexpression integer,
    postexpression integer,
    description character varying(1000),
    guid character varying(60),
    iconid integer,
    isoffensive boolean,
    isassistance boolean,
    durationattributeid integer,
    trackingspeedattributeid integer,
    dischargeattributeid integer,
    rangeattributeid integer,
    falloffattributeid integer,
    disallowautorepeat boolean,
    published boolean,
    displayname character varying(100),
    iswarpsafe boolean,
    rangechance boolean,
    electronicchance boolean,
    propulsionchance boolean,
    distribution integer,
    sfxname character varying(20),
    npcusagechanceattributeid integer,
    npcactivationchanceattributeid integer,
    fittingusagechanceattributeid integer,
    modifierinfo text
);


--
-- Name: dgmexpressions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dgmexpressions (
    expressionid integer NOT NULL,
    operandid integer,
    arg1 integer,
    arg2 integer,
    expressionvalue character varying(100),
    description character varying(1000),
    expressionname character varying(500),
    expressiontypeid integer,
    expressiongroupid integer,
    expressionattributeid integer
);


--
-- Name: dgmtypeattributes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dgmtypeattributes (
    typeid integer NOT NULL,
    attributeid integer NOT NULL,
    valueint integer,
    valuefloat double precision
);


--
-- Name: dgmtypeeffects; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dgmtypeeffects (
    typeid integer NOT NULL,
    effectid integer NOT NULL,
    isdefault boolean
);


--
-- Name: evegraphics; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE evegraphics (
    graphicid integer NOT NULL,
    soffactionname character varying(100),
    graphicfile character varying(100),
    sofhullname character varying(100),
    sofracename character varying(100),
    description text
);


--
-- Name: eveicons; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE eveicons (
    iconid integer NOT NULL,
    iconfile character varying(500),
    description text
);


--
-- Name: eveunits; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE eveunits (
    unitid integer NOT NULL,
    unitname character varying(100),
    displayname character varying(50),
    description character varying(1000)
);


--
-- Name: industryactivity; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE industryactivity (
    typeid integer NOT NULL,
    activityid integer NOT NULL,
    "time" integer
);


--
-- Name: industryactivitymaterials; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE industryactivitymaterials (
    typeid integer,
    activityid integer,
    materialtypeid integer,
    quantity integer
);


--
-- Name: industryactivityprobabilities; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE industryactivityprobabilities (
    typeid integer,
    activityid integer,
    producttypeid integer,
    probability numeric(3,2)
);


--
-- Name: industryactivityproducts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE industryactivityproducts (
    typeid integer,
    activityid integer,
    producttypeid integer,
    quantity integer
);


--
-- Name: industryactivityraces; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE industryactivityraces (
    typeid integer,
    activityid integer,
    producttypeid integer,
    raceid integer
);


--
-- Name: industryactivityskills; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE industryactivityskills (
    typeid integer,
    activityid integer,
    skillid integer,
    level integer
);


--
-- Name: industryblueprints; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE industryblueprints (
    typeid integer NOT NULL,
    maxproductionlimit integer
);


--
-- Name: invcategories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE invcategories (
    categoryid integer NOT NULL,
    categoryname character varying(100),
    iconid integer,
    published boolean
);


--
-- Name: invcontrabandtypes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE invcontrabandtypes (
    factionid integer NOT NULL,
    typeid integer NOT NULL,
    standingloss double precision,
    confiscateminsec double precision,
    finebyvalue double precision,
    attackminsec double precision
);


--
-- Name: invcontroltowerresourcepurposes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE invcontroltowerresourcepurposes (
    purpose integer NOT NULL,
    purposetext character varying(100)
);


--
-- Name: invcontroltowerresources; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE invcontroltowerresources (
    controltowertypeid integer NOT NULL,
    resourcetypeid integer NOT NULL,
    purpose integer,
    quantity integer,
    minsecuritylevel double precision,
    factionid integer
);


--
-- Name: invflags; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE invflags (
    flagid integer NOT NULL,
    flagname character varying(200),
    flagtext character varying(100),
    orderid integer
);


--
-- Name: invgroups; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE invgroups (
    groupid integer NOT NULL,
    categoryid integer,
    groupname character varying(100),
    iconid integer,
    usebaseprice boolean,
    anchored boolean,
    anchorable boolean,
    fittablenonsingleton boolean,
    published boolean
);


--
-- Name: invitems; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE invitems (
    itemid integer NOT NULL,
    typeid integer NOT NULL,
    ownerid integer NOT NULL,
    locationid integer NOT NULL,
    flagid integer NOT NULL,
    quantity integer NOT NULL
);


--
-- Name: invmarketgroups; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE invmarketgroups (
    marketgroupid integer NOT NULL,
    parentgroupid integer,
    marketgroupname character varying(100),
    description character varying(3000),
    iconid integer,
    hastypes boolean
);


--
-- Name: invmetagroups; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE invmetagroups (
    metagroupid integer NOT NULL,
    metagroupname character varying(100),
    description character varying(1000),
    iconid integer
);


--
-- Name: invmetatypes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE invmetatypes (
    typeid integer NOT NULL,
    parenttypeid integer,
    metagroupid integer
);


--
-- Name: invnames; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE invnames (
    itemid integer NOT NULL,
    itemname character varying(200) NOT NULL
);


--
-- Name: invpositions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE invpositions (
    itemid integer NOT NULL,
    x double precision NOT NULL,
    y double precision NOT NULL,
    z double precision NOT NULL,
    yaw real,
    pitch real,
    roll real
);


--
-- Name: invtraits; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE invtraits (
    traitid integer NOT NULL,
    typeid integer,
    skillid integer,
    bonus double precision,
    bonustext text,
    unitid integer
);


--
-- Name: invtraits_traitid_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE invtraits_traitid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: invtraits_traitid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE invtraits_traitid_seq OWNED BY invtraits.traitid;


--
-- Name: invtypematerials; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE invtypematerials (
    typeid integer NOT NULL,
    materialtypeid integer NOT NULL,
    quantity integer NOT NULL
);


--
-- Name: invtypereactions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE invtypereactions (
    reactiontypeid integer NOT NULL,
    input boolean NOT NULL,
    typeid integer NOT NULL,
    quantity integer
);


--
-- Name: invtypes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE invtypes (
    typeid integer NOT NULL,
    groupid integer,
    typename character varying(100),
    description text,
    mass double precision,
    volume double precision,
    capacity double precision,
    portionsize integer,
    raceid integer,
    baseprice numeric(19,4),
    published boolean,
    marketgroupid integer,
    iconid integer,
    soundid integer,
    graphicid integer
);


--
-- Name: invuniquenames; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE invuniquenames (
    itemid integer NOT NULL,
    itemname character varying(200) NOT NULL,
    groupid integer
);


--
-- Name: invvolumes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE invvolumes (
    typeid integer NOT NULL,
    volume integer
);


--
-- Name: mapcelestialstatistics; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE mapcelestialstatistics (
    celestialid integer NOT NULL,
    temperature double precision,
    spectralclass character varying(10),
    luminosity double precision,
    age double precision,
    life double precision,
    orbitradius double precision,
    eccentricity double precision,
    massdust double precision,
    massgas double precision,
    fragmented boolean,
    density double precision,
    surfacegravity double precision,
    escapevelocity double precision,
    orbitperiod double precision,
    rotationrate double precision,
    locked boolean,
    pressure bigint,
    radius bigint,
    mass integer
);


--
-- Name: mapconstellationjumps; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE mapconstellationjumps (
    fromregionid integer,
    fromconstellationid integer NOT NULL,
    toconstellationid integer NOT NULL,
    toregionid integer
);


--
-- Name: mapconstellations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE mapconstellations (
    regionid integer,
    constellationid integer NOT NULL,
    constellationname character varying(100),
    x double precision,
    y double precision,
    z double precision,
    "xMin" double precision,
    "xMax" double precision,
    ymin double precision,
    ymax double precision,
    zmin double precision,
    zmax double precision,
    factionid integer,
    radius double precision
);


--
-- Name: mapdenormalize; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE mapdenormalize (
    itemid integer NOT NULL,
    typeid integer,
    groupid integer,
    solarsystemid integer,
    constellationid integer,
    regionid integer,
    orbitid integer,
    x double precision,
    y double precision,
    z double precision,
    radius double precision,
    itemname character varying(100),
    security double precision,
    celestialindex integer,
    orbitindex integer
);


--
-- Name: mapjumps; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE mapjumps (
    stargateid integer NOT NULL,
    destinationid integer
);


--
-- Name: maplandmarks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE maplandmarks (
    landmarkid integer NOT NULL,
    landmarkname character varying(100),
    description text,
    locationid integer,
    x double precision,
    y double precision,
    z double precision,
    iconid integer
);


--
-- Name: maplocationscenes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE maplocationscenes (
    locationid integer NOT NULL,
    graphicid integer
);


--
-- Name: maplocationwormholeclasses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE maplocationwormholeclasses (
    locationid integer NOT NULL,
    wormholeclassid integer
);


--
-- Name: mapregionjumps; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE mapregionjumps (
    fromregionid integer NOT NULL,
    toregionid integer NOT NULL
);


--
-- Name: mapregions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE mapregions (
    regionid integer NOT NULL,
    regionname character varying(100),
    x double precision,
    y double precision,
    z double precision,
    "xMin" double precision,
    "xMax" double precision,
    ymin double precision,
    ymax double precision,
    zmin double precision,
    zmax double precision,
    factionid integer,
    radius double precision
);


--
-- Name: mapsolarsystemjumps; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE mapsolarsystemjumps (
    fromregionid integer,
    fromconstellationid integer,
    fromsolarsystemid integer NOT NULL,
    tosolarsystemid integer NOT NULL,
    toconstellationid integer,
    toregionid integer
);


--
-- Name: mapsolarsystems; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE mapsolarsystems (
    regionid integer,
    constellationid integer,
    solarsystemid integer NOT NULL,
    solarsystemname character varying(100),
    x double precision,
    y double precision,
    z double precision,
    "xMin" double precision,
    "xMax" double precision,
    ymin double precision,
    ymax double precision,
    zmin double precision,
    zmax double precision,
    luminosity double precision,
    border boolean,
    fringe boolean,
    corridor boolean,
    hub boolean,
    international boolean,
    regional boolean,
    constellation boolean,
    security double precision,
    factionid integer,
    radius double precision,
    suntypeid integer,
    securityclass character varying(2)
);


--
-- Name: mapuniverse; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE mapuniverse (
    universeid integer NOT NULL,
    universename character varying(100),
    x double precision,
    y double precision,
    z double precision,
    x_min double precision,
    x_max double precision,
    y_min double precision,
    y_max double precision,
    z_min double precision,
    z_max double precision,
    radius double precision
);


--
-- Name: planetschematics; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE planetschematics (
    schematicid integer NOT NULL,
    schematicname character varying(255),
    cycletime integer
);


--
-- Name: planetschematicspinmap; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE planetschematicspinmap (
    schematicid integer NOT NULL,
    pintypeid integer NOT NULL
);


--
-- Name: planetschematicstypemap; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE planetschematicstypemap (
    schematicid integer NOT NULL,
    typeid integer NOT NULL,
    quantity integer,
    isinput boolean
);


--
-- Name: ramactivities; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE ramactivities (
    activityid integer NOT NULL,
    activityname character varying(100),
    iconno character varying(5),
    description character varying(1000),
    published boolean
);


--
-- Name: ramassemblylinestations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE ramassemblylinestations (
    stationid integer NOT NULL,
    assemblylinetypeid integer NOT NULL,
    quantity integer,
    stationtypeid integer,
    ownerid integer,
    solarsystemid integer,
    regionid integer
);


--
-- Name: ramassemblylinetypedetailpercategory; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE ramassemblylinetypedetailpercategory (
    assemblylinetypeid integer NOT NULL,
    categoryid integer NOT NULL,
    timemultiplier double precision,
    materialmultiplier double precision,
    costmultiplier double precision
);


--
-- Name: ramassemblylinetypedetailpergroup; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE ramassemblylinetypedetailpergroup (
    assemblylinetypeid integer NOT NULL,
    groupid integer NOT NULL,
    timemultiplier double precision,
    materialmultiplier double precision,
    costmultiplier double precision
);


--
-- Name: ramassemblylinetypes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE ramassemblylinetypes (
    assemblylinetypeid integer NOT NULL,
    assemblylinetypename character varying(100),
    description character varying(1000),
    basetimemultiplier double precision,
    basematerialmultiplier double precision,
    basecostmultiplier double precision,
    volume double precision,
    activityid integer,
    mincostperhour double precision
);


--
-- Name: raminstallationtypecontents; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE raminstallationtypecontents (
    installationtypeid integer NOT NULL,
    assemblylinetypeid integer NOT NULL,
    quantity integer
);


--
-- Name: skinlicense; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE skinlicense (
    licensetypeid integer NOT NULL,
    duration integer,
    skinid integer
);


--
-- Name: skinmaterials; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE skinmaterials (
    skinmaterialid integer NOT NULL,
    displaynameid integer,
    materialsetid integer
);


--
-- Name: skins; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE skins (
    skinid integer NOT NULL,
    internalname character varying(70),
    skinmaterialid integer
);


--
-- Name: skinship; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE skinship (
    skinid integer,
    typeid integer
);


--
-- Name: staoperations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE staoperations (
    activityid integer,
    operationid integer NOT NULL,
    operationname character varying(100),
    description character varying(1000),
    fringe integer,
    corridor integer,
    hub integer,
    border integer,
    ratio integer,
    caldaristationtypeid integer,
    minmatarstationtypeid integer,
    amarrstationtypeid integer,
    gallentestationtypeid integer,
    jovestationtypeid integer
);


--
-- Name: staoperationservices; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE staoperationservices (
    operationid integer NOT NULL,
    serviceid integer NOT NULL
);


--
-- Name: staservices; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE staservices (
    serviceid integer NOT NULL,
    servicename character varying(100),
    description character varying(1000)
);


--
-- Name: stastations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE stastations (
    stationid bigint NOT NULL,
    -- this is a double precision in the yaml, see https://github.com/fuzzysteve/yamlloader/issues/13
    security integer,
    dockingcostpervolume double precision,
    maxshipvolumedockable double precision,
    officerentalcost integer,
    operationid integer,
    stationtypeid integer,
    corporationid integer,
    solarsystemid integer,
    constellationid integer,
    regionid integer,
    stationname character varying(100),
    x double precision,
    y double precision,
    z double precision,
    reprocessingefficiency double precision,
    reprocessingstationstake double precision,
    reprocessinghangarflag integer
);


--
-- Name: stastationtypes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE stastationtypes (
    stationtypeid integer NOT NULL,
    dockentryx double precision,
    dockentryy double precision,
    dockentryz double precision,
    dockorientationx double precision,
    dockorientationy double precision,
    dockorientationz double precision,
    operationid integer,
    officeslots integer,
    reprocessingefficiency double precision,
    conquerable boolean
);


--
-- Name: translationtables; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE translationtables (
    sourcetable character varying(200) NOT NULL,
    destinationtable character varying(200),
    translatedkey character varying(200) NOT NULL,
    tcgroupid integer,
    tcid integer
);


--
-- Name: trntranslationcolumns; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE trntranslationcolumns (
    tcgroupid integer,
    tcid integer NOT NULL,
    tablename character varying(256) NOT NULL,
    columnname character varying(128) NOT NULL,
    masterid character varying(128)
);


--
-- Name: trntranslationlanguages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE trntranslationlanguages (
    numericlanguageid integer NOT NULL,
    languageid character varying(50),
    languagename character varying(200)
);


--
-- Name: trntranslations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE trntranslations (
    tcid integer NOT NULL,
    keyid integer NOT NULL,
    languageid character varying(50) NOT NULL,
    text text NOT NULL
);


--
-- Name: warcombatzones; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE warcombatzones (
    combatzoneid integer NOT NULL,
    combatzonename character varying(100),
    factionid integer,
    centersystemid integer,
    description character varying(500)
);


--
-- Name: warcombatzonesystems; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE warcombatzonesystems (
    solarsystemid integer NOT NULL,
    combatzoneid integer
);


--
-- Name: invtraits traitid; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY invtraits ALTER COLUMN traitid SET DEFAULT nextval('invtraits_traitid_seq'::regclass);


--
-- Name: agtagents agtagents_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY agtagents
    ADD CONSTRAINT agtagents_pkey PRIMARY KEY (agentid);


--
-- Name: agtagenttypes agtagenttypes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY agtagenttypes
    ADD CONSTRAINT agtagenttypes_pkey PRIMARY KEY (agenttypeid);


--
-- Name: agtresearchagents agtresearchagents_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY agtresearchagents
    ADD CONSTRAINT agtresearchagents_pkey PRIMARY KEY (agentid, typeid);


--
-- Name: certcerts certcerts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY certcerts
    ADD CONSTRAINT certcerts_pkey PRIMARY KEY (certid);


--
-- Name: chrancestries chrancestries_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY chrancestries
    ADD CONSTRAINT chrancestries_pkey PRIMARY KEY (ancestryid);


--
-- Name: chrattributes chrattributes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY chrattributes
    ADD CONSTRAINT chrattributes_pkey PRIMARY KEY (attributeid);


--
-- Name: chrbloodlines chrbloodlines_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY chrbloodlines
    ADD CONSTRAINT chrbloodlines_pkey PRIMARY KEY (bloodlineid);


--
-- Name: chrfactions chrfactions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY chrfactions
    ADD CONSTRAINT chrfactions_pkey PRIMARY KEY (factionid);


--
-- Name: chrraces chrraces_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY chrraces
    ADD CONSTRAINT chrraces_pkey PRIMARY KEY (raceid);


--
-- Name: crpactivities crpactivities_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY crpactivities
    ADD CONSTRAINT crpactivities_pkey PRIMARY KEY (activityid);


--
-- Name: crpnpccorporationdivisions crpnpccorporationdivisions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY crpnpccorporationdivisions
    ADD CONSTRAINT crpnpccorporationdivisions_pkey PRIMARY KEY (corporationid, divisionid);


--
-- Name: crpnpccorporationresearchfields crpnpccorporationresearchfields_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY crpnpccorporationresearchfields
    ADD CONSTRAINT crpnpccorporationresearchfields_pkey PRIMARY KEY (skillid, corporationid);


--
-- Name: crpnpccorporations crpnpccorporations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY crpnpccorporations
    ADD CONSTRAINT crpnpccorporations_pkey PRIMARY KEY (corporationid);


--
-- Name: crpnpccorporationtrades crpnpccorporationtrades_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY crpnpccorporationtrades
    ADD CONSTRAINT crpnpccorporationtrades_pkey PRIMARY KEY (corporationid, typeid);


--
-- Name: crpnpcdivisions crpnpcdivisions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY crpnpcdivisions
    ADD CONSTRAINT crpnpcdivisions_pkey PRIMARY KEY (divisionid);


--
-- Name: dgmattributecategories dgmattributecategories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dgmattributecategories
    ADD CONSTRAINT dgmattributecategories_pkey PRIMARY KEY (categoryid);


--
-- Name: dgmattributetypes dgmattributetypes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dgmattributetypes
    ADD CONSTRAINT dgmattributetypes_pkey PRIMARY KEY (attributeid);


--
-- Name: dgmeffects dgmeffects_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dgmeffects
    ADD CONSTRAINT dgmeffects_pkey PRIMARY KEY (effectid);


--
-- Name: dgmexpressions dgmexpressions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dgmexpressions
    ADD CONSTRAINT dgmexpressions_pkey PRIMARY KEY (expressionid);


--
-- Name: dgmtypeattributes dgmtypeattributes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dgmtypeattributes
    ADD CONSTRAINT dgmtypeattributes_pkey PRIMARY KEY (typeid, attributeid);


--
-- Name: dgmtypeeffects dgmtypeeffects_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dgmtypeeffects
    ADD CONSTRAINT dgmtypeeffects_pkey PRIMARY KEY (typeid, effectid);


--
-- Name: evegraphics evegraphics_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY evegraphics
    ADD CONSTRAINT evegraphics_pkey PRIMARY KEY (graphicid);


--
-- Name: eveicons eveicons_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY eveicons
    ADD CONSTRAINT eveicons_pkey PRIMARY KEY (iconid);


--
-- Name: eveunits eveunits_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY eveunits
    ADD CONSTRAINT eveunits_pkey PRIMARY KEY (unitid);


--
-- Name: industryactivity industryactivity_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY industryactivity
    ADD CONSTRAINT industryactivity_pkey PRIMARY KEY (typeid, activityid);


--
-- Name: industryblueprints industryblueprints_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY industryblueprints
    ADD CONSTRAINT industryblueprints_pkey PRIMARY KEY (typeid);


--
-- Name: invcategories invcategories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY invcategories
    ADD CONSTRAINT invcategories_pkey PRIMARY KEY (categoryid);


--
-- Name: invcontrabandtypes invcontrabandtypes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY invcontrabandtypes
    ADD CONSTRAINT invcontrabandtypes_pkey PRIMARY KEY (factionid, typeid);


--
-- Name: invcontroltowerresourcepurposes invcontroltowerresourcepurposes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY invcontroltowerresourcepurposes
    ADD CONSTRAINT invcontroltowerresourcepurposes_pkey PRIMARY KEY (purpose);


--
-- Name: invcontroltowerresources invcontroltowerresources_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY invcontroltowerresources
    ADD CONSTRAINT invcontroltowerresources_pkey PRIMARY KEY (controltowertypeid, resourcetypeid);


--
-- Name: invflags invflags_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY invflags
    ADD CONSTRAINT invflags_pkey PRIMARY KEY (flagid);


--
-- Name: invgroups invgroups_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY invgroups
    ADD CONSTRAINT invgroups_pkey PRIMARY KEY (groupid);


--
-- Name: invitems invitems_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY invitems
    ADD CONSTRAINT invitems_pkey PRIMARY KEY (itemid);


--
-- Name: invmarketgroups invmarketgroups_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY invmarketgroups
    ADD CONSTRAINT invmarketgroups_pkey PRIMARY KEY (marketgroupid);


--
-- Name: invmetagroups invmetagroups_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY invmetagroups
    ADD CONSTRAINT invmetagroups_pkey PRIMARY KEY (metagroupid);


--
-- Name: invmetatypes invmetatypes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY invmetatypes
    ADD CONSTRAINT invmetatypes_pkey PRIMARY KEY (typeid);


--
-- Name: invnames invnames_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY invnames
    ADD CONSTRAINT invnames_pkey PRIMARY KEY (itemid);


--
-- Name: invpositions invpositions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY invpositions
    ADD CONSTRAINT invpositions_pkey PRIMARY KEY (itemid);


--
-- Name: invtraits invtraits_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY invtraits
    ADD CONSTRAINT invtraits_pkey PRIMARY KEY (traitid);


--
-- Name: invtypematerials invtypematerials_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY invtypematerials
    ADD CONSTRAINT invtypematerials_pkey PRIMARY KEY (typeid, materialtypeid);


--
-- Name: invtypereactions invtypereactions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY invtypereactions
    ADD CONSTRAINT invtypereactions_pkey PRIMARY KEY (reactiontypeid, input, typeid);


--
-- Name: invtypes invtypes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY invtypes
    ADD CONSTRAINT invtypes_pkey PRIMARY KEY (typeid);


--
-- Name: invuniquenames invuniquenames_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY invuniquenames
    ADD CONSTRAINT invuniquenames_pkey PRIMARY KEY (itemid);


--
-- Name: invvolumes invvolumes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY invvolumes
    ADD CONSTRAINT invvolumes_pkey PRIMARY KEY (typeid);


--
-- Name: mapcelestialstatistics mapcelestialstatistics_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY mapcelestialstatistics
    ADD CONSTRAINT mapcelestialstatistics_pkey PRIMARY KEY (celestialid);


--
-- Name: mapconstellationjumps mapconstellationjumps_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY mapconstellationjumps
    ADD CONSTRAINT mapconstellationjumps_pkey PRIMARY KEY (fromconstellationid, toconstellationid);


--
-- Name: mapconstellations mapconstellations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY mapconstellations
    ADD CONSTRAINT mapconstellations_pkey PRIMARY KEY (constellationid);


--
-- Name: mapdenormalize mapdenormalize_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY mapdenormalize
    ADD CONSTRAINT mapdenormalize_pkey PRIMARY KEY (itemid);


--
-- Name: mapjumps mapjumps_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY mapjumps
    ADD CONSTRAINT mapjumps_pkey PRIMARY KEY (stargateid);


--
-- Name: maplandmarks maplandmarks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY maplandmarks
    ADD CONSTRAINT maplandmarks_pkey PRIMARY KEY (landmarkid);


--
-- Name: maplocationscenes maplocationscenes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY maplocationscenes
    ADD CONSTRAINT maplocationscenes_pkey PRIMARY KEY (locationid);


--
-- Name: maplocationwormholeclasses maplocationwormholeclasses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY maplocationwormholeclasses
    ADD CONSTRAINT maplocationwormholeclasses_pkey PRIMARY KEY (locationid);


--
-- Name: mapregionjumps mapregionjumps_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY mapregionjumps
    ADD CONSTRAINT mapregionjumps_pkey PRIMARY KEY (fromregionid, toregionid);


--
-- Name: mapregions mapregions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY mapregions
    ADD CONSTRAINT mapregions_pkey PRIMARY KEY (regionid);


--
-- Name: mapsolarsystemjumps mapsolarsystemjumps_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY mapsolarsystemjumps
    ADD CONSTRAINT mapsolarsystemjumps_pkey PRIMARY KEY (fromsolarsystemid, tosolarsystemid);


--
-- Name: mapsolarsystems mapsolarsystems_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY mapsolarsystems
    ADD CONSTRAINT mapsolarsystems_pkey PRIMARY KEY (solarsystemid);


--
-- Name: mapuniverse mapuniverse_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY mapuniverse
    ADD CONSTRAINT mapuniverse_pkey PRIMARY KEY (universeid);


--
-- Name: planetschematics planetschematics_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY planetschematics
    ADD CONSTRAINT planetschematics_pkey PRIMARY KEY (schematicid);


--
-- Name: planetschematicspinmap planetschematicspinmap_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY planetschematicspinmap
    ADD CONSTRAINT planetschematicspinmap_pkey PRIMARY KEY (schematicid, pintypeid);


--
-- Name: planetschematicstypemap planetschematicstypemap_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY planetschematicstypemap
    ADD CONSTRAINT planetschematicstypemap_pkey PRIMARY KEY (schematicid, typeid);


--
-- Name: ramactivities ramactivities_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ramactivities
    ADD CONSTRAINT ramactivities_pkey PRIMARY KEY (activityid);


--
-- Name: ramassemblylinestations ramassemblylinestations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ramassemblylinestations
    ADD CONSTRAINT ramassemblylinestations_pkey PRIMARY KEY (stationid, assemblylinetypeid);


--
-- Name: ramassemblylinetypedetailpercategory ramassemblylinetypedetailpercategory_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ramassemblylinetypedetailpercategory
    ADD CONSTRAINT ramassemblylinetypedetailpercategory_pkey PRIMARY KEY (assemblylinetypeid, categoryid);


--
-- Name: ramassemblylinetypedetailpergroup ramassemblylinetypedetailpergroup_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ramassemblylinetypedetailpergroup
    ADD CONSTRAINT ramassemblylinetypedetailpergroup_pkey PRIMARY KEY (assemblylinetypeid, groupid);


--
-- Name: ramassemblylinetypes ramassemblylinetypes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ramassemblylinetypes
    ADD CONSTRAINT ramassemblylinetypes_pkey PRIMARY KEY (assemblylinetypeid);


--
-- Name: raminstallationtypecontents raminstallationtypecontents_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY raminstallationtypecontents
    ADD CONSTRAINT raminstallationtypecontents_pkey PRIMARY KEY (installationtypeid, assemblylinetypeid);


--
-- Name: skinlicense skinlicense_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY skinlicense
    ADD CONSTRAINT skinlicense_pkey PRIMARY KEY (licensetypeid);


--
-- Name: skinmaterials skinmaterials_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY skinmaterials
    ADD CONSTRAINT skinmaterials_pkey PRIMARY KEY (skinmaterialid);


--
-- Name: skins skins_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY skins
    ADD CONSTRAINT skins_pkey PRIMARY KEY (skinid);


--
-- Name: staoperations staoperations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY staoperations
    ADD CONSTRAINT staoperations_pkey PRIMARY KEY (operationid);


--
-- Name: staoperationservices staoperationservices_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY staoperationservices
    ADD CONSTRAINT staoperationservices_pkey PRIMARY KEY (operationid, serviceid);


--
-- Name: staservices staservices_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY staservices
    ADD CONSTRAINT staservices_pkey PRIMARY KEY (serviceid);


--
-- Name: stastations stastations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY stastations
    ADD CONSTRAINT stastations_pkey PRIMARY KEY (stationid);


--
-- Name: stastationtypes stastationtypes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY stastationtypes
    ADD CONSTRAINT stastationtypes_pkey PRIMARY KEY (stationtypeid);


--
-- Name: translationtables translationtables_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY translationtables
    ADD CONSTRAINT translationtables_pkey PRIMARY KEY (sourcetable, translatedkey);


--
-- Name: trntranslationcolumns trntranslationcolumns_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY trntranslationcolumns
    ADD CONSTRAINT trntranslationcolumns_pkey PRIMARY KEY (tcid);


--
-- Name: trntranslationlanguages trntranslationlanguages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY trntranslationlanguages
    ADD CONSTRAINT trntranslationlanguages_pkey PRIMARY KEY (numericlanguageid);


--
-- Name: trntranslations trntranslations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY trntranslations
    ADD CONSTRAINT trntranslations_pkey PRIMARY KEY (tcid, keyid, languageid);


--
-- Name: warcombatzones warcombatzones_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY warcombatzones
    ADD CONSTRAINT warcombatzones_pkey PRIMARY KEY (combatzoneid);


--
-- Name: warcombatzonesystems warcombatzonesystems_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY warcombatzonesystems
    ADD CONSTRAINT warcombatzonesystems_pkey PRIMARY KEY (solarsystemid);


--
-- Name: industryActivityMaterials_idx1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "industryActivityMaterials_idx1" ON industryactivitymaterials USING btree (typeid, activityid);


--
-- Name: industryActivitySkills_idx1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "industryActivitySkills_idx1" ON industryactivityskills USING btree (typeid, activityid);


--
-- Name: invUniqueNames_IX_GroupName; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "invUniqueNames_IX_GroupName" ON invuniquenames USING btree (groupid, itemname);


--
-- Name: items_IX_OwnerLocation; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "items_IX_OwnerLocation" ON invitems USING btree (ownerid, locationid);


--
-- Name: ix_agtAgents_corporationID; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "ix_agtAgents_corporationID" ON agtagents USING btree (corporationid);


--
-- Name: ix_agtAgents_locationID; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "ix_agtAgents_locationID" ON agtagents USING btree (locationid);


--
-- Name: ix_agtResearchAgents_typeID; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "ix_agtResearchAgents_typeID" ON agtresearchagents USING btree (typeid);


--
-- Name: ix_certSkills_skillID; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "ix_certSkills_skillID" ON certskills USING btree (skillid);


--
-- Name: ix_dgmTypeAttributes_attributeID; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "ix_dgmTypeAttributes_attributeID" ON dgmtypeattributes USING btree (attributeid);


--
-- Name: ix_industryActivityMaterials_typeID; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "ix_industryActivityMaterials_typeID" ON industryactivitymaterials USING btree (typeid);


--
-- Name: ix_industryActivityProbabilities_productTypeID; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "ix_industryActivityProbabilities_productTypeID" ON industryactivityprobabilities USING btree (producttypeid);


--
-- Name: ix_industryActivityProbabilities_typeID; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "ix_industryActivityProbabilities_typeID" ON industryactivityprobabilities USING btree (typeid);


--
-- Name: ix_industryActivityProducts_productTypeID; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "ix_industryActivityProducts_productTypeID" ON industryactivityproducts USING btree (producttypeid);


--
-- Name: ix_industryActivityProducts_typeID; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "ix_industryActivityProducts_typeID" ON industryactivityproducts USING btree (typeid);


--
-- Name: ix_industryActivityRaces_productTypeID; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "ix_industryActivityRaces_productTypeID" ON industryactivityraces USING btree (producttypeid);


--
-- Name: ix_industryActivityRaces_typeID; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "ix_industryActivityRaces_typeID" ON industryactivityraces USING btree (typeid);


--
-- Name: ix_industryActivitySkills_skillID; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "ix_industryActivitySkills_skillID" ON industryactivityskills USING btree (skillid);


--
-- Name: ix_industryActivitySkills_typeID; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "ix_industryActivitySkills_typeID" ON industryactivityskills USING btree (typeid);


--
-- Name: ix_industryActivity_activityID; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "ix_industryActivity_activityID" ON industryactivity USING btree (activityid);


--
-- Name: ix_invContrabandTypes_typeID; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "ix_invContrabandTypes_typeID" ON invcontrabandtypes USING btree (typeid);


--
-- Name: ix_invGroups_categoryID; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "ix_invGroups_categoryID" ON invgroups USING btree (categoryid);


--
-- Name: ix_invItems_locationID; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "ix_invItems_locationID" ON invitems USING btree (locationid);


--
-- Name: ix_invTypes_groupID; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "ix_invTypes_groupID" ON invtypes USING btree (groupid);


--
-- Name: ix_invUniqueNames_itemName; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "ix_invUniqueNames_itemName" ON invuniquenames USING btree (itemname);


--
-- Name: ix_mapDenormalize_constellationID; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "ix_mapDenormalize_constellationID" ON mapdenormalize USING btree (constellationid);


--
-- Name: ix_mapDenormalize_orbitID; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "ix_mapDenormalize_orbitID" ON mapdenormalize USING btree (orbitid);


--
-- Name: ix_mapDenormalize_regionID; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "ix_mapDenormalize_regionID" ON mapdenormalize USING btree (regionid);


--
-- Name: ix_mapDenormalize_solarSystemID; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "ix_mapDenormalize_solarSystemID" ON mapdenormalize USING btree (solarsystemid);


--
-- Name: ix_mapDenormalize_typeID; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "ix_mapDenormalize_typeID" ON mapdenormalize USING btree (typeid);


--
-- Name: ix_mapSolarSystems_constellationID; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "ix_mapSolarSystems_constellationID" ON mapsolarsystems USING btree (constellationid);


--
-- Name: ix_mapSolarSystems_regionID; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "ix_mapSolarSystems_regionID" ON mapsolarsystems USING btree (regionid);


--
-- Name: ix_mapSolarSystems_security; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "ix_mapSolarSystems_security" ON mapsolarsystems USING btree (security);


--
-- Name: ix_ramAssemblyLineStations_ownerID; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "ix_ramAssemblyLineStations_ownerID" ON ramassemblylinestations USING btree (ownerid);


--
-- Name: ix_ramAssemblyLineStations_regionID; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "ix_ramAssemblyLineStations_regionID" ON ramassemblylinestations USING btree (regionid);


--
-- Name: ix_ramAssemblyLineStations_solarSystemID; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "ix_ramAssemblyLineStations_solarSystemID" ON ramassemblylinestations USING btree (solarsystemid);


--
-- Name: ix_skinShip_skinID; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "ix_skinShip_skinID" ON skinship USING btree (skinid);


--
-- Name: ix_skinShip_typeID; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "ix_skinShip_typeID" ON skinship USING btree (typeid);


--
-- Name: ix_staStations_constellationID; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "ix_staStations_constellationID" ON stastations USING btree (constellationid);


--
-- Name: ix_staStations_corporationID; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "ix_staStations_corporationID" ON stastations USING btree (corporationid);


--
-- Name: ix_staStations_operationID; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "ix_staStations_operationID" ON stastations USING btree (operationid);


--
-- Name: ix_staStations_regionID; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "ix_staStations_regionID" ON stastations USING btree (regionid);


--
-- Name: ix_staStations_solarSystemID; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "ix_staStations_solarSystemID" ON stastations USING btree (solarsystemid);


--
-- Name: ix_staStations_stationTypeID; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "ix_staStations_stationTypeID" ON stastations USING btree (stationtypeid);


--
-- Name: mapDenormalize_IX_groupConstellation; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "mapDenormalize_IX_groupConstellation" ON mapdenormalize USING btree (groupid, constellationid);


--
-- Name: mapDenormalize_IX_groupRegion; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "mapDenormalize_IX_groupRegion" ON mapdenormalize USING btree (groupid, regionid);


--
-- Name: mapDenormalize_IX_groupSystem; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "mapDenormalize_IX_groupSystem" ON mapdenormalize USING btree (groupid, solarsystemid);

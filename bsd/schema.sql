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

DROP INDEX public."ix_staStations_stationTypeID";
DROP INDEX public."ix_staStations_solarSystemID";
DROP INDEX public."ix_staStations_regionID";
DROP INDEX public."ix_staStations_operationID";
DROP INDEX public."ix_staStations_corporationID";
DROP INDEX public."ix_staStations_constellationID";
DROP INDEX public."ix_ramAssemblyLineStations_solarSystemID";
DROP INDEX public."ix_ramAssemblyLineStations_regionID";
DROP INDEX public."ix_ramAssemblyLineStations_ownerID";
DROP INDEX public."ix_invUniqueNames_itemName";
DROP INDEX public."ix_invItems_locationID";
DROP INDEX public."ix_invContrabandTypes_typeID";
DROP INDEX public."ix_dgmTypeAttributes_attributeID";
DROP INDEX public."ix_agtResearchAgents_typeID";
DROP INDEX public."ix_agtAgents_locationID";
DROP INDEX public."ix_agtAgents_corporationID";
DROP INDEX public."items_IX_OwnerLocation";
DROP INDEX public."invUniqueNames_IX_GroupName";
ALTER TABLE ONLY public.warcombatzonesystems DROP CONSTRAINT warcombatzonesystems_pkey;
ALTER TABLE ONLY public.warcombatzones DROP CONSTRAINT warcombatzones_pkey;
ALTER TABLE ONLY public.trntranslations DROP CONSTRAINT trntranslations_pkey;
ALTER TABLE ONLY public.trntranslationlanguages DROP CONSTRAINT trntranslationlanguages_pkey;
ALTER TABLE ONLY public.trntranslationcolumns DROP CONSTRAINT trntranslationcolumns_pkey;
ALTER TABLE ONLY public.stastationtypes DROP CONSTRAINT stastationtypes_pkey;
ALTER TABLE ONLY public.stastations DROP CONSTRAINT stastations_pkey;
ALTER TABLE ONLY public.staservices DROP CONSTRAINT staservices_pkey;
ALTER TABLE ONLY public.staoperationservices DROP CONSTRAINT staoperationservices_pkey;
ALTER TABLE ONLY public.staoperations DROP CONSTRAINT staoperations_pkey;
ALTER TABLE ONLY public.raminstallationtypecontents DROP CONSTRAINT raminstallationtypecontents_pkey;
ALTER TABLE ONLY public.ramassemblylinetypes DROP CONSTRAINT ramassemblylinetypes_pkey;
ALTER TABLE ONLY public.ramassemblylinetypedetailpergroup DROP CONSTRAINT ramassemblylinetypedetailpergroup_pkey;
ALTER TABLE ONLY public.ramassemblylinetypedetailpercategory DROP CONSTRAINT ramassemblylinetypedetailpercategory_pkey;
ALTER TABLE ONLY public.ramassemblylinestations DROP CONSTRAINT ramassemblylinestations_pkey;
ALTER TABLE ONLY public.ramactivities DROP CONSTRAINT ramactivities_pkey;
ALTER TABLE ONLY public.planetschematicstypemap DROP CONSTRAINT planetschematicstypemap_pkey;
ALTER TABLE ONLY public.planetschematicspinmap DROP CONSTRAINT planetschematicspinmap_pkey;
ALTER TABLE ONLY public.planetschematics DROP CONSTRAINT planetschematics_pkey;
ALTER TABLE ONLY public.mapuniverse DROP CONSTRAINT mapuniverse_pkey;
ALTER TABLE ONLY public.invuniquenames DROP CONSTRAINT invuniquenames_pkey;
ALTER TABLE ONLY public.invtypereactions DROP CONSTRAINT invtypereactions_pkey;
ALTER TABLE ONLY public.invtypematerials DROP CONSTRAINT invtypematerials_pkey;
ALTER TABLE ONLY public.invpositions DROP CONSTRAINT invpositions_pkey;
ALTER TABLE ONLY public.invnames DROP CONSTRAINT invnames_pkey;
ALTER TABLE ONLY public.invmetatypes DROP CONSTRAINT invmetatypes_pkey;
ALTER TABLE ONLY public.invmetagroups DROP CONSTRAINT invmetagroups_pkey;
ALTER TABLE ONLY public.invmarketgroups DROP CONSTRAINT invmarketgroups_pkey;
ALTER TABLE ONLY public.invitems DROP CONSTRAINT invitems_pkey;
ALTER TABLE ONLY public.invflags DROP CONSTRAINT invflags_pkey;
ALTER TABLE ONLY public.invcontroltowerresources DROP CONSTRAINT invcontroltowerresources_pkey;
ALTER TABLE ONLY public.invcontroltowerresourcepurposes DROP CONSTRAINT invcontroltowerresourcepurposes_pkey;
ALTER TABLE ONLY public.invcontrabandtypes DROP CONSTRAINT invcontrabandtypes_pkey;
ALTER TABLE ONLY public.eveunits DROP CONSTRAINT eveunits_pkey;
ALTER TABLE ONLY public.dgmtypeeffects DROP CONSTRAINT dgmtypeeffects_pkey;
ALTER TABLE ONLY public.dgmtypeattributes DROP CONSTRAINT dgmtypeattributes_pkey;
ALTER TABLE ONLY public.dgmexpressions DROP CONSTRAINT dgmexpressions_pkey;
ALTER TABLE ONLY public.dgmeffects DROP CONSTRAINT dgmeffects_pkey;
ALTER TABLE ONLY public.dgmattributetypes DROP CONSTRAINT dgmattributetypes_pkey;
ALTER TABLE ONLY public.dgmattributecategories DROP CONSTRAINT dgmattributecategories_pkey;
ALTER TABLE ONLY public.crpnpcdivisions DROP CONSTRAINT crpnpcdivisions_pkey;
ALTER TABLE ONLY public.crpnpccorporationtrades DROP CONSTRAINT crpnpccorporationtrades_pkey;
ALTER TABLE ONLY public.crpnpccorporations DROP CONSTRAINT crpnpccorporations_pkey;
ALTER TABLE ONLY public.crpnpccorporationresearchfields DROP CONSTRAINT crpnpccorporationresearchfields_pkey;
ALTER TABLE ONLY public.crpnpccorporationdivisions DROP CONSTRAINT crpnpccorporationdivisions_pkey;
ALTER TABLE ONLY public.crpactivities DROP CONSTRAINT crpactivities_pkey;
ALTER TABLE ONLY public.chrraces DROP CONSTRAINT chrraces_pkey;
ALTER TABLE ONLY public.chrfactions DROP CONSTRAINT chrfactions_pkey;
ALTER TABLE ONLY public.chrbloodlines DROP CONSTRAINT chrbloodlines_pkey;
ALTER TABLE ONLY public.chrattributes DROP CONSTRAINT chrattributes_pkey;
ALTER TABLE ONLY public.chrancestries DROP CONSTRAINT chrancestries_pkey;
ALTER TABLE ONLY public.agtresearchagents DROP CONSTRAINT agtresearchagents_pkey;
ALTER TABLE ONLY public.agtagenttypes DROP CONSTRAINT agtagenttypes_pkey;
ALTER TABLE ONLY public.agtagents DROP CONSTRAINT agtagents_pkey;
DROP TABLE public.warcombatzonesystems;
DROP TABLE public.warcombatzones;
DROP TABLE public.trntranslations;
DROP TABLE public.trntranslationlanguages;
DROP TABLE public.trntranslationcolumns;
DROP TABLE public.stastationtypes;
DROP TABLE public.stastations;
DROP TABLE public.staservices;
DROP TABLE public.staoperationservices;
DROP TABLE public.staoperations;
DROP TABLE public.raminstallationtypecontents;
DROP TABLE public.ramassemblylinetypes;
DROP TABLE public.ramassemblylinetypedetailpergroup;
DROP TABLE public.ramassemblylinetypedetailpercategory;
DROP TABLE public.ramassemblylinestations;
DROP TABLE public.ramactivities;
DROP TABLE public.planetschematicstypemap;
DROP TABLE public.planetschematicspinmap;
DROP TABLE public.planetschematics;
DROP TABLE public.mapuniverse;
DROP TABLE public.invuniquenames;
DROP TABLE public.invtypereactions;
DROP TABLE public.invtypematerials;
DROP TABLE public.invpositions;
DROP TABLE public.invnames;
DROP TABLE public.invmetatypes;
DROP TABLE public.invmetagroups;
DROP TABLE public.invmarketgroups;
DROP TABLE public.invitems;
DROP TABLE public.invflags;
DROP TABLE public.invcontroltowerresources;
DROP TABLE public.invcontroltowerresourcepurposes;
DROP TABLE public.invcontrabandtypes;
DROP TABLE public.eveunits;
DROP TABLE public.dgmtypeeffects;
DROP TABLE public.dgmtypeattributes;
DROP TABLE public.dgmexpressions;
DROP TABLE public.dgmeffects;
DROP TABLE public.dgmattributetypes;
DROP TABLE public.dgmattributecategories;
DROP TABLE public.crpnpcdivisions;
DROP TABLE public.crpnpccorporationtrades;
DROP TABLE public.crpnpccorporations;
DROP TABLE public.crpnpccorporationresearchfields;
DROP TABLE public.crpnpccorporationdivisions;
DROP TABLE public.crpactivities;
DROP TABLE public.chrraces;
DROP TABLE public.chrfactions;
DROP TABLE public.chrbloodlines;
DROP TABLE public.chrattributes;
DROP TABLE public.chrancestries;
DROP TABLE public.agtresearchagents;
DROP TABLE public.agtagenttypes;
DROP TABLE public.agtagents;
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
-- Name: eveunits; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE eveunits (
    unitid integer NOT NULL,
    unitname character varying(100),
    displayname character varying(50),
    description character varying(1000)
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
-- Name: invuniquenames; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE invuniquenames (
    itemid integer NOT NULL,
    itemname character varying(200) NOT NULL,
    groupid integer
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
    security double precision,
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
-- Name: eveunits eveunits_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY eveunits
    ADD CONSTRAINT eveunits_pkey PRIMARY KEY (unitid);


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
-- Name: invuniquenames invuniquenames_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY invuniquenames
    ADD CONSTRAINT invuniquenames_pkey PRIMARY KEY (itemid);


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
-- Name: ix_dgmTypeAttributes_attributeID; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "ix_dgmTypeAttributes_attributeID" ON dgmtypeattributes USING btree (attributeid);


--
-- Name: ix_invContrabandTypes_typeID; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "ix_invContrabandTypes_typeID" ON invcontrabandtypes USING btree (typeid);


--
-- Name: ix_invItems_locationID; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "ix_invItems_locationID" ON invitems USING btree (locationid);


--
-- Name: ix_invUniqueNames_itemName; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "ix_invUniqueNames_itemName" ON invuniquenames USING btree (itemname);


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
-- PostgreSQL database dump complete
--


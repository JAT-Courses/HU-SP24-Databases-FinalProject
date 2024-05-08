/*
 * Script for database setup with dataset.
*/

use ca_data_development;

/*================= Create Parent Tables =================*/

create table location(
  locationId smallint unsigned auto_increment not null,
  state varchar(100) not null,
  county varchar(100),
  city varchar(100),
  majorRegion varchar(100),
  minorRegion varchar(100),
  primary key (locationId)
);

create table groundWaterQualityCodes(
                                        codeId smallint unsigned auto_increment not null,
                                        description longtext,
                                        primary key (codeId)
);

create table landslideImpactTypes(
                                        typeId smallint unsigned auto_increment not null,
                                        abbreviation varchar(5),
                                        name varchar(50),
                                        primary key (typeId)
);

/*================= Create child tables. =================*/

create table earthquakes(
    earthquakeId smallint unsigned auto_increment not null,
    year smallint,
    month smallint,
    day smallint,
    hour smallint,
    minute smallint,
    second decimal(4,2),
    latitude varchar(50),
    longitude varchar(50),
    depth decimal(6,3),
    magnitude decimal(6,3),
    locationId smallint unsigned,
    earthquakeDateFormatted date,
  	primary key (earthquakeId),
  	CONSTRAINT FK_locationId_EQ foreign key (locationId) references location(locationId) ON DELETE CASCADE
);

create table groundWaterStations(
    stationId varchar(100) not null,
    siteCode varchar(100),
    stationName longtext,
    wellName varchar(100),
    latitude varchar(50),
    longitude varchar(50),
    lldatum varchar(100),
    posacc varchar(100),
    elevation varchar(100),
    elevdatum varchar(100),
    elevacc varchar(100),
    basinCode varchar(100),
    basinName varchar(100),
    wellDepth varchar(100),
    wellUse varchar(100),
    wellType varchar(100),
    wcr_no varchar(100),
    wdl longtext,
    comment longtext,
    locationId smallint unsigned,
    primary key (stationId),
    CONSTRAINT FK_locationId_GWS foreign key (locationId) references location(locationId) ON DELETE CASCADE
);

create table groundWaterMeasurements(
                                        measurementId smallint unsigned auto_increment not null,
                                        stationId varchar(100),
                                        measurementDate date,
                                        WLM_RPE decimal(6,3),
                                        WLM_RPE_QC smallint unsigned,
                                        WLM_GSE decimal(6,3),
                                        WLM_GSE_QC smallint unsigned,
                                        RPE_WSE decimal(6,3),
                                        RPE_WSE_QC smallint unsigned,
                                        GSE_WSE decimal(6,3),
                                        GSE_WSE_QC smallint unsigned,
                                        WSE decimal(6,3),
                                        WSE_QC smallint unsigned,
                                        primary key (measurementId),
                                        CONSTRAINT FK_stationId_GWM foreign key (stationId) references groundWaterStations(stationId) ON DELETE CASCADE,
                                        CONSTRAINT FK_WLM_RPE_QC_GWM foreign key (WLM_RPE_QC) references groundWaterQualityCodes(codeId) ON DELETE CASCADE,
                                        CONSTRAINT FK_WLM_GSE_QC_GWM foreign key (WLM_GSE_QC) references groundWaterQualityCodes(codeId) ON DELETE CASCADE,
                                        CONSTRAINT FK_RPE_WSE_QC_GWM foreign key (RPE_WSE_QC) references groundWaterQualityCodes(codeId) ON DELETE CASCADE,
                                        CONSTRAINT FK_GSE_WSE_QC_GWM foreign key (GSE_WSE_QC) references groundWaterQualityCodes(codeId) ON DELETE CASCADE,
                                        CONSTRAINT FK_WSE_QC_GWM foreign key (WSE_QC) references groundWaterQualityCodes(codeId) ON DELETE CASCADE
);

create table landslides(
                            landslideId smallint unsigned auto_increment not null,
                            landslideDate date,
                            latitude varchar(50),
                            longitude varchar(50),
                            locationId smallint unsigned,
                            impactTypeAbbreviation smallint unsigned,
                            nearestPlace longtext,
                            infoSource longtext,
                            primary key (landslideId),
                            CONSTRAINT FK_locationId_LS foreign key (locationId) references location(locationId) ON DELETE CASCADE,
                            CONSTRAINT FK_impactTypeAbbreviation_LS foreign key (impactTypeAbbreviation) references landslideImpactTypes(abbreviation) ON DELETE CASCADE
);


load data local infile 'clean/location/location.csv'
    into table location
        FIELDS TERMINATED BY ','
        IGNORE 1 LINES;

load data local infile 'clean/earthquakes/earthquakesOut.csv'
    into table earthquakes
        FIELDS TERMINATED BY ','
        IGNORE 1 LINES;

load data local infile 'clean/groundWaterLevels/gwlStationsOut.csv'
    into table groundWaterStations
    FIELDS TERMINATED BY ',' ENCLOSED BY '"'
    IGNORE 1 LINES;

load data local infile 'clean/groundWaterLevels/gwl-quality_codes.csv'
    into table groundWaterQualityCodes
    FIELDS TERMINATED BY ','
    IGNORE 1 LINES;

load data local infile 'clean/groundWaterLevels/gwl-daily-small.csv'
    into table groundWaterMeasurements
    FIELDS TERMINATED BY ','
    IGNORE 1 LINES
    (stationId, measurementDate, WLM_RPE, WLM_RPE_QC, WLM_GSE, WLM_GSE_QC, RPE_WSE, RPE_WSE_QC, GSE_WSE, GSE_WSE_QC, WSE, WSE_QC)
    SET measurementId = NULL;

load data local infile 'clean/landslides/impactTypes.csv'
    into table landslideImpactTypes
    FIELDS TERMINATED BY ','
    IGNORE 1 LINES;

load data local infile 'clean/landslides/landslidesOut.csv'
    into table landslides
    FIELDS TERMINATED BY ',' ENCLOSED BY '"'
    IGNORE 1 LINES;

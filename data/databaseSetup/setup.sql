/*
 * Script for database setup with dataset.
*/

use ca_data_development;

/*================= Create Parent Tables =================*/

create table location(
  locationId bigint unsigned auto_increment not null,
  state varchar(100) not null,
  county varchar(100),
  city varchar(100),
  majorRegion varchar(100),
  minorRegion varchar(100),
  primary key (locationId)
);

create table groundWaterQualityCodes(
                                        codeId bigint unsigned auto_increment not null,
                                        description longtext,
                                        primary key (codeId)
);

create table landslideImpactTypes(
                                        typeId bigint unsigned auto_increment not null,
                                        abbreviation varchar(5),
                                        name varchar(50),
                                        primary key (typeId),
                                        key (abbreviation)
);

/*================= Create child tables. =================*/

create table earthquakes(
    earthquakeId bigint unsigned auto_increment not null,
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
    locationId bigint unsigned,
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
    locationId bigint unsigned,
    primary key (stationId),
    CONSTRAINT FK_locationId_GWS foreign key (locationId) references location(locationId) ON DELETE CASCADE
);

create table groundWaterMeasurements(
                                        groundWaterMeasurementId bigint unsigned auto_increment not null,
                                        stationId varchar(100),
                                        measurementDate date,
                                        WLM_RPE decimal(6,3),
                                        WLM_RPE_QC bigint unsigned,
                                        WLM_GSE decimal(6,3),
                                        WLM_GSE_QC bigint unsigned,
                                        RPE_WSE decimal(6,3),
                                        RPE_WSE_QC bigint unsigned,
                                        GSE_WSE decimal(6,3),
                                        GSE_WSE_QC bigint unsigned,
                                        WSE decimal(6,3),
                                        WSE_QC bigint unsigned,
                                        primary key (groundWaterMeasurementId),
                                        CONSTRAINT FK_stationId_GWM foreign key (stationId) references groundWaterStations(stationId) ON DELETE CASCADE,
                                        CONSTRAINT FK_WLM_RPE_QC_GWM foreign key (WLM_RPE_QC) references groundWaterQualityCodes(codeId) ON DELETE CASCADE,
                                        CONSTRAINT FK_WLM_GSE_QC_GWM foreign key (WLM_GSE_QC) references groundWaterQualityCodes(codeId) ON DELETE CASCADE,
                                        CONSTRAINT FK_RPE_WSE_QC_GWM foreign key (RPE_WSE_QC) references groundWaterQualityCodes(codeId) ON DELETE CASCADE,
                                        CONSTRAINT FK_GSE_WSE_QC_GWM foreign key (GSE_WSE_QC) references groundWaterQualityCodes(codeId) ON DELETE CASCADE,
                                        CONSTRAINT FK_WSE_QC_GWM foreign key (WSE_QC) references groundWaterQualityCodes(codeId) ON DELETE CASCADE
);

create table landslides(
                            landslideId bigint unsigned auto_increment not null,
                            landslideDate varchar(20),
                            latitude varchar(50),
                            longitude varchar(50),
                            locationId bigint unsigned,
                            impactTypeAbbreviation varchar(5),
                            nearestPlace longtext,
                            infoSource longtext,
                            primary key (landslideId),
                            CONSTRAINT FK_locationId_LS foreign key (locationId) references location(locationId) ON DELETE CASCADE,
                            CONSTRAINT FK_impactTypeAbbreviation_LS foreign key (impactTypeAbbreviation) references landslideImpactTypes(abbreviation) ON DELETE CASCADE
);

create table snowpackSensors(
                           snowpackSensorId bigint unsigned auto_increment not null,
                           stationCode varchar(3),
                           longitude varchar(50),
                           latitude varchar(50),
                           locationId bigint unsigned,
                           primary key (snowpackSensorId),
                           key (stationCode),
                           CONSTRAINT FK_locationId_SPS foreign key (locationId) references location(locationId) ON DELETE CASCADE
);

create table snowpackMeasurements(
                                snowpackMeasurementId bigint unsigned auto_increment not null,
                                stationCode varchar(3),
                                duration varchar(5),
                                sensorNumber smallint,
                                sensorType varchar(20),
                                measurementDate datetime,
                                observedDate datetime,
                                value varchar(10),
                                dataFlag varchar(5),
                                units varchar(20),
                                primary key (snowpackMeasurementId),
                                CONSTRAINT FK_stationCode_SPM foreign key (stationCode) references snowpackSensors(stationCode) ON DELETE CASCADE
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
    SET groundWaterMeasurementId = NULL;

load data local infile 'clean/landslides/impactTypes.csv'
    into table landslideImpactTypes
    FIELDS TERMINATED BY ','
    IGNORE 1 LINES;

load data local infile 'clean/landslides/landslidesOut.csv'
    into table landslides
    FIELDS TERMINATED BY ',' ENCLOSED BY '"'
    IGNORE 1 LINES;

load data local infile 'clean/snowpack/snowpackSensors.csv'
    into table snowpackSensors
    FIELDS TERMINATED BY ','
    IGNORE 1 LINES;

load data local infile 'clean/snowpack/combinedSWC.csv'
    into table snowpackMeasurements
    FIELDS TERMINATED BY ','
    IGNORE 1 LINES
    (stationCode, duration, sensorNumber, sensorType, measurementDate, observedDate, value, dataFlag, units)
    SET snowpackMeasurementId = NULL;

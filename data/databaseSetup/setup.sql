/*
 * Script for database setup with dataset.
*/

use ca_data_development;

/*================= Create Parent Tables =================*/

create table location(
  locationId smallint unsigned auto_increment primary key not null,
  state varchar(100) not null,
  county varchar(100),
  city varchar(100),
  majorRegion varchar(100),
  minorRegion varchar(100)
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
  	primary key (earthquakeId),
  	CONSTRAINT FK_locationId_EQ foreign key (locationId) references location(locationId)
);

create table groundWaterStations(
    station varchar(100) not null,
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
    primary key (station),
    CONSTRAINT FK_locationId_GWS foreign key (locationId) references location(locationId)
);

create table groundWaterQualityCodes(
                                        codeId smallint unsigned auto_increment not null,
                                        description longtext,
                                        primary key (codeId)
);

create table groundWaterMeasurements(
                                        measurementId smallint unsigned auto_increment not null,
                                        station varchar(100),
                                        measurementDate varchar(100),
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
                                        CONSTRAINT FK_station_GWM foreign key (station) references groundWaterStations(station)
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
    FIELDS TERMINATED BY ','
    IGNORE 1 LINES;

load data local infile 'clean/groundWaterLevels/gwl-quality_codes.csv'
    into table groundWaterQualityCodes
    FIELDS TERMINATED BY ','
    IGNORE 1 LINES;

load data local infile 'clean/groundWaterLevels/gwl-daily-small.csv'
    into table groundWaterMeasurements
    FIELDS TERMINATED BY ','
    IGNORE 1 LINES
    SET measurementId = NULL;

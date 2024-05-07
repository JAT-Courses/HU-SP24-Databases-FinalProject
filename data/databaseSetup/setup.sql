/* Script for database setup with dataset.
 *
*/

use ca_data_development;


/*================= Create Parent Tables =================*/

create table if not exists location(
  locationId smallint unsigned auto_increment primary key not null,
  state varchar(100) not null,
  county varchar(100),
  city varchar(100),
  majorRegion varchar(100),
  minorRegion varchar(100)
);


create table if not exists earthquakes(
    earthquakeId smallint unsigned auto_increment primary key not null,
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
    locationId smallint
    CONSTRAINT FK_locationId FOREIGN KEY (locationId) references location(locationId)
                ON DELETE CASCADE
                ON UPDATE RESTRICT
);

load data local infile 'clean/earthquakes/earthquakesOut.csv'
    into table earthquakes
        FIELDS TERMINATED BY ','
        IGNORE 1 LINES;

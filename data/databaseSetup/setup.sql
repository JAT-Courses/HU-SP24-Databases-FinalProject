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
  majorregion varchar(100),
  minorregion varchar(100)
);


create table if not exists earthquakes(
    earthquakeId smallint unsigned auto_increment primary key not null,
    earthquakeDate smallint,
    magnitude decimal(6,3),
    locationId smallint
);

load data local infile 'clean/earthquakes/earthquakesOut.csv'
    into table earthquakes
        FIELDS TERMINATED BY ','
        IGNORE 1 LINES
    (earthquakeId)
    set earthquakeDate = @year




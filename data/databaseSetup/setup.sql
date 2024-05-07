/* Script for database setup with dataset.
 *
*/


/*================= Create Parent Tables =================*/

create table location(
  locationId smallint unsigned auto_increment primary key not null,
  state varchar(100) not null,
  county varchar(100),
  city varchar(100),
  majorregion varchar(100),
  minorregion varchar(100)
);


create table earthquakes(
    earthquakeId smallint unsigned auto_increment primary key not null,
    earthquakeDate date,
    magnitude decimal(6,3),
    locationId smallint
);

load data local infile 'clean/earthquakes/earthquakesOut.csv'
    into table earthquakes
        FIELDS TERMINATED BY ','
    (earthquakeId, @earthquakeDate)
    set earthquakeDate = cast( (select concat(@year,"-",@month,"-",@day)) AS Date)




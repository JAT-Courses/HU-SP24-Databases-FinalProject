/* Script to clean up the database.
 *
*/

# use ca_data_development;

/*********** Begin Cleanup ***********/

/* Unlock tables so we can remove them all */
UNLOCK TABLES;

/* Drop any and all tables/functions that already exist. */
/* Child Tables */
DROP TABLE IF EXISTS earthquakes;
DROP TABLE IF EXISTS groundWaterMeasurements;
DROP TABLE IF EXISTS groundWaterStations;
DROP TABLE IF EXISTS landslides;
DROP TABLE IF EXISTS snowpackMeasurements;
DROP TABLE IF EXISTS snowpackSensors;
DROP TABLE IF EXISTS wildfires;
DROP TABLE IF EXISTS fireDepartmentUnits;

/* Parent Tables */
DROP TABLE IF EXISTS wildfireCauses;
DROP TABLE IF EXISTS landslideImpactTypes;
DROP TABLE IF EXISTS groundWaterQualityCodes;
DROP TABLE IF EXISTS location;

/*********** End cleanup ***********/

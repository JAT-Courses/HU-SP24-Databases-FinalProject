/* Script to clean up the database.
 *
*/

/*********** Begin Cleanup ***********/

/* Unlock tables so we can remove them all */
UNLOCK TABLES;

/* Drop any and all tables/functions that already exist. */
/* Child Tables */
DROP TABLE IF EXISTS earthquakes;
DROP TABLE IF EXISTS groundWaterMeasurements;
DROP TABLE IF EXISTS groundWaterQualityCodes;
DROP TABLE IF EXISTS groundWaterStations;
DROP TABLE IF EXISTS earthquakes;

/* Parent Tables */
DROP TABLE IF EXISTS location;


/*********** End cleanup ***********/

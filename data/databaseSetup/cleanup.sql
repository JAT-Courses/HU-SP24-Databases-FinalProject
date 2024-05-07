/* Script to clean up the database.
 *
*/

/*********** Begin Cleanup ***********/

/* Unlock tables so we can remove them all */
UNLOCK TABLES;

/* Drop any and all tables/functions that already exist. */
/* Child Tables */
DROP TABLE IF EXISTS AvgHousehold;
DROP TABLE IF EXISTS FoodLegislation;
DROP TABLE IF EXISTS PopulationStats;
DROP TABLE IF EXISTS AvgHousehold;
DROP TABLE IF EXISTS ConsumptionStats;
DROP TABLE IF EXISTS MetabolicDisease;
DROP TABLE IF EXISTS FoodAssistance;
DROP TABLE IF EXISTS SchoolFoodPrograms;

/* Parent Tables */
DROP TABLE IF EXISTS DataType;
DROP TABLE IF EXISTS Location;


/*********** End cleanup ***********/
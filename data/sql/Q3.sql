select MONTH(measurementDate), avg(GSE_WSE) as averageGWL from groundWaterMeasurements where YEAR(measurementDate) = 2019 group by MONTH(measurementDate);


select MONTH(STR_TO_DATE(landslideDate, "%m/%d/%Y")) as month, count(*) from landslides where YEAR(STR_TO_DATE(landslideDate, "%m/%d/%Y")) = 2019 group by month;


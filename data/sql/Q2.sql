select MONTH(STR_TO_DATE(landslideDate, "%m/%d/%Y")) as month, count(*) from landslides where YEAR(STR_TO_DATE(landslideDate, "%m/%d/%Y")) = 2019 group by month;

select MONTH(STR_TO_DATE(measurementDate, "%Y%m%d")) as month, avg(value) from snowpackMeasurements where YEAR(STR_TO_DATE(measurementDate, "%Y%m%d")) = 2019 group by month;








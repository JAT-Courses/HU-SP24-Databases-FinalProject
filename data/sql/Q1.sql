
select MONTH(measurementDate) as month, avg(GSE_WSE) as averageGWL from groundWaterMeasurements where YEAR(measurementDate) = 2000 group by MONTH(measurementDate) order by month asc;

select MONTH(STR_TO_DATE(alarmDate, "%m/%d/%Y")) as month, count(*) from wildfires
inner join wildfireCauses as wfc using (causeId)
where (year = 2000 and MONTH(STR_TO_DATE(alarmDate, "%m/%d/%Y")) is not null)  and (causeId = 1 or causeId = 5 or causeId = 9 or causeId = 14 or causeId = 17)
group by month
order by month asc;

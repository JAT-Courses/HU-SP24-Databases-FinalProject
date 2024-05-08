select year, count(*) from wildfires
                               inner join wildfireCauses as wfc using (causeId)
                               inner join fireDepartmentUnits as fdu using (unitCode)
                               inner join location as l using (locationId)
where (majorRegion = "Northern") and (causeId = 1 or causeId = 5 or causeId = 9 or causeId = 14 or causeId = 17) and (year != 0)
group by year
order by year asc;

select year, count(*) from wildfires
                               inner join wildfireCauses as wfc using (causeId)
                               inner join fireDepartmentUnits as fdu using (unitCode)
                               inner join location as l using (locationId)
where (majorRegion = "Southern") and (causeId = 1 or causeId = 5 or causeId = 9 or causeId = 14 or causeId = 17) and (year != 0)
group by year
order by year asc;


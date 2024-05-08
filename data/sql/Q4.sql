

select year, count(*) from earthquakes
                               inner join location as l using (locationId)
where majorRegion = "Northern"
group by year;


select year, count(*) from earthquakes
                               inner join location as l using (locationId)
where majorRegion = "Southern"
group by year;


select avg(magnitude), count(*) from earthquakes
                                         inner join location as l using (locationId)
where majorRegion = "Northern"
group by majorRegion;


select avg(magnitude), count(*) from earthquakes
                                         inner join location as l using (locationId)
where majorRegion = "Southern"
group by majorRegion;


select year, count(*) as count from earthquakes
                                        inner join location as l using (locationId)
where majorRegion = "Northern"
group by year
order by count desc
limit 5;


select year, count(*) as count from earthquakes
                                        inner join location as l using (locationId)
where majorRegion = "Southern"
group by year
order by count desc
limit 5;





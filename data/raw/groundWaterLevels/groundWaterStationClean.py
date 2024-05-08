from dotenv import load_dotenv
import requests
import os
import json
import csv

load_dotenv("../../../.env.development.local")

baseAPIUrl = "https://maps.googleapis.com/maps/api/geocode/json"
headers = {'Accept': 'application/json'}

with open('gwlStationsOut.csv', 'w', newline='\n') as outfile:
    fieldnames = ['STATION','SITE_CODE','STNAME','WELL_NAME','LATITUDE','LONGITUDE','LLDATUM','POSACC','ELEV','ELEVDATUM','ELEVACC','BASIN_CODE','BASIN_NAME','WELL_DEPTH','WELL_USE','WELL_TYPE','WCR_NO','WDL','COMMENT','locationId']
    writer = csv.DictWriter(outfile, fieldnames=fieldnames)

    writer.writeheader()

    with open('gwl-stations.csv') as stationsFile:
        stationsReader = csv.DictReader(stationsFile)
        for stationsReaderRow in stationsReader:

            with open('../locations/location.csv') as locationFile:
                locationReader = csv.DictReader(locationFile)
                for locationReaderRow in locationReader:
                    if locationReaderRow['county'] == stationsReaderRow['COUNTY_NAME'] and locationReaderRow['state'] == 'California':
                        writer.writerow(
                            {'STATION': stationsReaderRow['STATION'], 'SITE_CODE': stationsReaderRow['SITE_CODE'], 'STNAME': stationsReaderRow['STNAME'], 'WELL_NAME': stationsReaderRow['WELL_NAME'],
                             'LATITUDE': stationsReaderRow['LATITUDE'], 'LONGITUDE': stationsReaderRow['LONGITUDE'], 'POSACC': stationsReaderRow['POSACC'], 'ELEV': stationsReaderRow['ELEV'],
                             'ELEVDATUM': stationsReaderRow['ELEVDATUM'], 'ELEVACC': stationsReaderRow['ELEVACC'], 'BASIN_CODE': stationsReaderRow['BASIN_CODE'], 'BASIN_NAME': stationsReaderRow['BASIN_NAME'],
                             'WELL_DEPTH': stationsReaderRow['WELL_DEPTH'], 'WELL_USE': stationsReaderRow['WELL_USE'], 'WELL_TYPE': stationsReaderRow['WELL_TYPE'], 'WCR_NO': stationsReaderRow['WCR_NO'],
                             'WDL': stationsReaderRow['WDL'], 'COMMENT': stationsReaderRow['COMMENT'], 'locationId': locationReaderRow['id']})
                        break

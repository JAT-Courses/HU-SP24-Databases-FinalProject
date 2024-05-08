from dotenv import load_dotenv
import requests
import os
import json
import csv

load_dotenv("../../../.env.development.local")

baseAPIUrl = "https://maps.googleapis.com/maps/api/geocode/json"
headers = {'Accept': 'application/json'}

with open('earthquakesOut.csv', 'w', newline='\n') as outfile:
    fieldnames = ['earthquakeId', 'year', 'month', 'day', 'hour', 'minute', 'second', 'lat', 'lon', 'depth', 'magnitude', 'locationId']
    writer = csv.DictWriter(outfile, fieldnames=fieldnames)

    writer.writeheader()

    with open('CGS_Map_Sheet_48%3A_Historic_Earthquakes%2C_1769_to_2015_-_California_(Magnitude_5.0-plus).csv') as earthquakeFile:
        earthquakeReader = csv.DictReader(earthquakeFile)
        for earthquakeReaderRow in earthquakeReader:
            query = {'latlng': earthquakeReaderRow['lat'] + ',' + earthquakeReaderRow['lon'], 'result_type': 'administrative_area_level_2', 'key': os.getenv('google_api_key')}

            req = requests.get(baseAPIUrl, headers=headers, params=query)

            if len(req.json()['results']) != 0:
                countyName = req.json()['results'][0]['address_components'][0]['long_name'].split(' County')[0]

                with open('../locations/location.csv') as locationFile:
                    locationReader = csv.DictReader(locationFile)
                    for locationReaderRow in locationReader:
                        if locationReaderRow['county'] == countyName and locationReaderRow['state'] == 'California':
                            # print(locationReaderRow)
                            writer.writerow({'earthquakeId': earthquakeReaderRow['OBJECTID'], 'year': earthquakeReaderRow['year'], 'month': earthquakeReaderRow['month'], 'day': earthquakeReaderRow['day'], 'hour': earthquakeReaderRow['hour'], 'minute': earthquakeReaderRow['minute'], 'second': earthquakeReaderRow['second'], 'lat': earthquakeReaderRow['lat'], 'lon': earthquakeReaderRow['lon'], 'depth': earthquakeReaderRow['depth'], 'magnitude': earthquakeReaderRow['magnitude'], 'locationId': locationReaderRow['id']})
                            break

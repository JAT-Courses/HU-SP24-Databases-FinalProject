from dotenv import load_dotenv
import requests
import os
import json
import csv
from bs4 import BeautifulSoup
import re
from datetime import datetime

load_dotenv("../../../.env.development.local")

baseAPIUrl = "https://services2.arcgis.com/zr3KAIbsRSUyARHG/ArcGIS/rest/services/Reported_Landslide_Events_Web_Service/FeatureServer/0/"
headers = {'Accept': 'application/json'}
params = {'token': os.getenv('arcgis_api_key')}

baseGoogleMapsAPIUrl = "https://maps.googleapis.com/maps/api/geocode/json"
googleMapsHeaders = {'Accept': 'application/json'}

with open('landslidesOut.csv', 'w', newline='\n') as outfile:
    fieldnames = ['landslideId', 'date', 'lat', 'lon', 'locationId', 'impacts', 'nearestPlace', 'infoSource']
    writer = csv.DictWriter(outfile, fieldnames=fieldnames)

    writer.writeheader()

    with open('landslideIDs.csv') as landslidesFile:
        landslidesReader = csv.DictReader(landslidesFile)
        for landslidesReaderRow in landslidesReader:
            req = requests.get(baseAPIUrl + landslidesReaderRow['id'] + "/", headers=headers, params=params)

            soup = BeautifulSoup(req.text, 'html.parser')
            reqText = soup.get_text()

            landslideId = landslidesReaderRow['id']
            date = ""
            lat = ""
            lon = ""
            locationId = ""
            impacts = ""
            nearestPlace = ""
            infoSource = ""

            for item in reqText.split("\n"):
                if "EVENT_DATE" in item:
                    match = re.search(r'\d{1,2}\/\d{1,2}\/\d{2,4}', item)
                    date = match.group()
                elif "NEAREST_PLACE" in item:
                    nearestPlace = item.split(':')[1]
                elif "INFO_SOURCE" in item:
                    infoSource = item.split(':')[1]
                elif "IMPACTS" in item:
                    impacts = item.split(':')[1]
                elif "LAT" in item:
                    lat = item.split(':')[1]
                elif "LONG" in item:
                    lon = item.split(':')[1]

            googleMapsQuery = {'latlng': lat + ',' + lon, 'result_type': 'administrative_area_level_2', 'key': os.getenv('google_api_key')}

            mapsLocation = requests.get(baseGoogleMapsAPIUrl, headers=googleMapsHeaders, params=googleMapsQuery)

            if len(mapsLocation.json()['results']) != 0:
                countyName = mapsLocation.json()['results'][0]['address_components'][0]['long_name'].split(' County')[0]

                with open('../locations/location.csv') as locationFile:
                    locationReader = csv.DictReader(locationFile)
                    for locationReaderRow in locationReader:
                        if locationReaderRow['county'] == countyName and locationReaderRow['state'] == 'California':
                            # print(locationReaderRow)
                            writer.writerow({'landslideId': landslideId, 'date': date, 'lat': lat, 'lon': lon, 'locationId': locationReaderRow['id'], 'impacts': impacts, 'nearestPlace': nearestPlace, 'infoSource': infoSource})
                            break



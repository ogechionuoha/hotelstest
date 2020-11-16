from geopy.geocoders import Nominatim
#import pandas as pd
import time
import os
import csv

app = Nominatim(user_agent="loid")

def get_country(lat, lon, language="en"):
    """This function returns an address as raw from a location
    will repeat until success"""
    # build coordinates string to pass to reverse() function
    coordinates = f"{lat}, {lon}"
    time.sleep(1)
    try:
        location = app.reverse(coordinates, language=language)
    except:
        return get_country(lat, lon)

    location = app.reverse(coordinates, language=language)
    address = location.address
    return address.split(',')[-1]


if __name__ == '__main__':
    print('Processing...')
    hotelcountries = os.path.join('.','./input/dataset/train_hotel_countries.csv')
    with open('./input/dataset/hotel_info.csv', 'r') as hotelfile, open(hotelcountries, 'a') as countries_csv:
        hotelscsv = csv.reader(hotelfile)
        header = hotelscsv.__next__()
        for hotel in list(hotelscsv):
            country = get_country(hotel[-2], hotel[-1])
            line = ','.join([str(hotel[0]), country])
            countries_csv.write(line)
            countries_csv.write('\n')

    print('Complete!')



import json
from geopy.geocoders import Nominatim
from tqdm import tqdm

# initialize Nominatim API
geolocator = Nominatim(user_agent="geoapiExercises")

# load JSON file
with open('output.json', 'r') as f:
    data = json.load(f)

# iterate over items with progress bar
for item in tqdm(data):
    # get latitude and longitude
    lat = item['coords']['lat']
    lng = item['coords']['lng']
    
    # get city name
    location = geolocator.reverse(lat+","+lng)
    address = location.raw['address']
    city = address.get('city', '')
    if city == "":
        municipality = address.get('municipality', '')
        if municipality == "":
            print(item)
            print(address)
            break
        else:
            item['city'] = municipality
    
    else:
        item['city'] = city

# save updated JSON file
with open('filename.json', 'w') as f:
    json.dump(data, f, indent=4)
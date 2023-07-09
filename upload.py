import json
import firebase_admin
from firebase_admin import credentials
from firebase_admin import db

# Initialize Firebase Admin SDK
cred = credentials.Certificate("rastreador-6719e-firebase-adminsdk-kljoq-c29436f626.json")  # Path to your service account key JSON file
firebase_admin.initialize_app(cred, {
    'databaseURL': 'https://rastreador-6719e-default-rtdb.europe-west1.firebasedatabase.app'
})

# Path to your JSON file
json_file_path = "sscvl.json"
# json_file_path = "output.json"

# Read JSON data from file
with open(json_file_path) as file:
    data = json.load(file)

# Push JSON data to the Firebase real-time database
ref = db.reference('/sscvl/')  # Reference to the root of your database
ref.set(data)

print("Data pushed successfully to Firebase real-time database.")

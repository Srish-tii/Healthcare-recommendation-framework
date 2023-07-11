import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart' as latLng;
import 'package:flutter_map/flutter_map.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geocoding/geocoding.dart';

class LocationData {
  final String id;
  final String city;
  final String address;
  final Map<String, String> coords;
  final String category;

  LocationData({
    required this.id,
    required this.address,
    required this.coords,
    required this.city,
    required this.category,
  });

  factory LocationData.fromJson(Map<String, dynamic> json) {
    return LocationData(
      id: json['id'],
      address: json['address'],
      city: json['city'],
      coords: Map<String, String>.from(json['coords']),
      category: json['category'],
    );
  }
}

class WriteActivity extends StatefulWidget {
  @override
  _AddActivityState createState() => _AddActivityState();
}

class _AddActivityState extends State<WriteActivity> {
  String _currentLocation = 'Fetching your current location...';
  String _currentAddress = "Fetching your current location...";
  Position? _currentPosition;
  String? _selectedCategory;
  String? _selectedCity;

  int _numberOfLocationsToShow = 250;
  List<LocationData> _locations = [];
  List<LocationData> _closestLocations = [];

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _loadLocations();
  }

  Future<void> _getCurrentLocation() async {
    var permissionStatus = await Permission.location.request();
    if (permissionStatus.isGranted) {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _currentLocation =
            'Latitude: ${position.latitude}, Longitude: ${position.longitude}';
        _calculateClosestLocations(position);
      });

      await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      ).then((Position position) {
        setState(() => this._currentPosition = position);
        _getAddressFromLatLng(position);
      }).catchError((e) {
        debugPrint(e);
      });
    } else {
      setState(() {
        _currentLocation = 'Permission denied';
      });
    }
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(position.latitude, position.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            '${place.street}, ${place.subLocality},${place.subAdministrativeArea}, ${place.postalCode}';
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _loadLocations() async {
    final String response = await rootBundle.loadString('assets/output.json');
    final data = await json.decode(response);

    List<LocationData> locations = (data as List<dynamic>)
        .map((json) => LocationData.fromJson(json))
        .toList();
    setState(() {
      _locations = locations;
      _closestLocations = locations.take(_numberOfLocationsToShow).toList();
    });
    print(locations.length);
  }

  void _calculateClosestLocations(Position currentLocation) {
    List<LocationData> locations = List.from(_locations);

    locations.sort((a, b) {
      double distanceA = _calculateDistance(
        currentLocation.latitude,
        currentLocation.longitude,
        double.parse(a.coords['lat']!),
        double.parse(a.coords['lng']!),
      );
      double distanceB = _calculateDistance(
        currentLocation.latitude,
        currentLocation.longitude,
        double.parse(b.coords['lat']!),
        double.parse(b.coords['lng']!),
      );
      return distanceA.compareTo(distanceB);
    });

    setState(() {
      _closestLocations = locations.take(250).toList();
    });
  }

  double _calculateDistance(
    double startLatitude,
    double startLongitude,
    double endLatitude,
    double endLongitude,
  ) {
    return Geolocator.distanceBetween(
      startLatitude,
      startLongitude,
      endLatitude,
      endLongitude,
    );
  }

  void _filterLocations() {
    List<LocationData> filteredLocations = _locations;

    // Filter by category
    if (_selectedCategory != null) {
      filteredLocations = filteredLocations
          .where((location) => location.category == _selectedCategory)
          .toList();
    }

    // Filter by city name
    if (_selectedCity != null) {
      filteredLocations = filteredLocations
          .where((location) => location.city == _selectedCity)
          .toList();
    }

    setState(() {
      _closestLocations =
          filteredLocations.take(_numberOfLocationsToShow).toList();
    });
  }

  void _updateNumberOfLocationsToShow(int numberOfLocations) {
    setState(() {
      _numberOfLocationsToShow = numberOfLocations;
      _closestLocations = _locations.take(_numberOfLocationsToShow).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Activity'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 300,
            child: FlutterMap(
              options: MapOptions(
                center: latLng.LatLng(
                  _currentPosition!.latitude,
                  _currentPosition!.longitude,
                ),
                zoom: 13.0,
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c'],
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      width: 60.0,
                      height: 60.0,
                      point: latLng.LatLng(
                        _currentPosition!.latitude,
                        _currentPosition!.longitude,
                      ),
                      builder: (ctx) => Container(
                        child: FlutterLogo(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              _currentAddress,
              style: TextStyle(fontSize: 18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Text(
                  'Select a category:',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: _selectedCategory,
                    hint: Text('Select a category'),
                    onChanged: (value) {
                      setState(() {
                        _selectedCategory = value;
                        _filterLocations();
                      });
                    },
                    items: [
                      DropdownMenuItem<String>(
                        value: null,
                        child: Text('All'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'water',
                        child: Text('Water'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'ground',
                        child: Text('Ground'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Text(
                  'Select a city:',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: _selectedCity,
                    hint: Text('Select a city'),
                    onChanged: (value) {
                      setState(() {
                        _selectedCity = value;
                        _filterLocations();
                      });
                    },
                    items: [
                      DropdownMenuItem<String>(
                        value: null,
                        child: Text('All'),
                      ),

                      DropdownMenuItem<String>(
                        value: 'Orleans',
                        child: Text('Orleans'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'Issoudun',
                        child: Text('Issoudun'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'Chateauroux',
                        child: Text('Chateauroux'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'Arrondissement de Tours',
                        child: Text('Arrondissement de Tours'),
                      ),

                      DropdownMenuItem<String>(
                        value: 'Montargis',
                        child: Text('Montargis'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'Loches',
                        child: Text('Loches'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'Tours',
                        child: Text('Tours'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'Bourges',
                        child: Text('Bourges'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'Blois',
                        child: Text('Blois'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'Chinon',
                        child: Text('Chinon'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'Chartres',
                        child: Text('Chartres'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'Romorantin-Lanthenay',
                        child: Text('Romorantin-Lanthenay'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'Pithiviers',
                        child: Text('Pithiviers'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'Vendome',
                        child: Text('Vendome'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'La Chatre',
                        child: Text('La Chatre'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'Chateaudun',
                        child: Text('Chateaudun'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'Valencisse',
                        child: Text('Valencisse'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'Tauxigny-Saint-Bauld',
                        child: Text('Tauxigny-Saint-Bauld'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'Le Blanc',
                        child: Text('Le Blanc'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'Chalette-sur-Loing',
                        child: Text('Chalette-sur-Loing'),
                      ),
                      // Add more city options as needed
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Number of Locations',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                int numberOfLocations = int.tryParse(value) ?? 0;
                _updateNumberOfLocationsToShow(numberOfLocations);
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _closestLocations.length,
              itemBuilder: (context, index) {
                LocationData location = _closestLocations[index];
                return ListTile(
                  title: Text(location.address),
                  subtitle: Text(
                    'Latitude: ${location.coords['lat']}, Longitude: ${location.coords['lng']}',
                  ),
                  // Add any other UI elements you want to display for each location
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import "package:latlong2/latlong.dart" as latLng;
import 'dart:math';
import 'package:flutter_map/flutter_map.dart';

class LocationData {
  final String id;
  final String image;
  final String link;
  final String address;
  final Map<String, String> coords;
  final String promoted;
  final String mapIcon;

  LocationData({
    required this.id,
    required this.image,
    required this.link,
    required this.address,
    required this.coords,
    required this.promoted,
    required this.mapIcon,
  });

  factory LocationData.fromJson(Map<String, dynamic> json) {
    return LocationData(
      id: json['id'],
      image: json['image'],
      link: json['link'],
      address: json['address'],
      coords: Map<String, String>.from(json['coords']),
      promoted: json['promoted'],
      mapIcon: json['map_icon'],
    );
  }
}

class WriteActivity extends StatefulWidget {
  @override
  _AddActivityState createState() => _AddActivityState();
}

class _AddActivityState extends State<WriteActivity> {
  String _currentLocation = 'Fetching your current location...';
  int _numberOfLocationsToShow = 50;
  List<LocationData> _locations = [];
  List<LocationData> _closestLocations = [];
  double _radius = 0.0;
  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _loadLocations();
  }

  Future<void> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      _currentLocation =
          'Latitude: ${position.latitude}, Longitude: ${position.longitude}';
      _calculateClosestLocations(position);
    });
  }

  Future<void> _loadLocations() async {
    final String response = await rootBundle.loadString('assets/sscvl.json');
    final data = await json.decode(response);

    List<LocationData> locations = (data as List<dynamic>)
        .map((json) => LocationData.fromJson(json))
        .toList();
    setState(() {
      _locations = locations;
    });
    print(locations.length);
  }

  // void _calculateClosestLocations(Position currentLocation) {
  //   List<LocationData> locations = List.from(_locations);

  //   locations.sort((a, b) {
  //     double distanceA = _calculateDistance(
  //       currentLocation.latitude,
  //       currentLocation.longitude,
  //       double.parse(a.coords['lat']!),
  //       double.parse(a.coords['lng']!),
  //     );
  //     double distanceB = _calculateDistance(
  //       currentLocation.latitude,
  //       currentLocation.longitude,
  //       double.parse(b.coords['lat']!),
  //       double.parse(b.coords['lng']!),
  //     );
  //     return distanceA.compareTo(distanceB);
  //   });

  //   setState(() {
  //     _closestLocations = locations.take(50).toList();
  //   });
  // }
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

    if (_numberOfLocationsToShow <= 0) {
      // Show all locations within the radius
      setState(() {
        _closestLocations = locations
            .where((location) =>
                _calculateDistance(
                    currentLocation.latitude,
                    currentLocation.longitude,
                    double.parse(location.coords['lat']!),
                    double.parse(location.coords['lng']!)) <=
                _radius)
            .toList();
      });
    } else {
      // Show the specified number of closest locations within the radius
      setState(() {
        _closestLocations = locations
            .where((location) =>
                _calculateDistance(
                    currentLocation.latitude,
                    currentLocation.longitude,
                    double.parse(location.coords['lat']!),
                    double.parse(location.coords['lng']!)) <=
                _radius)
            .take(_numberOfLocationsToShow)
            .toList();
      });
    }
  }

  // void _calculateClosestLocations(Position currentLocation) {
  //   List<LocationData> locations = List.from(_locations);

  //   locations.sort((a, b) {
  //     double distanceA = _calculateDistance(
  //       currentLocation.latitude,
  //       currentLocation.longitude,
  //       double.parse(a.coords['lat']!),
  //       double.parse(a.coords['lng']!),
  //     );
  //     double distanceB = _calculateDistance(
  //       currentLocation.latitude,
  //       currentLocation.longitude,
  //       double.parse(b.coords['lat']!),
  //       double.parse(b.coords['lng']!),
  //     );
  //     return distanceA.compareTo(distanceB);
  //   });

  //   setState(() {
  //     _closestLocations = locations
  //         .where((location) =>
  //             _calculateDistance(
  //                 currentLocation.latitude,
  //                 currentLocation.longitude,
  //                 double.parse(location.coords['lat']!),
  //                 double.parse(location.coords['lng']!)) <=
  //             _radius)
  //         .take(50)
  //         .toList();
  //   });
  // }

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

  void _updateNumberOfLocationsToShow(int numberOfLocations) {
    setState(() {
      _numberOfLocationsToShow = numberOfLocations;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Add New Activity'),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  // Wrap the SizedBox with Expanded
                  child: FlutterMap(
                options: MapOptions(
                  center: latLng.LatLng(
                    37.42,
                    -122.04,
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
                        width: 80.0,
                        height: 80.0,
                        point: latLng.LatLng(37.42, -112.04),
                        builder: (ctx) => Container(
                          child: FlutterLogo(),
                        ),
                      )
                    ],
                  ),
                ],
              )),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  _currentLocation,
                  style: TextStyle(fontSize: 18),
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
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Slider(
                  value: _radius,
                  min: 0.0,
                  max: 200.0,
                  onChanged: (value) {
                    setState(() {
                      _radius = value;
                    });
                  },
                  divisions: 100,
                  label: 'Radius: ${_radius.toStringAsFixed(2)}',
                ),
              ),
              Container(
                  // Add a Container with a height constraint
                  height: 200, // Replace with the desired height
                  child: Flexible(
                    child: ListView.builder(
                      itemCount: min(
                          _numberOfLocationsToShow, _closestLocations.length),
                      itemBuilder: (context, index) {
                        LocationData location = _closestLocations[index];
                        return ListTile(
                          title: Text(location.address),
                          subtitle: Text(
                              'Latitude: ${location.coords['lat']}, Longitude: ${location.coords['lng']}'),
                          // Add any other UI elements you want to display for each location
                        );
                      },
                    ),
                  )),
            ],
          ),
        ));
  }
}

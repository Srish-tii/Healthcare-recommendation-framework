import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:rastreador/Patient/PatientHome/PatientHome.dart';
import '../../main.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

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
  String _currentLocation = 'Fetching location...';
  List<LocationData> _locations = [];
  List<LocationData> _closestLocations = [];

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
      _closestLocations = locations.take(10).toList();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Activity'),
      ),
      body: Column(
        children: [
          Center(
            child: Text(
              _currentLocation,
              style: TextStyle(fontSize: 20),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: min(10, _closestLocations.length),
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
          ),
        ],
      ),
    );
  }
}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// class WriteActivity extends StatefulWidget {
//   @override
//   _AddActivityState createState() => _AddActivityState();
// }

// class _AddActivityState extends State<WriteActivity> {
//   List<Map<dynamic, dynamic>> _activities = [];

//   @override
//   void initState() {
//     super.initState();
//     _fetchActivities();
//   }

//   Future<void> _fetchActivities() async {
//     DatabaseReference activitiesRef =
//         FirebaseDatabase.instance.reference().child('ssclv');
//     DatabaseEvent event = await activitiesRef.once();

//     DataSnapshot dataSnapshot = event.snapshot;

//     Map<dynamic, dynamic> activitiesData =
//         dataSnapshot.value as Map<dynamic, dynamic>;
//     List<Map<dynamic, dynamic>> activitiesList = [];

//     activitiesData.forEach((key, value) {
//       activitiesList.add(value);
//     });

//     // Sort activities by distance
//     Position currentPosition = await Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.high,
//     );

//     activitiesList.sort((a, b) {
//       double aDistance = _calculateDistance(
//         currentPosition.latitude,
//         currentPosition.longitude,
//         a['coords']['lat'],
//         a['coords']['lng'],
//       );
//       double bDistance = _calculateDistance(
//         currentPosition.latitude,
//         currentPosition.longitude,
//         b['coords']['lat'],
//         b['coords']['lng'],
//       );
//       return aDistance.compareTo(bDistance);
//     });

//     setState(() {
//       _activities =
//           activitiesList.sublist(0, 5); // Get top 5 closest activities
//     });
//   }

//   double _calculateDistance(double startLatitude, double startLongitude,
//       double endLatitude, double endLongitude) {
//     return Geolocator.distanceBetween(
//       startLatitude,
//       startLongitude,
//       endLatitude,
//       endLongitude,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Add New Activity'),
//       ),
//       body: ListView.builder(
//         itemCount: _activities.length,
//         itemBuilder: (context, index) {
//           Map<dynamic, dynamic> activity = _activities[index];
//           String id = activity['id'].toString();
//           double latitude = activity['coords']['lat'];
//           double longitude = activity['coords']['lng'];

//           return ListTile(
//             title: Text('ID: $id'),
//             subtitle: Text('Latitude: $latitude, Longitude: $longitude'),
//           );
//         },
//       ),
//     );
//   }
// }
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


// ///--------------------------- Add new Activity page ------------------------------
// class WriteActivity extends StatefulWidget {
//   @override
//   _AddActivity createState() => _AddActivity();
// }

// class _AddActivity extends State<WriteActivity> {
//   final _actname = TextEditingController();
//   final _actype = TextEditingController();
//   final _actlocation = TextEditingController();
//   showAlertDialog(BuildContext context) {
//     // set up the button
//     Widget okButton = TextButton(
//       style: TextButton.styleFrom(
//           padding: const EdgeInsets.all(16.0),
//           primary: Colors.white,
//           textStyle: const TextStyle(fontSize: 20)),
//       child: Text("OK"),
//       onPressed: () {
//         Navigator.push(
//             context, MaterialPageRoute(builder: (context) => MyApp()));
//       },
//     );
//     // set up the AlertDialog
//     AlertDialog alert = AlertDialog(
//       title: Text("Exit"),
//       content: Text("Do you want to exit !"),
//       actions: [
//         okButton,
//       ],
//       elevation: 24.0,
//       backgroundColor: Colors.blueGrey[200],
//     );
//     showDialog(context: context, builder: (BuildContext context) => alert);
//   }

//   Position? _currentPosition;
//   //final database = FirebaseDatabase.instance.reference() ;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Location"),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             if (_currentPosition != null)
//               Text(
//                   "LAT: ${_currentPosition!.latitude}, LNG: ${_currentPosition!.longitude}"),
//             TextButton(
//               child: Text("Get location"),
//               onPressed: () {
//                 _getCurrentLocation();
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

  // _getCurrentLocation() {
  //   Geolocator.getCurrentPosition(
  //           desiredAccuracy: LocationAccuracy.best,
  //           forceAndroidLocationManager: true)
  //       .then((Position position) {
  //     setState(() {
  //       _currentPosition = position;
  //     });
  //   }).catchError((e) {
  //     print(e);
  //   });
  // }

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

class LocationScreen extends StatefulWidget {
  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String locationMessage = "Current location of the user";
  late String lat;
  late String long;
  late double accuracy;

  Future<Position> _getcurrentlocation() async {
    bool serviceEnabled = await Geolocator.openLocationSettings();
   // serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      // return Future.error("Location services are disabled");
    }
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Location permission is denied");
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          "Your location permission is denied, we cannot track your location");
    }
    return await Geolocator.getCurrentPosition();
  }

  void _livelocation() {
    final LocationSettings locationSettings = LocationSettings(
    accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );
    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position position) {
      lat = position.latitude.toString();
      long = position.longitude.toString();
      accuracy = position.accuracy;

      setState(() {
        locationMessage =
            'Latitude: $lat, Longitude: $long\nAccuracy: $accuracy meters';
      });
    });
  }

  Future<void> _openMap(String lat, String long) async {
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$lat,$long';
    await launchUrl(Uri.parse(googleUrl));  //to show google map on screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User location',style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.green[600]
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              locationMessage,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _getcurrentlocation().then((value) {
                  lat = '${value.latitude}';
                  long = '${value.longitude}';
                  accuracy = value.accuracy;

                  setState(() {
                    locationMessage =
                        'Latitude: $lat, Longitude: $long\nAccuracy: $accuracy meters';
                  });

                  _livelocation();
                });
              },
              child: Text("Get Current Location"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _openMap(lat, long);
              },
              child: Text("Open Google Map"),
            ),
          ],
        ),
      ),
    );
  }
}

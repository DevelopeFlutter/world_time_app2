// ignore_for_file: library_private_types_in_public_api

import 'dart:developer' as log;
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'dart:async';
import 'package:timezone/timezone.dart' as tz;

import 'MapClass.dart';

class WorldTimeDisplay extends StatefulWidget {
  const WorldTimeDisplay({super.key});

  @override
  _WorldTimeDisplayState createState() => _WorldTimeDisplayState();
}

class _WorldTimeDisplayState extends State<WorldTimeDisplay> {
  Timer? _timer;
  List locations = [];
  Location location = Location();
  dynamic   _locationData;



  @override
  void initState() {
    super.initState();
    locations = tz.timeZoneDatabase.locations.entries.toList();
    setState(() {});
    // Start a timer to update the time every 1 minute (you can adjust the duration as needed)
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {}); // Trigger a rebuild of the widget to update the time
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () async{

        _locationData = await location.getLocation();

        location.enableBackgroundMode(enable: true);
        Navigator.push(context, MaterialPageRoute(builder:(con){
          return MapClass( currentLocation: _locationData,);
        } ));

      },
      child: Icon(Icons.add,size: 20,),),
      appBar: AppBar(
        title: const Text('World Time Display'),
      ),
      body: ListView.builder(
        itemCount: locations.length,
        itemBuilder: (context, index) {
          dynamic location = locations[index];
          dynamic value;
          dynamic key;
          if (location is MapEntry<String, dynamic>) {
            key = location.key.split(':').first;
            value = location.value.toString();
          } else {}
          double calculateDistance(
              double lat1, double lon1, double lat2, double lon2) {
            const double earthRadiusKm = 6371.0; // Earth's radius in kilometers
            double radians(double degrees) {
              return degrees * pi / 180.0;
            }

            double dLat = radians(lat2 - lat1);
            double dLon = radians(lon2 - lon1);

            double a = pow(sin(dLat / 2), 2) +
                cos(radians(lat1)) * cos(radians(lat2)) * pow(sin(dLon / 2), 2);
            double c = 2 * atan2(sqrt(a), sqrt(1 - a));

            double distance = earthRadiusKm * c;
            return distance;
          }

          dynamic timeZone = tz.getLocation(value);
          double latitudeCity1 = 40.7128;
          double longitudeCity1 = -74.0060;
          double latitudeCity2 = 51.5074;
          double longitudeCity2 = -0.1278;
          double travelSpeedKmPerHour = 800.0;

          double distanceKm = calculateDistance(
              latitudeCity1, longitudeCity1, latitudeCity2, longitudeCity2);
          double travelTimeHours = distanceKm / travelSpeedKmPerHour;
          // log.log('$travelTimeHours this is the TravelTimeHours');
          //
          // log.log('${distanceKm.toStringAsFixed(2)} this is the distance ');

          // Get the current time in the specified time zone
          var currentTime = tz.TZDateTime.now(timeZone);
          return ListTile(
            title: Text('$key'),
            subtitle: Text(
                '${currentTime.hour}:${currentTime.minute}:${currentTime.second}'),
          );
        },
      ),
    );
  }
}

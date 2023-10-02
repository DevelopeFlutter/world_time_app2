import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapClass extends StatefulWidget {
  MapClass({super.key, required this.currentLocation,});
  dynamic currentLocation;

  @override
  State<MapClass> createState() => _MapClassState();
}

class _MapClassState extends State<MapClass> {
  GoogleMapController? _mapController;
  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  Location _location = Location();

  @override
  Widget build(BuildContext context) {
    log('${widget.currentLocation} This is the current Location');
    LatLng initialPosition = widget.currentLocation != null
        ? LatLng(
            widget.currentLocation!.latitude, widget.currentLocation!.longitude)
        : const LatLng(
            0.0, 0.0); // Default initial position if location not available

    return Scaffold(
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: initialPosition,
          zoom: 14.0,
        ),
        markers: Set<Marker>.from([
          Marker(
            markerId: const MarkerId('currentLocation'),
            position: initialPosition,
            // infoWindow: const InfoWindow(title: 'Current Location'),
          ),
        ]),
      ),
    );
  }
}

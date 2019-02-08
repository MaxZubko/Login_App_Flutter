import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyMap extends StatefulWidget {
  @override
  MyMapState createState() => MyMapState();
}

class MyMapState extends State<MyMap> {
  GoogleMapController mapController;

  final LatLng _center = const LatLng(50.006406, 36.236484);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Map'),
          backgroundColor: Colors.blueGrey[900],
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          options: GoogleMapOptions(
            scrollGesturesEnabled: true,
            tiltGesturesEnabled: true,
            rotateGesturesEnabled: true,
            myLocationEnabled: true,
            compassEnabled: true,
            cameraPosition: CameraPosition(
              target: _center,
              zoom: 11.0,
            ),
          ),
        ),
      );
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    mapController.addMarker(
      MarkerOptions(
        position: LatLng( 50.006406, 36.236484
          // mapController.cameraPosition.target.latitude,
          // mapController.cameraPosition.target.longitude,
          ),
        infoWindowText: InfoWindowText('My Location', 'Office'),
        icon: BitmapDescriptor.defaultMarker,
      ),
    );
  }
}
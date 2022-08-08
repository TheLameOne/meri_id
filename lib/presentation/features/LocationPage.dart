//import "package:meri_id/presentation/custom/custom_scaffold.dart";
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meri_id/presentation/features/otp.dart';

class Location extends StatefulWidget {
  static const String routeNamed = "LocationPage";
  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {
  double lat = 28.644800;
  double long = 77.216721;
  List<Marker> allMarkers = [];

  @override
  void initState() {
    super.initState();
    allMarkers.add(Marker(
      markerId: const MarkerId('myMarker'),
      draggable: false,
      onTap: () {
        print('Marker Tapped');
      },
      position: LatLng(lat, long),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Your Operator Location"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pushNamed(context, OTP.routeNamed),
          ),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(target: LatLng(lat, long), zoom: 12.0),
              markers: Set.from(allMarkers),
            ),
          ],
        ),
      ),
    );
  }
}

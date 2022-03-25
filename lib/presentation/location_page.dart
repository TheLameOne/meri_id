//import "package:meri_id/presentation/custom/custom_scaffold.dart";
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Location extends StatefulWidget {
  double lat = 28.644800;
  double long = 77.216721;

  Location({required this.lat, required this.long});

  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {
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
      position: LatLng(widget.lat, widget.long),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
                target: LatLng(widget.lat, widget.long), zoom: 12.0),
            markers: Set.from(allMarkers),
          ),
        ],
      ),
    );
  }
  // Widget build(BuildContext context) {
  //   return CustomScaffold(
  //     appBarText: 'Location',
  //     appbarOnTap: () {
  //       Navigator.pop(context);
  //     },
  //     body: Stack(
  //       children: [
  //         GoogleMap(
  //           initialCameraPosition: CameraPosition(
  //               target: LatLng(widget.lat, widget.long), zoom: 12.0),
  //           markers: Set.from(allMarkers),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}

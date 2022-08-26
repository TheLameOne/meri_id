import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:meri_id/model/Loc.dart';
import 'package:meri_id/utils/global.dart';
import 'package:meri_id/utils/styles.dart';

class GoogleMapTracking extends StatefulWidget {
  late String data;

  GoogleMapTracking({required this.data});

  @override
  State<GoogleMapTracking> createState() => _GoogleMapTrackingState();
}

class _GoogleMapTrackingState extends State<GoogleMapTracking> {
  List<Marker> allMarkers = [];
  late BitmapDescriptor customIcon1 = BitmapDescriptor.defaultMarker;
  late BitmapDescriptor customIcon2 = BitmapDescriptor.defaultMarker;
  _mymarker(String gender) async {
    if (gender == "female") {
      customIcon1 = await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(size: Size(12, 12)), 'assets/images/female.png');
    } else {
      customIcon1 = await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(), 'assets/images/male.png');
    }
    customIcon2 = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(12, 12)), 'assets/images/home.png');
  }

  bool isLoading = true;
  final Completer<GoogleMapController> _controller = Completer();

  Loc loc = Loc();
  static LatLng sourceLocation = LatLng(37.33500926, -122.03272188);
  static LatLng destinationLocation = LatLng(28.7041, 77.1025);
  List<LatLng> polylineCoordinates = [];

  void getPolyPoints() async {
    loc = await apiService.getLoc(widget.data);
    sourceLocation = LatLng(double.parse(loc.opLat), double.parse(loc.opLong));
    destinationLocation =
        LatLng(double.parse(loc.bookLat), double.parse(loc.bookLong));

    print(sourceLocation);
    print(destinationLocation);
    _mymarker(loc.gender);
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyC71uktesLZfNFqlMcKRgJFdNiyZoug9o0", // Your Google Map Key
      PointLatLng(double.parse(loc.opLat), double.parse(loc.opLong)),
      PointLatLng(double.parse(loc.bookLat), double.parse(loc.bookLong)),
    );
    if (result.points.isNotEmpty) {
      result.points.forEach(
        (PointLatLng point) => polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        ),
      );

      allMarkers.add(Marker(
          markerId: const MarkerId('source'),
          draggable: false,
          onTap: () {},
          icon: customIcon1,
          position: sourceLocation));

      allMarkers.add(Marker(
          markerId: const MarkerId('destination'),
          draggable: false,
          onTap: () {},
          icon: customIcon2,
          position: destinationLocation));

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _parent();
  }

  void _parent() async {
    getPolyPoints();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Styles.backgroundColor,
        appBar: AppBar(
          actions: [],
          title: Text("Operator Live Location"),
          centerTitle: true,
          backgroundColor: Colors.white,
          foregroundColor: Styles.blackColor,
          elevation: 0,
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(color: Styles.redColor),
              )
            : GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                      double.parse(loc.bookLat), double.parse(loc.bookLong)),
                  zoom: 14,
                ),
                // markers: markers.values.toSet(),
                markers: allMarkers.toSet(),
                onMapCreated: (mapController) {
                  _controller.complete(mapController);
                },
                polylines: {
                  Polyline(
                    polylineId: const PolylineId("route"),
                    points: polylineCoordinates,
                    color: Styles.redColor,
                    width: 8,
                  ),
                },
              ),
      ),
    );
  }
}

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
  bool isLoading = true;
  final Completer<GoogleMapController> _controller = Completer();
  Loc loc = Loc();

  static const LatLng sourceLocation = LatLng(37.33500926, -122.03272188);
  static const LatLng destination = LatLng(37.33429383, -122.06600055);
  List<LatLng> polylineCoordinates = [];
  void getPolyPoints() async {
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
    loc = await apiService.getLoc(widget.data);
    getPolyPoints();
  }

  BitmapDescriptor icon1 = BitmapDescriptor.defaultMarker;
  BitmapDescriptor icon2 = BitmapDescriptor.defaultMarker;

  seticonMarker() async{
    String imgurl = "https://www.fluttercampus.com/img/car.png";
      Uint8List bytes = (await NetworkAssetBundle(Uri.parse(imgurl))
      .load(imgurl))
      .buffer
      .asUint8List();
    icon2 = BitmapDescriptor.fromBytes(bytes); //Icon for Marker
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Styles.backgroundColor,
        appBar: AppBar(
          actions: [],
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
                  zoom: 13.5,
                ),
                markers: {
                   Marker(
                    markerId: MarkerId("source"),
                    position: sourceLocation,
                    icon: icon1
                  ),
                   Marker(
                    markerId: MarkerId("destination"),
                    position: destination,
                    icon: icon1
                  ),
                },
                onMapCreated: (mapController) {
                  _controller.complete(mapController);
                },
                polylines: {
                  Polyline(
                    polylineId: const PolylineId("route"),
                    points: polylineCoordinates,
                    color: const Color(0xFF7B61FF),
                    width: 6,
                  ),
                },
              ),
      ),
    );
  }
}

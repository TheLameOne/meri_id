import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
// import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:meri_id/utils/styles.dart';

class Places extends StatefulWidget {
  @override
  _PlacesState createState() => _PlacesState();
}

class _PlacesState extends State<Places> {
  String googleApikey = "AIzaSyC71uktesLZfNFqlMcKRgJFdNiyZoug9o0";
  GoogleMapController? mapController; //contrller for Google map
  CameraPosition? cameraPosition;
  LatLng startLocation = LatLng(17.471236, 78.721465);
  String location = "Search Location";

  Marker x() {
    return Marker(
      markerId: const MarkerId('myMarker'),
      draggable: false,
      onTap: () {},
      position: startLocation,
    );
  }

  List<Marker> allMarkers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Search Location"),
          backgroundColor: Styles.redColor,
        ),
        body: Stack(children: [
          GoogleMap(
            markers: Set.from(allMarkers),
            zoomGesturesEnabled: true,
            initialCameraPosition: CameraPosition(
              target: startLocation,
              zoom: 14.0,
            ),
            mapType: MapType.normal,
            //map type
            onMapCreated: (controller) {
              //method called when map is created
              setState(() {
                mapController = controller;
              });
            },
          ),

          //search autoconplete input
          Positioned(
              //search input bar
              top: 10,
              child: InkWell(
                  onTap: () async {
                    var place = await PlacesAutocomplete.show(
                        context: context,
                        apiKey: googleApikey,
                        mode: Mode.overlay,
                        types: [],
                        strictbounds: false,
                        components: [Component(Component.country, 'IN')],
                        //google_map_webservice package
                        onError: (err) {
                          print(err);
                        });

                    if (place != null) {
                      setState(() {
                        location = place.description.toString();
                      });

                      //form google_maps_webservice package
                      final plist = GoogleMapsPlaces(
                        apiKey: googleApikey,
                        apiHeaders: await GoogleApiHeaders().getHeaders(),
                        //from google_api_headers package
                      );
                      String placeid = place.placeId ?? "0";
                      final detail = await plist.getDetailsByPlaceId(placeid);
                      final geometry = detail.result.geometry!;
                      final lat = geometry.location.lat;
                      final lang = geometry.location.lng;
                      var newlatlang = LatLng(lat, lang);
                      setState(() {
                        startLocation = newlatlang;
                      });

                      //move map camera to selected place with animation
                      mapController?.animateCamera(
                          CameraUpdate.newCameraPosition(CameraPosition(
                        target: newlatlang,
                        zoom: 17,
                      )));
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Card(
                      child: Container(
                          padding: EdgeInsets.all(0),
                          width: MediaQuery.of(context).size.width - 40,
                          child: ListTile(
                            title: Text(
                              location,
                              style: TextStyle(fontSize: 18),
                            ),
                            trailing: Icon(Icons.search),
                            dense: true,
                          )),
                    ),
                  )))
        ]));
  }
}

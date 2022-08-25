import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
// import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

import '../../model/Address.dart';
import '../../model/Booking.dart';
import '../../services/widgets/CustomText.dart';
import '../../utils/global.dart';
import '../../utils/strings.dart';
import '../../utils/styles.dart';
import '../custom/CustomButton.dart';
import '../custom/CustomLocation.dart';

import '../custom/CustomTextField.dart';
import 'ChooseTimeSlot.dart';

class ChooseAddress extends StatefulWidget {
  late Booking booking;
  ChooseAddress({required this.booking});

  @override
  State<ChooseAddress> createState() => _ChooseAddressState();
}

class _ChooseAddressState extends State<ChooseAddress> {
  String googleApikey = "AIzaSyC71uktesLZfNFqlMcKRgJFdNiyZoug9o0";
  LatLng startLocation = LatLng(17.471236, 78.721465);
  String location = "Search Location";
  bool _language = true;
  Address address = Address();
  double? latitude;
  double? longitude;

  @override
  void initState() {
    super.initState();
    _parent();
  }

  _parent() async {
    await _languageFunction();
    // _getUserLocation();
  }

  _languageFunction() async {
    bool val = await checkLanguage();
    setState(() {
      _language = val;
      latitude = 17.471236;
      longitude = 78.721465;
    });
  }

  _routeToTimeSlotPage() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ChooseTimeSlot(booking: widget.booking)));
  }

  // _getUserLocation() async {
  //   Location location = Location();
  //   final _locationData = await location.getLocation();
  //   setState(() {
  //     latitude = _locationData.latitude;
  //     longitude = _locationData.longitude;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Styles.backgroundColor,
            appBar: AppBar(
              actions: [],
              backgroundColor: Styles.backgroundColor,
              foregroundColor: Styles.blackColor,
              elevation: 0,
            ),
            body: (latitude != null && longitude != null)
                ? SingleChildScrollView(
                    child: Container(
                        color: Styles.backgroundColor,
                        padding: const EdgeInsets.only(
                            left: 32, right: 32, bottom: 32),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText.xLargeText(
                                (_language)
                                    ? StringValues.address.english
                                    : StringValues.address.hindi,
                              ),
                              const SizedBox(height: 32),
                              TextField(
                                onTap: () async {
                                  var place = await PlacesAutocomplete.show(
                                      context: context,
                                      apiKey: googleApikey,
                                      mode: Mode.overlay,
                                      types: [],
                                      strictbounds: false,
                                      components: [
                                        Component(Component.country, 'IN')
                                      ],

                                      //google_map_webservice package
                                      onError: (err) {
                                        print(err);
                                      });

                                  if (place != null) {
                                    setState(() {});

                                    //form google_maps_webservice package
                                    final plist = GoogleMapsPlaces(
                                      apiKey: googleApikey,
                                      apiHeaders:
                                          await GoogleApiHeaders().getHeaders(),
                                      //from google_api_headers package
                                    );
                                    String placeid = place.placeId ?? "0";
                                    final detail = await plist
                                        .getDetailsByPlaceId(placeid);
                                    final geometry = detail.result.geometry!;
                                    final lat = geometry.location.lat;
                                    final lang = geometry.location.lng;
                                    var newlatlang = LatLng(lat, lang);

                                    //move map camera to selected place with animation

                                  }
                                },
                              ),
                              const SizedBox(height: 16),
                              CustomTextField(
                                hintText: "",
                                hintTextSize: 16,
                                initialValue: '',
                                onChanged: (value) {
                                  address.address_line_1 = value;
                                },
                                onSaved: () {},
                                validator: () {},
                                labelText: (_language)
                                    ? StringValues.homeStreet.english
                                    : StringValues.homeStreet.hindi,
                              ),
                              const SizedBox(height: 16),
                              CustomTextField(
                                hintText: "",
                                hintTextSize: 16,
                                initialValue: '',
                                onChanged: (value) {
                                  address.address_line_2 = value;
                                },
                                onSaved: () {},
                                validator: () {},
                                labelText: (_language)
                                    ? StringValues.area.english
                                    : StringValues.area.hindi,
                              ),
                              const SizedBox(height: 16),
                              CustomTextField(
                                hintText: "",
                                hintTextSize: 16,
                                initialValue: '',
                                onChanged: (value) {
                                  address.city = value;
                                },
                                onSaved: () {},
                                validator: () {},
                                labelText: (_language)
                                    ? StringValues.cityDistrict.english
                                    : StringValues.cityDistrict.hindi,
                              ),
                              const SizedBox(height: 16),
                              CustomTextField(
                                hintText: "",
                                hintTextSize: 16,
                                initialValue: '',
                                onChanged: (value) {
                                  address.state = value;
                                },
                                onSaved: () {},
                                validator: () {},
                                labelText: (_language)
                                    ? StringValues.state.english
                                    : StringValues.state.hindi,
                              ),
                              const SizedBox(height: 16),
                              CustomTextField(
                                hintText: "",
                                hintTextSize: 16,
                                initialValue: '',
                                onChanged: (value) {
                                  address.pincode = value;
                                },
                                onSaved: () {},
                                validator: () {},
                                labelText: (_language)
                                    ? StringValues.pincode.english
                                    : StringValues.pincode.hindi,
                              ),
                              const SizedBox(height: 32),
                              CustomButton(
                                  postIconSize: 20,
                                  postIcon: Icons.arrow_forward,
                                  visiblepostIcon: false,
                                  labelText: (_language)
                                      ? StringValues.proceed.english
                                      : StringValues.proceed.hindi,
                                  containerColor: Styles.redColor,
                                  onTap: () {
                                    widget.booking.address = address;
                                    _routeToTimeSlotPage();
                                  })
                            ])))
                : const Center(
                    child: CircularProgressIndicator(
                      color: Styles.redColor,
                    ),
                  )));
  }
}

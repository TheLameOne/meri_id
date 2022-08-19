import 'dart:async';

import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:meri_id/presentation/custom/CustomButton.dart';
import 'package:meri_id/presentation/custom/CustomLocation.dart';
import 'package:meri_id/presentation/custom/CustomTextField.dart';
import 'package:meri_id/presentation/features/ChooseTimeSlot.dart';
import 'package:meri_id/services/widgets/CustomText.dart';
import 'package:meri_id/utils/styles.dart';

import '../../utils/global.dart';
import '../../utils/strings.dart';

class ChooseAddress extends StatefulWidget {
  static const String routeNamed = 'choose Address';
  const ChooseAddress({Key? key}) : super(key: key);

  @override
  State<ChooseAddress> createState() => _ChooseAddressState();
}

class _ChooseAddressState extends State<ChooseAddress> {
  bool _language = true;
  @override
  void initState() {
    super.initState();
    _parent();
  }

  _parent() async {
    await _languageFunction();
    _getUserLocation();
  }

  _languageFunction() async {
    bool val = await checkLanguage();
    _language = val;
  }

  double? latitude;
  double? longitude;

  _routeToTimeSlotPage() {
    Navigator.pushNamed(context, ChooseTimeSlot.routeNamed);
  }

  _getUserLocation() async {
    Location location = Location();
    final _locationData = await location.getLocation();
    setState(() {
      latitude = _locationData.latitude;
      longitude = _locationData.longitude;
    });
  }

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
                              CustomTextField(
                                hintText: "",
                                hintTextSize: 16,
                                initialValue: '',
                                onSaved: () {},
                                onChanged: () {},
                                validator: () {},
                                labelText: (_language)
                                    ? StringValues.chooseYourLocation.english
                                    : StringValues.chooseYourLocation.hindi,
                              ),
                              const SizedBox(height: 16),
                              Container(
                                  height: 500,
                                  child: CustomLocation(
                                      lat: latitude!, long: longitude!)),
                              const SizedBox(height: 16),
                              CustomTextField(
                                hintText: "",
                                hintTextSize: 16,
                                initialValue: '',
                                onChanged: () {},
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
                                onChanged: () {},
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
                                onChanged: () {},
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
                                onChanged: () {},
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
                                onChanged: () {},
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

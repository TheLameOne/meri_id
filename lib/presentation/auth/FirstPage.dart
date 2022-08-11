import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meri_id/presentation/auth/PhoneNumber.dart';
import 'package:meri_id/presentation/custom/CustomButton.dart';
import 'package:meri_id/services/widgets/CustomText.dart';
import 'package:meri_id/utils/global.dart';
import 'package:meri_id/utils/styles.dart';
import '../custom/CustomScaffold.dart';

class FirstPage extends StatefulWidget {
  static const String routeNamed = "FirstPage";

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {

  bool _showFingerPrintButton = true;
  bool _isTimer = true;
  bool _language = true;

  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    var duration = const Duration(seconds: 2);
    Timer(duration, _checkLocalStorage);
  }

  _checkLocalStorage() async {
    String? value = await preferenceService.getUID();
    String? lang = await preferenceService.getLanguage();
    setState(() {
      if (value == null || value == "") {
        _showFingerPrintButton = false;
      } else {
        _showFingerPrintButton = true;
      }
      if (lang == 'hindi') _language = false;
      _isTimer = false;
    });
  }

  route() {
    Navigator.popAndPushNamed(context, PhoneNumber.routeNamed);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const SizedBox(height: 20),
              Column(
                children: [
                  Image.asset(
                    Styles.STATIC_LOGO_IMAGE,
                    height: 200,
                    width: 200,
                  ),
                  CustomText.xLargeText("मेरी ID"),
                ],
              ),
              SizedBox(height: (_showFingerPrintButton) ? 120 : 80),
              Column(
                children: [
                  Padding(
                      padding:
                          (!_isTimer && _showFingerPrintButton)
                              ? const EdgeInsets.all(0)
                              : const EdgeInsets.all(0),
                      child: (!_isTimer && _showFingerPrintButton)
                          ? CustomButton(
                              postIcon: Icons.arrow_forward_ios,
                              visiblepostIcon: false,
                              labelText: (_language)
                                  ? "Finger Print"
                                  : "finger print hindi",
                              containerColor: Styles.redColor,
                              onTap: () {})
                          : Container()),
                  Padding(
                      padding: const EdgeInsets.only(top: 32),
                      child: (_isTimer == false)
                          ? CustomButton(
                              postIcon: Icons.arrow_forward_ios,
                              visiblepostIcon: false,
                              labelText: (_language)
                                  ? "Sign in by mobile number"
                                  : "Sign in by mobile number hindi",
                              containerColor: Styles.redColor,
                              onTap: () {
                                route();
                              })
                          : Container()),
                  const SizedBox(height: 20),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

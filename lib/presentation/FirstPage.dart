import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meri_id/presentation/LocationPage.dart';
import 'package:meri_id/presentation/PhoneNumber.dart';
import 'package:meri_id/presentation/otp.dart';
import 'package:meri_id/presentation/splashPage.dart';

import 'package:meri_id/utils/styles.dart';

import '../utils/strings.dart';
import 'custom/CustomScaffold.dart';

class FirstPage extends StatefulWidget {
  static const String routeNamed = "FirstPage";

  @override
  State<FirstPage>createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {

   @override
  void initState() {
    super.initState();
    startTime();
  }
  startTime() async {
  var duration = new Duration(seconds: 3);
  return Timer(duration, route);
}
route() {
  Navigator.popAndPushNamed(context, Location.routeNamed);
}
  @override
  Widget build(BuildContext context) {
    return    
    CustomScaffold(
            body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            StringValues.LOGO_IMAGE,
            height: 200,
            width: 200,
          ),
          const Text(
            "मेरी ID",
            style: TextStyle(
              fontSize: 35,
            ),
          )
        ],
      ),
      ),
      );
  }
}

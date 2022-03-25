import 'dart:async';
import 'package:flutter/material.dart';
import 'package:meri_id/main.dart';
import 'package:meri_id/utils/strings.dart';

import 'homepage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 2),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const MyHomePage(
            title: 'Meri ID',
          ),
        ),
      ),
    );
  }
  //_navigatetohome();

  //_navigatetohome() async {
  //  await Future.delayed(const Duration(seconds: 2), () {});
  //  Navigator.pushReplacement(
  //      context, MaterialPageRoute(builder: (context) => const MyApp()));
  //}

  //Timer(const Duration(seconds: 5), () {
  //Navigator.of(context).pop();
  //Navigator.of(context).push();
  // Routing
  //  (MaterialPageRoute(builder: (BuildContext context) => const MyApp()));
  //});
  //}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
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
    )));
  }
}

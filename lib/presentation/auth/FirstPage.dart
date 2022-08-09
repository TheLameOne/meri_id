import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meri_id/presentation/auth/PhoneNumber.dart';
import 'package:meri_id/presentation/custom/CustomButton.dart';
import 'package:meri_id/services/widgets/CustomTextStyles.dart';
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
    setState(() {
      if (value == null || value == "") {
        _showFingerPrintButton = false;
      } else {
        _showFingerPrintButton = true;
      }
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(height: 20),
            Column(
              children: [
                Image.network(
                  Styles.LOGO_IMAGE,
                  height: 160,
                  width: 160,
                ),
                  Text("मेरी ID" , style: CustomTextStyles.textStyleHigh()),
              ],
            ),
            SizedBox(height: (_showFingerPrintButton) ? 120 : 80),

            Column(
              children: [
                Padding(
                    padding: (!_isTimer && _showFingerPrintButton)
                        ? const EdgeInsets.all(32)
                        : const EdgeInsets.all(0),
                    child: (!_isTimer && _showFingerPrintButton)
                        ? CustomButton(
                            postIcon: Icons.arrow_forward_ios,
                            visiblepostIcon: false,
                            labelText: "Finger Print",
                            containerColor: Styles.redColor,
                            onTap: () {})
                        : Container()),

                  Padding(
                padding: (!_isTimer) 
                    ? const EdgeInsets.symmetric(horizontal: 32)
                    : const EdgeInsets.all(0),
                child: (_isTimer == false)
                    ? CustomButton(
                        postIcon: Icons.arrow_forward_ios,
                        visiblepostIcon: false,
                        labelText: "Login By Number",
                        containerColor: Styles.redColor,
                        onTap: () {})
                    : Container()),
                const SizedBox(height: 20),     
              ],
            ),
          
          ],
        ),
      ),
    );
  }
}

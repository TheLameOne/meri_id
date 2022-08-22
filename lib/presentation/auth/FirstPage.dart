import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meri_id/presentation/SplashPage.dart';
import 'package:meri_id/presentation/auth/PhoneNumber.dart';
import 'package:meri_id/presentation/custom/CustomButton.dart';
import 'package:meri_id/presentation/features/SvgScreen.dart';
import 'package:meri_id/presentation/kyc/AadharPage.dart';
import 'package:meri_id/presentation/kyc/OtherDocumentPage.dart';
import 'package:meri_id/presentation/kyc/PanPage.dart';
import 'package:meri_id/presentation/kyc/VideoPage.dart';
import 'package:meri_id/services/widgets/CustomText.dart';
import 'package:meri_id/utils/global.dart';
import 'package:meri_id/utils/styles.dart';
import '../../services/LocalAuthApi.dart';
import '../../utils/strings.dart';
import '../custom/CustomScaffold.dart';
import '../kyc/KycStepper.dart';

class FirstPage extends StatefulWidget {
  static const String routeNamed = "FirstPage";

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  bool _showFingerPrintButton = true;
  bool _isTimer = true;
  bool _language = true;
  bool isLoading = false;

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

  pageRouting(String state ,BuildContext c)
  {
      switch(state)
      {
        case "kyc" : Navigator.popAndPushNamed(context, KycStepper.routeNamed);break;
        case "pan" : Navigator.popAndPushNamed(context, PANPage.routeNamed);break;
        case "other" : Navigator.popAndPushNamed(context, OtherDocumentPage.routeNamed);break;
        case "aadhar" : Navigator.popAndPushNamed(context, AadharPage.routeNamed);break;
        case "video" : Navigator.popAndPushNamed(context, VideoPage.routeNamed);break;
        case "pending" : Navigator.popAndPushNamed(context, SvgScreen.routeNamed);break;
        case "active" : Navigator.popAndPushNamed(context, SplashPage.routeNamed);break;
        case "" : errorToast("Please Try Againg", c);break;
        default: errorToast("Please Try Againg", c);break;
      }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: SingleChildScrollView(
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
                SizedBox(height: (_showFingerPrintButton) ? 200 : 280),
                Column(
                  children: [
                    Padding(
                        padding: (!_isTimer && _showFingerPrintButton)
                            ? const EdgeInsets.all(0)
                            : const EdgeInsets.all(0),
                        child: (!_isTimer && _showFingerPrintButton)
                            ? CustomButton(
                                isLoading: isLoading,
                                postIcon: Icons.arrow_forward_ios,
                                visiblepostIcon: false,
                                labelText: (_language)
                                    ? StringValues.fingerprint.english
                                    : StringValues.fingerprint.hindi,
                                containerColor: Styles.redColor,
                                onTap: () async {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  final isAuthenticated =
                                      await LocalAuthApi.authenticate();
                                  if (isAuthenticated) {
                                    String state = await apiService.currentStatus();
                                    pageRouting(state,context);
                                  } else {
                                    errorToast("Please Try Again", context);
                                  }
                                  setState(() {
                                    isLoading = false;
                                  });
                                })
                            : Container()),
                    Padding(
                        padding: const EdgeInsets.only(top: 32),
                        child: (_isTimer == false)
                            ? CustomButton(
                                postIcon: Icons.arrow_forward_ios,
                                visiblepostIcon: false,
                                labelText: (_language)
                                    ? StringValues.loginByMobileNumber.english
                                    : StringValues.loginByMobileNumber.hindi,
                                containerColor: Styles.redColor,
                                onTap: () {
                                  route();
                                })
                            : Container()),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:meri_id/presentation/auth/PhoneNumber.dart';
import 'package:meri_id/presentation/custom/CustomButton.dart';
import 'package:meri_id/presentation/custom/CustomIcon.dart';
import 'package:meri_id/presentation/custom/CustomScaffold.dart';
import 'package:meri_id/presentation/custom/CustomTextField.dart';
import 'package:meri_id/presentation/kyc/KycStepper.dart';
import 'package:meri_id/presentation/splashPage.dart';
import 'package:meri_id/services/widgets/CustomText.dart';
import 'package:meri_id/utils/styles.dart';

import '../../utils/global.dart';
import '../../utils/strings.dart';

class OTP extends StatefulWidget {
  static const String routeNamed = 'OTP';
  @override
  State<OTP> createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  bool _language = true;
  void initState() {
    super.initState();
    _parent();
  }

  _parent() async {
    await _languageFunction();
  }

  _languageFunction() async {
    bool val = await checkLanguage();
    setState(() {
      _language = val;
    });
  }

  _routeToSplashPage() {
    Navigator.popAndPushNamed(context, SplashPage.routeNamed);
  }

  _routeToKycStepper() {
    Navigator.popAndPushNamed(context, KycStepper.routeNamed);
  }

  _routeToPhoneNumber() {
    Navigator.pushNamed(context, PhoneNumber.routeNamed);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomIcon(
                height: 120,
                width: 120,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                hintText: "",
                hintTextSize: 16,
                initialValue: '',
                onChanged: () {},
                onSaved: () {},
                validator: () {},
                labelText: (_language)
                    ? StringValues.enterOTP.english
                    : StringValues.enterOTP.hindi,
              ),
              const SizedBox(height: 32),
              CustomButton(
                  postIcon: Icons.arrow_forward_ios,
                  visiblepostIcon: false,
                  labelText: (_language)
                      ? StringValues.submit.english
                      : StringValues.submit.hindi,
                  onTap: () {
                    _routeToKycStepper();
                  },
                  containerColor: Styles.redColor),
              const SizedBox(
                height: 16,
              ),
              InkWell(
                child: CustomText.mediumText((_language)
                    ? StringValues.enterNumberAgain.english
                    : StringValues.enterNumberAgain.hindi),
                onTap: (() => _routeToPhoneNumber()),
              )
            ],
          ),
        ),
      ),
    );
  }
}

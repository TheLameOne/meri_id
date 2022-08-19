import 'package:flutter/material.dart';
import 'package:meri_id/presentation/custom/CustomButton.dart';
import 'package:meri_id/presentation/custom/CustomIcon.dart';
import 'package:meri_id/presentation/custom/CustomScaffold.dart';
import 'package:meri_id/presentation/custom/CustomTextField.dart';
import 'package:meri_id/presentation/auth/otp.dart';
import 'package:meri_id/utils/styles.dart';

import '../../utils/global.dart';
import '../../utils/strings.dart';

class PhoneNumber extends StatefulWidget {
  static const String routeNamed = 'PhoneNumber';
  @override
  State<PhoneNumber> createState() => _PhoneNumberState();
}

class _PhoneNumberState extends State<PhoneNumber> {
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

  _routeToOtp() {
    Navigator.pushNamed(context, OTP.routeNamed);
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
                    ? StringValues.enterPhoneNumber.english
                    : StringValues.enterPhoneNumber.hindi,
              ),
              const SizedBox(height: 32),
              CustomButton(
                postIcon: Icons.arrow_forward_ios,
                visiblepostIcon: false,
                labelText: (_language)
                    ? StringValues.getOTP.english
                    : StringValues.getOTP.hindi,
                onTap: _routeToOtp,
                containerColor: Styles.redColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}

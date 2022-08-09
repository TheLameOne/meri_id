import 'package:flutter/material.dart';
import 'package:meri_id/presentation/custom/CustomButton.dart';
import 'package:meri_id/presentation/custom/CustomIcon.dart';
import 'package:meri_id/presentation/custom/CustomScaffold.dart';
import 'package:meri_id/presentation/custom/CustomTextField.dart';
import 'package:meri_id/presentation/splashPage.dart';

class OTP extends StatefulWidget {
  static const String routeNamed = 'OTP';
  @override
  State<OTP> createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  _routeToSplashPage() {
    Navigator.pushNamed(context, SplashPage.routeNamed);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomIcon(
              height: 100,
              width: 100,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextField(
              hintText: "Enter OTP",
              hintTextSize: 16,
              initialValue: '',
              onChanged: () {},
              onSaved: () {},
              validator: () {},
              labelText: 'Enter OTP',
            ),
            Padding(
              padding: const EdgeInsets.all(32),
              child: CustomButton(
                  postIcon: Icons.arrow_forward_ios,
                  visiblepostIcon: true,
                  labelText: "OTP ",
                  onTap: () {
                    _routeToSplashPage();
                  }),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:meri_id/presentation/custom/CustomButton.dart';
import 'package:meri_id/presentation/custom/CustomIcon.dart';
import 'package:meri_id/presentation/custom/CustomScaffold.dart';
import 'package:meri_id/presentation/custom/CustomTextField.dart';
import 'package:meri_id/presentation/features/otp.dart';

class PhoneNumber extends StatefulWidget {
  static const String routeNamed = 'PhoneNumber';
  @override
  State<PhoneNumber> createState() => _PhoneNumberState();
}

class _PhoneNumberState extends State<PhoneNumber> {
  _routeToOtp() {
    Navigator.pushNamed(context, OTP.routeNamed);
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
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              hintText: "Enter Phone Number",
              hintTextSize: 16,
              initialValue: '',
              onChanged: () {},
              onSaved: () {},
              validator: () {},
              labelText: 'Enter Phone Number',
            ),
            Padding(
                padding: const EdgeInsets.all(32),
                child: CustomButton(
                    postIcon: Icons.arrow_forward_ios,
                    visiblepostIcon: true,
                    labelText: "GET OTP ",
                    onTap: _routeToOtp))
          ],
        ),
      ),
    );
  }
}

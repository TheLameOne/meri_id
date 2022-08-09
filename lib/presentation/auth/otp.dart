import 'package:flutter/material.dart';
import 'package:meri_id/presentation/KYC/PanPage.dart';
import 'package:meri_id/presentation/auth/PhoneNumber.dart';
import 'package:meri_id/presentation/custom/CustomButton.dart';
import 'package:meri_id/presentation/custom/CustomIcon.dart';
import 'package:meri_id/presentation/custom/CustomScaffold.dart';
import 'package:meri_id/presentation/custom/CustomTextField.dart';
import 'package:meri_id/presentation/splashPage.dart';
import 'package:meri_id/services/widgets/CustomText.dart';
import 'package:meri_id/utils/styles.dart';

class OTP extends StatefulWidget {
  static const String routeNamed = 'OTP';
  @override
  State<OTP> createState() => _OTPState();
}

class _OTPState extends State<OTP> {

  _routeToSplashPage() {
    Navigator.pushNamed(context, SplashPage.routeNamed);
  }

    _routeToPhoneNumber() {
    Navigator.pushNamed(context, PhoneNumber.routeNamed);
  }

      _routeToPanpage() {
    Navigator.pushNamed(context, PANPage.routeNamed);
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
                labelText: "Enter OTP",
              ),
              const SizedBox(height :32),
              CustomButton(
                    postIcon: Icons.arrow_forward_ios,
                    visiblepostIcon: false,
                    labelText: "Submit",
                    onTap: () {
                      _routeToPanpage();
                    },
                    containerColor: Styles.redColor
                    ), 
                    const SizedBox(height: 16,),
           InkWell(
             child:  CustomText.mediumText("Enter Number Again"),
             onTap: (() => _routeToPhoneNumber()),
           )
            ],
          ),
        ),
      ),
    );
  }
}

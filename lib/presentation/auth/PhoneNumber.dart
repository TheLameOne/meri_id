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
String phoneNumber = "";
  bool isButtonLoading = false;

  _routeToOtp(BuildContext c) async {
    setState(() {
      isButtonLoading = true;
    });
    if (validatePhone(phoneNumber) == null) {
      bool res = await apiService.getOtp(phoneNumber);
      if(res) 
      {
        Navigator.push(context ,
            MaterialPageRoute
            (builder: (context) => OTP(phoneNumber: phoneNumber)
        ));
      }
       else {
             errorToast("Oops!! please Connect With Admin", c);
      }
    }
    else {
      errorToast("please enter valid phone Number", c);
    }
        setState(() {
              isButtonLoading = false;
            });
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
                  initialValue: phoneNumber,
                  onSaved: () {},
                  onChanged: (value) {
                    phoneNumber = value!;
                  },
                  validator: () {},
                  labelText: StringValues.enterPhoneNumber.english),
              const SizedBox(height: 32),
              CustomButton(
                isLoading: isButtonLoading,
                postIcon: Icons.arrow_forward_ios,
                visiblepostIcon: false,
                labelText: StringValues.getOTP.english,
                onTap: () {
                  _routeToOtp(context);
                },
                containerColor: Styles.redColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}

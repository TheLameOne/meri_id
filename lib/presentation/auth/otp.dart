import 'package:flutter/material.dart';
import 'package:meri_id/presentation/auth/PhoneNumber.dart';
import 'package:meri_id/presentation/custom/CustomButton.dart';
import 'package:meri_id/presentation/custom/CustomIcon.dart';
import 'package:meri_id/presentation/custom/CustomScaffold.dart';
import 'package:meri_id/presentation/custom/CustomTextField.dart';
import 'package:meri_id/presentation/kyc/SvgScreen.dart';
import 'package:meri_id/presentation/kyc/AadharPage.dart';
import 'package:meri_id/presentation/kyc/KycStepper.dart';
import 'package:meri_id/presentation/kyc/OtherDocumentPage.dart';
import 'package:meri_id/presentation/kyc/PanPage.dart';
import 'package:meri_id/presentation/kyc/VideoPage.dart';
import 'package:meri_id/presentation/splashPage.dart';
import 'package:meri_id/services/widgets/CustomText.dart';
import 'package:meri_id/utils/styles.dart';

import '../../utils/global.dart';
import '../../utils/strings.dart';

class OTP extends StatefulWidget {
  final String phoneNumber;
  OTP({required this.phoneNumber});
  @override
  State<OTP> createState() => _OTPState();
}

class _OTPState extends State<OTP> {
 _routeToPhoneNumber() {
    Navigator.pushNamed(context, PhoneNumber.routeNamed);
  }

  bool isButtonLoading = false;
  String otp = "";



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


  _routeToSplashPage(BuildContext c) async {
    setState(() {
      isButtonLoading = true;
    });
    if (validateOtp(otp) == null) {
      bool res = await apiService.login(widget.phoneNumber , otp);
      if (res) {
             String state = await apiService.currentStatus();
              pageRouting(state,context);
              
      } else {
        errorToast("Oops!! server down", c);
      }
    } else {
      errorToast("please enter valid Otp", c);
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
                  initialValue: '',
                  onSaved: () {},
                  onChanged: (value) {
                    otp = value!;
                  },
                  validator: () {},
                  labelText: StringValues.getOTP.english),
              const SizedBox(height: 32),
              CustomButton(
                  postIcon: Icons.arrow_forward_ios,
                  visiblepostIcon: false,
                  labelText: StringValues.submit.english,
                  isLoading: isButtonLoading,
                  onTap: () async{
                    await _routeToSplashPage(context);
                  },
                  containerColor: Styles.redColor),
              const SizedBox(
                height: 16,
              ),
              InkWell(
                  onTap: (() => _routeToPhoneNumber()),
                  child: CustomText.mediumText(
                      StringValues.enterNumberAgain.english))
            ],
          ),
        ),
      ),
    );
  }
}

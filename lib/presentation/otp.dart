import 'package:flutter/material.dart';
import 'package:meri_id/presentation/custom/text_icon_card.dart';
import 'package:meri_id/presentation/custom/textfield.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({Key? key}) : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance =
        ScreenUtil(height: 640, width: 320, allowFontScaling: false)
          ..init(context);
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Number TextField
            CustomTextField(
                labelText: "adsd",
                hintText: "ddf",
                initialValue: "",
                onSaved: () {},
                onChanged: () {},
                validator: () {}),
            //Submit Button
            Text("Submit"),
            //OTP Text Field
            Text("Enter OTP"),
          ],
        ),
      ),
    );
  }
}

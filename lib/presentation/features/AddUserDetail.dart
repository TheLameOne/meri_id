import 'package:flutter/material.dart';
import 'package:meri_id/presentation/custom/CustomButton.dart';
import 'package:meri_id/presentation/custom/CustomIcon.dart';
import 'package:meri_id/presentation/custom/CustomScaffold.dart';
import 'package:meri_id/presentation/custom/CustomTextField.dart';
import 'package:meri_id/utils/styles.dart';

import '../../utils/global.dart';

class AdduserDetails extends StatefulWidget {
  const AdduserDetails({Key? key}) : super(key: key);

  @override
  State<AdduserDetails> createState() => _AdduserDetailsState();
}

class _AdduserDetailsState extends State<AdduserDetails> {
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

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 60,
            ),
            CustomTextField(
              hintText: "eg. Harsh",
              hintTextSize: 16,
              initialValue: '',
              onChanged: (value) {},
              onSaved: () {},
              validator: () {},
              labelText: 'Enter Name',
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              hintText: "1234-5678-1234-5678",
              hintTextSize: 16,
              initialValue: '',
              onChanged: (value) {},
              onSaved: () {},
              validator: () {},
              labelText: 'Enter Aadhar Number',
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              hintText: "Email",
              hintTextSize: 16,
              initialValue: '',
              onChanged: (value) {},
              onSaved: () {},
              validator: () {},
              labelText: 'Enter Email-ID',
            ),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: CustomButton(
                  postIcon: Icons.arrow_forward_ios,
                  visiblepostIcon: true,
                  labelText: "Submit ",
                  onTap: () {
                    //_routeToSplashPage()
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:meri_id/presentation/custom/CustomButton.dart';

import 'package:meri_id/presentation/custom/CustomScaffold.dart';
import 'package:meri_id/presentation/kyc/OtherDocumentPage.dart';
import 'package:meri_id/presentation/kyc/PanPage.dart';
import 'package:meri_id/services/widgets/CustomText.dart';
import 'package:meri_id/utils/styles.dart';

import '../../utils/global.dart';
import '../../utils/strings.dart';

class KycStepper extends StatefulWidget {
  static const String routeNamed = 'kycStepper';

  @override
  State<KycStepper> createState() => _KycStepperState();
}

class _KycStepperState extends State<KycStepper> {
  bool hide = true;
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

  _routeToPanPage() {
    Navigator.popAndPushNamed(context, PANPage.routeNamed);
  }

  _routeToOtherDocumentPage() {
    Navigator.popAndPushNamed(context, OtherDocumentPage.routeNamed);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 32,
            ),
            CustomText.xLargeText(
              (_language)
                  ? StringValues.chooseKYCJourney.english
                  : StringValues.chooseKYCJourney.hindi,
            ),
            const SizedBox(height: 64),
            CustomText.xLargeText(
              (_language)
                  ? StringValues.KYCJourney1.english
                  : StringValues.KYCJourney1.hindi,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                CustomText.mediumText("1. "),
                CustomText.mediumText(
                  (_language)
                      ? StringValues.uploadPANCard.english
                      : StringValues.uploadPANCard.hindi,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                CustomText.mediumText("2. "),
                CustomText.mediumText(
                  (_language)
                      ? StringValues.uploadAadhar.english
                      : StringValues.uploadAadhar.hindi,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                CustomText.mediumText("3. "),
                CustomText.mediumText(
                  (_language)
                      ? StringValues.videoKYC.english
                      : StringValues.videoKYC.hindi,
                ),
              ],
            ),
            const SizedBox(height: 16),
            CustomButton(
              postIcon: Icons.arrow_forward_ios,
              labelText: (_language)
                  ? StringValues.proceed.english
                  : StringValues.proceed.hindi,
              onTap: () {
                _routeToPanPage();
              },
              containerColor: Styles.redColor,
            ),
            const SizedBox(height: 64),
            CustomText.xLargeText(
              (_language)
                  ? StringValues.KYCJourney2.english
                  : StringValues.KYCJourney2.hindi,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                CustomText.mediumText("1. "),
                CustomText.mediumText(
                  (_language)
                      ? StringValues.uploadOtherDocuments.english
                      : StringValues.uploadOtherDocuments.hindi,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                CustomText.mediumText("2. "),
                CustomText.mediumText(
                  (_language)
                      ? StringValues.videoKYC.english
                      : StringValues.videoKYC.hindi,
                ),
              ],
            ),
            const SizedBox(height: 16),
            CustomButton(
              postIcon: Icons.arrow_forward_ios,
              labelText: (_language)
                  ? StringValues.proceed.english
                  : StringValues.proceed.hindi,
              onTap: () {
                _routeToOtherDocumentPage();
              },
              containerColor: Styles.redColor,
            ),
          ],
        ),
      ),
    ));
  }
}

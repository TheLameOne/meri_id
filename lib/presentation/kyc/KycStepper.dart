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
  bool isPanLoading = false;
  bool isOtherLoading = false;
  
  _routeToPanPage() async {
      bool val = await apiService.statusUpdate("pan");
        if (val)
        Navigator.popAndPushNamed(context, PANPage.routeNamed);
        else
        errorToast("!OOps Please Try Again", context);
  }

  _routeToOtherDocumentPage() async {
    bool val = await apiService.statusUpdate("other");
    if (val)
      Navigator.popAndPushNamed(context, OtherDocumentPage.routeNamed);
    else
      errorToast("!OOps Please Try Again", context);
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
            CustomText.xLargeText(StringValues.chooseKYCJourney.english),
            const SizedBox(height: 64),
            CustomText.xLargeText(StringValues.KYCJourney1.english),
            const SizedBox(height: 16),
            Row(
              children: [
                CustomText.mediumText("1. "),
                CustomText.mediumText(StringValues.uploadPANCard.english),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                CustomText.mediumText("2. "),
                CustomText.mediumText(StringValues.uploadAadhar.english),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                CustomText.mediumText("3. "),
                CustomText.mediumText(StringValues.videoKYC.english),
              ],
            ),
            const SizedBox(height: 16),
            CustomButton(
              isLoading: isPanLoading,
              postIcon: Icons.arrow_forward_ios,
              labelText: StringValues.proceed.english,
              onTap: () async {
                setState(() {
                  isPanLoading = true;
                });
                await _routeToPanPage();
                setState(() {
                  isPanLoading = false;
                });
              },
              containerColor: Styles.redColor,
            ),
            const SizedBox(height: 64),
            CustomText.xLargeText(StringValues.KYCJourney2.english),
            const SizedBox(height: 16),
            Row(
              children: [
                CustomText.mediumText("1. "),
                CustomText.mediumText(
                    StringValues.uploadOtherDocuments.english),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                CustomText.mediumText("2. "),
                CustomText.mediumText(StringValues.videoKYC.english),
              ],
            ),
            const SizedBox(height: 16),
            CustomButton(
              isLoading: isOtherLoading,
              postIcon: Icons.arrow_forward_ios,
              labelText: StringValues.proceed.english,
              onTap: () async {
                setState(() {
                  isOtherLoading = true;
                });
                await _routeToOtherDocumentPage();
                setState(() {
                  isOtherLoading = false;
                });
              },
              containerColor: Styles.redColor,
            ),
          ],
        ),
      ),
    ));
  }
}

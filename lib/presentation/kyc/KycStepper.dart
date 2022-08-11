import 'package:flutter/material.dart';
import 'package:meri_id/presentation/custom/CustomButton.dart';

import 'package:meri_id/presentation/custom/CustomScaffold.dart';
import 'package:meri_id/presentation/kyc/OtherDocumentPage.dart';
import 'package:meri_id/presentation/kyc/PanPage.dart';
import 'package:meri_id/services/widgets/CustomText.dart';
import 'package:meri_id/utils/styles.dart';

class KycStepper extends StatefulWidget {
  static const String routeNamed = 'kycStepper';

  @override
  State<KycStepper> createState() => _KycStepperState();
}

class _KycStepperState extends State<KycStepper> {
  bool hide = true;

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
            CustomText.xLargeText("Choose Kyc Journey"),
            const SizedBox(height: 64),
            CustomText.xLargeText("Kyc Journey 1"),
            const SizedBox(height: 16),
            CustomText.mediumText("1. Upload PanCard"),
            const SizedBox(height: 16),
            CustomText.mediumText("2. Upload AdharCard"),
            const SizedBox(height: 16),
            CustomText.mediumText("3. Video Kyc"),
            const SizedBox(height: 16),
            CustomButton(
              postIcon: Icons.arrow_forward_ios,
              labelText: "Proceed",
              onTap: () {
                _routeToPanPage();
              },
              containerColor: Styles.redColor,
            ),
            const SizedBox(height: 64),
            CustomText.xLargeText("Kyc Journey 2"),
            const SizedBox(height: 16),
            CustomText.mediumText("1. Upload Other Document"),
            const SizedBox(height: 16),
            CustomText.mediumText("2. Video Kyc"),
            const SizedBox(height: 16),
            CustomButton(
              postIcon: Icons.arrow_forward_ios,
              labelText: "Proceed",
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

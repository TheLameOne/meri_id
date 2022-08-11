import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meri_id/presentation/SplashPage.dart';
import 'package:meri_id/presentation/custom/CustomButton.dart';
import 'package:meri_id/presentation/custom/CustomScaffold.dart';
import 'package:meri_id/utils/styles.dart';

class SvgScreen extends StatefulWidget {
  static const String routeNamed = 'svgScreen';
  const SvgScreen({Key? key}) : super(key: key);

  @override
  State<SvgScreen> createState() => _SvgScreenState();
}

class _SvgScreenState extends State<SvgScreen> {
  _routeToSplashPage() {
    Navigator.popAndPushNamed(context, SplashPage.routeNamed);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/images/pending.svg'),
              CustomButton(
                postIcon: Icons.arrow_forward_ios,
                labelText: "Check Kyc Status",
                onTap: () {
                  _routeToSplashPage();
                },
                containerColor: Styles.redColor,
              ),
              // CustomText.largeText("Your Kyc is in Pending  , Currently it is checking by ")
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meri_id/presentation/SplashPage.dart';
import 'package:meri_id/presentation/custom/CustomButton.dart';
import 'package:meri_id/presentation/custom/CustomScaffold.dart';
import 'package:meri_id/services/widgets/CustomText.dart';
import 'package:meri_id/utils/styles.dart';

import '../../utils/global.dart';
import '../../utils/strings.dart';

class SvgScreen extends StatefulWidget {
  static const String routeNamed = 'svgScreen';
  const SvgScreen({Key? key}) : super(key: key);

  @override
  State<SvgScreen> createState() => _SvgScreenState();
}

class _SvgScreenState extends State<SvgScreen> {
  bool _language = true;
  bool isLoading = false;
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                              height: 32,
                            ),
                              CustomText.xLargeText(
                          "Check VKyc",
                        ),
              SvgPicture.asset('assets/images/pending.svg'),
                  ],
                ),                   
              CustomButton(
                isLoading: isLoading,
                postIcon: Icons.arrow_forward_ios,
                labelText: (_language)
                    ? StringValues.checkKYCStatus.english
                    : StringValues.checkKYCStatus.hindi,
                onTap: () async {
                  setState(() {
                    isLoading = true;
                  });

                  String val = await apiService.currentStatus();
                  if (val == "pending")
                    successToast("Video Kyc is Still in progress", context);
                  else
                    Navigator.popAndPushNamed(context, SplashPage.routeNamed);
                  setState(() {
                    isLoading = false;
                  });
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

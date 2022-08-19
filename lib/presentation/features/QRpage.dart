import 'package:flutter/material.dart';
import 'package:meri_id/presentation/SplashPage.dart';
import 'package:meri_id/presentation/custom/CustomButton.dart';
import 'package:meri_id/services/widgets/CustomText.dart';
import 'package:meri_id/utils/global.dart';
import 'package:meri_id/utils/styles.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../utils/strings.dart';

class QRpage extends StatefulWidget {
  final String data;

  const QRpage({Key? key, required this.data}) : super(key: key);

  @override
  State<QRpage> createState() => _QRpageState();
}

class _QRpageState extends State<QRpage> {
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
    return SafeArea(
      child: Scaffold(
          backgroundColor: Styles.backgroundColor,
          body: Container(
              color: Styles.backgroundColor,
              child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText.largeText((_language)
                                ? StringValues.qrCodeofBooking.english
                                : StringValues.qrCodeofBooking.hindi),
                            const SizedBox(
                              height: 16,
                            ),
                            CustomText.mediumText((_language)
                                ? StringValues.bookingID.english
                                : StringValues.bookingID.hindi),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 32, vertical: 128),
                              child: QrImage(
                                data: (widget.data == null) ? "" : widget.data,
                                version: QrVersions.auto,
                                size: 320,
                              ),
                            ),
                          ],
                        ),
                        (currentPage == 1)
                            ? CustomButton(
                                postIconSize: 20,
                                postIcon: Icons.arrow_forward,
                                visiblepostIcon: false,
                                labelText: (_language)
                                    ? StringValues.goToHomePage.english
                                    : StringValues.goToHomePage.hindi,
                                containerColor: Styles.redColor,
                                onTap: () {
                                  currentPage = 0;
                                  Navigator.popAndPushNamed(
                                      context, SplashPage.routeNamed);
                                })
                            : CustomButton(
                                postIconSize: 20,
                                postIcon: Icons.arrow_forward,
                                visiblepostIcon: false,
                                labelText: (_language)
                                    ? StringValues.goBack.english
                                    : StringValues.goBack.hindi,
                                containerColor: Styles.redColor,
                                onTap: () {
                                  Navigator.pop(context);
                                })
                      ])))),
    );
  }
}

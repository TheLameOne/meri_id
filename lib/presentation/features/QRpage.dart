import 'package:flutter/material.dart';
import 'package:meri_id/presentation/SplashPage.dart';
import 'package:meri_id/presentation/custom/CustomButton.dart';
import 'package:meri_id/services/widgets/CustomText.dart';
import 'package:meri_id/utils/global.dart';
import 'package:meri_id/utils/styles.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRpage extends StatefulWidget {
  final String data;

  const QRpage({Key? key ,required this.data}) : super(key: key);

  @override
  State<QRpage> createState() => _QRpageState();
}

class _QRpageState extends State<QRpage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor:    Styles.backgroundColor,
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
                            CustomText.largeText("QR code of booking"),
                             const SizedBox(
                              height: 16,
                            ),
                            CustomText.mediumText("Booking id"),
                          
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 32 ,vertical: 128),
                              child: QrImage(
                                data: (widget.data == null) ? ""  : widget.data,
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
                                labelText: "Go To Home Page",
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
                                labelText: "Go Back",
                                containerColor: Styles.redColor,
                                onTap: () {
                                  currentPage = 0;
                                  Navigator.popAndPushNamed(
                                      context, SplashPage.routeNamed);
                                })
                      ])))),
    );
  }
}

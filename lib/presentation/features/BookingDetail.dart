import 'package:flutter/material.dart';
import 'package:meri_id/presentation/features/GoogleMapTracking.dart';
import 'package:meri_id/presentation/features/QRpage.dart';
import 'package:meri_id/services/widgets/CustomText.dart';
import 'package:meri_id/utils/styles.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../utils/global.dart';

class BookingDetail extends StatefulWidget {
  static const String routeNamed = 'booking detail';
  const BookingDetail({Key? key}) : super(key: key);

  @override
  State<BookingDetail> createState() => _BookingDetailState();
}

class _BookingDetailState extends State<BookingDetail> {
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
          appBar: AppBar(
            actions: [],
            backgroundColor: Styles.backgroundColor,
            foregroundColor: Styles.blackColor,
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText.xLargeText("Booking Details"),
                  const SizedBox(height: 16),
                  CustomText.mediumText("BOOK14254334"),
                  const SizedBox(height: 32),
                  CustomText.largeText("Booking"),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: Card(
                      elevation: 4,
                      shadowColor: Styles.grayColor,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          color: Styles.grayColor,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                CustomText.mediumText("1.Harsh Verma"),
                                CustomText.smallText("Aadhar Update"),
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Column(
                              children: [
                                CustomText.mediumText("2.Savagecarol"),
                                CustomText.smallText("Aadhar Update"),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  CustomText.largeText("Timing"),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: Card(
                      elevation: 4,
                      shadowColor: Styles.grayColor,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          color: Styles.grayColor,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText.smallText("2022-08-16"),
                            CustomText.smallText("5:00 pm to 6:00 pm"),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  CustomText.largeText("Address"),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: Card(
                      elevation: 4,
                      shadowColor: Styles.grayColor,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          color: Styles.grayColor,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText.smallText(
                                "Vignana Bharathi Institute of Technology,Aushapur, Ghatkesar, near HPCL, Hyderabad, Telangana 501301")
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  CustomText.largeText("Operator"),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: Card(
                      elevation: 4,
                      shadowColor: Styles.grayColor,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          color: Styles.grayColor,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText.smallText("Harsh Verma"),
                            CustomText.smallText("7451985966"),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const QRpage(data: "lets do it")),
                      );
                    },
                    icon: const Icon(
                      Icons.qr_code,
                      size: 28,
                    )),
                IconButton(
                    onPressed: () {
                      launchUrlString("tel:+91963852741");
                    },
                    icon: const Icon(Icons.call, size: 28)),
                IconButton(
                    onPressed: () {
                      Navigator.pushNamed(
                          context, GoogleMapTracking.routeNamed);
                    },
                    icon: const Icon(Icons.location_on, size: 28))
              ],
            ),
          )),
    );
  }
}

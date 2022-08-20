import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
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
            child: Container(
              color: Styles.backgroundColor,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 32, left: 32, right: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText.xLargeText("Booking Detail"),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomText.mediumText("BOOK9932562423"),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomText.largeText("Booking Info"),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomText.mediumText("1. Kartikeya Sharma"),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomText.smallText("Aadhar Enrollment"),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomText.mediumText('2. Janhvi Singh'),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomText.smallText("Aadhar Updation"),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomText.mediumText("3. Alankar Saxena"),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomText.smallText("Aadhar Updation"),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomText.largeText("Time Details"),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomText.mediumText("Date : 25-Aug-2022"),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomText.mediumText("Time : 4:00 to 5:00 pm"),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomText.largeText("Address Detail "),
                    const SizedBox(
                      height: 16,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomText.mediumText(
                        "Vignana Bharathi Institute of Technology,Aushapur, Ghatkesar, near HPCL, Hyderabad, Telangana 501301"),
                    const SizedBox(
                      height: 16,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomText.largeText("Operator Info"),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomText.mediumText("Harsh Verma"),
                    CustomText.mediumText("7451985966"),
                    const SizedBox(
                      height: 16,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                ),
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

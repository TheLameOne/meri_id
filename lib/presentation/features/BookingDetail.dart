import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:meri_id/presentation/features/GoogleMapTracking.dart';
import 'package:meri_id/presentation/features/QRpage.dart';
import 'package:meri_id/services/widgets/CustomText.dart';
import 'package:meri_id/utils/styles.dart';
import 'package:url_launcher/url_launcher_string.dart';

class BookingDetail extends StatefulWidget {
  static const String routeNamed = 'booking detail';
  const BookingDetail({Key? key}) : super(key: key);

  @override
  State<BookingDetail> createState() => _BookingDetailState();
}

class _BookingDetailState extends State<BookingDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  CustomText.mediumText("Booking Id - 12345"),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomText.largeText("Booking Info"),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomText.mediumText("1. klartikeya sharma"),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomText.smallText(
                      "reasone dfmndlkfmdslkfn  sdlfjnsldfmdslkfds ldsfmsdl"),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomText.mediumText('2. janhvi singh'),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomText.smallText(
                      "dslkkfndklsfndskf sdfnldksfnds ldfjdslfmdsl"),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomText.mediumText("3. Alankar saxena"),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomText.smallText(
                      "dsjnfkdsf dslkfmdslkfdlsf dsflmdslkfnmds lkfmdldsf"),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomText.largeText("Time Details"),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomText.mediumText("Date  02-Jan-2022"),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomText.mediumText("Time 16:00 to 17:00 pm"),
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
                      "57 , Moti enclave aurangabad mathura , 281006 , lat long"),
                  const SizedBox(
                    height: 16,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomText.largeText("operator Info"),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomText.mediumText("Hasrsh Verma"),
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
                           MaterialPageRoute(builder: (context) => const QRpage(data: "lets do it")),
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
                    Navigator.pushNamed(context, GoogleMapTracking.routeNamed);
                  },
                  icon: const Icon(Icons.location_on, size: 28))
            ],
          ),
        ));
  }
}

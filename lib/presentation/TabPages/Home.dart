import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart';
import 'package:meri_id/model/Book.dart';
import 'package:meri_id/presentation/custom/CustomCard.dart';
import 'package:meri_id/presentation/features/BookingDetail.dart';
import 'package:meri_id/presentation/features/GoogleMapTracking.dart';
import 'package:meri_id/services/widgets/CustomText.dart';
import 'package:meri_id/utils/styles.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../utils/global.dart';
import '../../utils/strings.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _language = true;
  bool isLoading = true;
  List<Book> ls = [];
  void initState() {
    super.initState();
    _parent();
  }

  _parent() async {
    ls = await apiService.getBooking();
    await _languageFunction();
    setState(() {
      isLoading = false;
    });
  }

  _languageFunction() async {
    bool val = await checkLanguage();
    setState(() {
      _language = val;
    });
  }

  _routoBookingDetail(Book book) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => BookingDetail(
                  book: book,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return (isLoading)
        ? const Center(
            child: CircularProgressIndicator(color: Styles.redColor),
          )
        : SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 32),
                      CustomText.xLargeText((_language)
                          ? StringValues.home.english
                          : StringValues.home.hindi),
                      const SizedBox(height: 32),
                                 (ls.length == 0)
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 64, horizontal: 16),
                              child:
                                  SvgPicture.asset("assets/images/empty.svg"))
                          : Container(),
                          
                      for (int i = 0; i < ls.length; i++)
                        CustomCard(
                          phoneNumber: ls[i].operator?.phoneNumber,
                          date: ls[i].slotDate,
                          time: ls[i].slotTime,
                          booking_id: ls[i].bookingId,
                          onTap: () {
                            _routoBookingDetail(ls[i]);
                          },
                          makeCall: () {
                            if (ls[i].operator?.phoneNumber == "")
                              errorToast("Operator will b assigned soon to you",
                                  context);
                            else
                              launchUrlString(
                                  "tel:+91${ls[i].operator?.phoneNumber}");
                          },
                        ),
           
                    ])),
          );
  }
}

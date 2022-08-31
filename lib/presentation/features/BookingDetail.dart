import 'package:flutter/material.dart';
import 'package:meri_id/model/Book.dart';
import 'package:meri_id/presentation/features/GoogleMapTracking.dart';
import 'package:meri_id/presentation/features/QRpage.dart';
import 'package:meri_id/services/widgets/CustomText.dart';
import 'package:meri_id/utils/styles.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../utils/global.dart';

class BookingDetail extends StatefulWidget {
  late Book book;
  BookingDetail({required this.book});

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
    print(widget.book.friendList);
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
                  CustomText.mediumText(widget.book.bookingId),
                  const SizedBox(height: 32),
                  CustomText.largeText("Booking"),
                  const SizedBox(height: 8),
                  Container(
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
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (int i = 0;
                                i < widget.book.friendList!.length;
                                i++)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText.mediumText(
                                      "${i + 1}. ${widget.book.friendList?[i].name}"),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  CustomText.smallText(
                                      "+91${widget.book.friendList?[i].phone_number}"),
                                  const SizedBox(
                                    height: 4,
                                  ),
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
                            CustomText.smallText(widget.book.slotDate),
                            CustomText.smallText(widget.book.slotTime),
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
                          children: [CustomText.smallText(widget.book.address)],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  (widget.book.operator?.name == "")
                      ? Container()
                      : CustomText.largeText("Operator"),
                  (widget.book.operator?.name == "")
                      ? Container()
                      : const SizedBox(height: 8),
                  (widget.book.operator?.name == "")
                      ? Container()
                      : SizedBox(
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
                                      widget.book.operator?.name ?? ""),
                                  CustomText.smallText(
                                      widget.book.operator?.phoneNumber ?? ""),
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
                                QRpage(data: widget.book.uuid)),
                      );
                    },
                    icon: const Icon(
                      Icons.qr_code,
                      size: 28,
                    )),
                IconButton(
                    onPressed: () {
                      if (widget.book.operator?.phoneNumber == "")
                        errorToast("operator will be appoint soon", context);
                      else
                        launchUrlString(
                            "tel:+91${widget.book.operator?.phoneNumber}");
                    },
                    icon: Icon(
                        (widget.book.operator?.name == "")
                            ? Icons.phone_disabled
                            : Icons.call,
                        size: 28)),
                IconButton(
                    onPressed: () {
                      if (widget.book.operator?.phoneNumber == "")
                        errorToast("operator will be appoint soon", context);
                      else
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => GoogleMapTracking(
                                    data: widget.book.uuid))));
                    },
                    icon: Icon(
                        (widget.book.operator?.name == "")
                            ? Icons.location_off
                            : Icons.location_on,
                        size: 28))
              ],
            ),
          )),
    );
  }
}

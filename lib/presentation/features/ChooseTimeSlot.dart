import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meri_id/model/Booking.dart';
import 'package:meri_id/model/Payment.dart';
import 'package:meri_id/presentation/custom/CustomButton.dart';
import 'package:meri_id/presentation/features/QRpage.dart';
import 'package:meri_id/services/widgets/CustomText.dart';
import 'package:meri_id/utils/styles.dart';
import 'package:intl/intl.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../utils/global.dart';
import '../../utils/strings.dart';

class ChooseTimeSlot extends StatefulWidget {
  late Booking booking;
  ChooseTimeSlot({required this.booking});

  @override
  State<ChooseTimeSlot> createState() => _ChooseTimeSlotState();
}

class _ChooseTimeSlotState extends State<ChooseTimeSlot> {
  bool loading = true;
  static const platform = MethodChannel("razorpay_flutter");
  late Razorpay _razorpay;

  bool _language = true;
  TextEditingController dateInput = TextEditingController();
  String? selectedValue = null;

  @override
  void initState() {
    dateInput.text = ""; //set the initial value of text field
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
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

  _routeToQRPage(data) {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => QRpage(data: data)),
    );
  }

  void openCheckout() async {
    var options = {
      'key': 'rzp_test_FfJrm8TZId9hTK',
      'amount': 5000,
      'name': 'Meri ID',
      'description': 'Aadhar Service',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {'contact': '7451985966', 'email': 'test@razorpay.com'},
      'external': {
        'wallets': ['paytm']
      }
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      errorToast("!oops some error has occured", context);
      debugPrint('Error: e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    print(
        'Success Response: ${response.paymentId} + ${response.orderId} + ${response.signature}');
    successToast("Payment Successful", context);
    widget.booking.payment = Payment(
        amount: 50.00, from_user: "${response.orderId}||${response.orderId}");
    try {
      String res = await apiService.createBooking(widget.booking);
      if (res != "")
        _routeToQRPage(res);
      else
        errorToast("!oops Some Error Occur Money will be refund", context);
    } catch (e) {
      print("---------->");
      print(e);
      errorToast("!oops Some Error Occur", context);
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print('Error Response: $response');
    errorToast("Payment could not be completed!", context);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print('External SDK Response: $response');
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  final List<String> items = [
    ('9:00 AM - 12:00 PM'),
    ('12:00 PM - 3:00 PM'),
    ('3:00 PM - 6:00 PM')
  ];

  Widget dropDownWidget() {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        isExpanded: true,
        hint: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const Icon(
                Icons.list,
                size: 28,
                color: Styles.blackColor,
              ),
              const SizedBox(
                width: 4,
              ),
              Expanded(
                child: Text(
                  "Choose Time Slot",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Styles.blackColor,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        items: items
            .map((item) => DropdownMenuItem<String>(
                value: item, child: CustomText.smallText(item)))
            .toList(),
        value: selectedValue,
        onChanged: (value) {
          setState(() {
            selectedValue = value as String;
          });
        },
        icon: const Icon(
          Icons.arrow_forward_ios,
          size: 28,
          color: Styles.blackColor,
        ),
        iconSize: 14,
        iconEnabledColor: Styles.grayColor,
        iconDisabledColor: Colors.grey,
        buttonPadding: const EdgeInsets.only(left: 14, right: 14),
        buttonDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(color: Colors.grey, blurRadius: 5, offset: Offset(2, 4))
            ]),
        buttonElevation: 2,
        itemHeight: 40,
        itemPadding: const EdgeInsets.only(left: 14, right: 14),
        dropdownPadding: const EdgeInsets.symmetric(horizontal: 0),
        dropdownDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(color: Colors.grey, blurRadius: 5, offset: Offset(2, 4))
            ]),
        dropdownElevation: 8,
        scrollbarRadius: const Radius.circular(10),
        offset: const Offset(-20, 0),
      ),
    );
  }

  bool _term = false;
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
          body: Container(
              color: Styles.backgroundColor,
              padding: const EdgeInsets.only(left: 32, right: 32, bottom: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      CustomText.xLargeText("Choose Time Slot"),
                      const SizedBox(
                        height: 16,
                      ),
                      TextField(
                          cursorColor: Styles.redColor,
                          controller: dateInput,
                          decoration: InputDecoration(
                            icon: Icon(Icons.calendar_today),
                            prefixIconColor: Styles.redColor,
                            fillColor: Styles.redColor,
                            labelText: (_language)
                                ? StringValues.enterDate.english
                                : StringValues.enterDate.hindi,
                            border: InputBorder.none,
                            labelStyle: GoogleFonts.montserrat(
                                textStyle: const TextStyle(
                                    fontSize: 16, color: Styles.blackColor)),
                            hintStyle: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                                  fontSize: 16, color: Styles.blackColor),
                            ),
                          ),
                          readOnly: true,
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime.now().add(
                                const Duration(days: 30),
                              ),
                              builder: (context, child) {
                                return Theme(
                                  child: child!,
                                  data: Theme.of(context).copyWith(
                                    colorScheme: ColorScheme.light(
                                      primary: Styles.redColor, // <-- SEE HERE
                                      onPrimary: Styles
                                          .backgroundColor, // <-- SEE HERE
                                      onSurface:
                                          Styles.blackColor, // <-- SEE HERE
                                    ),
                                    textButtonTheme: TextButtonThemeData(
                                      style: TextButton.styleFrom(
                                          primary: Styles
                                              .redColor // button text color
                                          ),
                                    ),
                                  ),
                                );
                              },
                            );

                            if (pickedDate != null) {
                              print(
                                  pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                              String formattedDate =
                                  DateFormat('yyyy-MM-dd').format(pickedDate);
                              print(
                                  formattedDate); //formatted date output using intl package =>  2021-03-16
                              setState(() {
                                dateInput.text =
                                    formattedDate; //set output date to TextField value.
                                widget.booking.slot_date =
                                    formattedDate.toString();
                              });
                            } else {}
                          }),
                      SizedBox(
                        height: 16,
                      ),
                      if (widget.booking.slot_date != null) dropDownWidget(),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: SizedBox(
                            height: 300,
                            child: SvgPicture.asset('assets/images/date.svg')),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText.smallText(
                              "I would prefer female operator"),
                          InkWell(
                            onTap: () {
                              setState(() {
                                if (widget.booking.preference == "male")
                                  widget.booking.preference = "female";
                                else
                                  widget.booking.preference = "male";
                              });
                            },
                            child: Container(
                                padding: const EdgeInsets.all(2),
                                margin: const EdgeInsets.only(left: 10),
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Styles.blackColor, width: .5),
                                    borderRadius: BorderRadius.circular(50)),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: (widget.booking.preference ==
                                              "female")
                                          ? Styles.redColor
                                          : Styles.backgroundColor,
                                      borderRadius: BorderRadius.circular(50)),
                                )),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText.smallText("Please Read"),
                          InkWell(
                            onTap: () {
                              launchUrl(Uri.parse(
                                  "https://admin-meriid.web.app/user/guidelines"));
                            },
                            child: Text("Terms And Condition",
                                style: GoogleFonts.montserrat(
                                    textStyle: const TextStyle(
                                        decoration: TextDecoration.underline,
                                        fontSize: 16,
                                        color: Styles.blackColor,
                                        fontWeight: FontWeight.w500))),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                _term = !_term;
                              });
                            },
                            child: Container(
                                padding: const EdgeInsets.all(2),
                                margin: const EdgeInsets.only(left: 10),
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Styles.blackColor, width: .5),
                                    borderRadius: BorderRadius.circular(50)),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: (_term == true)
                                          ? Styles.redColor
                                          : Styles.backgroundColor,
                                      borderRadius: BorderRadius.circular(50)),
                                )),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomText.smallText(
                              "Aadhar update/enrolment fees : Rs 50"),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      CustomButton(
                          postIconSize: 20,
                          postIcon: Icons.arrow_forward,
                          visiblepostIcon: false,
                          labelText:
                              (_language) ? "Make Payment" : "भुगतान करना",
                          containerColor: Styles.redColor,
                          onTap: () {
                            if (selectedValue == null) {
                              errorToast(
                                  "please choose the time slot", context);
                            } else if (_term == false)
                              errorToast("Please approve terms and condition",
                                  context);
                            else {
                              widget.booking.slot_time = selectedValue;
                              openCheckout();
                            }
                          })
                    ],
                  ),
                ],
              ))),
    );
  }
}

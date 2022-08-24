import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meri_id/model/Booking.dart';
import 'package:meri_id/model/Payment.dart';
import 'package:meri_id/presentation/custom/CustomButton.dart';
import 'package:meri_id/presentation/custom/CustomTextField.dart';
import 'package:meri_id/presentation/features/QRpage.dart';
import 'package:meri_id/services/widgets/CustomText.dart';
import 'package:meri_id/utils/styles.dart';
import 'package:intl/intl.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
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
                  padding:
                      const EdgeInsets.only(left: 32, right: 32, bottom: 32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          CustomText.xLargeText((_language)
                              ? StringValues.chooseDay.english
                              : StringValues.chooseDay.hindi),
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
                                        fontSize: 16,
                                        color: Styles.blackColor)),
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
                                          primary:
                                              Styles.redColor, // <-- SEE HERE
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
                                      DateFormat('yyyy-MM-dd')
                                          .format(pickedDate);
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
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: SvgPicture.asset('assets/images/date.svg'),
                      ),
                      CustomText.smallText(
                          "Aadhar update/enrolment fees : Rs 50"),
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
                            openCheckout();
                          })
                    ],
                  )))),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
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
  static const String routeNamed = 'choose time';
  const ChooseTimeSlot({Key? key}) : super(key: key);

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

  String? radioValue;

  _routeToQRPage() {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const QRpage(data: "lets do it")),
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
      debugPrint('Error: e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print('Success Response: $response');
    successToast("Payment Successful", context);
    _routeToQRPage();
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
                                    firstDate: DateTime(1950),
                                    //DateTime.now() - not to allow to choose before today.
                                    lastDate: DateTime(2100));

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
                                  });
                                } else {}
                              }),
                          const SizedBox(
                            height: 16,
                          ),
                        ],
                      ),
                      SvgPicture.asset('assets/images/date.svg'),
                      CustomButton(
                          postIconSize: 20,
                          postIcon: Icons.arrow_forward,
                          visiblepostIcon: false,
                          labelText: (_language)
                              ? StringValues.checkout.english
                              : StringValues.checkout.hindi,
                          containerColor: Styles.redColor,
                          onTap: () {
                            openCheckout();
                          })
                    ],
                  )))),
    );
  }
}

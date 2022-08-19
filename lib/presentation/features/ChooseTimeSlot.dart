import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meri_id/presentation/custom/CustomButton.dart';
import 'package:meri_id/presentation/custom/CustomTextField.dart';
import 'package:meri_id/presentation/features/QRpage.dart';
import 'package:meri_id/services/widgets/CustomText.dart';
import 'package:meri_id/utils/styles.dart';
import 'package:intl/intl.dart';

import '../../utils/global.dart';
import '../../utils/strings.dart';

class ChooseTimeSlot extends StatefulWidget {
  static const String routeNamed = 'choose time';
  const ChooseTimeSlot({Key? key}) : super(key: key);

  @override
  State<ChooseTimeSlot> createState() => _ChooseTimeSlotState();
}

class _ChooseTimeSlotState extends State<ChooseTimeSlot> {
  bool _language = true;
  TextEditingController dateInput = TextEditingController();

  @override
  void initState() {
    dateInput.text = ""; //set the initial value of text field
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

  String? radioValue;

  _submit() {
    _routeToQRPage();
  }

  _routeToQRPage() {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const QRpage(data: "lets do it")),
    );
  }

  // Widget _timeWidget(String startTime, String endTime, String val) {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceAround,
  //     children: [
  //       Container(
  //         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
  //         decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(10),
  //           color: Styles.backgroundColor,
  //         ),
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceAround,
  //           children: [
  //             CustomText.mediumText(startTime),
  //             const SizedBox(
  //               width: 16,
  //             ),
  //             CustomText.mediumText("-"),
  //             const SizedBox(
  //               width: 16,
  //             ),
  //             CustomText.mediumText(endTime),
  //           ],
  //         ),
  //       ),
  //       Padding(
  //         padding: const EdgeInsets.only(top: 16, bottom: 16),
  //         child: Radio(
  //             fillColor:
  //                 MaterialStateColor.resolveWith((states) => Styles.iconColor),
  //             value: val,
  //             groupValue: radioValue,
  //             onChanged: (val) {
  //               setState(() {
  //                 radioValue = val.toString();
  //                 print(radioValue);
  //               });
  //             }),
  //       ),
  //     ],
  //   );
  // }

  // Widget _timeBoxWidget() {
  //   return Container(
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(10),
  //         color: Styles.grayColor,
  //       ),
  //       padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
  //       child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
  //         _timeWidget("9:00 am", "10:00 am", '1'),
  //         _timeWidget("10:00 am", "11:00 am", '2'),
  //         _timeWidget("11:00 am", "12:00 am", '3'),
  //         _timeWidget("12:00 am", "13:00 pm", '4'),
  //         _timeWidget("13:00 am", "14:00 pm", '5'),
  //         _timeWidget("14:00 am", "15:00 pm", '6'),
  //         _timeWidget("15:00 am", "16:00 pm", '7'),
  //       ]));
  // }

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
                          // timeboxwidget()
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
                              ? StringValues.submit.english
                              : StringValues.submit.hindi,
                          containerColor: Styles.redColor,
                          onTap: () {
                            _submit();
                          })
                    ],
                  )))),
    );
  }
}

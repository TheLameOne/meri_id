import 'package:flutter/material.dart';
import 'package:meri_id/presentation/custom/CustomButton.dart';
import 'package:meri_id/services/widgets/CustomText.dart';
import 'package:meri_id/utils/styles.dart';

class ChooseTimeSlot extends StatefulWidget {
  static const String routeNamed = 'choose time';
  const ChooseTimeSlot({Key? key}) : super(key: key);

  @override
  State<ChooseTimeSlot> createState() => _ChooseTimeSlotState();
}

class _ChooseTimeSlotState extends State<ChooseTimeSlot> {
  String? radioValue;

  _submit() {}

  Widget _timeWidget(String startTime, String endTime, String val) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Styles.backgroundColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomText.mediumText(startTime),
              const SizedBox(
                width: 16,
              ),
              CustomText.mediumText("-"),
              const SizedBox(
                width: 16,
              ),
              CustomText.mediumText(endTime),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16, bottom: 16),
          child: Radio(
              fillColor:
                  MaterialStateColor.resolveWith((states) => Styles.iconColor),
              value: val,
              groupValue: radioValue,
              onChanged: (val) {
                setState(() {
                   radioValue = val.toString();
                     print(radioValue);
                });
               
              }),
        ),
      ],
    );
  }

  Widget _timeBoxWidget() {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Styles.grayColor,
        ),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _timeWidget("9:00 am", "10:00 am", '1'),
          _timeWidget("10:00 am", "11:00 am", '2'),
          _timeWidget("11:00 am", "12:00 am", '3'),
          _timeWidget("12:00 am", "13:00 pm", '4'),
          _timeWidget("13:00 am", "14:00 pm", '5'),
          _timeWidget("14:00 am", "15:00 pm", '6'),
          _timeWidget("15:00 am", "16:00 pm", '7'),
        ]));
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText.xLargeText("Choose Time Slot"),
                        const SizedBox(
                          height: 16,
                        ),
                        _timeBoxWidget(),
                        const SizedBox(
                          height: 16,
                        ),
                        (radioValue != null)
                            ? CustomButton(
                                postIconSize: 20,
                                postIcon: Icons.arrow_forward,
                                visiblepostIcon: false,
                                labelText: "Next Page ",
                                containerColor: Styles.redColor,
                                onTap: () {
                                  _submit();
                                })
                            : Container(),
                      ])))),
    );
  }
}

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:meri_id/model/Booking.dart';
import 'package:meri_id/model/Friends.dart';
import 'package:meri_id/presentation/custom/CustomButton.dart';
import 'package:meri_id/presentation/custom/CustomTextField.dart';
import 'package:meri_id/presentation/features/ChooseAddress.dart';
import 'package:meri_id/presentation/features/ChooseTimeSlot.dart';
import 'package:meri_id/presentation/features/Places.dart';
import 'package:meri_id/services/widgets/CustomText.dart';

import '../../utils/global.dart';
import '../../utils/strings.dart';
import '../../utils/styles.dart';

class Add extends StatefulWidget {
  const Add({Key? key}) : super(key: key);

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  List<Friends> listFriends = [Friends(), Friends(), Friends()];
  Booking booking = Booking();
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

  final List<String> items = ['1', '2', '3'];
  String? selectedValue;

  _routeToAddress() {
    booking.friends = listFriends;
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ChooseAddress(booking: booking)));
  }

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
                  (_language)
                      ? StringValues.numberOfPeople.english
                      : StringValues.numberOfPeople.hindi,
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

  Widget dropDown(int i) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(height: 16),
      Row(
        children: [
          CustomText.mediumText(
            (_language)
                ? StringValues.person.english
                : StringValues.person.hindi,
          ),
          CustomText.mediumText(" ${i.toString()}")
        ],
      ),
      const SizedBox(height: 16),
      CustomTextField(
        hintText: "",
        hintTextSize: 16,
        initialValue: '',
        onChanged: (value) {
          listFriends[i - 1].name = value;
        },
        onSaved: () {},
        validator: () {},
        labelText:
            (_language) ? StringValues.name.english : StringValues.name.hindi,
      ),
      const SizedBox(height: 16),
      CustomTextField(
        hintText: "",
        hintTextSize: 16,
        initialValue: '',
        onChanged: (value) {
          listFriends[i - 1].phone_number = value;
        },
        onSaved: () {},
        validator: () {},
        labelText: (_language)
            ? StringValues.phoneNumber.english
            : StringValues.phoneNumber.hindi,
      ),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                listFriends[i - 1].booking_type = "create";
              });
            },
            child: Row(
              children: [
                const Text("Create"),
                Container(
                    padding: const EdgeInsets.all(2),
                    margin: const EdgeInsets.only(left: 10),
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                        border: Border.all(color: Styles.blackColor, width: .5),
                        borderRadius: BorderRadius.circular(50)),
                    child: Container(
                      decoration: BoxDecoration(
                          color: (listFriends[i - 1].booking_type == "create")
                              ? Styles.redColor
                              : Styles.backgroundColor,
                          borderRadius: BorderRadius.circular(50)),
                    ))
              ],
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                listFriends[i - 1].booking_type = "update";
              });
            },
            child: Row(
              children: [
                const Text("Update"),
                Container(
                    padding: const EdgeInsets.all(2),
                    margin: const EdgeInsets.only(left: 10),
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                        border: Border.all(color: Styles.blackColor, width: .5),
                        borderRadius: BorderRadius.circular(50)),
                    child: Container(
                      decoration: BoxDecoration(
                          color: (listFriends[i - 1].booking_type == "update")
                              ? Styles.redColor
                              : Styles.backgroundColor,
                          borderRadius: BorderRadius.circular(50)),
                    ))
              ],
            ),
          ),
        ],
      ),
      (listFriends[i - 1].booking_type == "update")
          ? const SizedBox(height: 16)
          : Container(),
      (listFriends[i - 1].booking_type == "update")
          ? CustomTextField(
              hintText: "",
              hintTextSize: 16,
              initialValue: '',
              onChanged: (value) {
                listFriends[i - 1].reason = value;
              },
              onSaved: () {},
              validator: () {},
              labelText: (_language)
                  ? StringValues.reason.english
                  : StringValues.reason.hindi,
            )
          : Container(),
      (listFriends[i - 1].booking_type == "update")
          ? const SizedBox(height: 16)
          : Container(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Styles.backgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 32),
                  CustomText.xLargeText(
                    (_language)
                        ? StringValues.addBookings.english
                        : StringValues.addBookings.hindi,
                  ),
                  const SizedBox(height: 16),
                  CustomText.mediumText(
                    (_language)
                        ? StringValues.forHowMany.english
                        : StringValues.forHowMany.hindi,
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  dropDownWidget(),
                  const SizedBox(height: 16),
                  if (selectedValue != null)
                    for (int i = 1; i <= int.parse(selectedValue!); i++)
                      dropDown(i),
                  const SizedBox(height: 16),
                ],
              ),
              (selectedValue != null)
                  ? CustomButton(
                      postIconSize: 20,
                      postIcon: Icons.arrow_forward,
                      visiblepostIcon: false,
                      labelText: (_language)
                          ? StringValues.proceed.english
                          : StringValues.proceed.hindi,
                      containerColor: Styles.redColor,
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Places()));
                      })
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}

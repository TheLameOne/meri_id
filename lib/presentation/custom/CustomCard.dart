import 'package:flutter/material.dart';
import 'package:meri_id/services/widgets/CustomText.dart';
import 'package:meri_id/utils/styles.dart';

class CustomCard extends StatelessWidget {
  final String booking_id;
  final String date;
  final String time;
  final Color color;
  final Function onTap;
  final Function makeCall;
  final String? phoneNumber;

  const CustomCard(
      {this.booking_id = "7231905",
      this.phoneNumber = "",
      this.date = "Date",
      this.time = "Time",
      required this.makeCall,
      this.color = Styles.blackColor,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 22),
        child: Card(
          elevation: 5,
          shadowColor: Styles.blackColor,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: color,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CustomText.mediumText(booking_id),
                      ],
                    ),
                    // Calling button
                    InkWell(
                      onTap: () {
                        makeCall();
                      },
                      child: (phoneNumber == "")
                          ? const Icon(
                              Icons.phone_disabled,
                              size: 32,
                            )
                          : const Icon(
                              Icons.call,
                              size: 32,
                            ),
                    )
                  ],
                ),
                const SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText.timeText(date),
                    (time == "")
                        ? CustomText.timeText("Slot: Pending")
                        : CustomText.timeText(time),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

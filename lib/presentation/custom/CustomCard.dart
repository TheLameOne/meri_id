import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meri_id/services/widgets/CustomText.dart';
import 'package:meri_id/utils/styles.dart';

class CustomCard extends StatelessWidget {
  final String booking_id;
  final String date;
  final String time;
  final String name;
  final Color color;

  const CustomCard(
      {this.booking_id = "7231905",
      this.date = "Date",
      this.time = "Time",
      this.name = "Person Name",
      this.color = Styles.redColor});

  @override
  Widget build(BuildContext context) {
    return Card(
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
                    // profile pic
                    Icon(Icons.person),
                    // Name
                    CustomText.smallText(name),
                  ],
                ),
                // Calling button
                IconButton(onPressed: () {}, icon: Icon(Icons.call))
              ],
            ),
            Row(
              children: [
                CustomText.smallText("Booking ID : "),
                CustomText.smallText(booking_id),
                // Booking ID
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Date
                CustomText.timeText(date),
                // Time
                CustomText.timeText(time),
              ],
            )
          ],
        ),
      ),
    );
  }
}

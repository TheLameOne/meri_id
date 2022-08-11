import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:meri_id/utils/styles.dart';

import '../../services/widgets/CustomText.dart';

class CustomTimeBox extends StatelessWidget {
  final EdgeInsetsGeometry margin;
  final double vertical;
  final double horizontal;
  final double radius;
  final Color color1;
  final Color color2;
  const CustomTimeBox({
    Key? key,
    this.margin = const EdgeInsets.symmetric(vertical: 10),
    this.vertical = 15,
    this.horizontal = 15,
    this.radius = 10,
    this.color1 = Styles.greenColor,
    this.color2 = Styles.grayColor,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: Styles.creamColor,
      ),
      padding: EdgeInsets.symmetric(vertical: vertical, horizontal: horizontal),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: BoxDecoration(
              // border: Border.all(width: 10),
              borderRadius: BorderRadius.circular(radius),
              color: color1,
            ),
            padding: EdgeInsets.symmetric(
                horizontal: horizontal, vertical: vertical),
            margin: margin,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText.mediumText("9:00 am"),
                CustomText.mediumText("-"),
                CustomText.mediumText("10:00 am"),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              // border: Border.all(width: 10),
              borderRadius: BorderRadius.circular(radius),
              color: color2,
            ),
            padding: EdgeInsets.symmetric(
                horizontal: horizontal, vertical: vertical),
            margin: margin,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText.mediumText("10:00 am"),
                CustomText.mediumText("-"),
                CustomText.mediumText("11:00 am"),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              // border: Border.all(width: 10),
              borderRadius: BorderRadius.circular(radius),
              color: color1,
            ),
            padding: EdgeInsets.symmetric(
                horizontal: horizontal, vertical: vertical),
            margin: margin,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText.mediumText("11:00 am"),
                CustomText.mediumText("-"),
                CustomText.mediumText("12:00 pm"),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              // border: Border.all(width: 10),
              borderRadius: BorderRadius.circular(radius),
              color: color2,
            ),
            padding: EdgeInsets.symmetric(
                horizontal: horizontal, vertical: vertical),
            margin: margin,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText.mediumText("1:00 pm"),
                CustomText.mediumText("-"),
                CustomText.mediumText("2:00 pm"),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              // border: Border.all(width: 10),
              borderRadius: BorderRadius.circular(radius),
              color: color1,
            ),
            padding: EdgeInsets.symmetric(
                horizontal: horizontal, vertical: vertical),
            margin: margin,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText.mediumText("2:00 pm"),
                CustomText.mediumText("-"),
                CustomText.mediumText("3:00 pm"),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              // border: Border.all(width: 10),
              borderRadius: BorderRadius.circular(radius),
              color: color2,
            ),
            padding: EdgeInsets.symmetric(
                horizontal: horizontal, vertical: vertical),
            margin: margin,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText.mediumText("3:00 pm"),
                CustomText.mediumText("-"),
                CustomText.mediumText("4:00 pm"),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              // border: Border.all(width: 10),
              borderRadius: BorderRadius.circular(radius),
              color: color1,
            ),
            padding: EdgeInsets.symmetric(
                horizontal: horizontal, vertical: vertical),
            margin: margin,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText.mediumText("4:00 pm"),
                CustomText.mediumText("-"),
                CustomText.mediumText("5:00 pm"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

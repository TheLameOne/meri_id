import 'package:flutter/material.dart';
import 'package:meri_id/services/widgets/CustomTextStyles.dart';

abstract class CustomText {

  static Text smalltext(String text) {
    return Text(text, style: CustomTextStyles.textStylelow());
  }
  static Text mediumText(String text) {
       return Text(text, style: CustomTextStyles.textStylelow());
    
  }
  static Text largeText(String text) {
       return Text(text, style: CustomTextStyles.textStyleHigh());
  }

    static Text xLargeText(String text) {
       return Text(text, style: CustomTextStyles.textStyleHighX());
  }
}

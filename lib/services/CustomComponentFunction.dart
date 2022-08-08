import 'package:flutter/material.dart';

abstract class CustomTextStyles {

  static TextStyle textStylelow() {
    return const TextStyle(
        fontSize: 14.0,
        fontFamily: 'Montserrat',
        color: Colors.black,
        fontWeight: FontWeight.w400);
  }

  static TextStyle textStyleMedium() {
    return const TextStyle(
        fontSize: 16.0,
        fontFamily: 'Montserrat',
        color: Colors.black,
        fontWeight: FontWeight.w500);
  }

  static TextStyle textStyleHigh() {
    return const TextStyle(
        fontSize: 18.0,
        fontFamily: 'Montserrat',
        color: Colors.black,
        fontWeight: FontWeight.w600);
  }

  

}

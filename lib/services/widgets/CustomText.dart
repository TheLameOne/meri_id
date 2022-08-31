import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meri_id/utils/styles.dart';

abstract class CustomText {
  static Text smallText(String text) {
    return Text(text,
        style: GoogleFonts.montserrat(
            textStyle: const TextStyle(
                fontSize: 16,
                color: Styles.blackColor,
                fontWeight: FontWeight.w500)));
  }

  static Text mediumText(String text) {
    return Text(text,
        style: GoogleFonts.montserrat(
            textStyle: const TextStyle(
                fontSize: 18,
                color: Styles.blackColor,
                fontWeight: FontWeight.w600)));
  }

  static Text largeText(String text) {
    return Text(text,
        style: GoogleFonts.montserrat(
            textStyle: const TextStyle(
                fontSize: 24,
                color: Styles.blackColor,
                fontWeight: FontWeight.w800)));
  }

  static Text xLargeText(String text) {
    return Text(text,
        style: GoogleFonts.montserrat(
            textStyle: const TextStyle(
                fontSize: 32,
                color: Styles.blackColor,
                fontWeight: FontWeight.bold)));
  }

  static Text timeText(String text) {
    return Text(text,
        style: GoogleFonts.montserrat(
            textStyle: const TextStyle(
                fontSize: 16,
                color: Styles.blackColor,
                fontWeight: FontWeight.w400)));
  }
}

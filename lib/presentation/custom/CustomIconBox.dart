import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meri_id/utils/styles.dart';

class CustomIconBox extends StatelessWidget {
  final IconData postIcon;
  final bool visiblepostIcon;
  final String labelText;
  final FontWeight labelTextWeight;
  final double sizelabelText;
  final Function onTap;
  final double postIconSize;
  final Color postIconColor;
  final Color containerColor;
  final bool isLoading;

  CustomIconBox(
      { required this.postIcon,
        required this.labelText,
      this.visiblepostIcon = false,
      this.sizelabelText = 20,
      this.labelTextWeight = FontWeight.w500,
      required this.onTap,
      this.isLoading = false,
      this.postIconSize = 24,
      this.postIconColor = Colors.black,
      this.containerColor = Styles.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: containerColor,
              boxShadow: const [BoxShadow(color: Styles.backgroundColor, blurRadius: 5, offset: Offset(2, 4))]),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10 , horizontal: 16),
        child: Center(
          child: (isLoading == false)
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(labelText,
                        style: GoogleFonts.montserrat(textStyle: const TextStyle(fontSize: 18 , color: Styles.blackColor))),
                    Container(
                      child: (visiblepostIcon)
                          ? Icon(
                              postIcon,
                              size: postIconSize,
                              color: postIconColor,
                            )
                          : Container(),
                    ),
                  ],
                )
              : const SizedBox(
              height: 24.0,
              width: 24,
              child: CircularProgressIndicator(color: Styles.blackColor),
            ),
        ),
      ),
    );
  }
}

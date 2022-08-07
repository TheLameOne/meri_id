import 'package:flutter/material.dart';
import 'package:meri_id/utils/styles.dart';

class CustomButton extends StatelessWidget {
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

  const CustomButton(
      {required this.postIcon,
      required this.labelText,
      this.visiblepostIcon = false,
      this.sizelabelText = 20,
      this.labelTextWeight = FontWeight.w500,
      required this.onTap ,
      this.isLoading = false,
      this.postIconSize = 24,
      this.postIconColor = Colors.black,
      this.containerColor =Styles.iconColor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:() { onTap(); },
      child: Container(
        decoration: BoxDecoration(color: containerColor, boxShadow: [
          BoxShadow(
              color: Styles.grayColor.withOpacity(.1),
              blurRadius: 3,
              offset: const Offset(0, 5))
        ]),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Center(
            child: (isLoading==false)?Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(labelText,
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 18,
                        fontWeight: labelTextWeight)),
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
            ):const CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}

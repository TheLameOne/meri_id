import 'package:flutter/material.dart';
import 'package:meri_id/services/widgets/CustomTextStyles.dart';
import 'package:meri_id/utils/styles.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final double hintTextSize;
  final String initialValue;

  final TextInputType textInputType;
  final Function onSaved;
  final Function onChanged;
  final Function validator;
  final IconData icon;
  final bool isPrefixIcon;
  final double preIconSize;
  final double padding;
  final bool size;
  final bool onRegPage;

  CustomTextField(
      {required this.labelText,
      required this.hintText,
      this.preIconSize = 30,
      this.hintTextSize = 16,
      required this.initialValue,
      required this.onSaved,
      required this.onChanged,
      required this.validator,
      this.textInputType = TextInputType.text,
      this.icon = Icons.location_on,
      this.isPrefixIcon = false,
      this.padding = 32,
      this.size = false,
      this.onRegPage = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: Container(
        decoration: (onRegPage == true)
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
                border: Border.all(width: 2, color: Styles.iconColor),
              )
            : BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
                boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 5, offset: Offset(2, 4))]),
        child: Padding(
          padding: (isPrefixIcon) ? const EdgeInsets.all(0) : const EdgeInsets.only(left: 16),
          child: TextFormField(
              onSaved: onSaved(),
              onChanged: onChanged(),
              keyboardType: textInputType,
              initialValue: initialValue,
              style: TextStyle(fontSize: 16),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: hintText,
                  labelText: labelText,
                  labelStyle: CustomTextStyles.textStylelow(),
                  prefixIcon: isPrefixIcon
                      ? Icon(
                          icon,
                          color: Styles.backgroundColor,
                          size: preIconSize,
                        )
                      : null,
                  hintStyle:  CustomTextStyles.textStylelow() ),
              
        ),
      ),
    )
    );
  }
}

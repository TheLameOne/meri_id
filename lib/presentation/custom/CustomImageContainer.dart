import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meri_id/utils/styles.dart';

class CustomImageContainer extends StatelessWidget {
  final String image;
  final Function onTap;
  final bool isLoading;

  CustomImageContainer({
    required this.image,
    required this.onTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Center(
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Styles.blackColor,
                    blurRadius: 10,
                    offset: Offset(1, 1))
              ]),
          child: isLoading
              ? CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Styles.grayColor),
                )
              : image != null
                  ? Image.network(
                      image,
                      fit: BoxFit.fill,
                    )
                  : Container(
                      padding: const EdgeInsets.all(16),
                      child: Icon(Icons.add_a_photo,
                          size: 50, color: Styles.grayColor)),
        ),
      ),
    );
  }
}

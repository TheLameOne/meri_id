import 'package:flutter/material.dart';
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
      onTap: () => {onTap()},
      child: Center(
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                    color: Styles.blackColor,
                    blurRadius: 10,
                    offset: Offset(1, 1))
              ]),
          child: isLoading
              ? const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Styles.grayColor),
                )
              : image != null
                  ? Image.asset(
                      image,
                      fit: BoxFit.fill,
                    )
                  : Container(
                      padding: const EdgeInsets.all(16),
                      child: const Icon(Icons.add_a_photo,
                          size: 50, color: Styles.grayColor)),
        ),
      ),
    );
  }
}

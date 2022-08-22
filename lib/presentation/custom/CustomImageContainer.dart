import 'package:flutter/material.dart';
import 'package:meri_id/utils/styles.dart';

class CustomImageContainer extends StatelessWidget {
  final String? image;
  final Function onTap;
  final bool isLoading;

  CustomImageContainer({
    this.image,
    required this.onTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {onTap()},
      child: Center(
        child: Container(
          height: 300,
          alignment: Alignment.center,
          decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Styles.backgroundColor,
          border: Border.all(width : 3 , color: Styles.blackColor) ,
          boxShadow: const [
            BoxShadow(
                color: Styles.backgroundColor,
                blurRadius: 5,
                offset: Offset(2, 4))
          ]),
          child: isLoading
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 96,horizontal: 64),
                  child: const CircularProgressIndicator(
                    color: Styles.blackColor,
                  ),
                )
              : image != null?    
                   Container(
                    height: 300,
                    width: 300,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                     child: Image.network(
                        image!,
                        fit: BoxFit.fill
                      ),
                   )
                  : Container(
                      padding: const EdgeInsets.all(16),
                      child: const Icon(Icons.add_a_photo,
                          size: 50, color: Styles.blackColor)),
        ),
      ),
    );
  }
}

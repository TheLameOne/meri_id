import 'package:flutter/material.dart';
import 'package:meri_id/utils/styles.dart';

import '../../utils/strings.dart';

class CustomIcon extends StatelessWidget {
  final double height;
  final double width;

  CustomIcon({this.height = 200, this.width = 200});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              Styles.LOGO_IMAGE,
              height: height,
              width: width,
            ),
            const Text(
              "मेरी ID",
              style: TextStyle(
                fontSize: 35,
              ),
            )
          ],
        ),
      ),
    );
  }
}

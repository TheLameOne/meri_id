import 'package:flutter/material.dart';
import 'package:meri_id/utils/styles.dart';

class CustomScaffold extends StatelessWidget {
  final Function appbarOnTap;
  final Widget body;
  final String appBarText;
  final double appBarTextSize;
  CustomScaffold(
      {required this.appbarOnTap,
      required this.body,
      required this.appBarText,
      this.appBarTextSize: 19});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Styles.ORANGE_COLOR,
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              IconButton(
                icon: new Icon(
                  Icons.arrow_back,
                  color: Styles.PURPLE_COLOR,
                  size: 28,
                ),
                onPressed: appbarOnTap(),
              ),
              Text(
                appBarText,
                style: TextStyle(
                    fontSize: appBarTextSize,
                    color: Colors.black,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
        body: body,
      ),
    );
  }
}

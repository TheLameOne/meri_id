import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../services/widgets/CustomText.dart';
import '../../utils/styles.dart';

class Feeds extends StatefulWidget {
  static const String routeNamed = 'Feeds';
  @override
  State<Feeds> createState() => _FeedsState();
}

class _FeedsState extends State<Feeds> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Styles.backgroundColor,
        appBar: AppBar(
          actions: [],
          backgroundColor: Styles.backgroundColor,
          foregroundColor: Styles.blackColor,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Container(
            color: Styles.backgroundColor,
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText.xLargeText("News Feed"),
                  const SizedBox(
                    height: 64,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

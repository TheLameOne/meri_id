import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:meri_id/utils/styles.dart';

import '../../services/widgets/CustomText.dart';

class LanguagePage extends StatefulWidget {
  static const String routeNamed = 'LanguagePage';

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                CustomText.xLargeText("Languages"),
                const SizedBox(
                  height: 64,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText.mediumText("English"),
                    Switch(
                      value: true,
                      onChanged: (value) {},
                      activeColor: Styles.redColor,
                    )
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText.mediumText("Hindi"),
                    Switch(
                      value: false,
                      onChanged: (value) {},
                      activeColor: Styles.redColor,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

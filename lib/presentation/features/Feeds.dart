import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../services/widgets/CustomText.dart';
import '../../utils/global.dart';
import '../../utils/strings.dart';
import '../../utils/styles.dart';

class Feeds extends StatefulWidget {
  static const String routeNamed = 'Feeds';
  @override
  State<Feeds> createState() => _FeedsState();
}

class _FeedsState extends State<Feeds> {
  bool isLoading = true;
  bool _language = true;
  void initState() {
    super.initState();
    _parent();
  }

  _parent() async {
    await _languageFunction();
    await _loadingOff();
  }

  _languageFunction() async {
    bool val = await checkLanguage();
    _language = val;
  }

  _loadingOff() {
    setState(() {
      isLoading = false;
    });
  }

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
        body:
            // (isLoading)
            //     ? const Center(
            //         child: CircularProgressIndicator(color: Styles.redColor),
            //       )
            SingleChildScrollView(
          child: Container(
            color: Styles.backgroundColor,
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText.xLargeText((_language)
                      ? StringValues.newsFeed.english
                      : StringValues.newsFeed.hindi),
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

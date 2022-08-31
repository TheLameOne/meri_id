import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:meri_id/utils/styles.dart';

import '../../services/widgets/CustomText.dart';
import '../../utils/global.dart';
import '../../utils/strings.dart';
import '../SplashPage.dart';

class LanguagePage extends StatefulWidget {
  static const String routeNamed = 'LanguagePage';

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  bool _language = true;
  bool _loading = true;
  bool english = false;
  bool hindi = false;

  @override
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
    setState(() {
      _language = val;
      if (_language) {
        english = true;
        hindi = false;
      } else {
        hindi = true;
        english = false;
      }
    });
  }

  _loadingOff() {
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Styles.backgroundColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Styles.redColor),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, SplashPage.routeNamed);
              }),
          backgroundColor: Styles.backgroundColor,
          foregroundColor: Styles.blackColor,
          elevation: 0,
        ),
        body: (_loading)
            ? const Center(
                child: CircularProgressIndicator(
                  color: Styles.redColor,
                ),
              )
            : SingleChildScrollView(
                child: Container(
                  color: Styles.backgroundColor,
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText.xLargeText((_language)
                            ? StringValues.languageSettings.english
                            : StringValues.languageSettings.hindi),
                        const SizedBox(
                          height: 64,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText.mediumText(
                              (_language)
                                  ? StringValues.eng.english
                                  : StringValues.eng.hindi,
                            ),
                            Switch(
                              value: english,
                              onChanged: (value) async {
                                await preferenceService.setLanguage("english");
                                setState(() {
                                  hindi = false;
                                  english = true;
                                  _language = true;
                                });
                              },
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
                            CustomText.mediumText(
                              (_language)
                                  ? StringValues.hin.english
                                  : StringValues.hin.hindi,
                            ),
                            Switch(
                              value: hindi,
                              onChanged: (value) async {
                                await preferenceService.setLanguage("hindi");
                                setState(() {
                                  hindi = true;
                                  english = false;
                                  _language = false;
                                });
                              },
                              activeColor: Styles.redColor,
                            )
                          ],
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

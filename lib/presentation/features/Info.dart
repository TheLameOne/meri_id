import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:meri_id/utils/styles.dart';
import '../../services/widgets/CustomText.dart';
import '../../utils/global.dart';
import '../../utils/strings.dart';
import 'package:flutter_html/flutter_html.dart';

class Info extends StatefulWidget {
  static const String routeNamed = 'Info';
  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  bool _isLoading = true;
  bool _language = true;
  String value = "No GuideLines";

  @override
  void initState() {
    super.initState();
    _parent();
  }

  _parent() async {
    value = await apiService.getGuildeLines();
    await _languageFunction();
    await _loadingOff();
  }

  _languageFunction() async {
    bool val = await checkLanguage();
    _language = val;
  }

  _loadingOff() {
    setState(() {
      _isLoading = false;
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
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(color: Styles.blackColor))
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText.xLargeText((_language)
                          ? StringValues.guidelines.english
                          : StringValues.guidelines.hindi),
                      const SizedBox(
                        height: 32,
                      ),
                      Center(
                          child: Html(
                        data: value,
                        style: {
                          "p": Style(
                            color: Styles.blackColor,
                            fontSize: FontSize.large,
                          )
                        },
                      )),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

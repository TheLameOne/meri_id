import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meri_id/utils/styles.dart';
import '../../services/widgets/CustomText.dart';
import '../../utils/global.dart';
import '../../utils/strings.dart';
import '../custom/CustomButton.dart';

class Issue extends StatefulWidget {
  static const String routeNamed = 'Issue';
  @override
  State<Issue> createState() => _IssueState();
}

class _IssueState extends State<Issue> {
  bool _language = true;

  @override
  void initState() {
    super.initState();
    _parent();
  }

  _parent() async {
    await _languageFunction();
  }

  _languageFunction() async {
    bool val = await checkLanguage();
    _language = val;
  }

  _raiseIssue() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                CustomText.xLargeText((_language)
                    ? StringValues.issue.english
                    : StringValues.issue.hindi),
                const SizedBox(
                  height: 32,
                ),
                // from here
                Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Styles.grayColor,
                    ),
                    child: TextField(
                        keyboardType: TextInputType.multiline,
                        minLines: 3,
                        maxLines: null,
                        cursorColor: Styles.blackColor,
                        decoration: InputDecoration(border: InputBorder.none),
                        style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                                fontSize: 16,
                                color: Styles.blackColor,
                                fontWeight: FontWeight.w400)))),
                // to here
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  child: CustomButton(
                      postIcon: Icons.arrow_forward_ios,
                      labelText: (_language)
                          ? StringValues.proceed.english
                          : StringValues.proceed.hindi,
                      containerColor: Styles.redColor,
                      onTap: () {
                        _raiseIssue();
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

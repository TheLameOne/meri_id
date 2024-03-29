import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meri_id/presentation/SplashPage.dart';
import 'package:meri_id/utils/styles.dart';
import '../../services/widgets/CustomText.dart';
import '../../utils/global.dart';
import '../../utils/strings.dart';
import '../custom/CustomButton.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class Issue extends StatefulWidget {
  static const String routeNamed = 'Issue';
  @override
  State<Issue> createState() => _IssueState();
}

class _IssueState extends State<Issue> {
  bool _language = true;
  String issue = "";
  bool isButtonLoading = false;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _parent();
  }

  _parent() async {
    await _languageFunction();
  }

  _languageFunction() async {
    bool val = await checkLanguage();
    setState(() {
      _language = val;
    });
  }

  final List<String> items = [
    'Government Related',
    'App Releated',
    'UI Related'
  ];

  String? selectedValue;
  Widget dropDownWidget() {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        isExpanded: true,
        hint: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: const [
              Icon(
                Icons.list,
                size: 28,
                color: Styles.blackColor,
              ),
              SizedBox(
                width: 4,
              ),
              Expanded(
                child: Text(
                  'Issues',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Styles.blackColor,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        items: items
            .map((item) => DropdownMenuItem<String>(
                value: item, child: CustomText.smallText(item)))
            .toList(),
        value: selectedValue,
        onChanged: (value) {
          setState(() {
            selectedValue = value as String;
          });
        },
        icon: const Icon(
          Icons.arrow_forward_ios,
          size: 28,
          color: Styles.blackColor,
        ),
        iconSize: 14,
        iconEnabledColor: Styles.grayColor,
        iconDisabledColor: Colors.grey,
        buttonPadding: const EdgeInsets.only(left: 14, right: 14),
        buttonDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(color: Colors.grey, blurRadius: 5, offset: Offset(2, 4))
            ]),
        buttonElevation: 2,
        itemHeight: 40,
        itemPadding: const EdgeInsets.only(left: 14, right: 14),
        dropdownPadding: const EdgeInsets.symmetric(horizontal: 0),
        dropdownDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(color: Colors.grey, blurRadius: 5, offset: Offset(2, 4))
            ]),
        dropdownElevation: 8,
        scrollbarRadius: const Radius.circular(10),
        offset: const Offset(-20, 0),
      ),
    );
  }

  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = '';
  double _confidence = 1.0;

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      print(available);
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            issue = val.recognizedWords;
            print(issue);
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
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
        body: Container(
          color: Styles.backgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText.xLargeText(
                      (_language)
                          ? StringValues.raiseIssue.english
                          : StringValues.raiseIssue.hindi,
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    dropDownWidget(),
                    const SizedBox(
                      height: 32,
                    ),
                    Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Styles.grayColor,
                        ),
                        child: TextField(
                            controller: TextEditingController(text: issue),
                            keyboardType: TextInputType.multiline,
                            minLines: 4,
                            maxLines: null,
                            cursorColor: Styles.blackColor,
                            decoration:
                                InputDecoration(border: InputBorder.none),
                            style: GoogleFonts.montserrat(
                                textStyle: const TextStyle(
                                    fontSize: 16,
                                    color: Styles.blackColor,
                                    fontWeight: FontWeight.w400)))),
                   
                   SizedBox(height: 16,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        FloatingActionButton(
                          backgroundColor: Styles.redColor,
                          onPressed: _listen,
                          child: Icon(
                              _isListening ? Icons.mic : Icons.mic_none),
                        ),
                      ],
                    )
                  ],
                ),

                // to here
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  child: CustomButton(
                      isLoading: isButtonLoading,
                      postIcon: Icons.arrow_forward_ios,
                      labelText: (_language)
                          ? StringValues.issue.english
                          : StringValues.issue.hindi,
                      containerColor: Styles.redColor,
                      onTap: () async {
                        setState(() {
                          isButtonLoading = true;
                        });
                        if (selectedValue == null) {
                          errorToast("Please Choose the tille", context);
                          setState(() {
                            isButtonLoading = false;
                          });
                          return;
                        }
                        if (issue == "") {
                          errorToast("Please Type Issue", context);
                          setState(() {
                            isButtonLoading = false;
                          });
                          return;
                        }
                        try {
                          await apiService.raiseIssue(selectedValue!, issue);
                          successToast("Send SuccessFully", context);
                          Navigator.pushNamed(context, SplashPage.routeNamed);
                        } catch (e) {
                          print(e);
                          errorToast("Oops! Something Went Wrong", context);
                        }
                        setState(() {
                          selectedValue = null;
                          issue = "";
                          isButtonLoading = false;
                        });
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

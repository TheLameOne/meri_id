import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:meri_id/utils/styles.dart';
import '../../services/widgets/CustomText.dart';
import '../../utils/global.dart';

class Info extends StatefulWidget {
  static const String routeNamed = 'Info';
  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  bool _isLoading = true;
  String value = "No GuideLines";

  @override
  void initState() {
    super.initState();
    _getGuidleLines();
  }

  _getGuidleLines() async {
    final String url = "https://meriid.herokuapp.com/api/general/guidelines";
    Response res = await get(Uri.parse(url));
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      print(body["data"][0]["guideline"]);
      setState(() {
        _isLoading = false;
        if (role == "user") {
          value = body["data"][0]["guideline"];
        }
      });
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
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(color: Styles.blackColor))
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText.xLargeText("GuideLines"),
                      const SizedBox(
                        height: 64,
                      ),
                      Center(
                        child: CustomText.smallText(value),
                      ),

                      //                   Switch(
                      //   value: isHindi,
                      //   onChanged: (value) {
                      //     setState(() {
                      //       isHindi = value;
                      //     });
                      //   },
                      //   activeTrackColor: Colors.lightGreenAccent,
                      //   activeColor: Colors.green,
                      // ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

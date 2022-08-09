import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:meri_id/utils/styles.dart';
import '../../utils/global.dart';

class Info extends StatefulWidget {
  const Info({Key? key}) : super(key: key);

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
        } else {
          value = body["data"][1]["guideline"];
        }
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SingleChildScrollView(
          child: Container(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator(color : Styles.iconColor))
                  : Padding(
                      padding: const EdgeInsets.all(32),
                      child: Column(
                        children: [
                          const Text("GuideLines",
                              style: TextStyle(
                                  fontSize: 32,
                                  fontFamily: 'Montserrat',
                                  color: Color.fromARGB(255, 171, 133, 133),
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(
                            height: 20,
                          ),
                          Center(
                              child: Text(value,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'Montserrat',
                                      color: Colors.black.withOpacity(0.7),
                                      fontWeight: FontWeight.w500))),

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
                    )),
        ),
      ],
    );
  }
}

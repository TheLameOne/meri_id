import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart';

import '../../utils/global.dart';




class Info extends StatefulWidget {
  const Info({ Key? key }) : super(key: key);

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
  _getGuidleLines() async 
  {
    final String url="https://meriid.herokuapp.com/api/general/guidelines";
    Response res = await get(Uri.parse(url));
      if (res.statusCode == 200) {
        var body = jsonDecode(res.body);
        print(body["data"][0]["guideline"]);
         setState(() {
          _isLoading = false;
          if(role =="user")
          {
          value = body["data"][0]["guideline"];
          }
          else
          {
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
            child: _isLoading ? Center(child: CircularProgressIndicator( color:  Colors.blue)) :
            Padding(
              padding: const EdgeInsets.all(32),
              child: Center(child: Text(value)),
            )
          ),
        ),
      ],
    );
  }
  }

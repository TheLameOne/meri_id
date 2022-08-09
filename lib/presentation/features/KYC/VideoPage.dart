import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:meri_id/presentation/custom/CustomButton.dart';
import 'package:meri_id/services/CustomComponentFunction.dart';
import 'package:meri_id/utils/styles.dart';

class VideoKYCPage extends StatefulWidget {
  const VideoKYCPage({Key? key}) : super(key: key);

  @override
  State<VideoKYCPage> createState() => _VideoKYCPageState();
}

class _VideoKYCPageState extends State<VideoKYCPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Styles.grayColor,
        appBar: AppBar(
          backgroundColor: Styles.grayColor,
          foregroundColor: Styles.blackColor,
          elevation: 0,
          actions: [],
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Text(
                "Video KYC",
                style: TextStyle(fontSize: 22, color: Styles.blackColor),
                textAlign: TextAlign.start,
              ),
              // Image.file()r
              SizedBox(
                height: 100,
              ),
              Icon(
                Icons.upload_file,
                color: Colors.black,
                size: 180,
              ),
              SizedBox(
                height: 200,
              ),
              CustomButton(
                postIcon: Icons.arrow_forward_ios,
                labelText: "Upload",
                onTap: () {},
              )
            ],
          ),
        ));
  }
}

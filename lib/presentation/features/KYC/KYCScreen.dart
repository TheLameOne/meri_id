import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:meri_id/presentation/features/KYC/AadharPage.dart';
import 'package:meri_id/presentation/features/KYC/PanPage.dart';
import 'package:meri_id/presentation/features/KYC/VideoPage.dart';

import '../../../utils/styles.dart';
import '../../custom/CustomButton.dart';

class KYCScreen extends StatefulWidget {
  const KYCScreen({Key? key}) : super(key: key);

  @override
  State<KYCScreen> createState() => _KYCScreenState();
}

class _KYCScreenState extends State<KYCScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Styles.grayColor,
        appBar: AppBar(
            backgroundColor: Styles.grayColor,
            foregroundColor: Styles.blackColor,
            elevation: 0,
            actions: []),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Text(
                "Upload Documents",
                style: TextStyle(fontSize: 22, color: Styles.blackColor),
                textAlign: TextAlign.start,
              ),
              // Image.file()
              SizedBox(
                height: 100,
              ),
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: CustomButton(
                  postIcon: Icons.arrow_forward_ios,
                  labelText: "Upload Aadhar",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AadharPage()),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: CustomButton(
                  postIcon: Icons.arrow_forward_ios,
                  labelText: "Upload PAN",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PANPage()),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: CustomButton(
                    postIcon: Icons.arrow_forward_ios,
                    labelText: "Video KYC",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => VideoKYCPage()),
                      );
                    }),
              )
            ],
          ),
        ));
  }
}

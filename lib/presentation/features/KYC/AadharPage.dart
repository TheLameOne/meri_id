import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meri_id/presentation/custom/CustomButton.dart';
import 'package:meri_id/presentation/features/KYC/CameraScreen.dart';
import 'package:meri_id/services/CustomComponentFunction.dart';
import 'package:meri_id/utils/styles.dart';

import '../../custom/CustomImageContainer.dart';

class AadharPage extends StatefulWidget {
  const AadharPage({Key? key}) : super(key: key);

  @override
  State<AadharPage> createState() => _AadharPageState();
}

class _AadharPageState extends State<AadharPage> {
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
                "Upload Aadhar",
                style: TextStyle(fontSize: 22, color: Styles.blackColor),
                textAlign: TextAlign.start,
              ),
              // Image.file()
              SizedBox(
                height: 100,
              ),
              CustomImageContainer(
                  // isLoading: postStore.isUploading,
                  onTap: () async {
                    try {
                      XFile? file = await ImagePicker.platform
                          .getImage(source: ImageSource.camera);
                      print(file);
                      if (file != null) {
                        String id =
                            DateTime.now().millisecondsSinceEpoch.toString();
                        // String url = await postStore.uploadingImage(
                        //     imageFile: file, id: id);
                        // if (url == null) {
                        //   Fluttertoast.showToast(msg: "Image Not Verified");
                        // } else {
                        //   Fluttertoast.showToast(msg: "Image Verified");
                        //   setState(() {
                        //     post.id = id;
                        //     post.imageUrl = url;
                        //   });
                        // }
                      }
                    } catch (e) {
                      print(e);
                      // showSnackbar(e.toString(), context);
                    }
                  },
                  image: "Harsh" //post.imageUrl,
                  ),
              SizedBox(
                height: 200,
              ),
              CustomButton(
                postIcon: Icons.arrow_forward_ios,
                labelText: "Upload",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CameraScreen()),
                  );
                },
              )
            ],
          ),
        ));
  }
}

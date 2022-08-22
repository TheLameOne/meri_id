import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meri_id/presentation/custom/CustomButton.dart';
import 'package:meri_id/presentation/custom/CustomImageContainer.dart';
import 'package:meri_id/presentation/custom/CustomScaffold.dart';
import 'package:meri_id/presentation/kyc/VideoPage.dart';
import 'package:meri_id/services/widgets/CustomText.dart';
import 'package:meri_id/utils/global.dart';
import 'package:meri_id/utils/strings.dart';
import 'package:meri_id/utils/styles.dart';

class OtherDocumentPage extends StatefulWidget {
  static const String routeNamed = 'otherDocumentPage';

  @override
  State<OtherDocumentPage> createState() => _OtherDocumentPageState();
}

class _OtherDocumentPageState extends State<OtherDocumentPage> {
  bool imageLoading = false;
  bool isButtonLoading = false;
  String? defaultContainerUrl = null;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        body: Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const SizedBox(
                height: 32,
              ),
              CustomText.xLargeText(StringValues.uploadOtherDocuments.english),
              Padding(
                padding: const EdgeInsets.all(32),
                child: CustomImageContainer(
                  isLoading: imageLoading,
                  onTap: () async {
                    try {
                      setState(() {
                        imageLoading = true;
                      });
                      XFile? xFile = (await ImagePicker.platform
                          .getImage(source: ImageSource.camera));
                      if (xFile != null) {
                        File file = File(xFile.path);
                        String id =
                            DateTime.now().millisecondsSinceEpoch.toString();
                        defaultContainerUrl = await uploadFileFirebase
                            .uploadFile(file, id, 'otherDocuments');
                      } else {
                        errorToast("Please Choose the File", context);
                      }
                    } catch (e) {
                      errorToast("oops! some error occur", context);
                      print(e);
                    }
                    setState(() {
                      imageLoading = false;
                    });
                  },
                  image: defaultContainerUrl, //post.imageUrl,
                ),
              ),
            ],
          ),
          Column(
            children: [
              CustomButton(
                isLoading: isButtonLoading,
                postIcon: Icons.arrow_forward_ios,
                labelText: StringValues.submit.english,
                onTap: () async {
                  setState(() {
                    isButtonLoading = true;
                  });

                  if (defaultContainerUrl == null) {
                    errorToast("Please Upload the Image", context);
                    return;
                  }

                  bool api =
                      await apiService.uploadDoc("other", defaultContainerUrl!);
                  if (api) {
                    bool val = await apiService.statusUpdate("video");
                                           successToast(
                                          "Congrats! Documents uploaded",
                                          context);
                    if (val) {
                      Navigator.popAndPushNamed(context, VideoPage.routeNamed);
                    } else
                      errorToast("!OOps Please Try Again", context);
                  }else
                  {
                    errorToast("!OOps Please Try Again", context);
                  }

                  setState(() {
                    isButtonLoading = false;
                  });

                },
                containerColor: Styles.redColor,
              ),
              const SizedBox(
                height: 32,
              ),
            ],
          )
        ],
      ),
    ));
  }
}

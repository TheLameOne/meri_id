import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meri_id/presentation/custom/CustomButton.dart';
import 'package:meri_id/presentation/custom/CustomScaffold.dart';
import 'package:meri_id/presentation/kyc/SvgScreen.dart';
import 'package:meri_id/services/widgets/CustomText.dart';
import 'package:meri_id/utils/styles.dart';

import '../../utils/global.dart';
import '../../utils/strings.dart';

class VideoPage extends StatefulWidget {
  static const String routeNamed = 'videoPage';

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  bool imageLoading = false;
  bool isSubmit = false;
  String? defaultContainerUrl = null;
  bool isButtonLoading = false;

  _routeToSvgScreen() {
    Navigator.popAndPushNamed(context, SvgScreen.routeNamed);
  }

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
                        CustomText.xLargeText(
                          StringValues.videoKYC.english,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        CustomButton(
                          isLoading: imageLoading,
                          postIcon: Icons.arrow_forward_ios,
                          labelText: (isSubmit)
                              ? StringValues.uploadAgain.english
                              : StringValues.record.english,
                          onTap: () async {
                            try {
                              setState(() {
                                imageLoading = true;
                              });
                              PickedFile? pickedFile = (await ImagePicker
                                  .platform
                                  .pickVideo(source: ImageSource.camera));
                              if (pickedFile != null) {
                                File file = File(pickedFile.path);
                                String id = DateTime.now()
                                    .millisecondsSinceEpoch
                                    .toString();
                                defaultContainerUrl = await uploadFileFirebase
                                    .uploadFile(file, id, 'video');
                              } else {
                                errorToast("Please Choose the File", context);
                              }
                            } catch (e) {
                              errorToast("oops! some error occur", context);
                              print(e);
                            }
                            setState(() {
                              imageLoading = false;
                              isSubmit = true;
                            });
                          },
                          containerColor: Styles.redColor,
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        (isSubmit)
                            ? CustomButton(
                                isLoading: isButtonLoading,
                                postIcon: Icons.arrow_forward_ios,
                                labelText: StringValues.submit.english,
                                onTap: () async {
                                  
                                  setState(() {
                                    isButtonLoading = true;
                                  });

                                  if (defaultContainerUrl == null) {
                                    errorToast(
                                        "Please Upload the Image", context);
                                    return;
                                  }
                                  bool api = await apiService.uploadDoc(
                                      "video", defaultContainerUrl!);
                                  if (api) {
                                    bool val = await apiService
                                        .statusUpdate("pending");
                                    if (val) {
                                      Navigator.popAndPushNamed(
                                          context, SvgScreen.routeNamed);
                                      successToast(
                                          "Video Kyc will be checked by Support Team",
                                          context);
                                    } else
                                      errorToast(
                                          "!OOps Please Try Again", context);
                                  } else {
                                    errorToast(
                                        "!OOps Please Try Again", context);
                                  }

                                  setState(() {
                                    isButtonLoading = false;
                                  });

                                },
                                containerColor: Styles.redColor,
                              )
                            : Container(),
                        (isSubmit) ? SizedBox(height: 32) : Container(),
                      ],
                    )
                  ],
                ),
              ));
  }
}

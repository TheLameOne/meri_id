import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meri_id/presentation/SplashPage.dart';
import 'package:meri_id/presentation/custom/CustomButton.dart';
import 'package:meri_id/presentation/custom/CustomImageContainer.dart';
import 'package:meri_id/presentation/custom/CustomScaffold.dart';
import 'package:meri_id/presentation/features/SvgScreen.dart';
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
  bool _language = true;
  bool imageLoading = false;
  bool isLoading = true;
  bool isSubmit = false;
  String defaultContainerUrl =
      'https://cdn4.iconfinder.com/data/icons/human-resources-34/100/Team-02-512.png';
  void initState() {
    super.initState();
    _parent();
  }

  _parent() async {
    await _languageFunction();
    await _loadingOff();
  }

  _loadingOff() {
    setState(() {
      isLoading = false;
    });
  }

  _languageFunction() async {
    bool val = await checkLanguage();
    setState(() {
      _language = val;
    });
  }

  _routeToSvgScreen() {
    Navigator.popAndPushNamed(context, SvgScreen.routeNamed);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        body: (isLoading)
            ? const Center(
                child: CircularProgressIndicator(color: Styles.redColor),
              )
            : Padding(
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
                          (_language)
                              ? StringValues.videoKYC.english
                              : StringValues.videoKYC.hindi,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        CustomButton(
                          isLoading: imageLoading,
                          postIcon: Icons.arrow_forward_ios,
                          labelText: (isSubmit)
                              ? (_language)
                                  ? StringValues.uploadAgain.english
                                  : StringValues.uploadAgain.hindi
                              : (_language)
                                  ? StringValues.record.english
                                  : StringValues.record.hindi,
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
                                postIcon: Icons.arrow_forward_ios,
                                labelText: (_language)
                                    ? StringValues.submit.english
                                    : StringValues.submit.hindi,
                                onTap: () {
                                  _routeToSvgScreen();
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

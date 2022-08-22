import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meri_id/presentation/KYC/AadharPage.dart';
import 'package:meri_id/presentation/custom/CustomButton.dart';
import 'package:meri_id/presentation/custom/CustomImageContainer.dart';
import 'package:meri_id/presentation/custom/CustomScaffold.dart';
import 'package:meri_id/services/widgets/CustomText.dart';
import 'package:meri_id/utils/styles.dart';

import '../../utils/global.dart';
import '../../utils/strings.dart';

class PANPage extends StatefulWidget {
  static const String routeNamed = 'panPage';

  @override
  State<PANPage> createState() => _PANPageState();
}

class _PANPageState extends State<PANPage> {
  bool _language = true;
  bool imageLoading = false;
  bool isLoading = true;
  String? defaultContainerUrl = null;
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

  _routeToAdhar() {
    Navigator.popAndPushNamed(context, AadharPage.routeNamed);
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
                              ? StringValues.uploadPANCard.english
                              : StringValues.uploadPANCard.hindi,
                        ),
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
                                  String id = DateTime.now()
                                      .millisecondsSinceEpoch
                                      .toString();
                                  defaultContainerUrl = await uploadFileFirebase
                                      .uploadFile(file, id, 'pan');
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
                            image: defaultContainerUrl,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        CustomButton(
                          postIcon: Icons.arrow_forward_ios,
                          labelText: (_language)
                              ? StringValues.submit.english
                              : StringValues.submit.hindi,
                          onTap: () {
                            _routeToAdhar();
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

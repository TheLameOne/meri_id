import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:meri_id/presentation/KYC/VideoPage.dart';
import 'package:meri_id/presentation/custom/CustomButton.dart';
import 'package:meri_id/presentation/custom/CustomImageContainer.dart';
import 'package:meri_id/presentation/custom/CustomScaffold.dart';
import 'package:meri_id/services/widgets/CustomText.dart';
import 'package:meri_id/utils/styles.dart';

import '../../utils/global.dart';
import '../../utils/strings.dart';

class OtherDocumentPage extends StatefulWidget {
  static const String routeNamed = 'otherDocumentPage';

  @override
  State<OtherDocumentPage> createState() => _OtherDocumentPageState();
}

class _OtherDocumentPageState extends State<OtherDocumentPage> {
  bool _language = true;
  void initState() {
    super.initState();
    _parent();
  }

  _parent() async {
    await _languageFunction();
  }

  _languageFunction() async {
    bool val = await checkLanguage();
    setState(() {
      _language = val;
    });
  }

  _routeToVideoPage() {
    Navigator.popAndPushNamed(context, VideoPage.routeNamed);
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
                (_language)
                    ? StringValues.uploadOtherDocuments.english
                    : StringValues.uploadOtherDocuments.hindi,
              ),
              Padding(
                padding: const EdgeInsets.all(32),
                child: CustomImageContainer(
                    onTap: () async {
                      try {
                        XFile? file = await ImagePicker.platform
                            .getImage(source: ImageSource.camera);
                        print(file);
                        if (file != null) {
                          String id =
                              DateTime.now().millisecondsSinceEpoch.toString();
                        }
                      } catch (e) {
                        print(e);
                      }
                    },
                    image: Styles.STATIC_LOGO_IMAGE //post.imageUrl,
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
                  _routeToVideoPage();
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

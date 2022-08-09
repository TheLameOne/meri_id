import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meri_id/presentation/SplashPage.dart';
import 'package:meri_id/presentation/custom/CustomButton.dart';
import 'package:meri_id/presentation/custom/CustomImageContainer.dart';
import 'package:meri_id/presentation/custom/CustomScaffold.dart';
import 'package:meri_id/services/widgets/CustomText.dart';
import 'package:meri_id/utils/styles.dart';

class VideoPage extends StatefulWidget {
    static const String routeNamed = 'videoPage';

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {

    _routeToSplashPage() {
    Navigator.pushNamed(context, SplashPage.routeNamed);
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
              CustomText.xLargeText("UPLOAD VIDEO"),
              Padding(
                padding: const EdgeInsets.all(32),
                child: CustomImageContainer(
                    onTap: () async {
                      try {
                        XFile? file = await ImagePicker.platform
                            .getVideo(source: ImageSource.camera);
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
                labelText: "submit",
                onTap: () {
                  _routeToSplashPage();
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

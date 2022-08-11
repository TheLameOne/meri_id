import 'package:flutter/material.dart';
import 'package:meri_id/presentation/custom/CustomButton.dart';
import 'package:meri_id/presentation/custom/CustomIconBox.dart';
import 'package:meri_id/services/widgets/CustomText.dart';
import 'package:meri_id/utils/styles.dart';
import '../features/Feeds.dart';
import '../features/Info.dart';
import '../features/Issue.dart';
import '../features/Language.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  _logOut() {}
  _routeToFeedsPage() {
    Navigator.pushNamed(context, Feeds.routeNamed);
  }

  _routeToLanguagePage() {
    Navigator.pushNamed(context, LanguagePage.routeNamed);
  }

  _routeToIssuePage() {
    Navigator.pushNamed(context, Issue.routeNamed);
  }

  _routeToInfoPage() {
    Navigator.pushNamed(context, Info.routeNamed);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.all(32),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(height: 32),
            CustomText.xLargeText("Profile"),
            const SizedBox(height: 32),
            CustomText.mediumText("Kartikeya Sharma"),
            const SizedBox(height: 16),
            CustomText.mediumText("+917830980280"),
            const SizedBox(height: 32),
            CustomIconBox(
                postIcon: Icons.arrow_forward_ios,
                visiblepostIcon: true,
                labelText: "News Feed",
                containerColor: Styles.grayColor,
                onTap: () {
                  _routeToFeedsPage();
                }),
            const SizedBox(height: 32),
            CustomIconBox(
                postIconSize: 20,
                containerColor: Styles.grayColor,
                postIcon: Icons.arrow_forward_ios,
                visiblepostIcon: true,
                labelText: "Raise Issue",
                onTap: () {
                  _routeToIssuePage();
                  print("harsh");
                }),
            const SizedBox(height: 32),
            CustomIconBox(
                containerColor: Styles.grayColor,
                postIcon: Icons.arrow_forward_ios,
                visiblepostIcon: true,
                postIconSize: 20,
                labelText: "Government Guidelines",
                onTap: () {
                  _routeToInfoPage();
                }),
            const SizedBox(height: 32),
            CustomIconBox(
                postIconSize: 20,
                postIcon: Icons.arrow_forward_ios,
                visiblepostIcon: true,
                labelText: "Language Settings",
                containerColor: Styles.grayColor,
                onTap: () {
                  _routeToLanguagePage();
                }),
            const SizedBox(height: 64),
            CustomButton(
                postIconSize: 20,
                postIcon: Icons.arrow_forward,
                visiblepostIcon: false,
                labelText: "Logout ",
                containerColor: Styles.redColor,
                onTap: () {
                  _logOut();
                }),
          ])),
    );
  }
}

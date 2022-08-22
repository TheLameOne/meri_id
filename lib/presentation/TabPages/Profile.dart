import 'package:flutter/material.dart';
import 'package:meri_id/presentation/custom/CustomButton.dart';
import 'package:meri_id/presentation/custom/CustomIconBox.dart';
import 'package:meri_id/services/widgets/CustomText.dart';
import 'package:meri_id/utils/styles.dart';
import '../../utils/global.dart';
import '../../utils/strings.dart';
import '../auth/FirstPage.dart';
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
  bool _language = true;
  bool _loading = true;
  @override
  void initState() {
    super.initState();
    _parent();
  }

  _parent() async {
    await _languageFunction();
    await _loadingOff();
    await _getProfileData();
  }

  _getProfileData() async {
    await apiService.getProfile();
  }

  _routeToFeedsPage() {
    Navigator.pushNamed(context, Feeds.routeNamed);
  }

  _loadingOff() {
    setState(() {
      _loading = false;
    });
  }

  _languageFunction() async {
    bool val = await checkLanguage();
    _language = val;
  }

  _routeToLanguagePage() {
    Navigator.pop(context);
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
    return (_loading)
        ? const Center(
            child: CircularProgressIndicator(
              color: Styles.redColor,
            ),
          )
        : SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText.xLargeText((_language)
                          ? StringValues.profile.english
                          : StringValues.profile.hindi),
                      const SizedBox(height: 32),
                      CustomText.mediumText(userProfile.name),
                      const SizedBox(height: 16),
                      CustomText.mediumText("+91${userProfile.number}"),
                      const SizedBox(height: 32),
                      CustomIconBox(
                          postIcon: Icons.arrow_forward_ios,
                          visiblepostIcon: true,
                          labelText: (_language)
                              ? StringValues.newsFeed.english
                              : StringValues.newsFeed.hindi,
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
                          labelText: (_language)
                              ? StringValues.raiseIssue.english
                              : StringValues.raiseIssue.hindi,
                          onTap: () {
                            _routeToIssuePage();
                          }),
                      const SizedBox(height: 32),
                      CustomIconBox(
                          containerColor: Styles.grayColor,
                          postIcon: Icons.arrow_forward_ios,
                          visiblepostIcon: true,
                          postIconSize: 20,
                          labelText: (_language)
                              ? StringValues.guidelines.english
                              : StringValues.guidelines.hindi,
                          onTap: () {
                            _routeToInfoPage();
                          }),
                      const SizedBox(height: 32),
                      CustomIconBox(
                          postIconSize: 20,
                          postIcon: Icons.arrow_forward_ios,
                          visiblepostIcon: true,
                          labelText: (_language)
                              ? StringValues.languageSettings.english
                              : StringValues.languageSettings.hindi,
                          containerColor: Styles.grayColor,
                          onTap: () {
                            _routeToLanguagePage();
                          }),
                      const SizedBox(height: 64),
                      CustomButton(
                          isLoading: isLogOutLoading,
                          postIconSize: 20,
                          postIcon: Icons.arrow_forward,
                          visiblepostIcon: false,
                          labelText: (_language)
                              ? StringValues.logout.english
                              : StringValues.logout.hindi,
                          containerColor: Styles.redColor,
                          onTap: () {
                            setState(() {
                              isLogOutLoading = true;
                            });
                            currentPage = 0;
                            apiService.logOut();
                            setState(() {
                              isLogOutLoading = false;
                            });
                            Navigator.popAndPushNamed(
                                context, FirstPage.routeNamed);
                          }),
                    ])),
          );
  }

  bool isLogOutLoading = false;
}

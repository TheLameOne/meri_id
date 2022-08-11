import 'package:flutter/material.dart';
import 'package:meri_id/presentation/custom/CustomButton.dart';
import 'package:meri_id/presentation/custom/CustomIconBox.dart';
import 'package:meri_id/services/widgets/CustomText.dart';
import 'package:meri_id/utils/styles.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  _logOut() {}
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 const SizedBox(height: 32),
                CustomText.xLargeText("Profile"),
                const SizedBox(height: 32),
                CustomText.mediumText("Kartikeya Sharma")  ,
                const SizedBox(height: 16),
                CustomText.mediumText("+917830980280")  ,
                const SizedBox(height: 32),
                 CustomIconBox(
                   postIcon: Icons.arrow_forward_ios,
                  visiblepostIcon: true,
                  labelText: "News Feed",
                  containerColor: Styles.grayColor,
                  onTap: () {
                  }),
                     const SizedBox(height: 32),
                    CustomIconBox(
                           postIconSize: 20,
                             containerColor: Styles.grayColor,
                   postIcon: Icons.arrow_forward_ios,
                  visiblepostIcon: true,
                  labelText: "Raise Issue",
                  onTap: () {
              
                  }),
                     const SizedBox(height: 32),
                    CustomIconBox(
                             containerColor: Styles.grayColor,
                   postIcon: Icons.arrow_forward_ios,
                  visiblepostIcon: true,
                  postIconSize: 20,
                  labelText: "Government Guidelines",
                  onTap: () {
        
                  }),
                    const SizedBox(height: 32),
                   CustomIconBox(
                          postIconSize: 20,
                  postIcon: Icons.arrow_forward_ios,
                  visiblepostIcon: true,
                  labelText: "Change Language",
                  containerColor: Styles.grayColor,
                  onTap: () {
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

import 'package:flutter/material.dart';
import 'package:meri_id/presentation/custom/CustomButton.dart';
import 'package:meri_id/presentation/custom/CustomScaffold.dart';
import 'package:meri_id/presentation/custom/CustomTextField.dart';

class AddFriend extends StatefulWidget {
  static const String routeNamed = "AddFriend";

  @override
  State<AddFriend> createState() => _AddFriendState();
}

class _AddFriendState extends State<AddFriend> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CustomScaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 60,
              ),
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Text(
                  "Add Friend",
                  style: TextStyle(fontSize: 32, color: Colors.grey[700]),
                ),
              ),
              const SizedBox(height: 32),
              CustomTextField(
                hintText: "Adhar Number",
                hintTextSize: 16,
                initialValue: '',
                onChanged: () {},
                onSaved: () {},
                validator: () {},
                labelText: 'Enter Adhar Number',
              ),
              CustomTextField(
                hintText: "eg. 7451985966",
                hintTextSize: 16,
                initialValue: '',
                onChanged: () {},
                onSaved: () {},
                validator: () {},
                labelText: 'Enter Phone Number',
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                hintText: "XXXXXX",
                hintTextSize: 16,
                initialValue: '',
                onChanged: () {},
                onSaved: () {},
                validator: () {},
                labelText: 'Enter OTP',
              ),
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: CustomButton(
                    postIcon: Icons.arrow_forward_ios,
                    visiblepostIcon: true,
                    labelText: "Submit ",
                    onTap: () {
                      //_routeToSplashPage()
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

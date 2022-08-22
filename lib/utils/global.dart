import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meri_id/services/PreferenceService.dart';
import 'package:meri_id/utils/styles.dart';

import '../model/UserProfile.dart';
import '../services/ApiService.dart';
import '../services/FirebaseStorage.dart';

var currentPage = 0;
var role = "user";
UserProfile userProfile = UserProfile(name: "", number: "", userId: "");

final PreferenceService preferenceService = PreferenceService.getInstance();
final ApiService apiService = ApiService.getInstance();
final UploadFileFirebase uploadFileFirebase = UploadFileFirebase.getInstance();

String? validateEmail(String email) {
  if (email == null || email.isEmpty) return 'Required !!!';
  RegExp regex = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  return (!regex.hasMatch(email)) ? 'Valid Email!!' : null;
}

String? validateName(String name) {
  String? required = requiredString(name);
  if (required != null) return required;
  RegExp regex = RegExp(r'^[ a-zA-Z]*$');
  return (!regex.hasMatch(name)) ? 'Valid Name!!' : null;
}

String? validatePhone(String phone) {
  String? required = requiredString(phone);
  if (required != null) return required;

  RegExp regex = RegExp(r'^(?:[+0]9)?[0-9]{10}$');
  return (!regex.hasMatch(phone)) ? 'Valid Phone Number!!' : null;
}

String? requiredString(String value) {
  if (value == null || value.isEmpty) return 'Required !!!';
  return null;
}

Future<bool> checkLanguage() async =>
    (await preferenceService.getLanguage() == null ||
        await preferenceService.getLanguage() == "english");


String? validateOtp(String otp) {
  String? required = requiredString(otp);
  if (required != null) return required;

  RegExp regex = RegExp(r'^[0-9]{1,6}$');
  return (!regex.hasMatch(otp)) ? 'Valid Otp!!' : null;
}



Widget customizedLeadingIconWidget(String message) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: Styles.blackColor,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(message, style: const TextStyle(color: Styles.backgroundColor , fontSize: 16 , fontWeight: FontWeight.w500))
      ],
    ),
  );
}

void errorToast(String message, BuildContext context) {
  var fToast = FToast();
  fToast.init(context);
  fToast.showToast(
      child: customizedLeadingIconWidget(message), gravity: ToastGravity.TOP);
}

Widget successIconWidget(String message) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: Color.fromARGB(255, 18, 191, 222),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(message, style: const TextStyle(color: Styles.backgroundColor ,  fontSize: 16))
      ],
    ),
  );
}

void successToast(String message, BuildContext context) {
  var fToast = FToast();
  fToast.init(context);
  fToast.showToast(
      child: successIconWidget(message), gravity: ToastGravity.TOP );
}

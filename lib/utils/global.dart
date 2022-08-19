import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meri_id/services/PreferenceService.dart';
import 'package:meri_id/utils/styles.dart';

import '../services/FirebaseStorage.dart';

var currentPage = 0;
var role = "user";

final PreferenceService preferenceService = PreferenceService.getInstance();
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

// Widget _dialoque() {
//   return Builder(builder: (context) {
//     return AlertDialog(
//       title: const Text('In Which Language you want to use App'),
//       actions: <Widget>[
//         TextButton(
//           child: const Text('Hindi'),
//           onPressed: () {
//             setState(() {
//               _language = false;
//               preferenceService.setLanguage("hindi");
//               _isVisible = false;
//             });
//           },
//         ),
//         TextButton(
//           child: const Text('English'),
//           onPressed: () {
//             setState(() {
//               preferenceService.setLanguage("english");
//               _isVisible = false;
//             });
//           },
//         ),
//       ],
//     );
//   });
// }

Widget customizedLeadingIconWidget(String message) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: Styles.blackColor,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(message, style: const TextStyle(color: Styles.backgroundColor))
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

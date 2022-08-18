import 'package:meri_id/services/PreferenceService.dart';

var currentPage = 0;
var role = "user";

final PreferenceService preferenceService = PreferenceService.getInstance();

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

import 'dart:convert';

import 'package:http/http.dart';
import 'package:meri_id/model/Address.dart';
import 'package:meri_id/model/Booking.dart';

import '../model/UserProfile.dart';
import '../utils/global.dart';
import 'PreferenceService.dart';

class ApiService {
  ApiService._();
  factory ApiService.getInstance() => _instance;
  static final ApiService _instance = ApiService._();

  final String baseUrl = "https://meriid.herokuapp.com/api";
  final String role = 'user';
  final String token = 'Token';

  Future<bool> getOtp(String phoneNumber) async {
    final String url = "$baseUrl/auth/otp-send";
    Response res = await post(
      Uri.parse(url),
      headers: {'content-type': 'application/json'},
      body: jsonEncode(
          <String, String>{'phone_number': phoneNumber, 'role': role}),
    );
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      return true;
    }
    return false;
  }

  Future<bool> login(String phoneNumber, String otp) async {
    final String url = "$baseUrl/auth/login";
    Response res = await post(
      Uri.parse(url),
      headers: {'content-type': 'application/json'},
      body:
          jsonEncode(<String, String>{'phone_number': phoneNumber, 'otp': otp}),
    );

    if (res.statusCode == 201) {
      var body = jsonDecode(res.body);
      await preferenceService.setUID(body["data"]["token"]);
      return true;
    }
    return false;
  }

  Future<String> currentStatus() async {
    String? authId = await preferenceService.getUID();
    final String url = "$baseUrl/auth/current-status";
    Response res = await get(
      Uri.parse(url),
      headers: {
        'content-type': 'application/json',
        'Authorization': '$token $authId'
      },
    );
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      return body["data"]["status"];
    }
    return "";
  }

  Future<bool> statusUpdate(String status) async {
    String? authId = await preferenceService.getUID();
    final String url = "$baseUrl/auth/user/status/update";
    Response res = await post(
      Uri.parse(url),
      headers: {
        'content-type': 'application/json',
        'Authorization': '$token $authId'
      },
      body: jsonEncode(<String, String>{'status': status}),
    );
    print(res.body);
    print(res.statusCode);
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      return true;
    }
    return false;
  }

  Future<bool> uploadDoc(String docType, String link) async {
    String? authId = await preferenceService.getUID();
    final String url = "$baseUrl/auth/user/docs/update";
    Response res = await put(
      Uri.parse(url),
      headers: {
        'content-type': 'application/json',
        'Authorization': '$token $authId'
      },
      body: jsonEncode(<String, String>{'doc_type': docType, 'link': link}),
    );
    print(res.body);
    print(res.statusCode);
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      return true;
    }
    return false;
  }

  Future<bool> logOut() async {
    await preferenceService.removeUID();
    return true;
  }

  Future<UserProfile> getProfile() async {
    String authId = await PreferenceService.uid;
    final String url = "$baseUrl/auth/profile";

    Response res = await get(
      Uri.parse(url),
      headers: {
        'content-type': 'application/json',
        'Authorization': '$token $authId'
      },
    );

    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      return UserProfile(
        uuid: body['data']['uuid'],
        name: body['data']['name'],
        number: body['data']['phone_number'],
      );
    }
    return UserProfile(name: "", number: "", uuid: "");
  }

  Future<bool> raiseIssue(String title, String description) async {
    String authId = await PreferenceService.uid;
    final String url = "$baseUrl/auth/issue";

    Response res = await post(Uri.parse(url),
        headers: {
          'content-type': 'application/json',
          'Authorization': '$token $authId'
        },
        body: jsonEncode(<String, String>{
          'title': title,
          'description': description,
          'user': userProfile.uuid
        }));

    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      return true;
    }
    return false;
  }

  Future<String> getGuildeLines() async {
    final String url = "$baseUrl/general/guidelines?role=user";
    Response res = await get(Uri.parse(url));
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      return body["data"][0]["guideline"];
    }
    return "No GuidelInes";
  }

  Future<bool> createBooking(Booking booking) async {
    String authId = await PreferenceService.uid;
    var address = new Map();
    address['address_line_1'] = booking.address.addressLine1;
    address['address_line_2'] = booking.address.addressLine2;
    address['city'] = booking.address.city;
    address['pincode'] = booking.address.pincode;
    address['state'] = booking.address.state;
    address['latitude'] = booking.address.lat;
    address['longitude'] = booking.address.long;

    var friends = List<Map>;
    friends['name'] = booking.friends.name;
    friends['phoneNumber'] = booking.friends.phoneNumber;
    friends['reason'] = booking.friends.reason;

    final String url = "$baseUrl/booking/booking";
    Response res = await post(Uri.parse(url),
        headers: {
          'content-type': 'application/json',
          'Authorization': '$token $authId'
        },
        body: jsonEncode(<String, String>{
          'address': address.toString(),
          'friends': friends.toString(),
        }));

    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      return true;
    }
    return false;
  }
}

import 'dart:convert';

import 'package:http/http.dart';

import '../model/UserProfile.dart';
import '../utils/global.dart';
import 'PreferenceService.dart';

class ApiService {
  ApiService._();
  factory ApiService.getInstance() => _instance;
  static final ApiService _instance = ApiService._();
  
  final String baseUrl = "https://meriid.herokuapp.com/api";
  final String role = 'operator';
  final String token = 'Token';

  Future<bool> getOtp(String phoneNumber) async {
    final String url = "$baseUrl/auth/otp-send";
    Response res = await post(
      Uri.parse(url),
      headers: {'content-type': 'application/json'},
      body: jsonEncode(
          <String, String>{'phone_number': phoneNumber, 'role': role}),
    );
    print(res.body);
    print(res.statusCode);
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


  Future<bool> currentStatus(String phoneNumber, String otp) async {
    String authId = await PreferenceService.uid;
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
          name: body['data']['name'],
          number: body['data']['phone_number'],
          userId: body['data']['user']);
    }
    return UserProfile(name: "", number: "", userId: "");
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
          'user': userProfile.userId
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


  Future<bool> punchInAttendance(String date, String time) async {
    String authId = await PreferenceService.uid;
    final String url = "$baseUrl/auth/issue";
    Response res = await post(Uri.parse(url),
        headers: {
          'content-type': 'application/json',
          'Authorization': '$token $authId'
        },
        body: jsonEncode(<String, String>{
          "date": date,
          "punch_in": time,
        }));

    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      return true;
    }
    return false;
  }

  Future<bool> punchOutAttendance(String date, String time) async {
    String authId = await PreferenceService.uid;
    final String url = "$baseUrl/auth/issue";
    Response res = await post(Uri.parse(url),
        headers: {
          'content-type': 'application/json',
          'Authorization': '$token $authId'
        },
        body: jsonEncode(<String, String>{
          "date": date,
          "punch_out": time,
        }));

    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      return true;
    }
    return false;
  }
}

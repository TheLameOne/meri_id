import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart';
import 'package:meri_id/model/Book.dart';
import 'package:meri_id/model/Booking.dart';
import 'package:meri_id/model/Friends.dart';
import 'package:meri_id/model/Loc.dart';
import 'package:meri_id/model/Payment.dart';
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

  Future<void> getProfile() async {
    String? authId = await preferenceService.getUID();
    final String url = "$baseUrl/auth/profile/user";

    Response res = await get(
      Uri.parse(url),
      headers: {
        'content-type': 'application/json',
        'Authorization': '$token $authId'
      },
    );
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      userProfile = UserProfile(
        uuid: body['data']['uuid'],
        name: body['data']['name'],
        number: body['data']['phone_number'],
      );
    }
  }

  Future<bool> raiseIssue(String title, String description) async {
    String? authId = await preferenceService.getUID();
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

  Future<String> createBooking(Booking booking) async {
    String? authId = await preferenceService.getUID();
    final String url = "$baseUrl/booking/booking";
    var body = jsonEncode(<dynamic, dynamic>{
      'address': {
        'address_line_1': booking.address?.address_line_1,
        'address_line_2': booking.address?.address_line_2,
        'city': booking.address?.city,
        'state': booking.address?.state,
        'pincode': booking.address?.pincode,
        'latitude': booking.address?.latitude,
        'longitude': booking.address?.longitude
      },
      'slot_date': booking.slot_date,
      'slot_time' : booking.slot_time,
      'preference': booking.preference,
      'friends': [
        {
          'name': booking.friends?[0].name,
          'phone_number': booking.friends?[0].phone_number,
          'reason': booking.friends?[0].reason,
          'booking_type': booking.friends?[0].booking_type
        },
        {
          'name': booking.friends?[1].name,
          'phone_number': booking.friends?[1].phone_number,
          'reason': booking.friends?[1].reason,
          'booking_type': booking.friends?[1].booking_type
        },
        {
          'name': booking.friends?[2].name,
          'phone_number': booking.friends?[2].phone_number,
          'reason': booking.friends?[2].reason,
          'booking_type': booking.friends?[2].booking_type
        }
      ],
      'payment': {
        'amount': booking.payment?.amount,
        'from_user': booking.payment?.from_user
      }
    });

    print(body);

    Response res = await post(Uri.parse(url),
        headers: {
          'content-type': 'application/json',
          'Authorization': '$token $authId'
        },
        body: body);
    print(res.body);
    print(res.statusCode);
    if (res.statusCode == 201) {
      var body = jsonDecode(res.body);
      return body["data"]["booking_id"];
    }
    return "";
  }

  Future<List<Book>> getBooking() async {
    List<Book> ls = [];
    final String url = "$baseUrl/booking/booking";
    String? authId = await preferenceService.getUID();
    Response res = await get(Uri.parse(url), headers: {
      'content-type': 'application/json',
      'Authorization': '$token $authId'
    });
    print(res.body);
    print(res.statusCode);
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      for (int i = 0; i < body['data'].length; i++) {
        Book x = Book();
        List<Friends> fList = [];
        x.address = body["data"][i]["address"];
        x.uuid = body["data"][i]["uuid"];
        x.bookingId = body["data"][i]["booking_id"];
        x.slotDate = body["data"][i]["slot_date"];
        x.slotTime = body["data"][i]["slot_time"];
        x.operator = Operator(
            name: body["data"][i]["operator"]["name"],
            phoneNumber: body["data"][i]["operator"]["phone_number"]);
        for (int j = 0; j < body["data"][i]["friends"].length; j++) {
          fList.add(Friends(
              name: body["data"][i]["friends"][j]["name"],
              phone_number: body["data"][i]["friends"][j]["phone_number"]));
        }
        x.friendList = fList;
        ls.add(x);
      }
    }
    return ls;
  }

  Future<Loc> getLoc(String uuid) async {
    String? authId = await preferenceService.getUID();
    final String url = "$baseUrl/booking/booking/location/${uuid}";
    Response res = await get(
      Uri.parse(url),
      headers: {
        'content-type': 'application/json',
        'Authorization': '$token $authId'
      },
    );

    print(res.body);
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);

      return Loc(
        opLat: body["data"]["operator"]["lat"],
        opLong: body["data"]["operator"]["lng"],
        bookLat: body["data"]["booking"]["lat"],
        bookLong: body["data"]["booking"]["lng"],
        gender: body["data"]["gender"],
      );
    }
    return Loc();
  }
}

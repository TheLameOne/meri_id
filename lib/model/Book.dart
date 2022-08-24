import 'package:meri_id/model/Address.dart';
import 'package:meri_id/model/Friends.dart';
import 'package:meri_id/model/Payment.dart';

class Operator {
  late String name;
  late String phoneNumber;
  Operator({this.name = "", this.phoneNumber = ""});
}

class Book {
  late String address;
  late String slotDate;
  late String slotTime;
  late List<Friends>? friendList;
  late Operator? operator;
  late String uuid;
  late String bookingId;
  Book(
      {this.address = "",
      this.slotDate = "",
      this.slotTime = "",
      this.uuid = "",
      this.bookingId = "",
      this.friendList,
      this.operator});
}

import 'package:meri_id/model/Address.dart';
import 'package:meri_id/model/Friends.dart';
import 'package:meri_id/model/Payment.dart';

class Booking {
  late Address? address;
  late String? slot_date;
  late List<Friends>? friends;
  late Payment? payment;
  late String preference = "male";
  late String? slot_time;
  Booking(
      {this.address,
      this.slot_date,
      this.friends,
      this.payment,
      this.preference = "male" , 
      this.slot_time});
}

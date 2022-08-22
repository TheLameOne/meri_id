import 'package:meri_id/model/Address.dart';
import 'package:meri_id/model/Friends.dart';
import 'package:meri_id/model/Payment.dart';

class Booking {
  late Address? address;
  late String? slot_date;
  late List<Friends>? friends;
  late Payment? payment;

  Booking({
  this.address = null,
  this.slot_date = null,
  this.friends = null,
  this.payment = null
  });
}

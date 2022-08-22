import 'package:meri_id/model/Address.dart';
import 'package:meri_id/model/Friends.dart';

class Booking {
  late Address address;
  late String slotDate;
  late String bookingType;
  late Friends friends;

  Booking({
    required this.address,
    required this.slotDate,
    required this.bookingType,
    required this.friends,
  });
}

class Address {
  late String address_line_1;
  late String address_line_2;
  late String city;
  late String state;
  late String pincode;
  late String latitude;
  late String longitude;

  Address(
      {required this.address_line_1,
      required this.address_line_2,
      required this.city,
      required this.state,
      required this.pincode,
      required this.latitude,
      required this.longitude});
}


class DataUserList {
  late String name;
  late String nop_pbb;
  late String email;
  late String address;
  late int waste_volume;

  DataUserList(
      {required this.name,
      required this.nop_pbb,
      required this.email,
      required this.address,
      required this.waste_volume});

      @override
  String toString() {
    return 'DataUserList{name: $name, nop_pbb: $nop_pbb, email: $email, address: $address, waste_volume: $waste_volume}';
  }

}

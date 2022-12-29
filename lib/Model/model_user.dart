class DataUser {
  bool? success;
  Data? data;
  int? message;

  DataUser({this.success, this.data, this.message});

  DataUser.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  User? user;
  Zone? zone;

  Data({this.user, this.zone});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    zone = json['zone'] != null ? new Zone.fromJson(json['zone']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.zone != null) {
      data['zone'] = this.zone!.toJson();
    }
    return data;
  }
}

class User {
  String? name;
  String? nopPbb;
  String? email;
  String? address;
  String? phoneNumber;
  int? wasteVolume;

  User(
      {this.name,
      this.nopPbb,
      this.email,
      this.address,
      this.phoneNumber,
      this.wasteVolume});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    nopPbb = json['nop_pbb'];
    email = json['email'];
    address = json['address'];
    phoneNumber = json['phone_number'];
    wasteVolume = json['waste_volume'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['nop_pbb'] = this.nopPbb;
    data['email'] = this.email;
    data['address'] = this.address;
    data['phone_number'] = this.phoneNumber;
    data['waste_volume'] = this.wasteVolume;
    return data;
  }
}

class Zone {
  String? transportationType;
  String? transportZone;
  int? rateInNumber;
  String? rateInRupiah;
  String? volume;
  int? monthlyBillInNumber;
  String? monthlyBillInRupiah;

  Zone(
      {this.transportationType,
      this.transportZone,
      this.rateInNumber,
      this.rateInRupiah,
      this.volume,
      this.monthlyBillInNumber,
      this.monthlyBillInRupiah});

  Zone.fromJson(Map<String, dynamic> json) {
    transportationType = json['transportation_type'];
    transportZone = json['transport_zone'];
    rateInNumber = json['rate_in_number'];
    rateInRupiah = json['rate_in_rupiah'];
    volume = json['volume'];
    monthlyBillInNumber = json['monthly_bill_in_number'];
    monthlyBillInRupiah = json['monthly_bill_in_rupiah'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['transportation_type'] = this.transportationType;
    data['transport_zone'] = this.transportZone;
    data['rate_in_number'] = this.rateInNumber;
    data['rate_in_rupiah'] = this.rateInRupiah;
    data['volume'] = this.volume;
    data['monthly_bill_in_number'] = this.monthlyBillInNumber;
    data['monthly_bill_in_rupiah'] = this.monthlyBillInRupiah;
    return data;
  }
}

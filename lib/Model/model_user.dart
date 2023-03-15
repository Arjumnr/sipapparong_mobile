class DataUser {
  bool? success;
  Data? data;
  int? message;

  DataUser({this.success, this.data, this.message});

  DataUser.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class Data {
  User? user;
  Zone? zone;

  Data({this.user, this.zone});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    zone = json['zone'] != null ? Zone.fromJson(json['zone']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (zone != null) {
      data['zone'] = zone!.toJson();
    }
    return data;
  }
}

class User {
  String? name;
  String? npwr;
  String? email;
  String? address;
  String? phoneNumber;
  String? wasteVolume;

  User(
      {this.name,
      this.npwr,
      this.email,
      this.address,
      this.phoneNumber,
      this.wasteVolume});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    npwr = json['npwr'];
    email = json['email'];
    address = json['address'];
    phoneNumber = json['phone_number'];
    wasteVolume = json['waste_volume'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['npwr'] = npwr;
    data['email'] = email;
    data['address'] = address;
    data['phone_number'] = phoneNumber;
    data['waste_volume'] = wasteVolume;
    return data;
  }
}

class Zone {
  String? transportationType;
  String? transportZone;
  int? rateInNumber;
  String? rateInRupiah;
  int? monthlyBillInNumber;
  String? monthlyBillInRupiah;

  Zone(
      {this.transportationType,
      this.transportZone,
      this.rateInNumber,
      this.rateInRupiah,
      this.monthlyBillInNumber,
      this.monthlyBillInRupiah});

  Zone.fromJson(Map<String, dynamic> json) {
    transportationType = json['transportation_type'];
    transportZone = json['transport_zone'];
    rateInNumber = json['rate_in_number'];
    rateInRupiah = json['rate_in_rupiah'];
    monthlyBillInNumber = json['monthly_bill_in_number'];
    monthlyBillInRupiah = json['monthly_bill_in_rupiah'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['transportation_type'] = transportationType;
    data['transport_zone'] = transportZone;
    data['rate_in_number'] = rateInNumber;
    data['rate_in_rupiah'] = rateInRupiah;
    data['monthly_bill_in_number'] = monthlyBillInNumber;
    data['monthly_bill_in_rupiah'] = monthlyBillInRupiah;
    return data;
  }
}

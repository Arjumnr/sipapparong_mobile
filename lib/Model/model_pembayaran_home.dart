class ModelHome {
  bool? success;
  Data? data;
  String? message;

  ModelHome({this.success, this.data, this.message});

  ModelHome.fromJson(Map<String, dynamic> json) {
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
  LatestMonthlyBill? latestMonthlyBill;

  Data({this.user, this.zone, this.latestMonthlyBill});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    zone = json['zone'] != null ? Zone.fromJson(json['zone']) : null;
    latestMonthlyBill = json['latest_monthly_bill'] != null
        ? LatestMonthlyBill.fromJson(json['latest_monthly_bill'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (zone != null) {
      data['zone'] = zone!.toJson();
    }
    if (latestMonthlyBill != null) {
      data['latest_monthly_bill'] = latestMonthlyBill!.toJson();
    }
    return data;
  }
}

class User {
  String? npwr;
  String? name;
  String? email;
  String? address;
  String? phoneNumber;
  String? wasteVolume;

  User(
      {this.npwr,
      this.name,
      this.email,
      this.address,
      this.phoneNumber,
      this.wasteVolume});

  User.fromJson(Map<String, dynamic> json) {
    npwr = json['npwr'];
    name = json['name'];
    email = json['email'];
    address = json['address'];
    phoneNumber = json['phone_number'];
    wasteVolume = json['waste_volume'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['npwr'] = npwr;
    data['name'] = name;
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

class LatestMonthlyBill {
  String? number;
  String? date;
  int? totalInNumber;
  String? totalInRupiah;
  String? snapToken;
  String? orderId;
  String? paidStatus;
  String? dateInMonthYear;

  LatestMonthlyBill(
      {this.number,
      this.date,
      this.totalInNumber,
      this.totalInRupiah,
      this.snapToken,
      this.orderId,
      this.paidStatus,
      this.dateInMonthYear});

  LatestMonthlyBill.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    date = json['date'];
    totalInNumber = json['total_in_number'];
    totalInRupiah = json['total_in_rupiah'];
    snapToken = json['snap_token'];
    orderId = json['order_id'];
    paidStatus = json['paid_status'];
    dateInMonthYear = json['date_in_month_year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['number'] = number;
    data['date'] = date;
    data['total_in_number'] = totalInNumber;
    data['total_in_rupiah'] = totalInRupiah;
    data['snap_token'] = snapToken;
    data['order_id'] = orderId;
    data['paid_status'] = paidStatus;
    data['date_in_month_year'] = dateInMonthYear;
    return data;
  }
}

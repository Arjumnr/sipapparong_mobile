class ModelHome {
  bool? success;
  Data? data;
  String? message;

  ModelHome({this.success, this.data, this.message});

  ModelHome.fromJson(Map<String, dynamic> json) {
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
  LatestMonthlyBill? latestMonthlyBill;

  Data({this.user, this.zone, this.latestMonthlyBill});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    zone = json['zone'] != null ? new Zone.fromJson(json['zone']) : null;
    latestMonthlyBill = json['latest_monthly_bill'] != null
        ? new LatestMonthlyBill.fromJson(json['latest_monthly_bill'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.zone != null) {
      data['zone'] = this.zone!.toJson();
    }
    if (this.latestMonthlyBill != null) {
      data['latest_monthly_bill'] = this.latestMonthlyBill!.toJson();
    }
    return data;
  }
}

class User {
  String? nopPbb;
  String? name;
  String? email;
  String? address;
  String? phoneNumber;
  int? wasteVolume;

  User(
      {this.nopPbb,
      this.name,
      this.email,
      this.address,
      this.phoneNumber,
      this.wasteVolume});

  User.fromJson(Map<String, dynamic> json) {
    nopPbb = json['nop_pbb'];
    name = json['name'];
    email = json['email'];
    address = json['address'];
    phoneNumber = json['phone_number'];
    wasteVolume = json['waste_volume'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nop_pbb'] = this.nopPbb;
    data['name'] = this.name;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['number'] = this.number;
    data['date'] = this.date;
    data['total_in_number'] = this.totalInNumber;
    data['total_in_rupiah'] = this.totalInRupiah;
    data['snap_token'] = this.snapToken;
    data['order_id'] = this.orderId;
    data['paid_status'] = this.paidStatus;
    data['date_in_month_year'] = this.dateInMonthYear;
    return data;
  }
}

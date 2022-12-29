import 'dart:convert';

class ModelTagihan {
  ModelTagihan({
    required this.success,
    required this.data,
    required this.message,
  });

  bool success;
  Data data;
  int message;

  factory ModelTagihan.fromJson(String str) =>
      ModelTagihan.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ModelTagihan.fromMap(Map<String, dynamic> json) => ModelTagihan(
        success: json["success"],
        data: Data.fromMap(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "data": data.toMap(),
        "message": message,
      };
}

class Data {
  Data({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,
    required this.to,
    required this.total,
  });

  int currentPage;
  List<Datum> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  List<Link> links;
  dynamic nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: List<Link>.from(json["links"].map((x) => Link.fromMap(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toMap() => {
        "current_page": currentPage,
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": List<dynamic>.from(links.map((x) => x.toMap())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class Datum {
  Datum(
      {required this.id,
      required this.userId,
      required this.number,
      required this.date,
      required this.total,
      required this.snapToken,
      required this.orderId,
      required this.paidStatus,
      required this.createdAt,
      required this.updatedAt,
      required this.totalInRupiah,
      required this.dateInMonthYear});

  int id;
  int userId;
  String number;
  DateTime date;
  int total;
  String snapToken;
  String orderId;
  String paidStatus;
  DateTime createdAt;
  DateTime updatedAt;
  String totalInRupiah;
  String dateInMonthYear;

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["id"],
        userId: json["user_id"],
        number: json["number"],
        date: DateTime.parse(json["date"]),
        total: json["total"],
        snapToken: json["snap_token"],
        orderId: json["order_id"],
        paidStatus: json["paid_status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        totalInRupiah: json["total_in_rupiah"],
        dateInMonthYear: json["date_in_month_year"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "user_id": userId,
        "number": number,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "total": total,
        "snap_token": snapToken,
        "order_id": orderId,
        "paid_status": paidStatus,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "total_in_rupiah": totalInRupiah,
        "date_in_month_year": dateInMonthYear,
      };
}

class Link {
  Link({
    required this.url,
    required this.label,
    required this.active,
  });

  String url;
  String label;
  bool active;

  factory Link.fromJson(String str) => Link.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Link.fromMap(Map<String, dynamic> json) => Link(
        url: json["url"] == null ? null : json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toMap() => {
        "url": url == null ? null : url,
        "label": label,
        "active": active,
      };
}

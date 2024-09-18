// To parse this JSON data, do
//
//     final preApprovedHistoryModel = preApprovedHistoryModelFromJson(jsonString);

import 'dart:convert';

PreApprovedHistoryModel preApprovedHistoryModelFromJson(String str) =>
    PreApprovedHistoryModel.fromJson(json.decode(str));

String preApprovedHistoryModelToJson(PreApprovedHistoryModel data) =>
    json.encode(data.toJson());

class PreApprovedHistoryModel {
  String? message;
  bool? success;
  List<Datum>? data;

  PreApprovedHistoryModel({
    this.message,
    this.success,
    this.data,
  });

  factory PreApprovedHistoryModel.fromJson(Map<String, dynamic> json) =>
      PreApprovedHistoryModel(
        message: json["message"],
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "success": success,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  int? id;
  int? gatekeeperid;
  int? userid;
  String? visitortype;
  String? name;
  String? description;
  String? cnic;
  String? mobileno;
  String? vechileno;
  DateTime? arrivaldate;
  String? arrivaltime;
  int? status;
  String? statusdescription;
  dynamic checkintime;
  dynamic checkouttime;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? fromDate;
  DateTime? toDate;

  Datum({
    this.id,
    this.gatekeeperid,
    this.userid,
    this.visitortype,
    this.name,
    this.description,
    this.cnic,
    this.mobileno,
    this.vechileno,
    this.arrivaldate,
    this.arrivaltime,
    this.status,
    this.statusdescription,
    this.checkintime,
    this.checkouttime,
    this.createdAt,
    this.updatedAt,
    this.fromDate,
    this.toDate,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        gatekeeperid: json["gatekeeperid"],
        userid: json["userid"],
        visitortype: json["visitortype"],
        name: json["name"],
        description: json["description"],
        cnic: json["cnic"],
        mobileno: json["mobileno"],
        vechileno: json["vechileno"],
        arrivaldate: json["arrivaldate"] == null
            ? null
            : DateTime.parse(json["arrivaldate"]),
        arrivaltime: json["arrivaltime"],
        status: json["status"],
        statusdescription: json["statusdescription"],
        checkintime: json["checkintime"],
        checkouttime: json["checkouttime"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        fromDate: json["from_date"] == null
            ? null
            : DateTime.parse(json["from_date"]),
        toDate:
            json["to_date"] == null ? null : DateTime.parse(json["to_date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "gatekeeperid": gatekeeperid,
        "userid": userid,
        "visitortype": visitortype,
        "name": name,
        "description": description,
        "cnic": cnic,
        "mobileno": mobileno,
        "vechileno": vechileno,
        "arrivaldate":
            "${arrivaldate!.year.toString().padLeft(4, '0')}-${arrivaldate!.month.toString().padLeft(2, '0')}-${arrivaldate!.day.toString().padLeft(2, '0')}",
        "arrivaltime": arrivaltime,
        "status": status,
        "statusdescription": statusdescription,
        "checkintime": checkintime,
        "checkouttime": checkouttime,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "from_date":
            "${fromDate!.year.toString().padLeft(4, '0')}-${fromDate!.month.toString().padLeft(2, '0')}-${fromDate!.day.toString().padLeft(2, '0')}",
        "to_date":
            "${toDate!.year.toString().padLeft(4, '0')}-${toDate!.month.toString().padLeft(2, '0')}-${toDate!.day.toString().padLeft(2, '0')}",
      };
}

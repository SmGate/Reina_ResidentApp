// To parse this JSON data, do
//
//     final getAllVisitors = getAllVisitorsFromJson(jsonString);

import 'dart:convert';

GetAllVisitors getAllVisitorsFromJson(String str) =>
    GetAllVisitors.fromJson(json.decode(str));

String getAllVisitorsToJson(GetAllVisitors data) => json.encode(data.toJson());

class GetAllVisitors {
  bool? success;
  List<Datum>? data;
  String? message;

  GetAllVisitors({
    this.success,
    this.data,
    this.message,
  });

  factory GetAllVisitors.fromJson(Map<String, dynamic> json) => GetAllVisitors(
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
      };
}

class Datum {
  int? id;
  int? gatekeeperid;
  int? societyid;
  int? subadminid;
  String? houseaddress;
  String? visitortype;
  String? name;
  String? cnic;
  String? mobileno;
  String? vechileno;
  String? arrivaldate;
  String? arrivaltime;
  String? checkoutdate;
  String? checkouttime;
  int? status;
  String? statusdescription;
  String? createdAt;
  String? updatedAt;

  Datum({
    this.id,
    this.gatekeeperid,
    this.societyid,
    this.subadminid,
    this.houseaddress,
    this.visitortype,
    this.name,
    this.cnic,
    this.mobileno,
    this.vechileno,
    this.arrivaldate,
    this.arrivaltime,
    this.checkoutdate,
    this.checkouttime,
    this.status,
    this.statusdescription,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        gatekeeperid: json["gatekeeperid"],
        societyid: json["societyid"],
        subadminid: json["subadminid"],
        houseaddress: json["houseaddress"],
        visitortype: json["visitortype"],
        name: json["name"],
        cnic: json["cnic"],
        mobileno: json["mobileno"],
        vechileno: json["vechileno"],
        arrivaldate: json["arrivaldate"],
        arrivaltime: json["arrivaltime"],
        checkoutdate: json["checkoutdate"],
        checkouttime: json["checkouttime"],
        status: json["status"],
        statusdescription: json["statusdescription"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "gatekeeperid": gatekeeperid,
        "societyid": societyid,
        "subadminid": subadminid,
        "houseaddress": houseaddress,
        "visitortype": visitortype,
        "name": name,
        "cnic": cnic,
        "mobileno": mobileno,
        "vechileno": vechileno,
        "arrivaldate": arrivaldate,
        "arrivaltime": arrivaltime,
        "checkoutdate": checkoutdate,
        "checkouttime": checkouttime,
        "status": status,
        "statusdescription": statusdescription,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

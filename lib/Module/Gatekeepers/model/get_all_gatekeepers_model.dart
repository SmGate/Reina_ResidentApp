// To parse this JSON data, do
//
//     final getAllGatekeepersModel = getAllGatekeepersModelFromJson(jsonString);

import 'dart:convert';

GetAllGatekeepersModel getAllGatekeepersModelFromJson(String str) =>
    GetAllGatekeepersModel.fromJson(json.decode(str));

String getAllGatekeepersModelToJson(GetAllGatekeepersModel data) =>
    json.encode(data.toJson());

class GetAllGatekeepersModel {
  String? message;
  bool? success;
  List<Datum>? data;

  GetAllGatekeepersModel({
    this.message,
    this.success,
    this.data,
  });

  factory GetAllGatekeepersModel.fromJson(Map<String, dynamic> json) =>
      GetAllGatekeepersModel(
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
  int? subadminid;
  int? societyid;
  String? gateno;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? firstname;
  String? lastname;
  dynamic email;
  String? cnic;
  String? address;
  String? mobileno;
  String? password;
  int? roleid;
  String? rolename;
  String? image;
  String? fcmtoken;
  dynamic code;
  int? isVerified;

  Datum({
    this.id,
    this.gatekeeperid,
    this.subadminid,
    this.societyid,
    this.gateno,
    this.createdAt,
    this.updatedAt,
    this.firstname,
    this.lastname,
    this.email,
    this.cnic,
    this.address,
    this.mobileno,
    this.password,
    this.roleid,
    this.rolename,
    this.image,
    this.fcmtoken,
    this.code,
    this.isVerified,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        gatekeeperid: json["gatekeeperid"],
        subadminid: json["subadminid"],
        societyid: json["societyid"],
        gateno: json["gateno"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        firstname: json["firstname"],
        lastname: json["lastname"],
        email: json["email"],
        cnic: json["cnic"],
        address: json["address"],
        mobileno: json["mobileno"],
        password: json["password"],
        roleid: json["roleid"],
        rolename: json["rolename"],
        image: json["image"],
        fcmtoken: json["fcmtoken"],
        code: json["code"],
        isVerified: json["is_verified"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "gatekeeperid": gatekeeperid,
        "subadminid": subadminid,
        "societyid": societyid,
        "gateno": gateno,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "firstname": firstname,
        "lastname": lastname,
        "email": email,
        "cnic": cnic,
        "address": address,
        "mobileno": mobileno,
        "password": password,
        "roleid": roleid,
        "rolename": rolename,
        "image": image,
        "fcmtoken": fcmtoken,
        "code": code,
        "is_verified": isVerified,
      };
}

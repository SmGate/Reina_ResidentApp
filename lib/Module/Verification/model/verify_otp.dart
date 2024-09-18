// To parse this JSON data, do
//
//     final varifyOtpModel = varifyOtpModelFromJson(jsonString);

import 'dart:convert';

VarifyOtpModel varifyOtpModelFromJson(String str) =>
    VarifyOtpModel.fromJson(json.decode(str));

String varifyOtpModelToJson(VarifyOtpModel data) => json.encode(data.toJson());

class VarifyOtpModel {
  String? message;
  bool? success;
  Data? data;

  VarifyOtpModel({
    this.message,
    this.success,
    this.data,
  });

  factory VarifyOtpModel.fromJson(Map<String, dynamic> json) => VarifyOtpModel(
        message: json["message"],
        success: json["success"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "success": success,
        "data": data?.toJson(),
      };
}

class Data {
  int? id;
  String? firstname;
  String? lastname;
  dynamic email;
  dynamic cnic;
  String? address;
  String? mobileno;
  int? roleid;
  String? rolename;
  String? image;
  dynamic fcmtoken;
  int? code;
  int? isVerified;
  DateTime? createdAt;
  DateTime? updatedAt;

  Data({
    this.id,
    this.firstname,
    this.lastname,
    this.email,
    this.cnic,
    this.address,
    this.mobileno,
    this.roleid,
    this.rolename,
    this.image,
    this.fcmtoken,
    this.code,
    this.isVerified,
    this.createdAt,
    this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        email: json["email"],
        cnic: json["cnic"],
        address: json["address"],
        mobileno: json["mobileno"],
        roleid: json["roleid"],
        rolename: json["rolename"],
        image: json["image"],
        fcmtoken: json["fcmtoken"],
        code: json["code"],
        isVerified: json["is_verified"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstname": firstname,
        "lastname": lastname,
        "email": email,
        "cnic": cnic,
        "address": address,
        "mobileno": mobileno,
        "roleid": roleid,
        "rolename": rolename,
        "image": image,
        "fcmtoken": fcmtoken,
        "code": code,
        "is_verified": isVerified,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

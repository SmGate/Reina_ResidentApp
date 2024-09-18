// To parse this JSON data, do
//
//     final fcmRefreshModel = fcmRefreshModelFromJson(jsonString);

import 'dart:convert';

FcmRefreshModel fcmRefreshModelFromJson(String str) =>
    FcmRefreshModel.fromJson(json.decode(str));

String fcmRefreshModelToJson(FcmRefreshModel data) =>
    json.encode(data.toJson());

class FcmRefreshModel {
  bool? success;
  Data? data;
  String? message;

  FcmRefreshModel({
    this.success,
    this.data,
    this.message,
  });

  factory FcmRefreshModel.fromJson(Map<String, dynamic> json) =>
      FcmRefreshModel(
        success: json["success"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
        "message": message,
      };
}

class Data {
  int? id;
  String? firstname;
  String? lastname;
  String? name;
  dynamic email;
  dynamic cnic;
  String? address;
  String? mobileno;
  int? roleid;
  String? rolename;
  String? image;
  String? fcmtoken;
  int? code;
  int? isVerified;
  DateTime? createdAt;
  DateTime? updatedAt;

  Data({
    this.id,
    this.firstname,
    this.lastname,
    this.name,
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
        name: json["name"],
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
        "name": name,
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

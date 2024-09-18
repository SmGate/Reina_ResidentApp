// To parse this JSON data, do
//
//     final societySupportModel = societySupportModelFromJson(jsonString);

import 'dart:convert';

SocietySupportModel societySupportModelFromJson(String str) =>
    SocietySupportModel.fromJson(json.decode(str));

String societySupportModelToJson(SocietySupportModel data) =>
    json.encode(data.toJson());

class SocietySupportModel {
  String? message;
  bool? success;
  Data? data;

  SocietySupportModel({
    this.message,
    this.success,
    this.data,
  });

  factory SocietySupportModel.fromJson(Map<String, dynamic> json) =>
      SocietySupportModel(
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
  int? superadminid;
  int? societyid;
  int? subadminid;
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
  Society? society;

  Data({
    this.id,
    this.superadminid,
    this.societyid,
    this.subadminid,
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
    this.society,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        superadminid: json["superadminid"],
        societyid: json["societyid"],
        subadminid: json["subadminid"],
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
        society:
            json["society"] == null ? null : Society.fromJson(json["society"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "superadminid": superadminid,
        "societyid": societyid,
        "subadminid": subadminid,
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
        "society": society?.toJson(),
      };
}

class Society {
  int? id;
  String? country;
  String? state;
  String? city;
  String? area;
  String? type;
  String? name;
  String? address;
  int? superadminid;
  int? structuretype;
  DateTime? createdAt;
  DateTime? updatedAt;

  Society({
    this.id,
    this.country,
    this.state,
    this.city,
    this.area,
    this.type,
    this.name,
    this.address,
    this.superadminid,
    this.structuretype,
    this.createdAt,
    this.updatedAt,
  });

  factory Society.fromJson(Map<String, dynamic> json) => Society(
        id: json["id"],
        country: json["country"],
        state: json["state"],
        city: json["city"],
        area: json["area"],
        type: json["type"],
        name: json["name"],
        address: json["address"],
        superadminid: json["superadminid"],
        structuretype: json["structuretype"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "country": country,
        "state": state,
        "city": city,
        "area": area,
        "type": type,
        "name": name,
        "address": address,
        "superadminid": superadminid,
        "structuretype": structuretype,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

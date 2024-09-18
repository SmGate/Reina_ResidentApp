// To parse this JSON data, do
//
//     final addEmergencyModel = addEmergencyModelFromJson(jsonString);

import 'dart:convert';

AddEmergencyModel addEmergencyModelFromJson(String str) =>
    AddEmergencyModel.fromJson(json.decode(str));

String addEmergencyModelToJson(AddEmergencyModel data) =>
    json.encode(data.toJson());

class AddEmergencyModel {
  Data? data;
  List<Gatekeeper>? subadmin;
  List<Gatekeeper>? gatekeepers;

  AddEmergencyModel({
    this.data,
    this.subadmin,
    this.gatekeepers,
  });

  factory AddEmergencyModel.fromJson(Map<String, dynamic> json) =>
      AddEmergencyModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        subadmin: json["subadmin"] == null
            ? []
            : List<Gatekeeper>.from(
                json["subadmin"]!.map((x) => Gatekeeper.fromJson(x))),
        gatekeepers: json["gatekeepers"] == null
            ? []
            : List<Gatekeeper>.from(
                json["gatekeepers"]!.map((x) => Gatekeeper.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "subadmin": subadmin == null
            ? []
            : List<dynamic>.from(subadmin!.map((x) => x.toJson())),
        "gatekeepers": gatekeepers == null
            ? []
            : List<dynamic>.from(gatekeepers!.map((x) => x.toJson())),
      };
}

class Data {
  String? residentid;
  String? societyid;
  String? subadminid;
  String? problem;
  String? description;
  String? status;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  Data({
    this.residentid,
    this.societyid,
    this.subadminid,
    this.problem,
    this.description,
    this.status,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        residentid: json["residentid"],
        societyid: json["societyid"],
        subadminid: json["subadminid"],
        problem: json["problem"],
        description: json["description"],
        status: json["status"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "residentid": residentid,
        "societyid": societyid,
        "subadminid": subadminid,
        "problem": problem,
        "description": description,
        "status": status,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
      };
}

class Gatekeeper {
  int? id;
  int? gatekeeperid;
  int? subadminid;
  int? societyid;
  String? gateno;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? firstname;
  String? lastname;
  String? name;
  String? email;
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
  int? superadminid;

  Gatekeeper({
    this.id,
    this.gatekeeperid,
    this.subadminid,
    this.societyid,
    this.gateno,
    this.createdAt,
    this.updatedAt,
    this.firstname,
    this.lastname,
    this.name,
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
    this.superadminid,
  });

  factory Gatekeeper.fromJson(Map<String, dynamic> json) => Gatekeeper(
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
        name: json["name"],
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
        superadminid: json["superadminid"],
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
        "name": name,
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
        "superadminid": superadminid,
      };
}

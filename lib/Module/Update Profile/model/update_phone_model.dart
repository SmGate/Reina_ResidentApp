// To parse this JSON data, do
//
//     final updatePhoneModel = updatePhoneModelFromJson(jsonString);

import 'dart:convert';

UpdatePhoneModel updatePhoneModelFromJson(String str) =>
    UpdatePhoneModel.fromJson(json.decode(str));

String updatePhoneModelToJson(UpdatePhoneModel data) =>
    json.encode(data.toJson());

class UpdatePhoneModel {
  String? message;
  bool? success;
  Data? data;

  UpdatePhoneModel({
    this.message,
    this.success,
    this.data,
  });

  factory UpdatePhoneModel.fromJson(Map<String, dynamic> json) =>
      UpdatePhoneModel(
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
  Resident? resident;

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
    this.resident,
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
        resident: json["resident"] == null
            ? null
            : Resident.fromJson(json["resident"]),
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
        "resident": resident?.toJson(),
      };
}

class Resident {
  int? id;
  int? residentid;
  int? subadminid;
  String? username;
  String? country;
  String? state;
  String? city;
  String? houseaddress;
  String? vechileno;
  String? residenttype;
  String? propertytype;
  String? visibility;
  int? committeemember;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  Resident({
    this.id,
    this.residentid,
    this.subadminid,
    this.username,
    this.country,
    this.state,
    this.city,
    this.houseaddress,
    this.vechileno,
    this.residenttype,
    this.propertytype,
    this.visibility,
    this.committeemember,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Resident.fromJson(Map<String, dynamic> json) => Resident(
        id: json["id"],
        residentid: json["residentid"],
        subadminid: json["subadminid"],
        username: json["username"],
        country: json["country"],
        state: json["state"],
        city: json["city"],
        houseaddress: json["houseaddress"],
        vechileno: json["vechileno"],
        residenttype: json["residenttype"],
        propertytype: json["propertytype"],
        visibility: json["visibility"],
        committeemember: json["committeemember"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "residentid": residentid,
        "subadminid": subadminid,
        "username": username,
        "country": country,
        "state": state,
        "city": city,
        "houseaddress": houseaddress,
        "vechileno": vechileno,
        "residenttype": residenttype,
        "propertytype": propertytype,
        "visibility": visibility,
        "committeemember": committeemember,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

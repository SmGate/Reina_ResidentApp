// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  bool? success;
  Data? data;
  int? societyId;
  String? bearer;

  UserModel({
    this.success,
    this.data,
    this.societyId,
    this.bearer,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        success: json["success"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        societyId: json["society_id"],
        bearer: json["Bearer"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
        "society_id": societyId,
        "Bearer": bearer,
      };
}

class Data {
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
  String? area;
  String? type;
  String? slogan;
  int? appcharges;
  String? logo;
  int? hasCustomIntro;
  int? superadminid;
  int? structuretype;
  int? societyId;

  Data({
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
    this.area,
    this.type,
    this.slogan,
    this.appcharges,
    this.logo,
    this.hasCustomIntro,
    this.superadminid,
    this.structuretype,
    this.societyId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
        area: json["area"],
        type: json["type"],
        slogan: json["slogan"],
        appcharges: json["appcharges"],
        logo: json["logo"],
        hasCustomIntro: json["has_custom_intro"],
        superadminid: json["superadminid"],
        structuretype: json["structuretype"],
        societyId: json["society_id"],
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
        "area": area,
        "type": type,
        "slogan": slogan,
        "appcharges": appcharges,
        "logo": logo,
        "has_custom_intro": hasCustomIntro,
        "superadminid": superadminid,
        "structuretype": structuretype,
        "society_id": societyId,
      };
}

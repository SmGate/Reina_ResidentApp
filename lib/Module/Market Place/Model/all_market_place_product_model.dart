// To parse this JSON data, do
//
//     final allMarketPlaceProductModel = allMarketPlaceProductModelFromJson(jsonString);

import 'dart:convert';

AllMarketPlaceProductModel allMarketPlaceProductModelFromJson(String str) =>
    AllMarketPlaceProductModel.fromJson(json.decode(str));

String allMarketPlaceProductModelToJson(AllMarketPlaceProductModel data) =>
    json.encode(data.toJson());

class AllMarketPlaceProductModel {
  String? message;
  bool? success;
  List<Datum>? data;

  AllMarketPlaceProductModel({
    this.message,
    this.success,
    this.data,
  });

  factory AllMarketPlaceProductModel.fromJson(Map<String, dynamic> json) =>
      AllMarketPlaceProductModel(
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
  int? residentid;
  int? societyid;
  int? subadminid;
  String? productname;
  String? description;
  String? productprice;
  String? contact;
  String? category;
  String? condition;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  Users? users;
  Residents? residents;
  List<Image>? images;

  Datum({
    this.id,
    this.residentid,
    this.societyid,
    this.subadminid,
    this.productname,
    this.description,
    this.productprice,
    this.contact,
    this.category,
    this.condition,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.users,
    this.residents,
    this.images,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        residentid: json["residentid"],
        societyid: json["societyid"],
        subadminid: json["subadminid"],
        productname: json["productname"],
        description: json["description"],
        productprice: json["productprice"],
        contact: json["contact"],
        category: json["category"],
        condition: json["condition"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        users: json["users"] == null ? null : Users.fromJson(json["users"]),
        residents: json["residents"] == null
            ? null
            : Residents.fromJson(json["residents"]),
        images: json["images"] == null
            ? []
            : List<Image>.from(json["images"]!.map((x) => Image.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "residentid": residentid,
        "societyid": societyid,
        "subadminid": subadminid,
        "productname": productname,
        "description": description,
        "productprice": productprice,
        "contact": contact,
        "category": category,
        "condition": condition,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "users": users?.toJson(),
        "residents": residents?.toJson(),
        "images": images == null
            ? []
            : List<dynamic>.from(images!.map((x) => x.toJson())),
      };
}

class Image {
  int? id;
  int? marketplaceid;
  String? images;
  DateTime? createdAt;
  DateTime? updatedAt;

  Image({
    this.id,
    this.marketplaceid,
    this.images,
    this.createdAt,
    this.updatedAt,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        id: json["id"],
        marketplaceid: json["marketplaceid"],
        images: json["images"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "marketplaceid": marketplaceid,
        "images": images,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class Residents {
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

  Residents({
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

  factory Residents.fromJson(Map<String, dynamic> json) => Residents(
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

class Users {
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

  Users({
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

  factory Users.fromJson(Map<String, dynamic> json) => Users(
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

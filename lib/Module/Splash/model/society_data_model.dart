// To parse this JSON data, do
//
//     final societyDataModel = societyDataModelFromJson(jsonString);

import 'dart:convert';

SocietyDataModel societyDataModelFromJson(String str) =>
    SocietyDataModel.fromJson(json.decode(str));

String societyDataModelToJson(SocietyDataModel data) =>
    json.encode(data.toJson());

class SocietyDataModel {
  String? message;
  bool? success;
  Data? data;

  SocietyDataModel({
    this.message,
    this.success,
    this.data,
  });

  factory SocietyDataModel.fromJson(Map<String, dynamic> json) =>
      SocietyDataModel(
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
  String? country;
  String? state;
  String? city;
  String? area;
  String? type;
  String? name;
  String? slogan;
  int? appcharges;
  String? address;
  String? logo;
  int? hasCustomIntro;
  int? superadminid;
  int? structuretype;
  DateTime? createdAt;
  DateTime? updatedAt;

  Data({
    this.id,
    this.country,
    this.state,
    this.city,
    this.area,
    this.type,
    this.name,
    this.slogan,
    this.appcharges,
    this.address,
    this.logo,
    this.hasCustomIntro,
    this.superadminid,
    this.structuretype,
    this.createdAt,
    this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        country: json["country"],
        state: json["state"],
        city: json["city"],
        area: json["area"],
        type: json["type"],
        name: json["name"],
        slogan: json["slogan"],
        appcharges: json["appcharges"],
        address: json["address"],
        logo: json["logo"],
        hasCustomIntro: json["has_custom_intro"],
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
        "slogan": slogan,
        "appcharges": appcharges,
        "address": address,
        "logo": logo,
        "has_custom_intro": hasCustomIntro,
        "superadminid": superadminid,
        "structuretype": structuretype,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

// To parse this JSON data, do
//
//     final addProductDetailModel = addProductDetailModelFromJson(jsonString);

import 'dart:convert';

AddProductDetailModel addProductDetailModelFromJson(String str) =>
    AddProductDetailModel.fromJson(json.decode(str));

String addProductDetailModelToJson(AddProductDetailModel data) =>
    json.encode(data.toJson());

class AddProductDetailModel {
  bool? success;
  Data? data;

  AddProductDetailModel({
    this.success,
    this.data,
  });

  factory AddProductDetailModel.fromJson(Map<String, dynamic> json) =>
      AddProductDetailModel(
        success: json["success"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
      };
}

class Data {
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
  List<Image>? images;

  Data({
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
    this.images,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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

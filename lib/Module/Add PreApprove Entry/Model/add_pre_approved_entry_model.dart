// To parse this JSON data, do
//
//     final addPreapproveEntryModel = addPreapproveEntryModelFromJson(jsonString);

import 'dart:convert';

AddPreapproveEntryModel addPreapproveEntryModelFromJson(String str) =>
    AddPreapproveEntryModel.fromJson(json.decode(str));

String addPreapproveEntryModelToJson(AddPreapproveEntryModel data) =>
    json.encode(data.toJson());

class AddPreapproveEntryModel {
  bool? success;
  Data? data;
  String? message;

  AddPreapproveEntryModel({this.success, this.data, this.message});

  factory AddPreapproveEntryModel.fromJson(Map<String, dynamic> json) =>
      AddPreapproveEntryModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
      };
}

class Data {
  int? gatekeeperid;
  int? userid;
  String? visitortype;
  String? name;
  String? description;
  String? cnic;
  String? mobileno;
  String? vechileno;
  String? arrivaldate;
  String? arrivaltime;
  int? status;
  String? statusdescription;
  String? image;
  dynamic fromDate;
  dynamic toDate;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  Data({
    this.gatekeeperid,
    this.userid,
    this.visitortype,
    this.name,
    this.description,
    this.cnic,
    this.mobileno,
    this.vechileno,
    this.arrivaldate,
    this.arrivaltime,
    this.status,
    this.statusdescription,
    this.fromDate,
    this.toDate,
    this.updatedAt,
    this.createdAt,
    this.image,
    this.id,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        gatekeeperid: json["gatekeeperid"],
        userid: json["userid"],
        visitortype: json["visitortype"],
        name: json["name"],
        image: json["image"],
        description: json["description"],
        cnic: json["cnic"],
        mobileno: json["mobileno"],
        vechileno: json["vechileno"],
        arrivaldate: json["arrivaldate"],
        arrivaltime: json["arrivaltime"],
        status: json["status"],
        statusdescription: json["statusdescription"],
        fromDate: json["from_date"],
        toDate: json["to_date"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "gatekeeperid": gatekeeperid,
        "userid": userid,
        "visitortype": visitortype,
        "name": name,
        "description": description,
        "cnic": cnic,
        "mobileno": mobileno,
        "vechileno": vechileno,
        "arrivaldate": arrivaldate,
        "arrivaltime": arrivaltime,
        "status": status,
        "image": image,
        "statusdescription": statusdescription,
        "from_date": fromDate,
        "to_date": toDate,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
      };
}

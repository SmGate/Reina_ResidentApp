// To parse this JSON data, do
//
//     final billModel = billModelFromJson(jsonString);

import 'dart:convert';

BillModel billModelFromJson(String str) => BillModel.fromJson(json.decode(str));

String billModelToJson(BillModel data) => json.encode(data.toJson());

class BillModel {
  bool? success;
  String? message;
  Data? data;

  BillModel({
    this.success,
    this.message,
    this.data,
  });

  factory BillModel.fromJson(Map<String, dynamic> json) => BillModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  List<Paid>? paid;
  List<Paid>? unpaid;
  List<Paid>? partiallypaid;

  Data({
    this.paid,
    this.unpaid,
    this.partiallypaid,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        paid: json["paid"] == null
            ? []
            : List<Paid>.from(json["paid"]!.map((x) => Paid.fromJson(x))),
        unpaid: json["unpaid"] == null
            ? []
            : List<Paid>.from(json["unpaid"]!.map((x) => Paid.fromJson(x))),
        partiallypaid: json["partiallypaid"] == null
            ? []
            : List<Paid>.from(
                json["partiallypaid"]!.map((x) => Paid.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "paid": paid == null
            ? []
            : List<dynamic>.from(paid!.map((x) => x.toJson())),
        "unpaid": unpaid == null
            ? []
            : List<dynamic>.from(unpaid!.map((x) => x.toJson())),
        "partiallypaid": partiallypaid == null
            ? []
            : List<dynamic>.from(partiallypaid!.map((x) => x.toJson())),
      };
}

class Paid {
  int? id;
  int? isAuto;
  String? description;
  dynamic otherDescription;
  String? charges;
  String? latecharges;
  String? appcharges;
  String? tax;
  String? balance;
  String? payableamount;
  String? totalpaidamount;
  int? subadminid;
  int? financemanagerid;
  int? residentid;
  int? propertyid;
  int? measurementid;
  DateTime? duedate;
  DateTime? billstartdate;
  DateTime? billenddate;
  DateTime? paidOn;
  String? month;
  String? billtype;
  String? specificType;
  String? paymenttype;
  String? status;
  int? isbilllate;
  int? noofappusers;
  DateTime? createdAt;
  DateTime? updatedAt;
  ResidentData? residentData;
  FinanceManager? financeManager;
  SubAdmin? subAdmin;
  ResidentData? user;

  Paid({
    this.id,
    this.isAuto,
    this.description,
    this.otherDescription,
    this.charges,
    this.latecharges,
    this.appcharges,
    this.tax,
    this.balance,
    this.payableamount,
    this.totalpaidamount,
    this.subadminid,
    this.financemanagerid,
    this.residentid,
    this.propertyid,
    this.measurementid,
    this.duedate,
    this.billstartdate,
    this.billenddate,
    this.paidOn,
    this.month,
    this.billtype,
    this.specificType,
    this.paymenttype,
    this.status,
    this.isbilllate,
    this.noofappusers,
    this.createdAt,
    this.updatedAt,
    this.residentData,
    this.financeManager,
    this.subAdmin,
    this.user,
  });

  factory Paid.fromJson(Map<String, dynamic> json) => Paid(
        id: json["id"],
        isAuto: json["is_auto"],
        description: json["description"],
        otherDescription: json["other_description"],
        charges: json["charges"],
        latecharges: json["latecharges"],
        appcharges: json["appcharges"],
        tax: json["tax"],
        balance: json["balance"],
        payableamount: json["payableamount"],
        totalpaidamount: json["totalpaidamount"],
        subadminid: json["subadminid"],
        financemanagerid: json["financemanagerid"],
        residentid: json["residentid"],
        propertyid: json["propertyid"],
        measurementid: json["measurementid"],
        duedate:
            json["duedate"] == null ? null : DateTime.parse(json["duedate"]),
        billstartdate: json["billstartdate"] == null
            ? null
            : DateTime.parse(json["billstartdate"]),
        billenddate: json["billenddate"] == null
            ? null
            : DateTime.parse(json["billenddate"]),
        paidOn:
            json["paid_on"] == null ? null : DateTime.parse(json["paid_on"]),
        month: json["month"],
        billtype: json["billtype"],
        specificType: json["specific_type"],
        paymenttype: json["paymenttype"],
        status: json["status"],
        isbilllate: json["isbilllate"],
        noofappusers: json["noofappusers"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        residentData: json["resident_data"] == null
            ? null
            : ResidentData.fromJson(json["resident_data"]),
        financeManager: json["finance_manager"] == null
            ? null
            : FinanceManager.fromJson(json["finance_manager"]),
        subAdmin: json["sub_admin"] == null
            ? null
            : SubAdmin.fromJson(json["sub_admin"]),
        user: json["user"] == null ? null : ResidentData.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "is_auto": isAuto,
        "description": description,
        "other_description": otherDescription,
        "charges": charges,
        "latecharges": latecharges,
        "appcharges": appcharges,
        "tax": tax,
        "balance": balance,
        "payableamount": payableamount,
        "totalpaidamount": totalpaidamount,
        "subadminid": subadminid,
        "financemanagerid": financemanagerid,
        "residentid": residentid,
        "propertyid": propertyid,
        "measurementid": measurementid,
        "duedate":
            "${duedate!.year.toString().padLeft(4, '0')}-${duedate!.month.toString().padLeft(2, '0')}-${duedate!.day.toString().padLeft(2, '0')}",
        "billstartdate":
            "${billstartdate!.year.toString().padLeft(4, '0')}-${billstartdate!.month.toString().padLeft(2, '0')}-${billstartdate!.day.toString().padLeft(2, '0')}",
        "billenddate":
            "${billenddate!.year.toString().padLeft(4, '0')}-${billenddate!.month.toString().padLeft(2, '0')}-${billenddate!.day.toString().padLeft(2, '0')}",
        "paid_on":
            "${paidOn!.year.toString().padLeft(4, '0')}-${paidOn!.month.toString().padLeft(2, '0')}-${paidOn!.day.toString().padLeft(2, '0')}",
        "month": month,
        "billtype": billtype,
        "specific_type": specificType,
        "paymenttype": paymenttype,
        "status": status,
        "isbilllate": isbilllate,
        "noofappusers": noofappusers,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "resident_data": residentData?.toJson(),
        "finance_manager": financeManager?.toJson(),
        "sub_admin": subAdmin?.toJson(),
        "user": user?.toJson(),
      };
}

class FinanceManager {
  int? id;
  int? financemanagerid;
  int? subadminid;
  int? superadminid;
  int? societyid;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  ResidentData? user;

  FinanceManager({
    this.id,
    this.financemanagerid,
    this.subadminid,
    this.superadminid,
    this.societyid,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  factory FinanceManager.fromJson(Map<String, dynamic> json) => FinanceManager(
        id: json["id"],
        financemanagerid: json["financemanagerid"],
        subadminid: json["subadminid"],
        superadminid: json["superadminid"],
        societyid: json["societyid"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        user: json["user"] == null ? null : ResidentData.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "financemanagerid": financemanagerid,
        "subadminid": subadminid,
        "superadminid": superadminid,
        "societyid": societyid,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "user": user?.toJson(),
      };
}

class ResidentData {
  int? id;
  String? firstname;
  String? lastname;
  dynamic email;
  String? cnic;
  String? address;
  String? mobileno;
  int? roleid;
  String? rolename;
  Image? image;
  String? fcmtoken;
  int? code;
  int? isVerified;
  DateTime? createdAt;
  DateTime? updatedAt;

  ResidentData({
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

  factory ResidentData.fromJson(Map<String, dynamic> json) => ResidentData(
        id: json["id"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        email: json["email"],
        cnic: json["cnic"],
        address: json["address"],
        mobileno: json["mobileno"],
        roleid: json["roleid"],
        rolename: json["rolename"],
        image: imageValues.map[json["image"]],
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
        "firstname": firstnameValues.reverse[firstname],
        "lastname": lastnameValues.reverse[lastname],
        "email": email,
        "cnic": cnicValues.reverse[cnic],
        "address": addressValues.reverse[address],
        "mobileno": mobileno,
        "roleid": roleid,
        "rolename": rolenameValues.reverse[rolename],
        "image": imageValues.reverse[image],
        "fcmtoken": fcmtoken,
        "code": code,
        "is_verified": isVerified,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

enum Address { ISB, SILVER_OAKS_ST1_H14 }

final addressValues = EnumValues(
    {"isb": Address.ISB, "Silver Oaks,st1,H14": Address.SILVER_OAKS_ST1_H14});

enum Cnic { THE_3740571712341, THE_3740812112131 }

final cnicValues = EnumValues({
  "37405-7171234-1": Cnic.THE_3740571712341,
  "37408-1211213-1": Cnic.THE_3740812112131
});

enum Firstname { FINANCE, SHABAZ, SUB }

final firstnameValues = EnumValues({
  "finance": Firstname.FINANCE,
  "shabaz": Firstname.SHABAZ,
  "sub": Firstname.SUB
});

enum Image { THE_1713430892_PNG, THE_1713868467_JPG, THE_1716981070_JPG }

final imageValues = EnumValues({
  "1713430892.png": Image.THE_1713430892_PNG,
  "1713868467.jpg": Image.THE_1713868467_JPG,
  "1716981070.jpg": Image.THE_1716981070_JPG
});

enum Lastname { ADMIN, AHMAD, MANAGER }

final lastnameValues = EnumValues({
  "admin": Lastname.ADMIN,
  "ahmad": Lastname.AHMAD,
  "manager": Lastname.MANAGER
});

enum Rolename { FINANCEMANAGER, RESIDENT, SUBADMIN }

final rolenameValues = EnumValues({
  "financemanager": Rolename.FINANCEMANAGER,
  "resident": Rolename.RESIDENT,
  "subadmin": Rolename.SUBADMIN
});

class SubAdmin {
  int? id;
  int? superadminid;
  int? societyid;
  int? subadminid;
  DateTime? createdAt;
  DateTime? updatedAt;
  ResidentData? user;

  SubAdmin({
    this.id,
    this.superadminid,
    this.societyid,
    this.subadminid,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  factory SubAdmin.fromJson(Map<String, dynamic> json) => SubAdmin(
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
        user: json["user"] == null ? null : ResidentData.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "superadminid": superadminid,
        "societyid": societyid,
        "subadminid": subadminid,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "user": user?.toJson(),
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

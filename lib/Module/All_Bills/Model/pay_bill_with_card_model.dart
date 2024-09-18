// To parse this JSON data, do
//
//     final payBillWithCardModel = payBillWithCardModelFromJson(jsonString);

import 'dart:convert';

PayBillWithCardModel payBillWithCardModelFromJson(String str) =>
    PayBillWithCardModel.fromJson(json.decode(str));

String payBillWithCardModelToJson(PayBillWithCardModel data) =>
    json.encode(data.toJson());

class PayBillWithCardModel {
  String? status;
  Data? data;

  PayBillWithCardModel({
    this.status,
    this.data,
  });

  factory PayBillWithCardModel.fromJson(Map<String, dynamic> json) =>
      PayBillWithCardModel(
        status: json["status"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
      };
}

class Data {
  String? ppMerchantId;
  String? ppPassword;
  String? hashKey;
  String? returnUrl;
  String? postUrl;
  int? ppAmount;
  String? ppBillReference;
  String? ppDescription;
  String? ppLanguage;
  String? ppTxnCurrency;
  String? ppTxnDateTime;
  String? ppTxnExpiryDateTime;
  String? ppTxnRefNo;
  String? ppMobile;
  String? ppTxnType;
  String? ppCnic;
  String? ppVersion;
  String? ppSubMerchantId;
  String? ppBankId;
  String? ppProductId;
  String? ppmpf1;
  String? ppmpf2;
  String? ppmpf3;
  String? ppmpf4;
  String? ppmpf5;
  String? ppSecureHash;

  Data({
    this.ppMerchantId,
    this.ppPassword,
    this.hashKey,
    this.returnUrl,
    this.postUrl,
    this.ppAmount,
    this.ppBillReference,
    this.ppDescription,
    this.ppLanguage,
    this.ppTxnCurrency,
    this.ppTxnDateTime,
    this.ppTxnExpiryDateTime,
    this.ppTxnRefNo,
    this.ppMobile,
    this.ppTxnType,
    this.ppCnic,
    this.ppVersion,
    this.ppSubMerchantId,
    this.ppBankId,
    this.ppProductId,
    this.ppmpf1,
    this.ppmpf2,
    this.ppmpf3,
    this.ppmpf4,
    this.ppmpf5,
    this.ppSecureHash,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        ppMerchantId: json["pp_MerchantID"],
        ppPassword: json["pp_Password"],
        hashKey: json["HashKey"],
        returnUrl: json["ReturnURL"],
        postUrl: json["PostURL"],
        ppAmount: json["pp_Amount"],
        ppBillReference: json["pp_BillReference"],
        ppDescription: json["pp_Description"],
        ppLanguage: json["pp_Language"],
        ppTxnCurrency: json["pp_TxnCurrency"],
        ppTxnDateTime: json["pp_TxnDateTime"],
        ppTxnExpiryDateTime: json["pp_TxnExpiryDateTime"],
        ppTxnRefNo: json["pp_TxnRefNo"],
        ppMobile: json["pp_mobile"],
        ppTxnType: json["pp_TxnType"],
        ppCnic: json["pp_CNIC"],
        ppVersion: json["pp_Version"],
        ppSubMerchantId: json["pp_SubMerchantID"],
        ppBankId: json["pp_BankID"],
        ppProductId: json["pp_ProductID"],
        ppmpf1: json["ppmpf_1"],
        ppmpf2: json["ppmpf_2"],
        ppmpf3: json["ppmpf_3"],
        ppmpf4: json["ppmpf_4"],
        ppmpf5: json["ppmpf_5"],
        ppSecureHash: json["pp_SecureHash"],
      );

  Map<String, dynamic> toJson() => {
        "pp_MerchantID": ppMerchantId,
        "pp_Password": ppPassword,
        "HashKey": hashKey,
        "ReturnURL": returnUrl,
        "PostURL": postUrl,
        "pp_Amount": ppAmount,
        "pp_BillReference": ppBillReference,
        "pp_Description": ppDescription,
        "pp_Language": ppLanguage,
        "pp_TxnCurrency": ppTxnCurrency,
        "pp_TxnDateTime": ppTxnDateTime,
        "pp_TxnExpiryDateTime": ppTxnExpiryDateTime,
        "pp_TxnRefNo": ppTxnRefNo,
        "pp_mobile": ppMobile,
        "pp_TxnType": ppTxnType,
        "pp_CNIC": ppCnic,
        "pp_Version": ppVersion,
        "pp_SubMerchantID": ppSubMerchantId,
        "pp_BankID": ppBankId,
        "pp_ProductID": ppProductId,
        "ppmpf_1": ppmpf1,
        "ppmpf_2": ppmpf2,
        "ppmpf_3": ppmpf3,
        "ppmpf_4": ppmpf4,
        "ppmpf_5": ppmpf5,
        "pp_SecureHash": ppSecureHash,
      };
}

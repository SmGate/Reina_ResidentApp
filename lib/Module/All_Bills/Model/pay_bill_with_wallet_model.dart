// To parse this JSON data, do
//
//     final payBillWithWalletModel = payBillWithWalletModelFromJson(jsonString);

import 'dart:convert';

PayBillWithWalletModel payBillWithWalletModelFromJson(String str) =>
    PayBillWithWalletModel.fromJson(json.decode(str));

String payBillWithWalletModelToJson(PayBillWithWalletModel data) =>
    json.encode(data.toJson());

class PayBillWithWalletModel {
  String? status;
  Data? data;

  PayBillWithWalletModel({
    this.status,
    this.data,
  });

  factory PayBillWithWalletModel.fromJson(Map<String, dynamic> json) =>
      PayBillWithWalletModel(
        status: json["status"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
      };
}

class Data {
  String? ppTxnType;
  String? ppVersion;
  String? ppAmount;
  String? ppAuthCode;
  String? ppBillReference;
  String? ppLanguage;
  String? ppMerchantId;
  String? ppResponseCode;
  String? ppResponseMessage;
  String? ppRetreivalReferenceNo;
  String? ppSubMerchantId;
  String? ppTxnCurrency;
  String? ppTxnDateTime;
  String? ppTxnRefNo;
  String? ppMobileNumber;
  String? ppCnic;
  dynamic ppDiscountedAmount;
  dynamic ppmpf1;
  dynamic ppmpf2;
  dynamic ppmpf3;
  dynamic ppmpf4;
  dynamic ppmpf5;
  String? ppSecureHash;

  Data({
    this.ppTxnType,
    this.ppVersion,
    this.ppAmount,
    this.ppAuthCode,
    this.ppBillReference,
    this.ppLanguage,
    this.ppMerchantId,
    this.ppResponseCode,
    this.ppResponseMessage,
    this.ppRetreivalReferenceNo,
    this.ppSubMerchantId,
    this.ppTxnCurrency,
    this.ppTxnDateTime,
    this.ppTxnRefNo,
    this.ppMobileNumber,
    this.ppCnic,
    this.ppDiscountedAmount,
    this.ppmpf1,
    this.ppmpf2,
    this.ppmpf3,
    this.ppmpf4,
    this.ppmpf5,
    this.ppSecureHash,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        ppTxnType: json["pp_TxnType"],
        ppVersion: json["pp_Version"],
        ppAmount: json["pp_Amount"],
        ppAuthCode: json["pp_AuthCode"],
        ppBillReference: json["pp_BillReference"],
        ppLanguage: json["pp_Language"],
        ppMerchantId: json["pp_MerchantID"],
        ppResponseCode: json["pp_ResponseCode"],
        ppResponseMessage: json["pp_ResponseMessage"],
        ppRetreivalReferenceNo: json["pp_RetreivalReferenceNo"],
        ppSubMerchantId: json["pp_SubMerchantID"],
        ppTxnCurrency: json["pp_TxnCurrency"],
        ppTxnDateTime: json["pp_TxnDateTime"],
        ppTxnRefNo: json["pp_TxnRefNo"],
        ppMobileNumber: json["pp_MobileNumber"],
        ppCnic: json["pp_CNIC"],
        ppDiscountedAmount: json["pp_DiscountedAmount"],
        ppmpf1: json["ppmpf_1"],
        ppmpf2: json["ppmpf_2"],
        ppmpf3: json["ppmpf_3"],
        ppmpf4: json["ppmpf_4"],
        ppmpf5: json["ppmpf_5"],
        ppSecureHash: json["pp_SecureHash"],
      );

  Map<String, dynamic> toJson() => {
        "pp_TxnType": ppTxnType,
        "pp_Version": ppVersion,
        "pp_Amount": ppAmount,
        "pp_AuthCode": ppAuthCode,
        "pp_BillReference": ppBillReference,
        "pp_Language": ppLanguage,
        "pp_MerchantID": ppMerchantId,
        "pp_ResponseCode": ppResponseCode,
        "pp_ResponseMessage": ppResponseMessage,
        "pp_RetreivalReferenceNo": ppRetreivalReferenceNo,
        "pp_SubMerchantID": ppSubMerchantId,
        "pp_TxnCurrency": ppTxnCurrency,
        "pp_TxnDateTime": ppTxnDateTime,
        "pp_TxnRefNo": ppTxnRefNo,
        "pp_MobileNumber": ppMobileNumber,
        "pp_CNIC": ppCnic,
        "pp_DiscountedAmount": ppDiscountedAmount,
        "ppmpf_1": ppmpf1,
        "ppmpf_2": ppmpf2,
        "ppmpf_3": ppmpf3,
        "ppmpf_4": ppmpf4,
        "ppmpf_5": ppmpf5,
        "pp_SecureHash": ppSecureHash,
      };
}

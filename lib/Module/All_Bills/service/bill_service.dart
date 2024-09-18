import 'package:userapp/Module/All_Bills/Model/pay_bill_with_card_model.dart';
import 'package:userapp/Module/All_Bills/Model/pay_bill_with_wallet_model.dart';
import 'package:userapp/utils/Constants/api_routes.dart';
import 'package:userapp/utils/Constants/base_client.dart';
import 'package:http/http.dart' as http;
import '../Model/BillModel.dart';

class BillService {
  static Future<dynamic> getAllBill({int? residentId}) async {
    try {
      var url = "${Api.monthlyBills}/${residentId.toString()}";

      var res = await BaseClientClass.get(url, "");

      if (res is http.Response) {
        return billModelFromJson(res.body);
      } else {
        return res.toString();
      }
    } catch (e) {
      return e;
    }
  }

//////// jazz cash payment with wallet
  static Future<dynamic> payWithWallet(
      {int? id, String? mobile, String? cnic}) async {
    try {
      Map data = {"bill_id": id, "mobile": mobile, "CNIC": cnic};

      var url = "${Api.payWithWallet}";

      var res = await BaseClientClass.post(url, data);

      if (res is http.Response) {
        return payBillWithWalletModelFromJson(res.body);
      } else {
        return res.toString();
      }
    } catch (e) {
      return e;
    }
  }

  //////
  //////// jazz cash payment with wallet
  static Future<dynamic> payWithCard({
    int? id,
    String? ppAmount,
    String? ppBankID,
    String? ppBillReference,
    String? ppDescription,
    String? ppLanguage,
    String? ppMerchantID,
    String? ppPassword,
    String? ppProductID,
    String? ppReturnURL,
    String? ppTxnCurrency,
    String? ppTxnDateTime,
    String? ppTxnExpiryDateTime,
    String? ppTxnRefNo,
    String? ppTxnType,
    String? ppVersion,
    String? ppmpf1,
    String? ppmpf2,
    String? ppmpf3,
    String? ppmpf4,
    String? ppmpf5,
  }) async {
    try {
      Map data = {
        "bill_id": id,
        'pp_Amount': ppAmount,
        'pp_BankID': ppBankID,
        'pp_BillReference': ppBillReference,
        'pp_Description': ppDescription,
        'pp_Language': ppLanguage,
        'pp_MerchantID': ppMerchantID,
        'pp_Password': ppPassword,
        'pp_ProductID': ppProductID,
        'pp_ReturnURL': ppReturnURL,
        'pp_TxnCurrency': ppTxnCurrency,
        'pp_TxnDateTime': ppTxnDateTime,
        'pp_TxnExpiryDateTime': ppTxnExpiryDateTime,
        'pp_TxnRefNo': ppTxnRefNo,
        'pp_TxnType': ppTxnType,
        'pp_Version': ppVersion,
        'ppmpf_1': ppmpf1,
        'ppmpf_2': ppmpf2,
        'ppmpf_3': ppmpf3,
        'ppmpf_4': ppmpf4,
        'ppmpf_5': ppmpf5,
      };

      var url = "${Api.cardPayment}";

      var res = await BaseClientClass.post(url, data);

      if (res is http.Response) {
        return payBillWithCardModelFromJson(res.body);
      } else {
        return res.toString();
      }
    } catch (e) {
      return e;
    }
  }
}

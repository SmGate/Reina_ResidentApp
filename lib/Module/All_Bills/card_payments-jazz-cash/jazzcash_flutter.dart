import 'package:flutter/cupertino.dart';
import 'package:userapp/Module/All_Bills/card_payments-jazz-cash/jasscash_payment_data_model.dart';
import 'package:userapp/Module/All_Bills/card_payments-jazz-cash/jazz_cash_payment_request.dart';
import 'package:userapp/Module/All_Bills/card_payments-jazz-cash/payment_screen.dart';

class JazzCashFlutter {
  String merchantId;
  String merchantPassword;
  String integritySalt;
  bool isSandbox;

  JazzCashFlutter({
    required this.merchantId,
    required this.merchantPassword,
    required this.integritySalt,
    required this.isSandbox,
  });

  String sandBoxTransactionUrl =
      "https://sandbox.jazzcash.com.pk/CustomerPortal/transactionmanagement/merchantform/";
  String liveTransactionUrl =
      "https://payments.jazzcash.com.pk/CustomerPortal/transactionmanagement/merchantform/";

  Future<String> startPayment(
      {required JazzCashPaymentDataModelV1 paymentDataModelV1,
      required BuildContext context}) async {
    JazzCashPaymentRequest paymentRequest = JazzCashPaymentRequest(
      integritySalt: integritySalt,
      merchantID: merchantId,
      merchantPassword: merchantPassword,
      transactionUrl: isSandbox ? sandBoxTransactionUrl : liveTransactionUrl,
    );

    String request = paymentRequest.generateRequest(
        jazzCashPaymentDataModel: paymentDataModelV1);
    return await Navigator.of(context).push(CupertinoPageRoute(
        builder: (context) =>
            PaymentScreen(request, paymentDataModelV1.ppReturnURL)));
  }
}

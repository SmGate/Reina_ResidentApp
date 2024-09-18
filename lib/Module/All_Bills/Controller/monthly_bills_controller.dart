// ignore_for_file: deprecated_member_use, unused_local_variable
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:userapp/Module/All_Bills/Model/pay_bill_with_card_model.dart';
import 'package:userapp/Module/All_Bills/Model/pay_bill_with_wallet_model.dart';
import 'package:userapp/Module/All_Bills/View/thanks_page.dart';
import 'package:userapp/Module/All_Bills/card_payments-jazz-cash/jasscash_payment_data_model.dart';
import 'package:userapp/Module/All_Bills/card_payments-jazz-cash/jazzcash_flutter.dart';
import 'package:userapp/Module/All_Bills/components/payment_dialogue.dart';
import 'package:userapp/Module/All_Bills/components/payment_sheet.dart';
import 'package:userapp/utils/Constants/secrets.dart';
import '../../HomeScreen/Model/residents.dart';
import '../../Login/Model/User.dart';
import '../Model/BillModel.dart';
import '../service/bill_service.dart';

class MonthlyBillsController extends GetxController {
  double itemHeight = 50.0; // Adjust this height based on your item height
  double maxHeight = 300.0;
  late DateTime dueDate;
  RxBool isLoading = false.obs;
  RxBool LoadingViaCard = false.obs;
  RxString errorPayingBill = "".obs;
  RxString errorPayingViaCard = "".obs;
  var data = Get.arguments;
  late final User userdata;
  late final Residents resident;
  var error = "";
  var billModel = BillModel();
  int? billId;
  String? payableAmount;

  var payWithWalletModel = PayBillWithWalletModel();
  var errorPayWithWallet = "".obs;
  var payViaCardModel = PayBillWithCardModel();

  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController cnicController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    userdata = data[0];
    resident = data[1];

    // monthlyBillsApi(
    //       userid: resident.residentid!);
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<BillModel> monthlyBillsApi({
    required int residentId,
  }) async {
    error = "";
    var res = await BillService.getAllBill(residentId: residentId);

    if (res is BillModel) {
      billModel = res;
      return billModel;
    } else {
      error = res.toString();
      Get.snackbar("Error", error);
    }

    return billModel;
  }

  ///////////////////////  pay with wallet
  payWithWallet(
      {int? id,
      String? mobile,
      String? cnic,
      String? totalPaidAmount,
      BuildContext? context}) async {
    isLoading.value = true;
    errorPayWithWallet.value = "";

    var res =
        await BillService.payWithWallet(id: id, mobile: mobile, cnic: cnic);
    isLoading.value = false;

    if (res is PayBillWithWalletModel &&
        res.data?.ppResponseCode == "000" &&
        res.status == "success") {
      Navigator.pop(context!);
      payWithWalletModel = res;
      mobileNumberController.clear();
      cnicController.clear();
      Get.to(() => ThankYouPage(
            message: res.data?.ppResponseMessage ?? "",
            transaction_status: res.data?.ppResponseCode ?? "",
          ));
      Get.snackbar("Message", payWithWalletModel.data?.ppResponseMessage ?? "");
    } else {
      isLoading.value = false;
      errorPayWithWallet.value = res.toString();
      Get.snackbar("Error", errorPayingBill.value);
    }
  }

  ///////////////////////  pay with card

  void showPaymentMethodDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return PaymentMethodDialog(
          mobileNumberController: mobileNumberController,
          cnicNumberController: cnicController,
          billId: billId ?? 0,
          onpressed: () {
            if (isValidMobileNumber(mobileNumberController.text)) {
              payWithWallet(
                id: billId,
                mobile: mobileNumberController.text,
                cnic: cnicController.text,
                totalPaidAmount: payableAmount,
                context: context,
              );
            } else {
              Get.snackbar("Message", "Invalid Mobile Number");
            }
            // payWithWallet(
            //     id: billId,
            //     mobile: mobileNumberController.text,
            //     cnic: cnicController.text,
            //     totalPaidAmount: payableAmount,
            //     context: context);
          },
        );
      },
    );
  }

  bool isValidMobileNumber(String mobileNumber) {
    if (mobileNumber.length == 11 &&
        RegExp(r'^\d{11}$').hasMatch(mobileNumber)) {
      return true;
    } else {
      return false;
    }
  }

  void showPaymentMethodBottomSheet(BuildContext context,
      Function onMobileAccountPressed, Function onCreditCardPressed) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return PaymentMethodBottomSheet(
          onCreditCardPressed: () {
            Navigator.pop(context);
            onCreditCardPressed();
          },
          onMobileAccountPressed: () {
            Navigator.pop(context);
            onMobileAccountPressed();
          },
        );
      },
    );
  }

  //////////  FUNCTION FOR JAZZ CASH PAYMENT WITH CARD
  Future payViaJazzCash(
      {BuildContext? context,
      String? balance,
      String? description,
      int? billId}) async {
    try {
      JazzCashFlutter jazzCashFlutter = JazzCashFlutter(
        merchantId: Secrets.MERCHANT_ID,
        merchantPassword: Secrets.MERCHANT_PASSWARD,
        integritySalt: Secrets.INTEGRITY_SALT,
        isSandbox: true,
      );

      DateTime date = DateTime.now();

      JazzCashPaymentDataModelV1 paymentDataModelV1 =
          JazzCashPaymentDataModelV1(
        ppAmount: balance ?? "",
        ppBillReference: 'billRef000-$billId',
        ppDescription: description ?? "",
        ppMerchantID: Secrets.MERCHANT_ID,
        ppPassword: Secrets.MERCHANT_PASSWARD,
        ppReturnURL: Secrets.RETURN_URL,
      );

      jazzCashFlutter
          .startPayment(
              paymentDataModelV1: paymentDataModelV1, context: context!)
          .then((_response) {
        print("response from jazzcash $_response");
      });
    } catch (err) {
      print("Error in payment $err");

      return false;
    }
  }
}

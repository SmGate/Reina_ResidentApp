// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:userapp/Module/HomeScreen/Controller/home_screen_controller.dart';
import 'package:userapp/Module/Login/Model/User.dart';
import 'package:userapp/Widgets/small_button.dart';
import 'package:userapp/utils/styles/colors.dart';

import '../../../utils/Constants/date_formatter.dart';
import '../../../Routes/set_routes.dart';
import '../../../Widgets/my_back_button.dart';
import '../Controller/monthly_bills_controller.dart';
import '../Model/BillModel.dart';

class UnpaidPaidBillDetails extends StatelessWidget {
  final User user;
  final String title;
  final BillModel model;
  final int index;

  UnpaidPaidBillDetails({
    Key? key,
    required this.user,
    required this.title,
    required this.model,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<MonthlyBillsController>();

    var homeScreenController = Get.find<HomeScreenController>();

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyBackButton(
              text: title,
              onTap: () {
                Get.offNamed(all_bill, arguments: user);
              },
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 3,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _sectionTitle("Resident Details"),
                      _residentDetails(),
                      const Divider(thickness: 1),
                      _sectionTitle("Bill Details"),
                      _billDetailsTable(),
                      const SizedBox(height: 20),
                      homeScreenController.user.permissions?['Payment'] == false
                          ? SizedBox()
                          : _payBillButton(controller, context),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16.0,
          color: AppColors.textBlack,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _residentDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _detailRow("Name",
            "${model.data!.unpaid![index].user?.firstname} ${model.data!.unpaid![index].user?.lastname}"),
        _detailRow("Role", "${model.data!.unpaid![index].user?.rolename}"),
        _detailRow("Mobile", "${model.data!.unpaid![index].user?.mobileno}"),
        _detailRow("Address", "${model.data!.unpaid![index].user?.address}"),
      ],
    );
  }

  Widget _detailRow(String name, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: TextStyle(
              fontSize: 14.0,
              color: AppColors.textBlack,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            width: 200,
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14.0,
                color: AppColors.textBlack,
              ),
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _billDetailsTable() {
    return Table(
      border: TableBorder.all(color: Colors.grey.withOpacity(0.5), width: 1),
      columnWidths: {
        0: FlexColumnWidth(3),
        1: FlexColumnWidth(5),
      },
      children: [
        _tableHeaderRow(),
        _tableRow("Generation Date",
            formatDateString("${model.data!.unpaid![index].billstartdate}")),
        _tableRow("Due Date",
            formatDateString("${model.data!.unpaid![index].duedate}")),
        _tableRow("End Date",
            formatDateString("${model.data!.unpaid![index].billenddate}")),
        _tableRow("Balance", "PKR ${model.data!.unpaid![index].balance}"),
        _tableRow("Charges", "PKR ${model.data!.unpaid![index].charges}"),
        _tableRow("Payable Amount",
            "PKR ${model.data!.unpaid![index].payableamount}"),
        _tableRow(
            "Late Charges", "PKR ${model.data!.unpaid![index].latecharges}"),
        _tableRow(
            "App Charges", "PKR ${model.data!.unpaid![index].appcharges}"),
        _tableRow("Tax", "PKR ${model.data!.unpaid![index].tax}"),
        _tableRow("Unpaid Amount",
            "PKR ${model.data!.unpaid![index].totalpaidamount}"),
        _tableRow("Payment Type", "${model.data!.unpaid![index].paymenttype}"),
        _tableRow("Bill Type", "${model.data!.unpaid![index].billtype}"),
        _tableRow("Bill Month", "${model.data!.unpaid![index].month}"),
        _tableRow(
            "Specific Type", "${model.data!.unpaid![index].specificType}"),
        _tableRow("Status", "${model.data!.unpaid![index].status}"),
      ],
    );
  }

  TableRow _tableHeaderRow() {
    return TableRow(
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.2),
      ),
      children: [
        _tableHeaderCell("Description"),
        _tableHeaderCell("Details"),
      ],
    );
  }

  Widget _tableHeaderCell(String text) {
    return Container(
      padding: EdgeInsets.all(8),
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14.0,
          color: AppColors.textBlack,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  TableRow _tableRow(String name, String value) {
    return TableRow(
      children: [
        _tableCell(name, isLabel: true),
        _tableCell(value),
      ],
    );
  }

  Widget _tableCell(String text, {bool isLabel = false}) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12.0,
          color: isLabel ? AppColors.textBlack : AppColors.dark,
          fontWeight: isLabel ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _payBillButton(MonthlyBillsController controller, BuildContext c) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Obx(
        () => controller.isLoading.value
            ? CircularProgressIndicator(color: AppColors.globalWhite)
            : CustomButton(
                height: 50,
                text: "Pay Bill",
                color: AppColors.green,
                textColor: AppColors.globalWhite,
                onPressed: () {
                  controller.showPaymentMethodBottomSheet(c, () {
                    controller.showPaymentMethodDialog(c);
                  }, () {
                    controller.payViaJazzCash(
                        context: c,
                        billId: model.data!.unpaid![index].id,
                        balance: model.data!.unpaid![index].balance,
                        description: model.data!.unpaid![index].description!);
                    // controller.payWithCard(id: model.data!.unpaid![index].id!);
                  });
                },
              ),
      ),
    );
  }
}

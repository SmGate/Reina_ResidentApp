// ignore_for_file: must_be_immutable, deprecated_member_use, unused_element

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

class PartiallyPaidBill extends StatelessWidget {
  User user = User();
  String title = "Partially Paid Bill Details";
  BillModel model = BillModel();
  int index = 0;

  PartiallyPaidBill({
    super.key,
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
      child: WillPopScope(
        onWillPop: () async {
          Get.offNamed(all_bill, arguments: user);
          return true;
        },
        child: Scaffold(
          backgroundColor: AppColors.background,
          body: Column(
            children: [
              MyBackButton(
                text: title,
                onTap: () {
                  Get.offNamed(all_bill, arguments: user);
                },
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 3,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // _invoiceHeader(),
                        // const SizedBox(height: 20),
                        _sectionTitle("Resident Details"),
                        _residentDetails(),
                        const Divider(thickness: 1),
                        _sectionTitle("Bill Details"),
                        _billDetailsTable(),
                        const SizedBox(height: 20),
                        homeScreenController.user.permissions?['Payment'] ==
                                false
                            ? SizedBox()
                            : _payBillButton(controller),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _invoiceHeader() {
    return Center(
      child: Text(
        "Invoice",
        style: TextStyle(
          fontSize: 20.0,
          color: AppColors.textBlack,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
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
            "${model.data!.partiallypaid![index].user?.firstname} ${model.data!.partiallypaid![index].user?.lastname}"),
        _detailRow(
            "Role", "${model.data!.partiallypaid![index].user?.rolename}"),
        _detailRow(
            "Mobile", "${model.data!.partiallypaid![index].user?.mobileno}"),
        _detailRow(
            "Address", "${model.data!.partiallypaid![index].user?.address}"),
      ],
    );
  }

  Widget _detailRow(String name, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: TextStyle(
              fontSize: 14.0,
              color: AppColors.textBlack,
              fontWeight: FontWeight.w600, // Bold and black
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14.0,
              color: AppColors.textBlack,
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
        _tableRow(
            "Generation Date",
            formatDateString(
                "${model.data!.partiallypaid![index].billstartdate}")),
        _tableRow("Due Date",
            formatDateString("${model.data!.partiallypaid![index].duedate}")),
        _tableRow(
            "End Date",
            formatDateString(
                "${model.data!.partiallypaid![index].billenddate}")),
        _tableRow("Paid On",
            formatDateString("${model.data!.partiallypaid![index].paidOn}")),
        _tableRow(
            "Charges", "PKR ${model.data!.partiallypaid![index].charges}"),
        _tableRow(
            "Balance", "PKR ${model.data!.partiallypaid![index].balance}"),
        _tableRow("Payable Amount",
            "PKR ${model.data!.partiallypaid![index].payableamount}"),
        _tableRow("Late Charges",
            "PKR ${model.data!.partiallypaid![index].latecharges}"),
        _tableRow("App Charges",
            "PKR ${model.data!.partiallypaid![index].appcharges}"),
        _tableRow("Tax", "PKR ${model.data!.partiallypaid![index].tax}"),
        _tableRow("Unpaid Amount",
            "PKR ${model.data!.partiallypaid![index].totalpaidamount}"),
        _tableRow(
            "Payment Type", "${model.data!.partiallypaid![index].paymenttype}"),
        _tableRow("Bill Type", "${model.data!.partiallypaid![index].billtype}"),
        _tableRow("Bill Month", "${model.data!.partiallypaid![index].month}"),
        _tableRow("Specific Type",
            "${model.data!.partiallypaid![index].specificType}"),
        _tableRow("Status", "${model.data!.partiallypaid![index].status}"),
      ],
    );
  }

  TableRow _tableHeaderRow() {
    return TableRow(
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.2),
      ),
      children: [
        _tableCell("Description", isHeader: true),
        _tableCell("Details", isHeader: true),
      ],
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

  Widget _tableCell(String text,
      {bool isHeader = false, bool isLabel = false}) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Text(
        text,
        style: TextStyle(
          fontSize: isHeader ? 14.0 : 12.0,
          color: isHeader || isLabel ? AppColors.textBlack : AppColors.dark,
          fontWeight: isHeader || isLabel
              ? FontWeight.bold
              : FontWeight.normal, // Bold and black
        ),
      ),
    );
  }

  Widget _payBillButton(MonthlyBillsController controller) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Obx(
        () => controller.isLoading.value
            ? CircularProgressIndicator(
                color: AppColors.globalWhite,
              )
            : CustomButton(
                height: 50,
                text: "Pay Bill",
                color: AppColors.green,
                textColor: AppColors.globalWhite,
                onPressed: () {
                  // controller.payBillApi(
                  //   id: model.data!.partiallypaid![index].id!,
                  //   totalPaidAmount: model.data!.partiallypaid![index].balance!,
                  // );
                },
              ),
      ),
    );
  }
}

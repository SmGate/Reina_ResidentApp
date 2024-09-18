// ignore_for_file: deprecated_member_use, unused_element

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:userapp/Module/Login/Model/User.dart';
import 'package:userapp/utils/styles/colors.dart';
import 'package:userapp/utils/styles/reuseable_textstyle.dart';

import '../../../utils/Constants/date_formatter.dart';
import '../../../Routes/set_routes.dart';
import '../../../Widgets/my_back_button.dart';
import '../Model/BillModel.dart';

class PaidBillDetails extends StatelessWidget {
  final User user;
  final String title;
  final BillModel model;
  final int index;

  PaidBillDetails({
    super.key,
    required this.user,
    required this.title,
    required this.model,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
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
                        _sectionTitle("Resident Details"),
                        _residentDetails(),
                        const Divider(thickness: 1),
                        _sectionTitle("Bill Details"),
                        _billDetailsTable(),
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
        style: reusableTextStyle(
          textStyle: GoogleFonts.dmSans(),
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
        style: reusableTextStyle(
          textStyle: GoogleFonts.dmSans(),
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
            "${model.data!.paid![index].user?.firstname} ${model.data!.paid![index].user?.lastname}"),
        _detailRow("Role", "${model.data!.paid![index].user?.rolename}"),
        _detailRow("Mobile", "${model.data!.paid![index].user?.mobileno}"),
        _detailRow("Address", "${model.data!.paid![index].user?.address}"),
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
            style: reusableTextStyle(
              textStyle: GoogleFonts.dmSans(),
              fontSize: 14.0,
              color: AppColors.textBlack,
              fontWeight: FontWeight.w600, // Label bold and black
            ),
          ),
          Text(
            value,
            style: reusableTextStyle(
              textStyle: GoogleFonts.dmSans(),
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
            "Paid On", formatDateString("${model.data!.paid![index].paidOn}")),
        _tableRow("Charges", "PKR ${model.data!.paid![index].charges}"),
        _tableRow("Balance", "PKR ${model.data!.paid![index].balance}"),
        _tableRow(
            "Payable Amount", "PKR ${model.data!.paid![index].payableamount}"),
        _tableRow(
            "Late Charges", "PKR ${model.data!.paid![index].latecharges}"),
        _tableRow("App Charges", "PKR ${model.data!.paid![index].appcharges}"),
        _tableRow("Tax", "PKR ${model.data!.paid![index].tax}"),
        _tableRow(
            "Paid Amount", "PKR ${model.data!.paid![index].totalpaidamount}"),
        _tableRow("Payment Type", "${model.data!.paid![index].paymenttype}"),
        _tableRow("Bill Type", "${model.data!.paid![index].billtype}"),
        _tableRow("Bill Month", "${model.data!.paid![index].month}"),
        _tableRow("Specific Type", "${model.data!.paid![index].specificType}"),
        _tableRow("Status", "${model.data!.paid![index].status}"),
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
        style: reusableTextStyle(
          textStyle: GoogleFonts.dmSans(),
          fontSize: isHeader ? 14.0 : 12.0,
          color: isHeader || isLabel ? AppColors.textBlack : AppColors.dark,
          fontWeight: isHeader || isLabel
              ? FontWeight.bold
              : FontWeight.normal, // Labels bold and black
        ),
      ),
    );
  }
}

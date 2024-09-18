// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:userapp/Helpers/Validation%20Helper/validation_helper.dart';
import 'package:userapp/Module/All_Bills/Controller/monthly_bills_controller.dart';
import 'package:userapp/Widgets/app_gradient.dart';
import 'package:userapp/Widgets/my_button.dart';
import 'package:userapp/Widgets/my_textform_field.dart';
import 'package:userapp/utils/styles/colors.dart';
import 'package:userapp/utils/styles/reuseable_textstyle.dart';

class PaymentMethodDialog extends StatelessWidget {
  TextEditingController mobileNumberController;
  TextEditingController cnicNumberController;
  final _formKey = new GlobalKey<FormState>();
  Function onpressed;
  int billId;
  PaymentMethodDialog(
      {required this.mobileNumberController,
      required this.cnicNumberController,
      required this.billId,
      required this.onpressed});
  @override
  Widget build(BuildContext context) {
    var controller = Get.find<MonthlyBillsController>();
    return AlertDialog(
      backgroundColor: AppColors.globalWhite,
      surfaceTintColor: AppColors.globalWhite,
      title: Text(
        'Enter Details',
        style: reusableTextStyle(
          textStyle: GoogleFonts.dmSans(),
          fontSize: 18.0,
          color: AppColors.textBlack,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            MyTextFormField(
              padding: EdgeInsets.only(left: 10, right: 6),
              textInputType: TextInputType.phone,
              width: double.infinity,
              validator: ValidationHelper().emptyStringValidator,
              hintText: "Enter Phone Number ",
              labelText: "Enter Phone Number ",
              controller: mobileNumberController,
              maxLength: 11,
              onChanged: (val) {},
            ),
            SizedBox(
              height: 20,
            ),
            MyTextFormField(
              maxLength: 6,
              padding: EdgeInsets.only(left: 10, right: 10),
              width: double.infinity,
              hintText: "Cnic (Last 6 digits",
              labelText: "Cnic (Last 6 digits)",
              validator: ValidationHelper().emptyStringValidator,
              controller: cnicNumberController,
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Obx(() => MyButton(
                    loading: controller.isLoading.value,
                    gradient: AppGradients.buttonGradient,
                    name: "Pay Bill",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        onpressed();
                      }
                    },
                  )),
            )
          ],
        ),
      ),
    );
  }
}

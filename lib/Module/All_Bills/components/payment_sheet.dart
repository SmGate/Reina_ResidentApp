import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:userapp/Module/All_Bills/Controller/monthly_bills_controller.dart';
import 'package:userapp/utils/styles/colors.dart';
import 'package:userapp/utils/styles/reuseable_textstyle.dart';

class PaymentMethodBottomSheet extends StatelessWidget {
  final VoidCallback onMobileAccountPressed;
  final VoidCallback onCreditCardPressed;

  PaymentMethodBottomSheet({
    required this.onMobileAccountPressed,
    required this.onCreditCardPressed,
  });

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<MonthlyBillsController>();
    return Container(
      color: AppColors.globalWhite,
      width: double.infinity,
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Select Payment Method',
            style: reusableTextStyle(
              textStyle: GoogleFonts.dmSans(),
              fontSize: 18.0,
              color: AppColors.textBlack,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20.0),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.appThem,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  onPressed: onMobileAccountPressed,
                  child: Row(
                    children: [
                      SizedBox(width: 20),
                      Icon(
                        Icons.mobile_friendly,
                        color: AppColors.globalWhite,
                      ),
                      SizedBox(width: 20),
                      Text(
                        'Mobile Account',
                        style: reusableTextStyle(
                          textStyle: GoogleFonts.dmSans(),
                          fontSize: 18.0,
                          color: AppColors.globalWhite,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      SizedBox(width: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10.0),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: Obx(() => ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.appThem,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      onPressed: onCreditCardPressed,
                      child: controller.LoadingViaCard.value
                          ? Center(
                              child: CircularProgressIndicator(
                              color: AppColors.globalWhite,
                            ))
                          : Row(
                              children: [
                                SizedBox(width: 20),
                                Icon(
                                  Icons.credit_card,
                                  color: AppColors.globalWhite,
                                ),
                                SizedBox(width: 20),
                                Text(
                                  'Credit Card',
                                  style: reusableTextStyle(
                                    textStyle: GoogleFonts.dmSans(),
                                    fontSize: 18.0,
                                    color: AppColors.globalWhite,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                SizedBox(width: 20),
                              ],
                            ),
                    )),
              ),
            ),
          ),
          SizedBox(height: 10.0),
        ],
      ),
    );
  }
}

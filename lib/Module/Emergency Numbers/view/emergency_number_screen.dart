// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:userapp/Module/Emergency%20Numbers/controller/emergency_numbers_controller.dart';
import 'package:userapp/Module/Emergency%20Numbers/view/numbers_detail.dart';
import 'package:userapp/Routes/set_routes.dart';
import 'package:userapp/Widgets/custom_card.dart';
import 'package:userapp/Widgets/my_back_button.dart';
import 'package:userapp/utils/Constants/images_strings.dart';
import 'package:userapp/utils/styles/colors.dart';
import 'package:userapp/utils/styles/reuseable_textstyle.dart';

class EmergencyNumbersScreen extends StatelessWidget {
  const EmergencyNumbersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<EmergencyNumbersController>();
    return WillPopScope(
      onWillPop: () async {
        await Get.offNamed(homescreen, arguments: controller.userdata);
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.background,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyBackButton(
                text: 'Emergency Numbers',
                onTap: () {
                  Get.offNamed(homescreen, arguments: controller.userdata);
                },
              ),
              Expanded(
                  child: ListView.builder(
                      itemCount: controller.numbersList.length,
                      itemBuilder: (contex, index) {
                        return Padding(
                          padding: EdgeInsets.only(
                              left: 20,
                              right: 20,
                              top: index == 0 ? 20 : 5,
                              bottom: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomCard(
                                boxShadow: BoxShadow(),
                                borderRadius: BorderRadius.circular(12),
                                onTap: () {
                                  Get.to(() => NumbersDetails(
                                        city: controller
                                            .numbersList[index].cityName,
                                        numbers: controller.numbersList[index]
                                            .emergencyNumbers,
                                      ));
                                },
                                width: double.infinity,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 20, top: 10, bottom: 10),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        AppImages.country,
                                        height: 30,
                                      ),
                                      SizedBox(
                                        width: 30,
                                      ),
                                      SizedBox(
                                        width: 160,
                                        child: Text(
                                          controller
                                              .numbersList[index].cityName,
                                          style: reusableTextStyle(
                                              textStyle: GoogleFonts.dmSans(),
                                              fontSize: 16.0,
                                              color: AppColors.textBlack,
                                              fontWeight: FontWeight.bold),
                                          maxLines: 2,
                                        ),
                                      ),
                                      Spacer(),
                                      Icon(Icons.arrow_forward_ios),
                                      SizedBox(
                                        width: 20,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }))
            ],
          ),
        ),
      ),
    );
  }
}

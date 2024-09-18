// ignore_for_file: must_be_immutable, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:userapp/Module/Emergency%20Numbers/controller/emergency_numbers_controller.dart';
import 'package:userapp/Module/Emergency%20Numbers/model/emergency_model.dart';
import 'package:userapp/Routes/set_routes.dart';
import 'package:userapp/Widgets/custom_card.dart';
import 'package:userapp/Widgets/my_back_button.dart';
import 'package:userapp/utils/Constants/constants.dart';
import 'package:userapp/utils/Constants/images_strings.dart';
import 'package:userapp/utils/styles/colors.dart';
import 'package:userapp/utils/styles/reuseable_textstyle.dart';

class NumbersDetails extends StatelessWidget {
  String? city;
  List<EmergencyNumbers>? numbers = [];
  Uri? uri;
  NumbersDetails({super.key, this.city, this.numbers});

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
                text: city ?? "",
                onTap: () {
                  Get.offNamed(homescreen, arguments: controller.userdata);
                },
              ),
              Expanded(
                  child: ListView.builder(
                      itemCount: numbers?.length,
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
                                onTap: () async {
                                  print("call");
                                  final phoneNumber = numbers![index].phone;

                                  uri = Uri.parse("tel://${phoneNumber}");

                                  try {
                                    await launchUrl(uri!);
                                    uri = null;
                                  } catch (e) {
                                    myToast(
                                        msg: e.toString(), isNegative: true);
                                  }
                                },
                                width: double.infinity,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 20, top: 10, bottom: 10),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 160,
                                            child: Text(
                                              numbers![index].serviceType,
                                              style: reusableTextStyle(
                                                  textStyle:
                                                      GoogleFonts.dmSans(),
                                                  fontSize: 16.0,
                                                  color: AppColors.textBlack,
                                                  fontWeight: FontWeight.bold),
                                              maxLines: 1,
                                            ),
                                          ),
                                          Text(
                                            numbers![index].phone,
                                            style: reusableTextStyle(
                                                textStyle: GoogleFonts.dmSans(),
                                                fontSize: 16.0,
                                                color: AppColors.dark,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ],
                                      ),
                                      Spacer(),
                                      Image.asset(
                                        AppImages.call2,
                                        height: 20,
                                      ),
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

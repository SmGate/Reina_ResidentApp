// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:userapp/Module/SocietyRules/controller/society_rule_controller.dart';
import 'package:userapp/Routes/set_routes.dart';
import 'package:userapp/Widgets/custom_card.dart';
import 'package:userapp/Widgets/empty_list.dart';
import 'package:userapp/Widgets/loading.dart';
import 'package:userapp/Widgets/my_back_button.dart';
import 'package:userapp/utils/Constants/images_strings.dart';
import 'package:userapp/utils/styles/colors.dart';
import 'package:userapp/utils/styles/reuseable_textstyle.dart';

class AllSocietyRules extends StatelessWidget {
  const AllSocietyRules({super.key});

  @override
  Widget build(BuildContext context) {
    var societyRulesController = Get.find<SocietyRuleController>();
    return WillPopScope(
      onWillPop: () async {
        Get.offNamed(homescreen, arguments: societyRulesController.user);
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.background,
          body: Column(
            children: [
              MyBackButton(
                text: "Rules",
                onTap: () {
                  Get.offNamed(homescreen,
                      arguments: societyRulesController.user);
                },
              ),
              Expanded(
                child: FutureBuilder(
                    future: societyRulesController.getAllRules(
                        societyId: societyRulesController.userdata.societyId
                            .toString()),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data != null &&
                            societyRulesController
                                    .societyRulesModel.data?.length !=
                                0) {
                          return ListView.builder(
                              itemCount: societyRulesController
                                  .societyRulesModel.data?.length,
                              itemBuilder: (contex, index) {
                                var data = societyRulesController
                                    .societyRulesModel.data?[index];
                                return Padding(
                                  padding: EdgeInsets.only(
                                      top: index == 0 ? 20 : 20,
                                      left: 20,
                                      right: 20),
                                  child: CustomCard(
                                      width: double.infinity,
                                      boxShadow: BoxShadow(),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10,
                                            bottom: 10,
                                            left: 20,
                                            right: 20),
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              AppImages.rules,
                                              height: 30,
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  data?.title ?? "",
                                                  style: reusableTextStyle(
                                                    textStyle:
                                                        GoogleFonts.dmSans(),
                                                    fontSize: 16.0,
                                                    color: AppColors.textBlack,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  data?.description ?? "",
                                                  style: reusableTextStyle(
                                                    textStyle:
                                                        GoogleFonts.dmSans(),
                                                    fontSize: 16.0,
                                                    color: AppColors.dark,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      )),
                                );
                              });
                        } else {
                          return EmptyList(
                            name: 'No Rules Added Yet',
                          );
                        }
                      } else if (snapshot.hasError) {
                        return Icon(Icons.error_outline);
                      } else {
                        return CircularIndicatorUnderWhiteBox();
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

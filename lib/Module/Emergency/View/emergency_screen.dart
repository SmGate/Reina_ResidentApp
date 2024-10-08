// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:userapp/utils/styles/colors.dart';
import '../../../utils/Constants/constants.dart';
import '../../../Routes/set_routes.dart';
import '../components/emergency_card.dart';
import '../../../Widgets/my_back_button.dart';
import '../Controller/emergency_controller.dart';

class AddEmergencyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddEmergencyController>(
        init: AddEmergencyController(),
        builder: (controller) {
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
                    children: <Widget>[
                      MyBackButton(
                        text: 'Emergency',
                        onTap: () {
                          Get.offNamed(homescreen,
                              arguments: controller.userdata);
                        },
                      ),
                      20.h.ph,
                      Expanded(
                        child: GridView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: controller.emergencies.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    mainAxisSpacing: 16,
                                    childAspectRatio: 3 / 2,
                                    crossAxisCount: 2),
                            itemBuilder: (BuildContext context, index) {
                              final AllEmergencies emergencies =
                                  controller.emergencies[index];

                              return EmergencyCard(
                                  controller: controller,
                                  emergencies: emergencies);
                            }),
                      ),
                    ],
                  )),
            ),
          );
        });
  }
}

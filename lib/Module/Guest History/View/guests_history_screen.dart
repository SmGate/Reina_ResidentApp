// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:userapp/Module/Guest%20History/Model/pre_approved_history_model.dart';
import 'package:userapp/Module/Pre%20Approve%20Entry/components/dialogue_box.dart';
import 'package:userapp/Widgets/loading.dart';
import 'package:userapp/utils/styles/colors.dart';

import '../../../utils/Constants/constants.dart';
import '../../../Routes/set_routes.dart';
import '../../../Widgets/my_back_button.dart';
import '../component/guest_history_component.dart';

class GuestsHistoryScreen extends GetView {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: AppColors.background,
          body: Column(children: [
            MyBackButton(
              text: 'Guest History',
              onTap: () {
                Get.offNamed(homescreen, arguments: controller.userdata);
              },
            ),
            23.h.ph,
            FutureBuilder<PreApprovedHistoryModel>(
              future: controller.preApprovedHistory(
                  userId: controller.userdata.userId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 250),
                    child: CircularIndicatorUnderWhiteBox(),
                  );
                } else if (snapshot.hasData) {
                  return Expanded(
                    child: ListView.builder(
                        itemCount:
                            controller.preApprovedHistoryModel.data?.length,
                        itemBuilder: (context, index) {
                          var preApprovedHistory =
                              controller.preApprovedHistoryModel.data?[index];
                          return PreApproveEntryHistoryCard(
                              id: preApprovedHistory!.id!,
                              updatedAt:
                                  preApprovedHistory.updatedAt!.toString(),
                              checkInTime: preApprovedHistory.checkintime ?? "",
                              name: preApprovedHistory.name ?? "",
                              checkOutTime:
                                  preApprovedHistory.checkouttime ?? "",
                              controller: controller,
                              cnic: preApprovedHistory.cnic,
                              vehicleNo: preApprovedHistory.vechileno,
                              onpressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                          backgroundColor:
                                              AppColors.globalWhite,
                                          surfaceTintColor:
                                              AppColors.globalWhite,
                                          content: PreApproveEntryDialog(
                                            name: preApprovedHistory.name,
                                            description:
                                                preApprovedHistory.description,
                                            arrivaldate: preApprovedHistory
                                                .arrivaldate
                                                .toString(),
                                            arrivaltime:
                                                preApprovedHistory.arrivaltime,
                                            cnic: preApprovedHistory.cnic,
                                            mobileno:
                                                preApprovedHistory.mobileno,
                                            vechileno:
                                                preApprovedHistory.vechileno,
                                            visitortype:
                                                preApprovedHistory.visitortype,
                                          ),
                                        ));
                              });
                        }),
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text("${snapshot.error}"));
                } else {
                  return Center(child: Text("No Data"));
                }
              },
            )
          ])),
    );
  }
}

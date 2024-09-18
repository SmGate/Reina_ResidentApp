// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:userapp/Module/Pre%20Approve%20Entry/Model/all_pre_approved_entriese_model.dart';
import 'package:userapp/Module/Pre%20Approve%20Entry/components/dialogue_box.dart';
import 'package:userapp/Routes/set_routes.dart';
import 'package:userapp/Widgets/app_gradient.dart';
import 'package:userapp/Widgets/loading.dart';

import '../../../utils/Constants/constants.dart';
import '../../../Widgets/my_back_button.dart';
import '../../../utils/styles/colors.dart';
import '../Controller/pre_approve_entry_controller.dart';

class PreApproveEntryScreen extends GetView {
  @override
  Widget build(BuildContext context) {
    var controller = Get.find<PreApproveEntryController>();

    return WillPopScope(
        onWillPop: () async {
          Get.offNamed(homescreen, arguments: controller.userdata);

          return true;
        },
        child: SafeArea(
            child: Scaffold(
                backgroundColor: AppColors.background,
                floatingActionButton: Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                        gradient: AppGradients.floatingbuttonGradient,
                        shape: BoxShape.circle),
                    child: IconButton(
                        onPressed: () {
                          Get.offNamed(addpreapproveentryscreen, arguments: [
                            controller.userdata,
                            controller.resident,
                            0
                          ]);
                        },
                        icon: Icon(
                          Icons.add,
                          color: AppColors.globalWhite,
                          weight: 20.0,
                          size: 40,
                        ))),
                body: Column(
                  children: [
                    MyBackButton(
                      text: 'Pre Approve Entry',
                      onTap: () {
                        Get.offNamed(homescreen,
                            arguments: controller.userdata);
                      },
                    ),
                    19.h.ph,
                    Expanded(
                        child: FutureBuilder<PreapproveEntryModel>(
                      future: controller.getAllPreApprovedEntry(
                          userid: controller.userdata.userId!, pageKey: 1),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                              child: CircularIndicatorUnderWhiteBox());
                        } else if (snapshot.hasData) {
                          return ListView.builder(
                              itemCount: controller
                                  .allPreApprovedEntriese.data?.data?.length,
                              itemBuilder: (context, index) {
                                var p = controller
                                    .allPreApprovedEntriese.data?.data?[index];
                                return PreApproveEntryCard(
                                    createdAt: p?.createdAt,
                                    updatedAt: p?.updatedAt.toString(),
                                    name: p?.name,
                                    status: p?.status,
                                    arrivalDate: p?.arrivaldate.toString(),
                                    checkInTime: p?.checkintime,
                                    checkOutTime: p?.checkouttime,
                                    statusDescription: p?.statusdescription,
                                    visitorType: p?.visitortype,
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                                  backgroundColor:
                                                      AppColors.globalWhite,
                                                  surfaceTintColor:
                                                      AppColors.globalWhite,
                                                  content:
                                                      PreApproveEntryDialog(
                                                    name: p?.name,
                                                    description: p?.description,
                                                    arrivaldate: p?.arrivaldate
                                                        .toString(),
                                                    arrivaltime: p?.arrivaltime,
                                                    cnic: p?.cnic,
                                                    mobileno: p?.mobileno,
                                                    vechileno: p?.vechileno,
                                                    visitortype: p?.visitortype,
                                                    expiryDate:
                                                        p?.toDate.toString(),
                                                  )));
                                    });
                              });
                        } else if (snapshot.hasError) {
                          return Center(child: Text("${snapshot.error}"));
                        } else {
                          return Center(child: Text("No Data"));
                        }
                      },
                    )),
                  ],
                ))));
  }
}

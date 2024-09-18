// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:userapp/Module/NoticeBoard/components/all_components.dart';
import 'package:userapp/Widgets/empty_list.dart';
import 'package:userapp/Widgets/loading.dart';
import 'package:userapp/Widgets/my_back_button.dart';
import 'package:userapp/utils/styles/colors.dart';
import '../../../Routes/set_routes.dart';
import '../Controller/notice_board_controller.dart';
import '../Model/notice_board_model.dart';

class NoticeBoardScreen extends GetView {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NoticeBoardController>(
      init: NoticeBoardController(),
      builder: (controller) => WillPopScope(
        onWillPop: () async {
          Get.offNamed(homescreen, arguments: controller.userdata);
          return true;
        },
        child: SafeArea(
          child: Scaffold(
              backgroundColor: AppColors.background,
              body: Column(
                children: [
                  MyBackButton(
                    text: 'NoticeBoard',
                    onTap: () {
                      Get.offNamed(homescreen, arguments: controller.userdata);
                    },
                  ),
                  Expanded(
                    child: FutureBuilder<NoticeBoardModel>(
                        future: controller.viewNoticeBoardApi(
                          controller.resident.subadminid!,
                        ),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            if (controller.noticeBoardModel.data != null &&
                                controller.noticeBoardModel.data?.length != 0) {
                              return ListView.builder(
                                  itemBuilder: (context, index) {
                                    return NoticeboardCard(
                                      title: controller.noticeBoardModel
                                          .data?[index].noticetitle,
                                      description: controller.noticeBoardModel
                                          .data?[index].noticedetail,
                                      startDate: controller.noticeBoardModel
                                          .data?[index].startdate
                                          .toString(),
                                      onpressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                AlertDialog(
                                                    backgroundColor:
                                                        AppColors.globalWhite,
                                                    surfaceTintColor:
                                                        AppColors.globalWhite,
                                                    content:
                                                        NoticeBoardDialogCard(
                                                      status: controller
                                                          .noticeBoardModel
                                                          .data?[index]
                                                          .status,
                                                      startDate: controller
                                                          .noticeBoardModel
                                                          .data?[index]
                                                          .startdate
                                                          .toString(),
                                                      endDate: controller
                                                          .noticeBoardModel
                                                          .data?[index]
                                                          .enddate
                                                          .toString(),
                                                      title: controller
                                                          .noticeBoardModel
                                                          .data?[index]
                                                          .noticetitle,
                                                      description: controller
                                                          .noticeBoardModel
                                                          .data?[index]
                                                          .noticedetail,
                                                      endTime: controller
                                                          .noticeBoardModel
                                                          .data?[index]
                                                          .endtime,
                                                      startTime: controller
                                                          .noticeBoardModel
                                                          .data?[index]
                                                          .starttime,
                                                    )));
                                      },
                                    );
                                  },
                                  itemCount:
                                      controller.noticeBoardModel.data?.length);
                            } else {
                              return Center(
                                child: EmptyList(
                                  name: 'No Notices',
                                ),
                              );
                            }
                          } else if (snapshot.hasError) {
                            return Icon(Icons.error_outline);
                          } else {
                            return Center(
                              child: CircularIndicatorUnderWhiteBox(),
                            );
                          }
                        }),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}

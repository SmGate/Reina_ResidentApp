// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:userapp/Module/ReportsHistory/components/report_history_component.dart';
import 'package:userapp/Module/ReportsHistory/model/report_history_model.dart';
import 'package:userapp/Widgets/loading.dart';
import 'package:userapp/utils/Constants/constants.dart';
import 'package:userapp/Widgets/my_back_button.dart';
import 'package:userapp/utils/styles/colors.dart';
import '../../../Routes/set_routes.dart';
import '../../../Widgets/empty_list.dart';
import '../Controller/admin_reports_history_controller.dart';

class ReportsHistoryScreen extends GetView {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReportHistoryController>(
        init: ReportHistoryController(),
        builder: (controller) => SafeArea(
              child: WillPopScope(
                onWillPop: () async {
                  Get.offNamed(homescreen, arguments: controller.user);
                  return true;
                },
                child: Scaffold(
                    backgroundColor: AppColors.background,
                    body: Column(children: [

                      MyBackButton(
                        text: 'Report History',
                        onTap: () {
                          Get.offNamed(homescreen, arguments: controller.user);
                        },
                      ),
                      // 32.h.ph,
                      Expanded(
                        child: PagedListView(
                          shrinkWrap: true,
                          primary: false,
                          pagingController: controller.pagingController,
                          addAutomaticKeepAlives: false,
                          builderDelegate: PagedChildBuilderDelegate(
                            firstPageProgressIndicatorBuilder: (context) {
                              return Center(
                                  child: Padding(
                                padding: const EdgeInsets.only(top: 300),
                                child: CircularIndicatorUnderWhiteBox(),
                              ));
                            },
                            newPageProgressIndicatorBuilder: (context) {
                              return Center(
                                  child: CircularProgressIndicator(
                                      color: primaryColor));
                            },
                            noItemsFoundIndicatorBuilder: (context) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 300),
                                child: EmptyList(
                                  name: 'No History',
                                ),
                              );
                            },
                            itemBuilder: (context, item, index) {
                              Datum reports = item as Datum;

                              return ReportHistoryCard(
                                controller: controller,
                                id: reports.id,
                                title: reports.title,
                                description: reports.description,
                                userId: reports.userid,
                                subAdminId: reports.subadminid,
                                createdAt: reports.createdAt.toString(),
                                status: reports.status,
                                statusDescription: reports.statusdescription,
                                updatedAat: reports.updatedAt.toString(),
                                ontap: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                              backgroundColor:
                                                  AppColors.globalWhite,
                                              surfaceTintColor:
                                                  AppColors.globalWhite,
                                              content: ComplaintHistoryDialog(
                                                title: reports.title,
                                                description:
                                                    reports.description,
                                                createdAt: reports.createdAt
                                                    .toString(),
                                                status: reports.status,
                                                statusDescription:
                                                    reports.statusdescription,
                                                updatedAat: reports.updatedAt
                                                    .toString(),
                                              )));
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ])),
              ),
            ));
  }
}

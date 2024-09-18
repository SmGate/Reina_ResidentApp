// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:userapp/Module/visitor_details/component/all_pre_approved.dart';
import 'package:userapp/Module/visitor_details/component/all_visitors.dart';
import 'package:userapp/Module/visitor_details/controller/visitor_details_controller.dart';
import 'package:userapp/Routes/set_routes.dart';
import 'package:userapp/Widgets/my_back_button.dart';
import 'package:userapp/utils/styles/colors.dart';

class GetAllVisitorsDetailsScreen extends StatelessWidget {
  const GetAllVisitorsDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<VisitorDetailsController>();
    return WillPopScope(
      onWillPop: () async {
        Get.offNamed(homescreen, arguments: controller.user);
        return true;
      },
      child: SafeArea(
        child: Scaffold(
            backgroundColor: AppColors.background,
            body: DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  MyBackButton(
                    text: 'Visitors Details',
                    onTap: () {
                      Get.offNamed(homescreen, arguments: controller.user);
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TabBar(
                    padding: EdgeInsets.only(top: 0),
                    labelColor: AppColors.appThem,
                    unselectedLabelColor: AppColors.textBlack,
                    indicatorColor: AppColors.appThem,
                    tabs: [
                      Tab(
                        child: Text(
                          "Visitors",
                        ),
                      ),
                      Tab(
                        child: Text("Pre Approved"),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        AllVisitors(
                          visitorDetailsController: controller,
                        ),
                        AllPreApprovedVisitors()
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}

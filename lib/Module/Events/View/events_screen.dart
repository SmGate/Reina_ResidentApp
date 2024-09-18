// ignore_for_file: deprecated_member_use, must_be_immutable
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:userapp/Module/Events/Model/society_events_model.dart';
import 'package:userapp/Module/Events/components/all_component.dart';
import 'package:userapp/Widgets/empty_list.dart';
import 'package:userapp/Widgets/loading.dart';
import 'package:userapp/Widgets/my_back_button.dart';
import 'package:userapp/utils/styles/colors.dart';
import '../../../utils/Constants/api_routes.dart';
import '../../../Routes/set_routes.dart';
import '../Controller/event_screen_controller.dart';

class EventsScreen extends GetView {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<EventScreenController>(
        init: EventScreenController(),
        builder: (controller) {
          return WillPopScope(
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
                      text: 'Community Events',
                      onTap: () {
                        Get.offNamed(homescreen,
                            arguments: controller.userdata);
                      },
                    ),
                    Expanded(
                      child: FutureBuilder<SocietyEventsModel>(
                          future: controller.viewEventsApi(
                            userid: controller.resident.subadminid!,
                          ),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data != null &&
                                  snapshot.data!.data!.length != 0) {
                                return ListView.builder(
                                    itemBuilder: (context, index) {
                                      return EventCard(
                                        title: controller.societyEventsModel
                                                .data?[index].title ??
                                            "",
                                        description: controller
                                            .societyEventsModel
                                            .data?[index]
                                            .description,
                                        startDate: controller.societyEventsModel
                                            .data?[index].startdate
                                            .toString(),
                                        index: index,
                                        image:
                                            "${Api.imageBaseUrl}${controller.societyEventsModel.data?[index].images?.first.image}",
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  AlertDialog(
                                                    backgroundColor:
                                                        AppColors.globalWhite,
                                                    surfaceTintColor:
                                                        AppColors.globalWhite,
                                                    content: EventDialog(
                                                        startTime: controller
                                                                .societyEventsModel
                                                                .data?[index]
                                                                .starttime ??
                                                            "",
                                                        endTime: controller
                                                                .societyEventsModel
                                                                .data?[index]
                                                                .endtime ??
                                                            "",
                                                        title: controller
                                                            .societyEventsModel
                                                            .data?[index]
                                                            .title,
                                                        startDate: controller
                                                            .societyEventsModel
                                                            .data?[index]
                                                            .startdate
                                                            .toString(),
                                                        endDate: controller
                                                            .societyEventsModel
                                                            .data?[index]
                                                            .enddate
                                                            .toString(),
                                                        description: controller
                                                            .societyEventsModel
                                                            .data?[index]
                                                            .description),
                                                  ));
                                        },
                                      );
                                    },
                                    itemCount: snapshot.data!.data!.length);
                              } else {
                                return EmptyList(name: 'No Events');
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
        });
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:userapp/Module/Guest%20History/Controller/guest_history_controller.dart';
import 'package:userapp/Module/Guest%20History/Model/pre_approved_history_model.dart';
import 'package:userapp/Module/Guest%20History/component/guest_history_component.dart';
import 'package:userapp/Module/Pre%20Approve%20Entry/components/dialogue_box.dart';
import 'package:userapp/Widgets/loading.dart';
import 'package:userapp/utils/styles/colors.dart';

class AllPreApprovedVisitors extends StatelessWidget {
  const AllPreApprovedVisitors({super.key});

  @override
  Widget build(BuildContext context) {
    var preApprovedVisitors = Get.find<GuestHistoryController>();
    return FutureBuilder<PreApprovedHistoryModel>(
      future: preApprovedVisitors.preApprovedHistory(
          userId: preApprovedVisitors.userdata.userId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularIndicatorUnderWhiteBox());
        } else if (snapshot.hasData) {
          return ListView.builder(
              itemCount:
                  preApprovedVisitors.preApprovedHistoryModel.data?.length,
              itemBuilder: (context, index) {
                var preApprovedHistory =
                    preApprovedVisitors.preApprovedHistoryModel.data?[index];
                return PreApproveEntryHistoryCard(
                    id: preApprovedHistory!.id!,
                    updatedAt: preApprovedHistory.updatedAt!.toString(),
                    checkInTime: preApprovedHistory.checkintime ?? "",
                    name: preApprovedHistory.name ?? "",
                    checkOutTime: preApprovedHistory.checkouttime ?? "",
                    controller: preApprovedVisitors,
                    cnic: preApprovedHistory.cnic,
                    vehicleNo: preApprovedHistory.vechileno,
                    onpressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                                backgroundColor: AppColors.globalWhite,
                                surfaceTintColor: AppColors.globalWhite,
                                content: PreApproveEntryDialog(
                                  name: preApprovedHistory.name,
                                  description: preApprovedHistory.description,
                                  arrivaldate:
                                      preApprovedHistory.arrivaldate.toString(),
                                  arrivaltime: preApprovedHistory.arrivaltime,
                                  cnic: preApprovedHistory.cnic,
                                  mobileno: preApprovedHistory.mobileno,
                                  vechileno: preApprovedHistory.vechileno,
                                  visitortype: preApprovedHistory.visitortype,
                                ),
                              ));
                    });
              });
        } else if (snapshot.hasError) {
          return Center(child: Text("${snapshot.error}"));
        } else {
          return Center(child: Text("No Data"));
        }
      },
    );
  }
}

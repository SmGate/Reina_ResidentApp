import 'package:get/get.dart';
import 'package:userapp/Module/Add%20PreApprove%20Entry/Controller/add_pre_approve_entry_controller.dart';
import 'package:userapp/Module/All_Bills/Controller/monthly_bills_controller.dart';
import 'package:userapp/Module/Chat%20Availbility/Controller/chat_availibility_controller.dart';
import 'package:userapp/Module/Chat%20Screens/Neighbour%20Chat%20Screen/Controller/neighbour_chat_screen_controller.dart';
import 'package:userapp/Module/Discussion%20Form/Controller/discussion_form_controller.dart';
import 'package:userapp/Module/Discussion%20Form/Controller/view_all_resident_controller.dart';
import 'package:userapp/Module/Emergency%20Numbers/controller/emergency_numbers_controller.dart';
import 'package:userapp/Module/Emergency/Controller/emergency_controller.dart';
import 'package:userapp/Module/Events/Controller/event_screen_controller.dart';
import 'package:userapp/Module/Family%20Member/Add%20Family%20Member/Controller/add_family_member_controller.dart';
import 'package:userapp/Module/Family%20Member/View%20Family%20Member/Controller/view_family_member_controller.dart';
import 'package:userapp/Module/Gatekeepers/controller/all_gatekeepers_controller.dart';
import 'package:userapp/Module/Guest%20History/Controller/guest_history_controller.dart';
import 'package:userapp/Module/HomeScreen/Controller/home_screen_controller.dart';
import 'package:userapp/Module/Login/Controller/login_controller.dart';
import 'package:userapp/Module/Market%20Place/Controller/market_place_controller.dart';
import 'package:userapp/Module/Market%20Place/Controller/market_place_product_details_controller.dart';
import 'package:userapp/Module/NoticeBoard/Controller/notice_board_controller.dart';
import 'package:userapp/Module/Pre%20Approve%20Entry/Controller/pre_approve_entry_controller.dart';
import 'package:userapp/Module/Profile/Controller/profile_controller.dart';
import 'package:userapp/Module/Report%20to%20Sub%20Admin/Controller/Admin%20Reports%20Controller/admin_reports_controller.dart';
import 'package:userapp/Module/Report%20to%20Sub%20Admin/Controller/Report%20to%20Admin%20Controller/report_to_admin_controller.dart';
import 'package:userapp/Module/ReportsHistory/Controller/admin_reports_history_controller.dart';
import 'package:userapp/Module/Signup/Resident%20Address%20Detail/Controller/resident_address_controller.dart';
import 'package:userapp/Module/Signup/Resident%20Personal%20Detail/Controller/resident_personal_detail_controller.dart';
import 'package:userapp/Module/SocietyRules/controller/society_rule_controller.dart';
import 'package:userapp/Module/Verification/Change%20Password/Controller/forget_password_controller.dart';
import 'package:userapp/Module/Verification/Verification%20Code/Controller/verification_code_controller.dart';

import 'package:userapp/Module/visitor_details/controller/visitor_details_controller.dart';
import 'package:userapp/Module/voting/controller/voting_controller.dart';

class ScreenBindings extends Bindings {
  ScreenBindings() {
    print("binding initialized");
  }
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
    Get.lazyPut(() => HomeScreenController());
    Get.lazyPut(() => EventScreenController());
    Get.lazyPut(() => NeighbourChatScreenController());
    Get.lazyPut(() => ChatAvailbilityController());
    Get.lazyPut(() => AddReportToAdminController());
    Get.lazyPut(() => AdminReportsController());
    Get.lazyPut(() => PreApproveEntryController());
    Get.lazyPut(() => AddPreApproveEntryController());
    Get.lazyPut(() => ReportHistoryController());
    Get.lazyPut(() => GuestHistoryController());
    Get.lazyPut(() => NoticeBoardController());
    Get.lazyPut(() => ResidentPersonalDetailController());
    Get.lazyPut(() => ResidentAddressDetailController());
    Get.lazyPut(() => AddFamilyMemberController());
    Get.lazyPut(() => ViewFamilyMemberController());
    Get.lazyPut(() => DiscussionFormController());
    Get.lazyPut(() => MonthlyBillsController());
    Get.lazyPut(() => MarketPlaceController());
    Get.lazyPut(() => AddEmergencyController());
    Get.lazyPut(() => VerificationCodeController());
    Get.lazyPut(() => AllGatekeeperController());
    Get.lazyPut(() => ForgetPasswordController());
    Get.lazyPut(() => MarketPlaceProductDetailsController());
    Get.lazyPut(() => ProfileController());
    Get.lazyPut(() => EmergencyNumbersController());
    Get.lazyPut(() => VisitorDetailsController());
    Get.lazyPut(() => SocietyRuleController());
    Get.lazyPut(() => VotingController());
    Get.lazyPut(() => ViewResidentController());
    Get.lazyPut(() => ForgetPasswordController());
  }
}

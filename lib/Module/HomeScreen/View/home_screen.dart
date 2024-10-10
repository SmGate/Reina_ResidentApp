// ignore_for_file: must_be_immutable, deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:userapp/Module/HomeScreen/components/drawer.dart';
import 'package:userapp/Module/HomeScreen/components/home_verification_card.dart';
import 'package:userapp/Module/HomeScreen/components/menu_items.dart';
import 'package:userapp/Module/HomeScreen/components/shimmer-animation.dart';
import 'package:userapp/utils/Constants/constants.dart';
import 'package:userapp/Helpers/Validation%20Helper/validation_helper.dart';
import 'package:userapp/Module/HomeScreen/Controller/home_screen_controller.dart';
import 'package:userapp/utils/Constants/images_strings.dart';
import 'package:userapp/utils/styles/colors.dart';
import '../../../Routes/set_routes.dart';
import '../../../Widgets/app_gradient.dart';
import '../../../Widgets/custom_card.dart';
import '../../../Widgets/my_button.dart';
import '../../../Widgets/my_textform_field.dart';
import '../../../utils/Constants/api_routes.dart';
import '../../../utils/Constants/session_controller.dart';
import '../../../utils/styles/reuseable_textstyle.dart';
import '../components/home_bottom_app_bar_icon.dart';
import '../Model/DiscussionRoomModel.dart';

class HomeScreen extends GetView {
  @override
  Widget build(BuildContext context) {
    var homeScreenController = Get.find<HomeScreenController>();

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SafeArea(
          child: Scaffold(
        backgroundColor: AppColors.background,
        drawer: MyDrawer(
          img: SessionController().user.image ?? "",
          userdata: SessionController().user,
          fname: "${SessionController().user.firstName}",
          lastname: "${SessionController().user.lastName}",
        ),
        body: Obx(() => homeScreenController.checkResidentVerified.value ||
                homeScreenController.isLoading.value
            ? HomeScreenShimmer()
            : FutureBuilder(
                future: homeScreenController.future,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    homeScreenController.snapShot = snapshot.data;
                    print(homeScreenController.snapShot.username);

                    if (homeScreenController.snapShot.username == null) {
                      return Form(
                        key: homeScreenController.key,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              10.h.ph,
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Text(
                                  'Your Identity on Smart Gate',
                                  style: reusableTextStyle(
                                      textStyle: GoogleFonts.dmSans(),
                                      fontSize: 35.0,
                                      color: AppColors.textBlack,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              20.h.ph,
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Text(
                                  'Create Your Unique Username',
                                  style: reusableTextStyle(
                                      textStyle: GoogleFonts.dmSans(),
                                      fontSize: 30.0,
                                      color: AppColors.dark,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              20.h.ph,
                              MyTextFormField(
                                hintText: 'User Name',
                                labelText: 'User Name',
                                controller:
                                    homeScreenController.userNameController,
                                validator:
                                    ValidationHelper().emptyStringValidator,
                              ),
                              20.h.ph,
                              Obx(() => MyButton(
                                    gradient: AppGradients.buttonGradient,
                                    loading:
                                        homeScreenController.isLoading.value,
                                    name: 'Create',
                                    onPressed: () {
                                      if (homeScreenController.key.currentState!
                                          .validate()) {
                                        if (!homeScreenController
                                            .isLoading.value) {
                                          homeScreenController
                                              .updateUserNameApi();
                                        }
                                      }
                                    },
                                  )),
                              20.h.ph,
                            ],
                          ),
                        ),
                      );
                    } else if (homeScreenController.snapShot.username != null &&
                        homeScreenController.snapShot.status == 0) {
                      return HomeVerificationCard();
                    } else if (homeScreenController.snapShot.username != null &&
                        homeScreenController.snapShot.status == 1) {
                      ////  here
                      ///
                      return SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Welcome Home",
                                          style: reusableTextStyle(
                                            textStyle: GoogleFonts.dmSans(),
                                            fontSize: 18.0,
                                            color: AppColors.textBlack,
                                          ),
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              AppImages.house2,
                                              height: 20,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Container(
                                              width: 220,
                                              child: Text(
                                                "${SessionController().user.firstName} ${SessionController().user.lastName}",
                                                style: reusableTextStyle(
                                                    textStyle:
                                                        GoogleFonts.dmSans(),
                                                    fontSize: 20.0,
                                                    color:
                                                        AppColors.boldHeading,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    Spacer(),
                                    GestureDetector(
                                      onTap: () {
                                        print("object");
                                        Scaffold.of(context).openDrawer();
                                      },
                                      child: Stack(children: [
                                        SessionController().user.image != "" ||
                                                SessionController()
                                                        .user
                                                        .image !=
                                                    null
                                            ? Container(
                                                width: 50.w,
                                                height: 50.w,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          300),
                                                  child: CachedNetworkImage(
                                                    fit: BoxFit.cover,
                                                    imageUrl:
                                                        "${Api.imageBaseUrl}${SessionController().user.image ?? ""}",
                                                    placeholder: (context,
                                                            url) =>
                                                        SizedBox(
                                                            height: 50,
                                                            width: 50,
                                                            child:
                                                                CircularProgressIndicator(
                                                              color: AppColors
                                                                  .appThem,
                                                            )),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Icon(Icons.error),
                                                  ),
                                                ),
                                              )
                                            : Container(
                                                width: 50.w,
                                                height: 50.w,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    image: DecorationImage(
                                                        image: AssetImage(
                                                      'assets/user.png',
                                                    ))),
                                              ),
                                        Positioned(
                                          left: 35.w,
                                          top: 2.h,
                                          child: Container(
                                            height: 12.w,
                                            width: 12.w,
                                            decoration: BoxDecoration(
                                              color: AppColors.appThem,
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                        )
                                      ]),
                                    ),
                                  ],
                                ),
                              ),

                              /////////////////  SCROLLING MENU CARD
                              CustomCard(
                                  width: double.infinity,
                                  elevation: 6,
                                  color: AppColors.globalWhite,
                                  borderRadius: BorderRadius.circular(10),
                                  onTap: () {},
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Get.offNamed(
                                                addpreapproveentryscreen,
                                                arguments: [
                                                  homeScreenController.user,
                                                  homeScreenController.snapShot,
                                                  2
                                                ]);
                                          },
                                          child: Column(
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(),
                                                height: 50,
                                                width: 50,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    gradient: AppGradients
                                                        .horizontalGradient),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: Image.asset(
                                                    AppImages.cab,
                                                    height: 50,
                                                    width: 50,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 6,
                                              ),
                                              Text(
                                                "Cab",
                                                style: reusableTextStyle(
                                                    textStyle:
                                                        GoogleFonts.dmSans(),
                                                    fontSize: 14.0,
                                                    color:
                                                        AppColors.boldHeading,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Get.offNamed(
                                                addpreapproveentryscreen,
                                                arguments: [
                                                  homeScreenController.user,
                                                  homeScreenController.snapShot,
                                                  1
                                                ]);
                                          },
                                          child: Column(
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(),
                                                height: 50,
                                                width: 50,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    gradient: AppGradients
                                                        .horizontalGradient),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: Image.asset(
                                                    AppImages.delivary,
                                                    height: 50,
                                                    width: 50,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 6,
                                              ),
                                              Text(
                                                "Delivery",
                                                style: reusableTextStyle(
                                                    textStyle:
                                                        GoogleFonts.dmSans(),
                                                    fontSize: 14.0,
                                                    color:
                                                        AppColors.boldHeading,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Get.offNamed(
                                                addpreapproveentryscreen,
                                                arguments: [
                                                  homeScreenController.user,
                                                  homeScreenController.snapShot,
                                                  0
                                                ]);
                                          },
                                          child: Column(
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(),
                                                height: 50,
                                                width: 50,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    gradient: AppGradients
                                                        .horizontalGradient),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: Image.asset(
                                                    AppImages.guest,
                                                    height: 50,
                                                    width: 50,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 6,
                                              ),
                                              Text(
                                                "Guest",
                                                style: reusableTextStyle(
                                                    textStyle:
                                                        GoogleFonts.dmSans(),
                                                    fontSize: 14.0,
                                                    color:
                                                        AppColors.boldHeading,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Get.offNamed(
                                                addpreapproveentryscreen,
                                                arguments: [
                                                  homeScreenController.user,
                                                  homeScreenController.snapShot,
                                                  3
                                                ]);
                                          },
                                          child: Column(
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(),
                                                height: 50,
                                                width: 50,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    gradient: AppGradients
                                                        .horizontalGradient),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: Image.asset(
                                                    AppImages.visitingHelp,
                                                    height: 50,
                                                    width: 50,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 6,
                                              ),
                                              Text(
                                                "Help",
                                                style: reusableTextStyle(
                                                    textStyle:
                                                        GoogleFonts.dmSans(),
                                                    fontSize: 14.0,
                                                    color:
                                                        AppColors.boldHeading,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),

                              SizedBox(
                                height: 14,
                              ),

                              ////////  ENTRY EXIT
                              Text(
                                "Entry / Exit",
                                style: reusableTextStyle(
                                  textStyle: GoogleFonts.dmSans(),
                                  fontSize: 16.0,
                                  color: AppColors.boldHeading,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  MenuItems(
                                    image: AppImages.gateKeeper,
                                    title: "Gate",
                                    secondTitle: "Keeper",
                                    ontap: () {
                                      Get.offNamed(allGatekeepers, arguments: [
                                        homeScreenController.user,
                                      ]);
                                    },
                                  ),
                                  SizedBox(
                                    width: 25,
                                  ),
                                  MenuItems(
                                    image: AppImages.preapprovedVisitor,
                                    title: "Pre Approve",
                                    secondTitle: "Visitor",
                                    ontap: () {
                                      Get.offNamed(preapproveentryscreen,
                                          arguments: [
                                            homeScreenController.user,
                                            homeScreenController.snapShot
                                          ]);
                                    },
                                  ),
                                  SizedBox(
                                    width: 25,
                                  ),
                                  MenuItems(
                                    image: AppImages.parkingSlots,
                                    title: "Parking",
                                    secondTitle: "Slots",
                                    ontap: () {
                                      // Get.offNamed(preapproveentryscreen,
                                      //     arguments: [
                                      //       homeScreenController.user,
                                      //       homeScreenController.snapShot
                                      //     ]);
                                    },
                                  ),
                                ],
                              ),

                              ////////  EVENTS COMMUNITY
                              SizedBox(
                                height: 10,
                              ),

                              Text(
                                "Community",
                                style: reusableTextStyle(
                                    textStyle: GoogleFonts.dmSans(),
                                    fontSize: 16.0,
                                    color: AppColors.boldHeading,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      MenuItems(
                                        image: AppImages.noticeBoard,
                                        title: "Notice",
                                        secondTitle: "Board",
                                        ontap: () {
                                          Get.offNamed(noticeboardscreen,
                                              arguments: [
                                                homeScreenController.user,
                                                homeScreenController.snapShot
                                              ]);
                                        },
                                      ),
                                      SizedBox(
                                        width: 30,
                                      ),
                                      MenuItems(
                                        image: AppImages.marketPlace,
                                        title: "Market",
                                        secondTitle: "Place",
                                        ontap: () {
                                          Get.offNamed(marketPlaceScreen,
                                              arguments: [
                                                homeScreenController.user,
                                                homeScreenController.snapShot
                                              ]);
                                        },
                                      ),
                                      SizedBox(
                                        width: 30,
                                      ),
                                      MenuItems(
                                        image: AppImages.rules,
                                        title: "Rule Book",
                                        secondTitle: "",
                                        ontap: () {
                                          Get.offNamed(
                                            societyRule,
                                            arguments:
                                                homeScreenController.user,
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      if (homeScreenController
                                              .user.permissions?["chat"] ==
                                          true) ...[
                                        MenuItems(
                                          image: AppImages.communityMember,
                                          title: "Community",
                                          secondTitle: "Member",
                                          ontap: () {
                                            Get.offNamed(chatavailbilityscreen,
                                                arguments: [
                                                  homeScreenController.user,
                                                  homeScreenController.snapShot
                                                ]);
                                          },
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                      ],
                                      //////////////////////////////Disscussion  Forum//////////////////
                                      if (homeScreenController
                                                      .user.permissions?[
                                                  "discussion_forum"] ==
                                              true &&
                                          homeScreenController
                                                      .user.permissions?[
                                                  "discussion_forum"] !=
                                              null) ...[
                                        MenuItems(
                                          image: AppImages.disscussionForum,
                                          title: "Disscussion",
                                          secondTitle: "Forum",
                                          ontap: () async {
                                            // DiscussionRoomModel
                                            //     discussionRoomModel =
                                            //     await homeScreenController
                                            //         .createChatRoomApi(
                                            //             token:
                                            //                 homeScreenController
                                            //                     .user
                                            //                     .bearerToken?,
                                            //             subadminid:
                                            //                 homeScreenController
                                            //                     .snapShot
                                            //                     .subadminid);

                                            Get.offNamed(discussion_form,
                                                arguments: [
                                                  homeScreenController.user,
                                                  homeScreenController.snapShot,
                                                  //  discussionRoomModel
                                                ]);
                                          },
                                        ),

                                        ///////////////////Community  Events/////////////////////////////
                                        SizedBox(
                                          width: 20,
                                        ),
                                      ] else
                                        SizedBox(),
                                      MenuItems(
                                        image: AppImages.societyEvents,
                                        title: "Community",
                                        secondTitle: "Events",
                                        ontap: () {
                                          Get.offNamed(eventsscreen,
                                              arguments: [
                                                homeScreenController.user,
                                                homeScreenController.snapShot
                                              ]);
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              //////// Safet assistant
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Safety Assitance",
                                style: reusableTextStyle(
                                    textStyle: GoogleFonts.dmSans(),
                                    fontSize: 16.0,
                                    color: AppColors.boldHeading,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  MenuItems(
                                    image: AppImages.emergencyNo,
                                    title: "Emergency",
                                    secondTitle: "No's",
                                    ontap: () {
                                      Get.offNamed(
                                        emergencyContact,
                                        arguments: homeScreenController.user,
                                      );
                                    },
                                  ),
                                  SizedBox(
                                    width: 25,
                                  ),
                                  MenuItems(
                                    image: AppImages.panicButton,
                                    title: "Report",
                                    secondTitle: "Emergency",
                                    ontap: () {
                                      Get.offNamed(addEmergencyScreen,
                                          arguments: [
                                            homeScreenController.user,
                                            homeScreenController.snapShot
                                          ]);
                                    },
                                  ),
                                ],
                              ),

                              //////// History
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "History",
                                style: reusableTextStyle(
                                    textStyle: GoogleFonts.dmSans(),
                                    fontSize: 16.0,
                                    color: AppColors.boldHeading,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  MenuItems(
                                    image: AppImages.complaintHistory,
                                    title: "Complaint",
                                    secondTitle: "History",
                                    ontap: () {
                                      Get.offNamed(reportshistoryscreen,
                                          arguments: [
                                            homeScreenController.user,
                                            homeScreenController.snapShot
                                          ]);
                                    },
                                  ),
                                  SizedBox(
                                    width: 25,
                                  ),
                                  MenuItems(
                                    image: AppImages.visitorHistory,
                                    title: "Visitor",
                                    secondTitle: "History",
                                    ontap: () {
                                      Get.offNamed(getAllVisitorDetails,
                                          arguments: homeScreenController.user);
                                    },
                                  ),
                                  // SizedBox(
                                  //   width: 25,
                                  // ),
                                  // MenuItems(
                                  //   image: AppImages.guestHistory,
                                  //   title: "Visitor",
                                  //   secondTitle: "Record",
                                  //   ontap: () {
                                  //     Get.offNamed(guestshistoryscreen,
                                  //         arguments: homeScreenController.user);
                                  //   },
                                  // ),
                                ],
                              ),

                              /////// CREATE
                              SizedBox(
                                height: 10,
                              ),

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Create",
                                    style: reusableTextStyle(
                                        textStyle: GoogleFonts.dmSans(),
                                        fontSize: 16.0,
                                        color: AppColors.boldHeading,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      MenuItems(
                                        image: AppImages.familyMember,
                                        title: "Family",
                                        secondTitle: "Members",
                                        ontap: () {
                                          if (homeScreenController
                                                  .user.roleId ==
                                              5) {
                                            myToast(
                                                msg:
                                                    'You have registered yourself as a family member, so you cannot add a new family member');
                                          } else {
                                            Get.offNamed(viewfamilymember,
                                                arguments: [
                                                  homeScreenController.user,
                                                  homeScreenController.snapShot
                                                ]);
                                          }
                                        },
                                      ),
                                      SizedBox(
                                        width: 25,
                                      ),
                                      MenuItems(
                                        image: AppImages.complaints,
                                        title: "Complaints",
                                        secondTitle: "",
                                        ontap: () {
                                          Get.offNamed(adminreports,
                                              arguments: [
                                                homeScreenController.user,
                                                homeScreenController.snapShot
                                              ]);
                                        },
                                      ),
                                      SizedBox(
                                        width: 25,
                                      ),
                                      MenuItems(
                                        image: AppImages.voting,
                                        title: "E-Voting",
                                        secondTitle: "",
                                        ontap: () {
                                          Get.offNamed(voting, arguments: [
                                            homeScreenController.user,
                                            homeScreenController.snapShot
                                          ]);
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              //////// Bills
                              SizedBox(
                                height: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Bills",
                                    style: reusableTextStyle(
                                        textStyle: GoogleFonts.dmSans(),
                                        fontSize: 16.0,
                                        color: AppColors.boldHeading,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      MenuItems(
                                        image: AppImages.bills,
                                        title: "Bills",
                                        secondTitle: "",
                                        ontap: () {
                                          Get.offNamed(all_bill, arguments: [
                                            homeScreenController.user,
                                            homeScreenController.snapShot,
                                          ]);
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              SizedBox(
                                height: 10,
                              ),

                              //////////
                              CustomCard(
                                  width: double.infinity,
                                  elevation: 5,
                                  boxShadow: BoxShadow(),
                                  borderRadius: BorderRadius.circular(10),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 6),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                height: 40,
                                                width: 40,
                                                decoration: BoxDecoration(
                                                    gradient: AppGradients
                                                        .horizontalGradient,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Image.asset(
                                                      AppImages.support),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "For Support",
                                                    style: reusableTextStyle(
                                                        textStyle: GoogleFonts
                                                            .dmSans(),
                                                        fontSize: 16.0,
                                                        color: AppColors
                                                            .boldHeading,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    "Contact us for any support purpose",
                                                    style: reusableTextStyle(
                                                        textStyle: GoogleFonts
                                                            .dmSans(),
                                                        fontSize: 12.0,
                                                        color: AppColors.dark,
                                                        fontWeight:
                                                            FontWeight.normal),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        Divider(
                                          color: AppColors.yellow,
                                          thickness: 3,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Email us at",
                                              style: reusableTextStyle(
                                                  textStyle:
                                                      GoogleFonts.dmSans(),
                                                  fontSize: 14.0,
                                                  color: AppColors.boldHeading,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              width: 30,
                                            ),
                                            SizedBox(
                                              width: 175,
                                              child: Text(
                                                homeScreenController
                                                        .user.supportEmail ??
                                                    "",
                                                style: reusableTextStyle(
                                                    textStyle:
                                                        GoogleFonts.dmSans(),
                                                    fontSize: 14.0,
                                                    color: AppColors.dark,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Or Call us at",
                                              style: reusableTextStyle(
                                                  textStyle:
                                                      GoogleFonts.dmSans(),
                                                  fontSize: 14.0,
                                                  color: AppColors.boldHeading,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Text(
                                              homeScreenController
                                                      .user.supportPhone ??
                                                  "",
                                              style: reusableTextStyle(
                                                  textStyle:
                                                      GoogleFonts.dmSans(),
                                                  fontSize: 14.0,
                                                  color: AppColors.dark,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        )
                                      ],
                                    ),
                                  )),

                              SizedBox(
                                height: 40,
                              )
                            ],
                          ),
                        ),
                      );
                    } else {
                      return HomeScreenShimmer();
                    }
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return HomeScreenShimmer();
                  } else if (snapshot.hasError) {
                    return HomeScreenShimmer();
                  } else {
                    return HomeScreenShimmer();
                  }
                })),
        floatingActionButton: Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
                gradient: AppGradients.floatingbuttonGradient,
                shape: BoxShape.circle),
            child: IconButton(
                onPressed: () {
                  if (homeScreenController.snapShot == null) {
                    // myToast(
                    //     msg:
                    //         "Something went wrong ,We're having issues loading this page.");
                  } else if (homeScreenController.snapShot.status == 0) {
                    myToast(
                        msg:
                            'Try Again later !. You are under verification Process.');
                  } else {
                    Get.offNamed(addEmergencyScreen, arguments: [
                      homeScreenController.user,
                      homeScreenController.snapShot
                    ]);
                    // Get.offNamed(reporttoadmin, arguments: [
                    //   homeScreenController.user,
                    //   homeScreenController.snapShot
                    // ]);
                  }
                },
                icon: Icon(
                  Icons.add,
                  color: AppColors.globalWhite,
                  weight: 20.0,
                  size: 40,
                ))),
        bottomNavigationBar: SizedBox(
          child: BottomAppBar(
            height: 87,
            shadowColor: Colors.transparent,
            color: Colors.white,
            surfaceTintColor: Colors.white,
            shape: CircularNotchedRectangle(),
            notchMargin: 10.0,
            child: Row(
              children: [
                //  20.w.pw,
                Obx(() => HomeBottomAppBarIcon(
                      text: 'Home',
                      icon: homeScreenController.selectedIndex.value == 0
                          ? AppImages.homeblue
                          : AppImages.homegrey,
                      color: homeScreenController.selectedIndex.value == 0
                          ? AppColors.appThem
                          : Colors.grey,
                      onPressed: () async {
                        // await homeScreenController.refreshScreen();
                        homeScreenController.onItemTapped(0);

                        if (homeScreenController.snapShot == null) {
                          // myToast(
                          //     msg:
                          //         "Something went wrong ,We're having issues loading this page.");
                        } else if (homeScreenController.snapShot.status == 0) {
                          myToast(
                              msg:
                                  'Try Again later !. You are under verification Process.');
                        } else if (homeScreenController.snapShot.status ==
                            null) {
                          myToast(
                              msg:
                                  "Something went wrong ,We're having issues loading this page.");
                        }
                      },
                    )),
                30.5.w.pw,
                HomeBottomAppBarIcon(
                  text: 'Complaints',
                  icon: homeScreenController.selectedIndex.value == 1
                      ? AppImages.complaintsblue
                      : AppImages.complaintsgrey,
                  onPressed: () async {
                    // await homeScreenController.refreshScreen();
                    homeScreenController.onItemTapped(1);
                    if (homeScreenController.snapShot == null) {
                      // myToast(
                      //     msg:
                      //         "Something went wrong ,We're having issues loading this page.");
                    } else if (homeScreenController.snapShot.status == 0) {
                      myToast(
                          msg:
                              'Try Again later !. You are under verification Process.');
                    } else if (homeScreenController.snapShot.status == null) {
                      myToast(
                          msg:
                              "Something went wrong ,We're having issues loading this page.");
                    } else {
                      Get.offNamed(adminreports, arguments: [
                        homeScreenController.user,
                        homeScreenController.snapShot
                      ]);
                    }
                  },
                  color: homeScreenController.selectedIndex.value == 1
                      ? AppColors.appThem
                      : Colors.grey,
                ),
                Spacer(),
                HomeBottomAppBarIcon(
                  text: 'Noticeboard',
                  icon: homeScreenController.selectedIndex.value == 2
                      ? AppImages.noticeboardblue
                      : AppImages.noticeboardgrey,
                  onPressed: () async {
                    // await homeScreenController.refreshScreen();
                    homeScreenController.onItemTapped(2);
                    if (homeScreenController.snapShot == null) {
                      // myToast(
                      //     msg:
                      //         "Something went wrong ,We're having issues loading this page.");
                    } else if (homeScreenController.snapShot.status == 0) {
                      myToast(
                          msg:
                              'Try Again later !. You are under verification Process.');
                    } else if (homeScreenController.snapShot.status == null) {
                      myToast(
                          msg:
                              "Something went wrong ,We're having issues loading this page.");
                    } else {
                      Get.offNamed(noticeboardscreen, arguments: [
                        homeScreenController.user,
                        homeScreenController.snapShot
                      ]);
                    }
                  },
                  color: homeScreenController.selectedIndex.value == 2
                      ? AppColors.appThem
                      : Colors.grey,
                ),
                30.5.w.pw,
                HomeBottomAppBarIcon(
                  text: 'Discussion',
                  icon: homeScreenController.selectedIndex.value == 3
                      ? AppImages.disscussionblue
                      : AppImages.disscussiongrey,
                  onPressed: () async {
                    if (homeScreenController
                            .user.permissions?["discussion_forum"] ==
                        false) {
                      myToast(
                          msg: 'You are not the member of disscussion forum');
                    } else {
                      // await homeScreenController.refreshScreen();
                      homeScreenController.onItemTapped(3);
                      if (homeScreenController.snapShot == null) {
                        // myToast(
                        //     msg:
                        //         "Something went wrong ,We're having issues loading this page.");
                      } else if (homeScreenController.snapShot.status == 0) {
                        myToast(
                            msg:
                                'Try Again later !. You are under verification Process.');
                      } else if (homeScreenController.snapShot.status == null) {
                        myToast(
                            msg:
                                "Something went wrong ,We're having issues loading this page.");
                      } else {
                        DiscussionRoomModel discussionRoomModel =
                            await homeScreenController.createChatRoomApi(
                                token: homeScreenController.user.bearerToken!,
                                subadminid:
                                    homeScreenController.snapShot.subadminid);
                        Get.offNamed(discussion_form, arguments: [
                          homeScreenController.user,
                          homeScreenController.snapShot,
                          discussionRoomModel
                        ]);
                      }
                    }
                  },
                  color: homeScreenController.selectedIndex.value == 3
                      ? AppColors.appThem
                      : Colors.grey,
                ),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      )),
    );
  }
}

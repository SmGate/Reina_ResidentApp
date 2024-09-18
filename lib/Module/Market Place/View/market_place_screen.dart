// ignore_for_file: invalid_use_of_protected_member, deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:readmore/readmore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:userapp/Widgets/app_gradient.dart';
import 'package:userapp/Widgets/custom_card.dart';
import 'package:userapp/Widgets/loading.dart';
import 'package:userapp/utils/Constants/constants.dart';
import 'package:userapp/Widgets/empty_list.dart';
import 'package:userapp/Widgets/my_button.dart';
import 'package:userapp/utils/Constants/images_strings.dart';
import 'package:userapp/utils/styles/colors.dart';
import 'package:userapp/utils/styles/reuseable_textstyle.dart';

import '../../../utils/Constants/api_routes.dart';
import '../../../Helpers/Date Helper/date_helper.dart';
import '../../../Routes/set_routes.dart';
import '../../../Widgets/my_back_button.dart';
import '../../Chat Availbility/Model/ChatNeighbours.dart';
import '../../Chat Availbility/Model/ChatRoomModel.dart';
import '../../Chat Screens/Neighbour Chat Screen/Controller/neighbour_chat_screen_controller.dart';
import '../Controller/market_place_controller.dart';
import '../Model/MarketPlace.dart' as marketplace;

class MarketPlaceScreen extends GetView {
  final MarketPlaceController controller = Get.find<MarketPlaceController>();

  @override
  Widget build(BuildContext context) {
    print("build");
    return DefaultTabController(
      length: 2,
      child: SafeArea(
          child: WillPopScope(
        onWillPop: () async {
          await Get.offNamed(homescreen, arguments: controller.userdata);
          return true;
        },
        child: Scaffold(
          backgroundColor: AppColors.background,
          body: Column(
            children: [
              MyBackButton(
                text: 'Market Place',
                onTap: () {
                  Get.offNamed(homescreen, arguments: controller.userdata);
                },
              ),
              SizedBox(
                height: 30,
              ),
              TabBar(
                controller: controller.tabController,
                indicatorSize: TabBarIndicatorSize.label,
                indicator: ShapeDecoration(
                  color: Colors.transparent,
                  shape: RoundedRectangleBorder(
                      // side: BorderSide(color: HexColor('#E1E3E6'), width: 0),
                      borderRadius: BorderRadius.circular(16.r)),
                ),
                tabs: [
                  Obx(() {
                    return buildBuySellTab(
                        imageUrl: AppImages.buy,
                        textColor: () {
                          if (controller.tabController.index == 0) {
                            return AppColors.globalWhite;
                          } else if (controller.tabController.index == 1) {
                            return AppColors.textBlack;
                          } else {
                            return AppColors.textBlack;
                          }
                        }(),
                        heading: 'Buy',
                        imageColor: () {
                          if (controller.selectedIndex == 1) {
                            return AppColors.textBlack;
                          } else if (controller.selectedIndex == 0) {
                            return Colors.white;
                          } else {
                            return AppColors.appThem;
                          }
                        }());
                  }),
                  Obx(() {
                    return buildBuySellTab(
                      imageUrl: AppImages.sell,
                      textColor: () {
                        if (controller.selectedIndex == 1) {
                          return AppColors.globalWhite;
                        } else if (controller.selectedIndex == 0) {
                          return AppColors.textBlack;
                        } else {
                          return AppColors.textBlack;
                        }
                      }(),
                      heading: 'Sell',
                      imageColor: () {
                        if (controller.selectedIndex == 1) {
                          return Colors.white;
                        } else if (controller.selectedIndex == 0) {
                          return AppColors.textBlack;
                        } else {
                          return AppColors.textBlack;
                        }
                      }(),
                    );
                  })
                ],
              ),
              30.h.ph,
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        backgroundColor: AppColors.globalWhite,
                        surfaceTintColor: AppColors.globalWhite,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                children: [
                                  SizedBox(width: 20.w),
                                  Icon(Icons.filter_list_sharp),
                                  SizedBox(width: 10.w),
                                  Text(
                                    "Categories",
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Spacer(),
                                  IconButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    icon: Icon(Icons.clear),
                                  ),
                                  SizedBox(width: 10.w),
                                ],
                              ),
                              SizedBox(
                                width: 300.w,
                                height: 300.w,
                                child: ListView.builder(
                                  itemCount: controller.categoryList.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Obx(() {
                                      return RadioListTile(
                                        activeColor: AppColors.appThem,
                                        title: Text(controller
                                            .categoryList[index].name
                                            .toString()),
                                        value: controller
                                            .categoryList[index].name
                                            .toString(),
                                        groupValue:
                                            controller.selectedCategory.value,
                                        onChanged: (value) {
                                          controller.selectedCategory.value =
                                              value.toString();
                                          print(controller
                                              .selectedCategory.value);
                                        },
                                      );
                                    });
                                  },
                                ),
                              ),
                              SizedBox(height: 10.h),
                              MyButton(
                                gradient: AppGradients.buttonGradient,
                                name: 'Select',
                                onPressed: () {
                                  controller.viewProductFutureData =
                                      controller.viewProducts(
                                    societyid: controller.resident.societyid!,
                                    token: controller.userdata.bearerToken!,
                                    category: controller.selectedCategory.value,
                                  );
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 20.w),
                  child: Row(children: [
                    Icon(Icons.filter_list_sharp),
                    10.w.pw,
                    Text(
                      "Categories",
                      style: reusableTextStyle(
                          textStyle: GoogleFonts.dmSans(),
                          fontSize: 18.0,
                          color: AppColors.textBlack,
                          fontWeight: FontWeight.bold),
                    ),
                  ]),
                ),
              ),
              10.h.ph,
              Expanded(
                  child: TabBarView(
                controller: controller.tabController,
                children: [
                  FutureBuilder(
                      future: controller.viewProductFutureData,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          if ((snapshot.data as List).isNotEmpty) {
                            return Obx(() {
                              return ListView.builder(
                                itemCount: controller.list.value.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return MarketPlaceCard(
                                      list: controller.list.value[index],
                                      index: index,
                                      length: controller.list.value.length);
                                },
                              );
                            });
                          } else {
                            return Center(
                              child: EmptyList(
                                name: 'No Items Found',
                              ),
                            );
                          }
                        } else if (snapshot.hasError) {
                          return Icon(Icons.error_outline);
                        } else {
                          return CircularIndicatorUnderWhiteBox();
                        }
                      }),
                  FutureBuilder(
                      future: controller.sellProductFutureData,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          if ((snapshot.data as List).isNotEmpty) {
                            return Column(
                              children: [
                                Expanded(
                                  child: Obx(() {
                                    return ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: controller.list2.value.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return MarketPlaceCard(
                                            list: controller.list2.value[index],
                                            index: index,
                                            length:
                                                controller.list2.value.length);
                                      },
                                    );
                                  }),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.w),
                                  child: MyButton(
                                    width: double.infinity,
                                    gradient: AppGradients.buttonGradient,
                                    name: 'Sell',
                                    onPressed: () {
                                      Get.offNamed(sellProductsScreen,
                                          arguments: [
                                            controller.userdata,
                                            controller.resident
                                          ]);
                                    },
                                  ),
                                ),
                                10.h.ph,
                              ],
                            );
                          } else {
                            return Column(
                              children: [
                                Spacer(),
                                Center(
                                  child: EmptyList(
                                    name: 'No Items Found',
                                  ),
                                ),
                                Spacer(),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: 20,
                                    right: 20,
                                  ),
                                  child: MyButton(
                                    gradient: AppGradients.buttonGradient,
                                    width: double.infinity,
                                    name: 'Sell',
                                    onPressed: () {
                                      Get.offNamed(sellProductsScreen,
                                          arguments: [
                                            controller.userdata,
                                            controller.resident
                                          ]);
                                    },
                                  ),
                                ),
                                20.h.ph,
                              ],
                            );
                          }
                        } else if (snapshot.hasError) {
                          return Icon(Icons.error_outline);
                        } else {
                          return CircularIndicatorUnderWhiteBox();
                        }
                      }),
                ],
              ))
            ],
          ),
        ),
      )),
    );
  }

  Widget MarketPlaceCard(
      {required marketplace.Data list, int? index, int length = 0}) {
    return Padding(
        padding: EdgeInsets.only(
            top: index == 0 ? 20 : 20, bottom: index == length - 1 ? 20 : 0),
        child: CustomCard(
            margin: EdgeInsets.only(left: 20, right: 20),
            onTap: () {
              Get.toNamed(marketPlaceProductDetails,
                  arguments: [controller.userdata, controller.resident, list]);
            },
            width: double.infinity,
            elevation: 0,
            color: AppColors.globalWhite,
            child: Column(
              children: [
                buildProductCard(
                    controller: controller,
                    residentId: list.residentid,
                    id: list.id,
                    image: list.images!.first.images.toString(),
                    price: list.productprice.toString(),
                    name: list.productname.toString(),
                    description: list.description.toString(),
                    date: list.createdAt.toString()),
                6.h.ph,
                if (controller.userdata.userId != list.residentid)
                  buildProfileCard(
                    onChatTap: () async {
                      ChatNeighbours userInfo =
                          await controller.productSellerInfoApi(
                              residentid: list.residentid!,
                              token: controller.userdata.bearerToken!);
                      final ChatRoomModel chatRoomModel =
                          await controller.createChatRoomApi(
                              token: controller.userdata.bearerToken!,
                              userid: controller.userdata.userId!,
                              chatuserid: list.residentid!);

                      Get.offNamed(neighbourchatscreen, arguments: [
                        controller.userdata, //Login User
                        controller.resident, // Resident Details
                        userInfo.data!.first,
                        chatRoomModel.data!.first.id,
                        ChatTypes.MarketPlaceChat.toString()
                            .split('.')
                            .last, // Chat User
                      ]);
                    },
                    onCallTap: () async {
                      controller.uri = Uri.parse("tel://${list.contact}");

                      try {
                        await launchUrl(controller.uri!);
                        controller.uri = null;
                      } catch (e) {
                        myToast(msg: e.toString(), isNegative: true);
                      }
                    },
                    image: list.users?.image.toString(),
                    residentType: list.residents!.residenttype.toString(),
                    name:
                        "${list.users?.firstname.toString()}${list.users?.lastname.toString()}",
                  )
                else
                  Container()
              ],
            )));
  }

  Widget buildBuySellTab({
    required String imageUrl,
    required String heading,
    required Color textColor,
    required Color imageColor,
  }) {
    return SizedBox(
      width: 120.w,
      height: 40.w,
      child: Tab(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              children: [
                Image.asset(
                  imageUrl,
                  color: imageColor,
                  width: 20,
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  heading,
                  style: reusableTextStyle(
                      textStyle: GoogleFonts.dmSans(),
                      fontSize: 14.0,
                      color: textColor,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          width: 120.w,
          height: 50.w,
          decoration: BoxDecoration(
            color: AppColors.appThem,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}

class buildProductCard extends GetView {
  final String? image;
  final String? price;
  final String? name;
  final String? description;
  final String? date;
  final int? id;
  final int? residentId;
  final MarketPlaceController controller;

  const buildProductCard(
      {super.key,
      required this.image,
      required this.residentId,
      required this.id,
      required this.price,
      required this.name,
      required this.description,
      required this.date,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 328.w,
      // height: 125.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: HexColor('#FFFFFF')),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 20, bottom: 10, left: 20, right: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.appThem,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: Api.imageBaseUrl + image!,
                      placeholder: (context, url) => Column(
                        children: [
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: CircularProgressIndicator(
                                color: AppColors.globalWhite,
                              ),
                            ),
                          ),
                        ],
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name ?? "",
                      style: reusableTextStyle(
                          textStyle: GoogleFonts.dmSans(),
                          fontSize: 16.0,
                          color: AppColors.textBlack,
                          fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      price ?? "",
                      style: reusableTextStyle(
                          textStyle: GoogleFonts.dmSans(),
                          fontSize: 14.0,
                          color: AppColors.dark,
                          fontWeight: FontWeight.normal),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      DateHelper
                          .convertLaravelDateFormatToDayMonthYearDateFormat(
                              date!),
                      style: reusableTextStyle(
                          textStyle: GoogleFonts.dmSans(),
                          fontSize: 12.0,
                          color: AppColors.dark,
                          fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
                Spacer(),
                if (controller.userdata.userId == residentId)
                  Obx(() {
                    return PopupMenuButton(
                        surfaceTintColor: AppColors.globalWhite,
                        color: AppColors.globalWhite,
                        initialValue: controller.status.value,
                        onOpened: () {},
                        onSelected: (val) {
                          controller.status.value = val.toString();

                          print(id.toString());
                          print(controller.status.value.toString());

                          controller.productStatus(
                              token: controller.userdata.bearerToken!,
                              id: id!,
                              status: controller.status.value.toString());
                        },
                        itemBuilder: (context) {
                          return [
                            PopupMenuItem(
                                value: 'sold', child: Text('Marked as Sold')),
                            PopupMenuItem(
                                value: 'forsale',
                                child: Text('Marked as For Sale')),
                            PopupMenuItem(
                              value: 'unavailable',
                              child: Text('Marked as Unavailable'),
                              onTap: () {},
                            ),
                          ];
                        });
                  })
                else
                  Container(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: ReadMoreText(
              description ?? "",
              trimMode: TrimMode.Line,
              trimLines: 2,
              colorClickableText: AppColors.appThem,
              trimCollapsedText: 'Show more',
              trimExpandedText: 'Show less',
              style: reusableTextStyle(
                  textStyle: GoogleFonts.dmSans(),
                  fontSize: 14.0,
                  color: AppColors.textBlack,
                  fontWeight: FontWeight.normal),
              moreStyle: reusableTextStyle(
                  textStyle: GoogleFonts.dmSans(),
                  fontSize: 14.0,
                  color: AppColors.appThem,
                  fontWeight: FontWeight.bold),
              lessStyle: reusableTextStyle(
                  textStyle: GoogleFonts.dmSans(),
                  fontSize: 14.0,
                  color: AppColors.appThem,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}

class buildProfileCard extends GetView {
  final String? image;
  final String? name;
  final String? residentType;
  final void Function()? onChatTap;
  final void Function()? onCallTap;

  const buildProfileCard(
      {super.key,
      required this.image,
      required this.name,
      required this.residentType,
      required this.onChatTap,
      required this.onCallTap});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Padding(
        padding: EdgeInsets.only(left: 20.w, top: 10, bottom: 10),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            height: 50,
            width: 50,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(300),
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: Api.imageBaseUrl + image.toString(),
                placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(
                    color: AppColors.appThem,
                  ),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
          ),
          8.w.pw,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name ?? "",
                  style: GoogleFonts.quicksand(
                      color: HexColor('#0D0B0C'),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  residentType ?? "",
                  style: GoogleFonts.quicksand(
                      color: HexColor('#6A7380'),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          IconButton(
              onPressed: onChatTap,
              icon: Icon(
                Icons.chat,
                color: AppColors.appThem,
              )),
          13.w.pw,
          IconButton(
              onPressed: onCallTap,
              icon: Icon(
                Icons.call,
                color: AppColors.appThem,
              )),
          38.w.pw
        ]),
      ),
    );
  }
}

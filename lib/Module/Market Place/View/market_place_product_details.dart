import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:userapp/Widgets/app_gradient.dart';
import 'package:userapp/Widgets/my_button.dart';
import 'package:userapp/utils/Constants/constants.dart';
import 'package:userapp/Helpers/Date%20Helper/date_helper.dart';
import 'package:userapp/Module/Market%20Place/Controller/market_place_product_details_controller.dart';
import 'package:userapp/utils/styles/colors.dart';
import 'package:userapp/utils/styles/reuseable_textstyle.dart';

import '../../../utils/Constants/api_routes.dart';

class MarketPlaceProductDetails extends StatelessWidget {
  final MarketPlaceProductDetailsController controller =
      Get.find<MarketPlaceProductDetailsController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              carouselController: controller.carouselController,
              items: (controller.snapShot.images as List)
                  .map((e) => Stack(
                        children: [
                          CachedNetworkImage(
                            width: 375.w,
                            height: 370.w,
                            fit: BoxFit.cover,
                            imageUrl: Api.imageBaseUrl + e.images.toString(),
                            placeholder: (context, url) => Center(
                              child: CircularProgressIndicator(
                                color: AppColors.appThem,
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 16.h),
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Obx(() {
                                return AnimatedSmoothIndicator(
                                  onDotClicked: (index) {
                                    controller.carouselController
                                        .animateToPage(index);
                                  },
                                  activeIndex: controller.carouselIndex.value,
                                  count: controller.snapShot.images!.length,
                                  effect: WormEffect(
                                      dotColor: Colors.white,
                                      dotWidth: 10.w,
                                      dotHeight: 10.w,
                                      activeDotColor: primaryColor),
                                );
                              }),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 15.h),
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  16.67.w.pw,
                                  GestureDetector(
                                    onTap: () {
                                      Get.back();
                                    },
                                    child: Icon(
                                      Icons.arrow_back_ios,
                                      color: Colors.white,
                                    ),
                                  ),
                                  122.922.w.pw,
                                  Obx(() {
                                    return Text(
                                      '${controller.carouselIndex.value + 1}/${controller.snapShot.images!.length}',
                                      style: GoogleFonts.quicksand(
                                          color: Colors.white,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600),
                                    );
                                  })
                                ],
                              ),
                            ),
                          ),
                        ],
                      ))
                  .toList(),
              options: CarouselOptions(
                  height: 320.w,
                  initialPage: 0,
                  viewportFraction: 1.0,
                  enlargeCenterPage: false,
                  onPageChanged: (int index, CarouselPageChangedReason c) {
                    controller.setCarouselIndex(index: index);
                  }),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "${controller.snapShot.productname}",
                        style: reusableTextStyle(
                            textStyle: GoogleFonts.dmSans(),
                            fontSize: 18.0,
                            color: AppColors.textBlack,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "${controller.snapShot.productprice}",
                        style: reusableTextStyle(
                            textStyle: GoogleFonts.dmSans(),
                            fontSize: 14.0,
                            color: AppColors.dark,
                            fontWeight: FontWeight.normal),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "${controller.snapShot.description}",
                        style: reusableTextStyle(
                            textStyle: GoogleFonts.dmSans(),
                            fontSize: 14.0,
                            color: AppColors.textBlack,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Details",
                        style: reusableTextStyle(
                            textStyle: GoogleFonts.dmSans(),
                            fontSize: 18.0,
                            color: AppColors.textBlack,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Contact",
                                style: reusableTextStyle(
                                    textStyle: GoogleFonts.dmSans(),
                                    fontSize: 14.0,
                                    color: AppColors.textBlack,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                "Category",
                                style: reusableTextStyle(
                                    textStyle: GoogleFonts.dmSans(),
                                    fontSize: 14.0,
                                    color: AppColors.textBlack,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                "Condition",
                                style: reusableTextStyle(
                                    textStyle: GoogleFonts.dmSans(),
                                    fontSize: 14.0,
                                    color: AppColors.textBlack,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                "Post At",
                                style: reusableTextStyle(
                                    textStyle: GoogleFonts.dmSans(),
                                    fontSize: 14.0,
                                    color: AppColors.textBlack,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                "Status",
                                style: reusableTextStyle(
                                    textStyle: GoogleFonts.dmSans(),
                                    fontSize: 14.0,
                                    color: AppColors.textBlack,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 120,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${controller.snapShot.contact}",
                                style: reusableTextStyle(
                                    textStyle: GoogleFonts.dmSans(),
                                    fontSize: 14.0,
                                    color: AppColors.dark,
                                    fontWeight: FontWeight.normal),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                "${controller.snapShot.category}",
                                style: reusableTextStyle(
                                    textStyle: GoogleFonts.dmSans(),
                                    fontSize: 14.0,
                                    color: AppColors.dark,
                                    fontWeight: FontWeight.normal),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                "${controller.snapShot.condition}",
                                style: reusableTextStyle(
                                    textStyle: GoogleFonts.dmSans(),
                                    fontSize: 14.0,
                                    color: AppColors.dark,
                                    fontWeight: FontWeight.normal),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                " ${DateHelper.convertLaravelDateFormatToDayMonthYearDateFormat(controller.snapShot.createdAt.toString())}",
                                style: reusableTextStyle(
                                    textStyle: GoogleFonts.dmSans(),
                                    fontSize: 14.0,
                                    color: AppColors.dark,
                                    fontWeight: FontWeight.normal),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                "${controller.snapShot.status}",
                                style: reusableTextStyle(
                                    textStyle: GoogleFonts.dmSans(),
                                    fontSize: 14.0,
                                    color: AppColors.dark,
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Owner Details",
                        style: reusableTextStyle(
                            textStyle: GoogleFonts.dmSans(),
                            fontSize: 18.0,
                            color: AppColors.textBlack,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(shape: BoxShape.circle),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(300),
                              child: CachedNetworkImage(
                                height: 64.w,
                                fit: BoxFit.cover,
                                imageUrl: Api.imageBaseUrl +
                                    "${controller.snapShot.users?.image}",
                                placeholder: (context, url) => Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.appThem,
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${controller.snapShot.users?.firstname} ${controller.snapShot.users?.lastname}",
                                style: reusableTextStyle(
                                    textStyle: GoogleFonts.dmSans(),
                                    fontSize: 18.0,
                                    color: AppColors.textBlack,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "${controller.snapShot.residents?.residenttype}",
                                style: reusableTextStyle(
                                    textStyle: GoogleFonts.dmSans(),
                                    fontSize: 16.0,
                                    color: AppColors.dark,
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                          // Spacer(),
                          // Text(
                          //   "${controller.snapShot.residents?.city}",
                          //   style: reusableTextStyle(
                          //       textStyle: GoogleFonts.dmSans(),
                          //       fontSize: 16.0,
                          //       color: AppColors.dark,
                          //       fontWeight: FontWeight.normal),
                          // ),
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Center(
                        child: MyButton(
                          gradient: AppGradients.buttonGradient,
                          width: 288.w,
                          height: 42.w,
                          border: 12.r,
                          name: 'Contact Owner',
                          onPressed: () async {
                            controller.uri = Uri.parse(
                                "tel://${controller.snapShot.contact}");

                            try {
                              await launchUrl(controller.uri!);
                              controller.uri = null;
                            } catch (e) {
                              myToast(msg: e.toString(), isNegative: true);
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductCardWidget extends StatelessWidget {
  final List<Widget> column;
  final double? height;

  const ProductCardWidget({super.key, required this.column, this.height});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 24.w),
      child: Container(
        decoration: BoxDecoration(
            color: HexColor('#F3F4F5'),
            borderRadius: BorderRadius.circular(16.r)),
        width: 328.w,
        height: height ?? 264.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: column,
        ),
      ),
    );
  }
}

class ProductCardHeading extends StatelessWidget {
  final String? text;

  const ProductCardHeading({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.w),
      child: Text(
        text ?? "",
        style: GoogleFonts.quicksand(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: HexColor('#0D0B0C')),
      ),
    );
  }
}

class ProductCardTextWidget extends StatelessWidget {
  final String? heading;
  final String? text;
  final double middleSizedBox;

  const ProductCardTextWidget(
      {super.key,
      required this.heading,
      required this.text,
      this.middleSizedBox = 0});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                heading ?? "",
                style: GoogleFonts.quicksand(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: HexColor('#6A7380')),
              ),
              middleSizedBox.w.pw,
              Text(text ?? "",
                  style: GoogleFonts.quicksand(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: HexColor('#0D0B0C'),
                  ),
                  textAlign: TextAlign.start),
            ],
          ),
        ),
        15.h.ph
      ],
    );
  }
}

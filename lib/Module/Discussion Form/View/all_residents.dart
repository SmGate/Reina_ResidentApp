// ignore_for_file: deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:userapp/Module/Discussion%20Form/Controller/view_all_resident_controller.dart';
import 'package:userapp/Module/Discussion%20Form/Model/all_resident_model.dart';
import 'package:userapp/Widgets/custom_card.dart';
import 'package:userapp/Widgets/empty_list.dart';
import 'package:userapp/Widgets/loading.dart';
import 'package:userapp/Widgets/my_back_button.dart';
import 'package:userapp/Widgets/my_textform_field.dart';
import 'package:userapp/utils/Constants/api_routes.dart';
import 'package:userapp/utils/styles/colors.dart';
import 'package:userapp/utils/styles/reuseable_textstyle.dart';
import '../../../Routes/set_routes.dart';

class ViewResidents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ViewResidentController>();
    return WillPopScope(
      onWillPop: () async {
        Get.offNamed(homescreen, arguments: controller.user);

        return true;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.background,
          body: Column(
            children: [
              MyBackButton(
                text: 'Residents',
                onTap: () {
                  Get.offNamed(homescreen, arguments: controller.user);
                },
              ),
              MyTextFormField(
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
                width: double.infinity,
                hintText: "Search Here",
                labelText: "Search Here",
                onChanged: (v) {
                  controller.searchValue.value = v;
                },
              ),
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
                        padding: const EdgeInsets.only(top: 250),
                        child: Center(child: CircularIndicatorUnderWhiteBox()),
                      ));
                    },
                    newPageProgressIndicatorBuilder: (context) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(
                              color: AppColors.appThem),
                        ),
                      );
                    },
                    noItemsFoundIndicatorBuilder: (context) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 200),
                        child: EmptyList(
                          name: 'No Entrise',
                        ),
                      );
                    },
                    itemBuilder: (context, item, index) {
                      final Datum residents = item as Datum;

                      return Obx(() {
                        if (((residents.firstname!.toLowerCase().contains(
                                        controller.searchValue.value) &&
                                    controller.searchValue.value.isNotEmpty) ||
                                controller.searchValue.value.isEmpty) &&
                            residents.residentid !=
                                controller.userdata.residentid) {
                          return ResidentCard(index, residents, controller);
                        } else {
                          return Container();
                        }
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  CustomCard ResidentCard(
      int index, Datum residents, ViewResidentController controller) {
    return CustomCard(
        margin: EdgeInsets.only(top: index == 0 ? 20 : 20, left: 20, right: 20),
        boxShadow: BoxShadow(),
        width: double.infinity,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 10, bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CachedNetworkImage(
                    imageBuilder: (context, imageProvider) => Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(300),
                          color: Colors.white,
                          image: DecorationImage(
                              image: NetworkImage(
                                  "${Api.imageBaseUrl}${residents.image}"),
                              fit: BoxFit.cover),
                        )),
                    imageUrl: "${Api.imageBaseUrl}${residents.image}",
                    placeholder: (context, url) => Column(
                      children: [
                        CircularProgressIndicator(
                          color: AppColors.appThem,
                        ),
                      ],
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 140,
                        // color: Colors.red,
                        child: Text(
                          residents.username ?? "",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: reusableTextStyle(
                            textStyle: GoogleFonts.dmSans(),
                            fontSize: 16.0,
                            color: AppColors.textBlack,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        residents.mobileno ?? "",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: reusableTextStyle(
                          textStyle: GoogleFonts.dmSans(),
                          fontSize: 14.0,
                          color: AppColors.dark,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      // Row(
                      //   children: [
                      //     Text(
                      //       "Status",
                      //       maxLines: 1,
                      //       overflow: TextOverflow.ellipsis,
                      //       style: reusableTextStyle(
                      //         textStyle: GoogleFonts.dmSans(),
                      //         fontSize: 14.0,
                      //         color: AppColors.textBlack,
                      //         fontWeight: FontWeight.bold,
                      //       ),
                      //     ),
                      //     SizedBox(
                      //       width: 20,
                      //     ),
                      //     Text(
                      //       residents.status == 1 ? "blocked" : "not blocked",
                      //       maxLines: 1,
                      //       overflow: TextOverflow.ellipsis,
                      //       style: reusableTextStyle(
                      //         textStyle: GoogleFonts.dmSans(),
                      //         fontSize: 14.0,
                      //         color: AppColors.dark,
                      //         fontWeight: FontWeight.normal,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                  Spacer(),
                  SizedBox(
                    height: 20,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.appThem,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6))),
                        onPressed: () {
                          controller.blockUser(
                              residentId: residents.residentid.toString());
                        },
                        child: Text(
                          "block",
                          style: TextStyle(
                              color: AppColors.globalWhite, fontSize: 10),
                        )),
                  )
                ],
              ),
            )
          ],
        ));
  }
}

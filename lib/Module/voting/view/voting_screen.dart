// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:userapp/Module/voting/controller/voting_controller.dart';
import 'package:userapp/Module/voting/model/get_all_poll_model.dart';
import 'package:userapp/Routes/set_routes.dart';
import 'package:userapp/Widgets/app_gradient.dart';
import 'package:userapp/Widgets/custom_card.dart';
import 'package:userapp/Widgets/loading.dart';
import 'package:userapp/Widgets/my_back_button.dart';
import 'package:userapp/Widgets/my_button.dart';
import 'package:userapp/Widgets/my_textform_field.dart';
import 'package:userapp/utils/Constants/images_strings.dart';
import 'package:userapp/utils/styles/colors.dart';
import 'package:userapp/utils/styles/reuseable_textstyle.dart';

class VotingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var votingController = Get.find<VotingController>();
    return WillPopScope(
      onWillPop: () async {
        Get.offNamed(homescreen, arguments: votingController.userdata);

        return true;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.background,
          body: Column(
            children: [
              MyBackButton(
                text: "Votings",
                onTap: () {
                  Get.offNamed(homescreen,
                      arguments: votingController.userdata);
                },
              ),
              Expanded(
                  child: FutureBuilder<GetAllPollModel>(
                future: votingController.getAllPoll(
                    societyId: votingController.userdata.societyId.toString(),
                    residentId:
                        votingController.userdata.residentid.toString()),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularIndicatorUnderWhiteBox());
                  } else if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount:
                            votingController.getAllPollModel.data?.length,
                        itemBuilder: (context, index) {
                          var data =
                              votingController.getAllPollModel.data?[index];
                          return CustomCard(
                              width: double.infinity,
                              margin: EdgeInsets.only(
                                  top: index == 0 ? 20 : 10,
                                  left: 20,
                                  right: 20,
                                  bottom: 10),
                              onTap: () {},
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, top: 20, bottom: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          AppImages.noticeBoard,
                                          height: 35,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: Text(
                                            data?.title ?? "",
                                            style: reusableTextStyle(
                                              textStyle: GoogleFonts.dmSans(),
                                              fontSize: 16.0,
                                              color: AppColors.textBlack,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            maxLines: 3,
                                            overflow: TextOverflow
                                                .ellipsis, // Optional: adds ellipsis if text overflows
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 40,
                                    ),
                                    votingController.getAllPollModel
                                                .data?[index].status ==
                                            "expired"

                                        ///////////  show voting result
                                        ? Container(
                                            height: votingController
                                                        .getAllPollModel
                                                        .data?[index]
                                                        .status ==
                                                    "expired"
                                                ? 150
                                                : 200,
                                            // color: Colors.red,
                                            child: ListView.builder(
                                              itemCount: votingController
                                                  .getAllPollModel
                                                  .data?[index]
                                                  .results!
                                                  .length,
                                              itemBuilder: (context, i) {
                                                return Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Image.asset(
                                                          AppImages.noticeBoard,
                                                          height: 20,
                                                        ),
                                                        SizedBox(
                                                          width: 20,
                                                        ),
                                                        Text(
                                                          "Option",
                                                          style:
                                                              reusableTextStyle(
                                                            textStyle:
                                                                GoogleFonts
                                                                    .dmSans(),
                                                            fontSize: 14.0,
                                                            color: AppColors
                                                                .textBlack,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                          maxLines: 3,
                                                        ),
                                                        Spacer(),
                                                        Text(
                                                          votingController
                                                                  .getAllPollModel
                                                                  .data?[index]
                                                                  .results![i]
                                                                  .option
                                                                  .toString() ??
                                                              "",
                                                          style:
                                                              reusableTextStyle(
                                                            textStyle:
                                                                GoogleFonts
                                                                    .dmSans(),
                                                            fontSize: 14.0,
                                                            color:
                                                                AppColors.dark,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                          ),
                                                          maxLines: 3,
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Image.asset(
                                                          AppImages.voting,
                                                          height: 20,
                                                        ),
                                                        SizedBox(
                                                          width: 20,
                                                        ),
                                                        Text(
                                                          "Votes",
                                                          style:
                                                              reusableTextStyle(
                                                            textStyle:
                                                                GoogleFonts
                                                                    .dmSans(),
                                                            fontSize: 14.0,
                                                            color: AppColors
                                                                .textBlack,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                          maxLines: 3,
                                                        ),
                                                        Spacer(),
                                                        Text(
                                                          votingController
                                                                  .getAllPollModel
                                                                  .data?[index]
                                                                  .results![i]
                                                                  .votes
                                                                  .toString() ??
                                                              "",
                                                          style:
                                                              reusableTextStyle(
                                                            textStyle:
                                                                GoogleFonts
                                                                    .dmSans(),
                                                            fontSize: 14.0,
                                                            color:
                                                                AppColors.dark,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                          ),
                                                          maxLines: 3,
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Icon(Icons.percent),
                                                        SizedBox(
                                                          width: 20,
                                                        ),
                                                        Text(
                                                          "Percentage",
                                                          style:
                                                              reusableTextStyle(
                                                            textStyle:
                                                                GoogleFonts
                                                                    .dmSans(),
                                                            fontSize: 14.0,
                                                            color: AppColors
                                                                .textBlack,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                          maxLines: 3,
                                                        ),
                                                        Spacer(),
                                                        Text(
                                                          "${votingController.getAllPollModel.data?[index].results![i].percentage.toString() ?? ""} %",
                                                          style:
                                                              reusableTextStyle(
                                                            textStyle:
                                                                GoogleFonts
                                                                    .dmSans(),
                                                            fontSize: 14.0,
                                                            color:
                                                                AppColors.dark,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                          ),
                                                          maxLines: 3,
                                                        ),
                                                      ],
                                                    ),
                                                    i ==
                                                            (votingController
                                                                        .getAllPollModel
                                                                        .data?[
                                                                            index]
                                                                        .results
                                                                        ?.length ??
                                                                    0) -
                                                                1
                                                        ? SizedBox()
                                                        : Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    top: 10,
                                                                    bottom: 10),
                                                            child: Divider(),
                                                          )
                                                  ],
                                                );
                                              },
                                            ),
                                          )
                                        : votingController.getAllPollModel
                                                    .data?[index].isMarked ==
                                                1
                                            ? Stack(
                                                children: [
                                                  Container(
                                                    height: 100,
                                                    // color: Colors.red,
                                                    child: ListView.builder(
                                                      itemCount:
                                                          votingController
                                                              .getAllPollModel
                                                              .data?[index]
                                                              .options!
                                                              .length,
                                                      itemBuilder:
                                                          (context, i) {
                                                        final option =
                                                            votingController
                                                                .getAllPollModel
                                                                .data?[index]
                                                                .options![i];
                                                        final isSelected = option
                                                                ?.isSelected
                                                                ?.toString() ==
                                                            "1";

                                                        return ListTile(
                                                          title: Text(
                                                              option?.option ??
                                                                  ""),
                                                          leading:
                                                              Radio<String>(
                                                            activeColor:
                                                                AppColors
                                                                    .appThem,
                                                            value: option
                                                                    ?.option ??
                                                                "",
                                                            groupValue: isSelected
                                                                ? option?.option
                                                                : "", // Set groupValue based on isSelected
                                                            onChanged: (value) {
                                                              if (isSelected) {
                                                                Fluttertoast
                                                                    .showToast(
                                                                        msg:
                                                                            "You have already vote this");
                                                              }
                                                            },
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                  Opacity(
                                                    opacity: 0.4,
                                                    child: Center(
                                                      child: Transform.rotate(
                                                        angle: -0.3,
                                                        child: Container(
                                                          width: 200,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            border: Border.all(
                                                              color: Colors.red,
                                                              width: 2,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                          ),
                                                          child: Center(
                                                            child: Text(
                                                              "Voted",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .red, // Text color
                                                                fontSize:
                                                                    40, // Font size
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold, // Text style
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              )

                                            ///////////  default resident voting  options
                                            : Container(
                                                height: 100,
                                                //   color: Colors.red,
                                                child: ListView.builder(
                                                  itemCount: votingController
                                                      .getAllPollModel
                                                      .data?[index]
                                                      .options!
                                                      .length,
                                                  itemBuilder: (context, i) {
                                                    return ListTile(
                                                      title: Text(votingController
                                                              .getAllPollModel
                                                              .data?[index]
                                                              .options![i]
                                                              .option ??
                                                          ""),
                                                      leading: Obx(() =>
                                                          Radio<String>(
                                                            activeColor:
                                                                AppColors
                                                                    .appThem,
                                                            value: votingController
                                                                    .getAllPollModel
                                                                    .data?[
                                                                        index]
                                                                    .options![i]
                                                                    .option ??
                                                                "",
                                                            groupValue:
                                                                votingController
                                                                    .radioSelectedOption
                                                                    .value,
                                                            onChanged: (value) {
                                                              votingController
                                                                  .selectOption(
                                                                      value ??
                                                                          '');

                                                              votingController
                                                                      .pollOptioId =
                                                                  votingController
                                                                      .getAllPollModel
                                                                      .data?[
                                                                          index]
                                                                      .options![
                                                                          i]
                                                                      .id;
                                                            },
                                                          )),
                                                    );
                                                  },
                                                )),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    votingController.getAllPollModel
                                                    .data?[index].status !=
                                                "expired" &&
                                            votingController.getAllPollModel
                                                    .data?[index].isResonable ==
                                                1
                                        ? MyTextFormField(
                                            controller: votingController
                                                .reasonController,
                                            padding: EdgeInsets.only(
                                                left: 20, right: 20),
                                            hintText: "Enter Reason",
                                            labelText: "Enter Reason",
                                            maxLines: 3,
                                          )
                                        : SizedBox(),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    votingController.getAllPollModel
                                                    .data?[index].status ==
                                                "expired" ||
                                            votingController.getAllPollModel
                                                    .data?[index].isMarked ==
                                                1
                                        ? SizedBox()
                                        : Center(
                                            child: Obx(() => MyButton(
                                                  loading: votingController
                                                      .loadingAddingVote.value,
                                                  gradient: AppGradients
                                                      .buttonGradient,
                                                  name: "Save",
                                                  onPressed: () {
                                                    votingController.addResidentVote(
                                                        pollId: votingController
                                                            .getAllPollModel
                                                            .data?[index]
                                                            .id
                                                            .toString(),
                                                        pollOptionId:
                                                            votingController
                                                                .pollOptioId
                                                                .toString(),
                                                        reason: votingController
                                                            .reasonController
                                                            .text,
                                                        residentId:
                                                            votingController
                                                                .userdata
                                                                .residentid
                                                                .toString());
                                                  },
                                                )),
                                          )
                                  ],
                                ),
                              ));
                        });
                  } else if (snapshot.hasError) {
                    return Center(child: Text("${snapshot.error}"));
                  } else {
                    return Center(child: Text("No Data"));
                  }
                },
              ))
            ],
          ),
        ),
      ),
    );
  }
}

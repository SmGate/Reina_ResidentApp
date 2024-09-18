// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:userapp/Widgets/app_gradient.dart';
import 'package:userapp/utils/Constants/constants.dart';
import 'package:userapp/Helpers/Validation%20Helper/validation_helper.dart';
import 'package:userapp/Module/Add%20PreApprove%20Entry/Model/GateKeeper.dart';
import 'package:userapp/Widgets/my_back_button.dart';
import 'package:userapp/Widgets/my_button.dart';
import 'package:userapp/Widgets/my_textform_field.dart';
import 'package:userapp/utils/styles/colors.dart';
import '../../../Routes/set_routes.dart';
import '../../../utils/styles/reuseable_textstyle.dart';
import '../Controller/add_pre_approve_entry_controller.dart';

class AddPreApproveEntry extends StatefulWidget {
  @override
  _AddPreApproveEntryState createState() => _AddPreApproveEntryState();
}

class _AddPreApproveEntryState extends State<AddPreApproveEntry> {
  late AddPreApproveEntryController controller;
  DateTime? startDate;
  DateTime? endDate;

  // Other variables

  @override
  void initState() {
    super.initState();
    controller = Get.find<AddPreApproveEntryController>();
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          Get.offNamed(preapproveentryscreen,
              arguments: [controller.userdata, controller.resident]);
          return true;
        },
        child: Scaffold(
          backgroundColor: AppColors.background,
          body: Column(
            children: [
              MyBackButton(
                text: 'Add PreApprove Entry',
                onTap: () {
                  Get.offNamed(preapproveentryscreen,
                      arguments: [controller.userdata, controller.resident]);
                },
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        30.h.ph,
                        Padding(
                          padding: EdgeInsets.fromLTRB(44.w, 0, 45.w, 0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Visitor Type",
                              style: reusableTextStyle(
                                  textStyle: GoogleFonts.dmSans(),
                                  fontSize: 18.0,
                                  color: AppColors.textBlack,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        12.h.ph,
                        Padding(
                          padding: EdgeInsets.fromLTRB(24.w, 0, 45.w, 0),
                          child: Stack(
                            children: [
                              Positioned(
                                top: 72,
                                left: 22,
                                child: Container(
                                  color: HexColor('#E4E4E4'),
                                  width: 275.w,
                                  height: 2.w,
                                ),
                              ),
                              SizedBox(
                                width: 300.w,
                                child: TabBar(
                                    onTap: (visitorType) {
                                      print(visitorType);

                                      if (visitorType == 0) {
                                        controller.visitorTypeValue?.value =
                                            'Guest';
                                      } else if (visitorType == 1) {
                                        controller.visitorTypeValue?.value =
                                            'Delivery';
                                      } else if (visitorType == 2) {
                                        controller.visitorTypeValue?.value =
                                            'Cab';
                                      } else if (visitorType == 3) {
                                        controller.visitorTypeValue?.value =
                                            'Visiting Help';
                                      }
                                    },
                                    labelPadding: EdgeInsets.zero,
                                    indicatorSize: TabBarIndicatorSize.label,
                                    automaticIndicatorColorAdjustment: true,
                                    controller: controller.tabController,
                                    indicatorWeight: 1.4,
                                    indicatorColor: AppColors.appThem,
                                    labelColor: HexColor('#717171'),
                                    labelStyle: reusableTextStyle(
                                        textStyle: GoogleFonts.dmSans(),
                                        fontSize: 14.0,
                                        color: AppColors.textBlack,
                                        fontWeight: FontWeight.normal),
                                    tabs: controller.tabs),
                              ),
                            ],
                          ),
                        ),

                        10.h.ph,

                        MyTextFormField(
                          suffixIcon: Icon(
                            Icons.search,
                            color: AppColors.appThem,
                          ),
                          controller: controller.searchController,
                          // validator: ValidationHelper().emptyStringValidator,
                          labelText: 'Search With Name',
                          hintText: 'Search With Name',
                          readOnly: false,
                          onTap: () {},
                          onChanged: (v) {
                            if (v.length == 0) {
                              controller.isSearhFieldEnable.value = false;
                            } else {
                              controller.isSearhFieldEnable.value = true;
                              controller.filterEntries(
                                  controller.searchController.text);
                            }
                          },
                        ),

                        Obx(() => controller.isSearhFieldEnable.value
                            ? Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 35, vertical: 10),
                                height: 140,
                                width: double.infinity,
                                color: AppColors.globalWhite,
                                child: ListView.builder(
                                    itemCount: controller
                                        .filterPreApprovedEntryList.length,
                                    itemBuilder: ((context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          controller
                                              .nameController.text = controller
                                                  .filterPreApprovedEntryList[
                                                      index]
                                                  .name ??
                                              "";

                                          controller.mobileNoController
                                              .text = controller
                                                  .filterPreApprovedEntryList[
                                                      index]
                                                  .mobileno ??
                                              "";

                                          controller.descriptionController
                                              .text = controller
                                                  .filterPreApprovedEntryList[
                                                      index]
                                                  .description ??
                                              "";

                                          controller
                                              .cnicController.text = controller
                                                  .filterPreApprovedEntryList[
                                                      index]
                                                  .cnic ??
                                              "";

                                          controller.vehicleNoController
                                              .text = controller
                                                  .filterPreApprovedEntryList[
                                                      index]
                                                  .vechileno ??
                                              "";
                                          controller.isSearhFieldEnable.value =
                                              false;
                                          controller.searchController.text = "";
                                        },
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: 20,
                                                  right: 20,
                                                  top: index == 0 ? 10 : 10),
                                              height: 30,
                                              child: Text(controller
                                                      .filterPreApprovedEntryList[
                                                          index]
                                                      .name ??
                                                  ""),
                                            ),
                                            index ==
                                                    controller
                                                            .filterPreApprovedEntryList
                                                            .length -
                                                        1
                                                ? SizedBox()
                                                : Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 20,
                                                            right: 20),
                                                    child: Divider(
                                                      color: AppColors.appThem,
                                                    ),
                                                  )
                                          ],
                                        ),
                                      );
                                    })),
                              )
                            : SizedBox()),

                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(44.w, 0, 45.w, 0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Choose Gate",
                              style: reusableTextStyle(
                                  textStyle: GoogleFonts.dmSans(),
                                  fontSize: 18.0,
                                  color: AppColors.textBlack,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(44.w, 0, 45.w, 0),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColors.appThem, width: 1.5),
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: DropdownButtonHideUnderline(
                                child: DropdownSearch<GateKeeper>(
                                  popupProps: PopupProps.dialog(
                                    dialogProps: DialogProps(
                                        contentPadding:
                                            EdgeInsets.only(left: 20),
                                        backgroundColor: AppColors.globalWhite),
                                    fit: FlexFit.loose,
                                    title: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 20, left: 10),
                                      child: Text(
                                        "Choose Gate",
                                        style: reusableTextStyle(
                                            textStyle: GoogleFonts.dmSans(),
                                            fontSize: 18.0,
                                            color: AppColors.textBlack,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    // showSearchBox: true,
                                    loadingBuilder: (context, _) => Center(
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                AppColors.appThem),
                                      ),
                                    ),
                                  ),
                                  dropdownDecoratorProps:
                                      DropDownDecoratorProps(
                                    dropdownSearchDecoration: InputDecoration(
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColors.appThem)),
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColors.appThem)),
                                      suffixIconColor: AppColors.appThem,
                                    ),
                                  ),
                                  validator: (value) => value == null
                                      ? 'Select Gatekeeper'
                                      : null,
                                  asyncItems: (String filter) async {
                                    return controller.getGateKeepersApi(
                                      subadminid:
                                          controller.resident.subadminid!,
                                    );
                                  },
                                  onChanged: (GateKeeper? data) {
                                    controller.SelectedGatekeeper(data!);
                                  },
                                  selectedItem: controller.gateKeepers,
                                  itemAsString: (GateKeeper gatekeeper) {
                                    return gatekeeper.gateNo.toString();
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),

                        Obx(() => MyTextFormField(
                              controller: controller.nameController,
                              validator:
                                  ValidationHelper().emptyStringValidator,
                              labelText: controller.visitorTypeValue?.value ==
                                      "Guest"
                                  ? 'Enter Guest Name'
                                  : controller.visitorTypeValue?.value ==
                                          "Delivery"
                                      ? "Enter Company Name"
                                      : controller.visitorTypeValue?.value ==
                                              "Cab"
                                          ? "Enter Driver Name"
                                          : "Enter Name",
                              hintText: controller.visitorTypeValue?.value ==
                                      "Guest"
                                  ? 'Enter Guest Name'
                                  : controller.visitorTypeValue?.value ==
                                          "Delivery"
                                      ? "Enter Company Name"
                                      : controller.visitorTypeValue?.value ==
                                              "Cab"
                                          ? "Enter Driver Name"
                                          : "Enter Name",
                            )),
                        MyTextFormField(
                          controller: controller.mobileNoController,
                          validator: ValidationHelper().emptyStringValidator,
                          labelText: 'Mobile Number *',
                          hintText: 'Mobile Number',
                          textInputType: TextInputType.number,
                          suffixIcon: GestureDetector(
                              onTap: () async {
                                final FlutterContactPicker _contactPicker =
                                    new FlutterContactPicker();

                                Contact? contact =
                                    await _contactPicker.selectContact();
                                controller.mobileNoController.text =
                                    contact!.phoneNumbers!.first.toString();
                                controller.nameController.text =
                                    contact.fullName.toString();
                              },
                              child: Icon(
                                Icons.contact_page_sharp,
                                color: AppColors.appThem,
                              )),
                        ),

                        MyTextFormField(
                          controller: controller.arrivaldate,
                          validator: ValidationHelper().emptyStringValidator,
                          labelText: 'Expected Arrival Date *',
                          hintText: 'Expected Arrival Date',
                          readOnly: true,
                          onTap: () {
                            controller.StartDate(context);
                          },
                        ),
                        MyTextFormField(
                          controller: controller.arrivaltime,
                          validator: ValidationHelper().emptyStringValidator,
                          labelText: 'Expected Arrival Time *',
                          hintText: 'Expected Arrival Time',
                          readOnly: true,
                          onTap: () {
                            controller.GuestTime(context);
                          },
                        ),

                        /////////
                        Obx(
                          () => controller.visitorTypeValue?.value ==
                                      "Delivery" ||
                                  controller.visitorTypeValue?.value ==
                                      "Visiting Help" ||
                                  controller.visitorTypeValue?.value == "Cab"
                              ? Container()
                              : Padding(
                                  padding:
                                      EdgeInsets.fromLTRB(44.w, 20, 45.w, 0),
                                  child: Container(
                                    height: 50,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        border: Border.all(
                                            color: AppColors.appThem,
                                            width: 1.5),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        isExpanded: true,
                                        value: controller.selectedValue?.value,
                                        hint: Text(
                                          'Select Long Term Entry Pass',
                                          style: GoogleFonts.ubuntu(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 1.sp,
                                              letterSpacing: 12.05),
                                        ),
                                        iconSize: 24,
                                        elevation: 16,
                                        style: GoogleFonts.ubuntu(
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 15.sp,
                                            color: HexColor('#555555')),
                                        underline: Container(
                                          height: 2,
                                          color: Colors.blueAccent,
                                        ),
                                        items:
                                            controller.items.map((String item) {
                                          return DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(item),
                                          );
                                        }).toList(),
                                        onChanged: (String? newValue) {
                                          controller.selectedValue?.value =
                                              newValue ?? "";
                                          updateSelectedDate(
                                              controller.selectedValue?.value ??
                                                  "");
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                        ),
//////////
                        //    if (controller.checkBoxValue) ...[
                        MyTextFormField(
                          controller: controller.descriptionController,
                          // validator: emptyStringValidator,
                          width: null,
                          maxLines: 3,
                          labelText: 'Description',
                          hintText: 'Description',
                        ),
                        MyTextFormField(
                          controller: controller.cnicController,
                          labelText: 'Cnic',
                          hintText: 'Cnic',
                          textInputType: TextInputType.number,
                          onChanged: (value) {
                            String formattedText =
                                ValidationHelper().formatText(value);

                            controller.cnicController.value = TextEditingValue(
                              text: formattedText,
                              selection: TextSelection.collapsed(
                                  offset: formattedText.length),
                            );
                          },
                        ),
                        MyTextFormField(
                          controller: controller.vehicleNoController,
                          labelText: 'Vehicle Number',
                          hintText: 'Vehicle Number',
                        ),
                        // ],
                        20.h.ph,
                        Padding(
                          padding: EdgeInsets.fromLTRB(44.w, 0, 45.w, 0),
                          child: ListTile(
                            title: Text(
                              'ISSUE QR CODE',
                              style: reusableTextStyle(
                                  textStyle: GoogleFonts.dmSans(),
                                  fontSize: 14.0,
                                  color: AppColors.textBlack,
                                  fontWeight: FontWeight.bold),
                            ),
                            trailing: Checkbox(
                              checkColor: AppColors.globalWhite,
                              activeColor: AppColors.appThem,
                              value: controller.checkBoxValue,
                              onChanged: (newValue) {
                                setState(() {
                                  controller.setCheckBox(newValue);
                                });
                              },
                            ),
                          ),
                        ),

                        20.h.ph,

                        if (controller.checkBoxValue) ...[
                          Container(
                            margin: EdgeInsets.only(left: 30, right: 30),
                            height: 260,
                            decoration: BoxDecoration(
                                color: AppColors.globalWhite,
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Add CNIC front image",
                                  style: reusableTextStyle(
                                      textStyle: GoogleFonts.dmSans(),
                                      fontSize: 14.0,
                                      color: AppColors.textBlack,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Expanded(
                                  child: Container(
                                    width: double.infinity,
                                    margin: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColors.appThem),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Obx(() {
                                      return controller.base64Image.value ==
                                              null
                                          ? Center(
                                              child: Text('No image selected'))
                                          : ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Image.memory(
                                                base64Decode(controller
                                                    .base64Image.value!
                                                    .split(',')
                                                    .last),
                                                fit: BoxFit.cover,
                                              ));
                                    }),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: AppColors.appThem),
                                        onPressed: () {
                                          controller
                                              .pickImage(ImageSource.gallery);
                                        },
                                        child: Text(
                                          "From Gallery",
                                          style: TextStyle(
                                              color: AppColors.globalWhite),
                                        )),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: AppColors.appThem),
                                        onPressed: () {
                                          controller
                                              .pickImage(ImageSource.camera);
                                        },
                                        child: Text("From Camera",
                                            style: TextStyle(
                                                color: AppColors.globalWhite)))
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          )
                        ],

                        20.h.ph,
                        Obx(() => Center(
                              child: MyButton(
                                gradient: AppGradients.buttonGradient,
                                loading: controller.isLoading.value,
                                name: 'Save',
                                onPressed: () {
                                  if (controller.formKey.currentState!
                                      .validate()) {
                                    if (controller.visitorTypeValue == null) {
                                      Get.snackbar(
                                          'Error', 'Select VisitorType');
                                    } else {
                                      if (!controller.isLoading.value) {
                                        controller.addPreApproveEntryApi(
                                            token: controller
                                                .userdata.bearerToken!,
                                            cnic:
                                                controller.cnicController.text,
                                            name:
                                                controller.nameController.text,
                                            mobileno: controller
                                                .mobileNoController.text,
                                            userid: controller.userdata.userId!,
                                            arrivaldate:
                                                controller.arrivaldate.text,
                                            arrivaltime: controller.arrivalTime
                                                .toString(),
                                            description: controller
                                                .descriptionController.text,
                                            vechileno: controller
                                                .vehicleNoController.text,
                                            visitortype: controller
                                                    .visitorTypeValue?.value ??
                                                "",
                                            gatekeeperid: controller
                                                .gateKeepers!.gateKeeperId!,
                                            arrivalType: controller
                                                    .visitorTypeValue?.value ??
                                                "",
                                            image: controller.base64Image.value,
                                            // startDate: DateTime.parse(
                                            //     controller.arrivaldate.text),
                                            toDate: endDate ??
                                                DateTime.now()
                                                    .add(Duration(days: 1)));
                                      }
                                    }
                                  }
                                },
                              ),
                            )),
                        20.h.ph
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void updateSelectedDate(String newValue) {
    controller.selectedValue?.value = newValue;
    startDate = DateTime.parse(controller.arrivaldate.text);

    switch (newValue) {
      case "1 Day":
        endDate = startDate?.add(Duration(days: 1));
        print("Start Date: $startDate, End Date: $endDate");
        break;
      case "1 Week":
        endDate = startDate?.add(Duration(days: 7));
        print("Start Date: $startDate, End Date: $endDate");
        break;
      case "1 Month":
        // Create the end date by adding one month to the start date
        int year = startDate!.year;
        int month = startDate!.month + 1;
        int day = startDate!.day;

        // Handle month overflow
        if (month > 12) {
          month = 1;
          year++;
        }

        // Handle day overflow if the start date is the last day of the month
        DateTime newEndDate = DateTime(year, month, day);
        if (newEndDate.month != month) {
          newEndDate =
              DateTime(year, month, 0); // Get last day of the previous month
        }

        endDate = newEndDate;
        print("Start Date: $startDate, End Date: $endDate");
        break;
      default:
        endDate = startDate?.add(Duration(days: 1));
    }
  }
}

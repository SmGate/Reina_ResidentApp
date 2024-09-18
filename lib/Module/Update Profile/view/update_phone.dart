// ignore_for_file: must_be_immutable

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:userapp/Helpers/Validation%20Helper/validation_helper.dart';
import 'package:userapp/Module/Update%20Profile/controller/update_user_profile_controller.dart';
import 'package:userapp/Routes/set_routes.dart';
import 'package:userapp/Widgets/app_gradient.dart';
import 'package:userapp/Widgets/my_back_button.dart';
import 'package:userapp/Widgets/my_button.dart';
import 'package:userapp/Widgets/my_textform_field.dart';
import 'package:userapp/utils/Constants/constants.dart';
import 'package:userapp/utils/Constants/images_strings.dart';
import 'package:userapp/utils/styles/colors.dart';

class UpdatePhone extends StatefulWidget {
  String phone;
  int userId;
  UpdatePhone({super.key, required this.phone, required this.userId});

  @override
  State<UpdatePhone> createState() => _UpdatePhoneState();
}

class _UpdatePhoneState extends State<UpdatePhone> {
  var updateProfileController = Get.put(UpdateUserProfileController());
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              MyBackButton(
                text: 'Update Phone',
                onTap: () {
                  Get.offNamed(homescreen,
                      arguments: updateProfileController.userdata);
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 58.w, vertical: 40),
                child: Image.asset(
                  AppImages.logo,
                  width: 302.w,
                  height: 201.w,
                ),
              ),
              MyTextFormField(
                validator: ValidationHelper().validatePhoneNumber,
                controller: updateProfileController.mobileController,
                fontWeight: FontWeight.w500,
                fontSize: 16,
                //   padding: EdgeInsets.only(top: 20),
                textInputType: TextInputType.number,
                hintText: 'Phone Number',
                labelText: 'Phone Number',
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: GestureDetector(
                      onTap: () {
                        showCountryPicker(
                            context: context,
                            countryListTheme: CountryListThemeData(
                              flagSize: 30,
                              backgroundColor: Colors.white,
                              textStyle: GoogleFonts.montserrat(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                              bottomSheetHeight: 500,

                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(12.0),
                                topRight: Radius.circular(12.0),
                              ),
                              //Optional. Styles the search field.
                              inputDecoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.appThem,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.appThem,
                                  ),
                                ),
                                labelStyle: GoogleFonts.montserrat(
                                  color: HexColor('#B6B6B6'),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                                labelText: 'Search',
                                hintText: 'Start typing to search',
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: AppColors.appThem,
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.appThem,
                                  ),
                                ),
                              ),
                            ),
                            onSelect: (Country country) {
                              updateProfileController.countryFlag.value =
                                  country.flagEmoji;
                              updateProfileController.countryCode.value =
                                  country.phoneCode;
                            });
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 16, 8, 0),
                        child: Obx(() {
                          return Text(
                            "${updateProfileController.countryFlag} + ${updateProfileController.countryCode}",
                            style: GoogleFonts.montserrat(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          );
                        }),
                      )),
                ),
                onTap: () {},
              ),
              16.h.ph,
              Obx(() => MyButton(
                    gradient: AppGradients.buttonGradient,
                    loading: updateProfileController.loading2.value,
                    width: 173.w,
                    height: 43.w,
                    border: 16.0.r,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        updateProfileController.phoneNumber.value =
                            "+${updateProfileController.countryCode}${updateProfileController.mobileController.text}";
                        updateProfileController.updatePhone(
                            phone: updateProfileController.phoneNumber.value,
                            userId: widget.userId);
                      }
                    },
                    textColor: Colors.white,
                    color: AppColors.appThem,
                    name: 'Next',
                    outlinedBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

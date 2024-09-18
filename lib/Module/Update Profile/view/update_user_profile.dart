// ignore_for_file: must_be_immutable

import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:userapp/Helpers/Validation%20Helper/validation_helper.dart';
import 'package:userapp/Module/Update%20Profile/controller/update_user_profile_controller.dart';
import 'package:userapp/Routes/set_routes.dart';
import 'package:userapp/Widgets/app_gradient.dart';
import 'package:userapp/Widgets/my_back_button.dart';
import 'package:userapp/Widgets/my_button.dart';
import 'package:userapp/Widgets/my_textform_field.dart';
import 'package:userapp/utils/Constants/api_routes.dart';
import 'package:userapp/utils/Constants/constants.dart';
import 'package:userapp/utils/styles/colors.dart';

class UpdateUserProfile extends StatefulWidget {
  String fname;
  String lastName;
  String profileImg;
  UpdateUserProfile(
      {super.key,
      required this.fname,
      required this.lastName,
      required this.profileImg});

  @override
  State<UpdateUserProfile> createState() => _UpdateUserProfileState();
}

class _UpdateUserProfileState extends State<UpdateUserProfile> {
  var updateProfileController = Get.put(UpdateUserProfileController());
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    updateProfileController.firstnameController.text = widget.fname;
    updateProfileController.lastnameController.text = widget.lastName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Builder(builder: (context) {
          return Form(
            key: _formKey,
            child: Column(
              children: [
                MyBackButton(
                  text: 'Update Profile',
                  onTap: () {
                    Get.offNamed(homescreen,
                        arguments: updateProfileController.userdata);
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Container(
                            height: 100.0.h,
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(
                                horizontal: 20.w, vertical: 20.h),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  'Choose Profile Photo',
                                  style: TextStyle(fontSize: 20.sp),
                                ),
                                20.h.ph,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    ElevatedButton.icon(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: AppColors.appThem),
                                      icon: Icon(
                                        Icons.camera,
                                        color: AppColors.yellow,
                                      ),
                                      onPressed: () {
                                        updateProfileController
                                            .getFromCamera(ImageSource.camera);
                                      },
                                      label: Text(
                                        'Camera',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    ElevatedButton.icon(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: AppColors.appThem),
                                      icon: Icon(
                                        Icons.image,
                                        color: AppColors.yellow,
                                      ),
                                      onPressed: () {
                                        updateProfileController.getFromGallery(
                                            ImageSource.gallery);
                                      },
                                      label: Text(
                                        'Gallery',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        });
                  },
                  child: Stack(
                    children: <Widget>[
                      Obx(() => CircleAvatar(
                            radius: 60.0,
                            backgroundColor: Colors.white,
                            child: ClipOval(
                              child: updateProfileController.imageFile.value ==
                                      null
                                  ? CachedNetworkImage(
                                      imageUrl:
                                          "${Api.imageBaseUrl}${widget.profileImg}",
                                      placeholder: (context, url) =>
                                          CircularProgressIndicator(
                                        color: AppColors.appThem,
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        width: 120.0,
                                        height: 120.0,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    )
                                  : CircleAvatar(
                                      radius: 60.0,
                                      backgroundImage: FileImage(File(
                                          updateProfileController
                                              .imageFile.value!.path
                                              .toString())),
                                    ),
                            ),
                          )),
                      Positioned(
                        left: 86,
                        top: 90,
                        child: InkWell(
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Container(
                                    height: 100.0.h,
                                    width: MediaQuery.of(context).size.width,
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 20.w, vertical: 20.h),
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                          'Choose Profile Photo',
                                          style: TextStyle(fontSize: 20.sp),
                                        ),
                                        20.h.ph,
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            ElevatedButton.icon(
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      AppColors.appThem),
                                              icon: Icon(
                                                Icons.camera,
                                                color: AppColors.yellow,
                                              ),
                                              onPressed: () {
                                                updateProfileController
                                                    .getFromCamera(
                                                        ImageSource.camera);
                                              },
                                              label: Text(
                                                'Camera',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                            ElevatedButton.icon(
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      AppColors.appThem),
                                              icon: Icon(
                                                Icons.image,
                                                color: AppColors.yellow,
                                              ),
                                              onPressed: () {
                                                updateProfileController
                                                    .getFromGallery(
                                                        ImageSource.gallery);
                                              },
                                              label: Text(
                                                'Gallery',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                });
                          },
                          child: Icon(
                            Icons.camera_alt,
                            color: AppColors.appThem,
                            size: 28,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                16.h.ph,
                MyTextFormField(
                  controller: updateProfileController.firstnameController,
                  validator: ValidationHelper().emptyStringValidator,
                  hintText: 'First Name',
                  labelText: 'Enter First Name',
                ),
                16.h.ph,
                MyTextFormField(
                  controller: updateProfileController.lastnameController,
                  validator: ValidationHelper().emptyStringValidator,
                  hintText: 'Last Name',
                  labelText: 'Enter Last Name',
                ),
                16.h.ph,
                Obx(() => MyButton(
                      gradient: AppGradients.buttonGradient,
                      loading: updateProfileController.loading.value,
                      width: 173.w,
                      height: 43.w,
                      border: 16.0.r,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          updateProfileController.updateUserProfile(
                              fname: updateProfileController
                                  .firstnameController.text,
                              lname: updateProfileController
                                  .lastnameController.text,
                              residentId:
                                  updateProfileController.userdata.userId,
                              image: updateProfileController.imageFile.value);
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
          );
        }),
      ),
    );
  }
}

// ignore_for_file: deprecated_member_use, must_be_immutable

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:userapp/Module/Add%20PreApprove%20Entry/Model/add_pre_approved_entry_model.dart';
import 'package:userapp/Widgets/app_gradient.dart';
import 'package:userapp/Widgets/my_back_button.dart';
import 'package:userapp/Widgets/my_button.dart';
import 'package:userapp/utils/styles/colors.dart';
import '../../../Routes/set_routes.dart';
import '../../Login/Model/User.dart';

class QrCodeGenerator extends StatelessWidget {
  final Data qrData;
  final User userdata;

  QrCodeGenerator({required this.qrData, required this.userdata});
  ScreenshotController screenshotController = ScreenshotController();
  @override
  Widget build(BuildContext context) {
    String jsonData = jsonEncode(qrData.toJson());
    // var addPreapprovedEntryController =
    //     Get.find<AddPreApproveEntryController>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Center(
          child: Column(
            children: [
              MyBackButton(
                text: 'Qr Code',
                onTap: () {
                  Get.offNamed(preapproveentryscreen, arguments: [userdata]);
                },
              ),
              SizedBox(
                height: 200,
              ),
              Screenshot(
                controller: screenshotController,
                child: QrImageView(
                  backgroundColor: AppColors.globalWhite,
                  padding: EdgeInsets.all(20),
                  data: jsonData,
                  version: QrVersions.auto,
                  size: 200.0,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              MyButton(
                name: "Send",
                onPressed: () async {
                  _shareQrCode();
                },
                gradient: AppGradients.buttonGradient,
              )
            ],
          ),
        ),
      ),
    );
  }

  _shareQrCode() async {
    final directory = (await getApplicationDocumentsDirectory()).path;
    screenshotController.capture().then((Uint8List? image) async {
      try {
        String fileName = DateTime.now().microsecondsSinceEpoch.toString();
        final imagePath = await File('$directory/$fileName.png').create();
        await imagePath.writeAsBytes(image!);
        Share.shareFiles([imagePath.path]);
      } catch (error) {}
    }).catchError((onError) {
      print('Error --->> $onError');
    });
  }
}

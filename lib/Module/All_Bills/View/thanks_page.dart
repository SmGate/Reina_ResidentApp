import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:userapp/Module/All_Bills/Controller/monthly_bills_controller.dart';
import 'package:userapp/Routes/set_routes.dart';
import 'package:userapp/Widgets/my_back_button.dart';
import 'package:userapp/utils/styles/colors.dart';

class ThankYouPage extends StatelessWidget {
  final String message;
  final String transaction_status;

  ThankYouPage({required this.message, required this.transaction_status});
  @override
  Widget build(BuildContext context) {
    var controller = Get.find<MonthlyBillsController>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Column(
          children: [
            MyBackButton(
              text: "Greeting",
              onTap: () async {
                await Get.offAllNamed(homescreen,
                    arguments: controller.userdata);
              },
            ),
            SizedBox(
              height: 150,
            ),
            Center(
              child: Icon(
                Icons.check_circle_outline,
                color: Colors.green,
                size: 100.0,
              ),
            ),
            SizedBox(height: 20),
            Text(
              transaction_status != "000" ? "Oh No" : 'Thank You!',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            SizedBox(height: 10),
            Text(
              message,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

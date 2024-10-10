import 'package:greatbrands_blott_mobile/app_config.dart';
import 'package:greatbrands_blott_mobile/helpers/alert_dialog.dart';
import 'package:greatbrands_blott_mobile/styles.dart';
import 'package:greatbrands_blott_mobile/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class BlottNotification extends StatelessWidget {
  const BlottNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(whiteSpace),
        child: CustomButton(
          title: "Continue",
          onTap: () => showNotificationDialog(context),
        ),
      ),
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(whiteSpace),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/notification-icon.png'),
              const SizedBox(height: whiteSpace),
              Text(
                "Get the most out of Blott ✅",
                style: headingStyle.copyWith(fontSize: 24),
              ),
              const SizedBox(height: smallWhiteSpace),
              Text(
                "Allow notifications to stay in the loop with your payments, requests and groups.",
                style: paragraphStyle,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

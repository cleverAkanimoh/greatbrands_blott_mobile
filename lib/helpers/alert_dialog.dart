import 'package:greatbrands_blott_mobile/app_config.dart';
import 'package:greatbrands_blott_mobile/helpers/navigator_push.dart';
import 'package:greatbrands_blott_mobile/screens/dashboard.dart';
import 'package:greatbrands_blott_mobile/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showNotificationDialog(BuildContext context) {
  showDialog(
    context: context,
    useRootNavigator: false,
    // barrierDismissible: false, // Todo: toggle true to override default behavior
    barrierColor: greyColor.withOpacity(.5),
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: Text(
          '“Blott” Would Like to Send You Notifications',
          style: subHeadingStyle.copyWith(fontSize: 17),
          textAlign: TextAlign.center,
        ),
        content: Text(
          'Notifications may include alerts, sounds, and icon badges. These can be configured in Settings.',
          style: paragraphStyle.copyWith(
            color: Colors.black54,
            fontSize: smallText,
          ),
          textAlign: TextAlign.center,
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    'Don\'t Allow',
                    style: buttonTextStyle,
                  ),
                ),
              ),
              Container(
                height: 48,
                width: 1,
                color: greyColor.withOpacity(.8),
              ),
              Expanded(
                child: TextButton(
                  onPressed: () =>
                      NavigatorPush.pushRemoveUntil(page: const Dashboard()),
                  child: Text(
                    'Allow',
                    style: buttonTextStyle,
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}

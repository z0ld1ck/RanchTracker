import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:malshy/core/const/app_colors.dart';

class PushNotificationsSwitchWidget extends StatefulWidget {
  const PushNotificationsSwitchWidget({super.key});

  @override
  State<PushNotificationsSwitchWidget> createState() => _PushNotificationsSwitchWidgetState();
}

class _PushNotificationsSwitchWidgetState extends State<PushNotificationsSwitchWidget> {
  bool foriOS = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Push-уведомления',
            style:
                Theme.of(context).textTheme.titleSmall!.copyWith(color: AppColors.black, fontWeight: FontWeight.w600),
          ),
          CupertinoSwitch(
            value: foriOS,
            onChanged: (value) {
              setState(() {
                foriOS = value;
              });
            },
            activeColor: Colors.green,
            thumbColor: AppColors.white,
          ),
        ],
      ).paddingOnly(left: 16,right: 16),
    ).paddingOnly(left: 16,right: 16);
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:malshy/core/const/app_colors.dart';

class PushNotifications extends StatefulWidget {
  const PushNotifications({Key? key}) : super(key: key);

  @override
  _PushNotificationsState createState() => _PushNotificationsState();
}

class _PushNotificationsState extends State<PushNotifications> {
  bool foriOS = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.fromSTEB(16, 24, 16, 0),
      decoration: BoxDecoration(
        color: AppColors.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Push-уведомления',
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(color: AppColors.black, fontWeight: FontWeight.w600),
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
      ),
    );
  }
}

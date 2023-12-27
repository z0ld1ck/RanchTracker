import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:malshy/core/const/app_colors.dart';
import 'package:malshy/presentation/home/widgets/personal_data_field.dart';
import 'package:malshy/presentation/home/widgets/profile_field.dart';
import 'package:malshy/presentation/home/widgets/push_notification_switch.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 20.h),
        child: AppBar(
          automaticallyImplyLeading: false,
        ),
      ),
      body: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 16.w,
              ),
              Text(
                'Профиль',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: AppColors.black,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              ProfileField(),
            ],
          ),
          SizedBox(
            height: 24.h,
          ),
          PersonalData(),
          SizedBox(
            height: 24.h,
          ),
          PushNotifications(),
        ],
      ),
    );
  }
}

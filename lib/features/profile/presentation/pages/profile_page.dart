import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:malshy/core/const/app_colors.dart';
import 'package:malshy/features/profile/presentation/widgets/personal_data_widget.dart';
import 'package:malshy/features/profile/presentation/widgets/profile_field_widget.dart';
import 'package:malshy/features/profile/presentation/widgets/push_notification_switch_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
            height: 16.h,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              ProfileFieldWidget(),
            ],
          ),
          SizedBox(
            height: 24.h,
          ),
          PersonalDataWidget(),
          SizedBox(
            height: 24.h,
          ),
          PushNotificationsSwitchWidget(),
        ],
      ),
    );
  }
}

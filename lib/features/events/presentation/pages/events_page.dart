import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:malshy/core/const/app_icons.dart';
import 'package:malshy/core/navigation/nav_services.dart';
import 'package:malshy/core/routes/global_routes.dart';

import '../../../../core/const/app_colors.dart';

class Events extends StatefulWidget {
  const Events({super.key});

  @override
  State<Events> createState() => _EventsState();
}

class _EventsState extends State<Events> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.white,
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 40.h),
        child: AppBar(
          title: Text('Добавить мероприятие'),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 16.h,
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  child: TextField(
                    decoration: InputDecoration(
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.all(10),
                      hintText: 'Поиск...',
                      hintStyle: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(
                              color: AppColors.gray,
                              fontWeight: FontWeight.w400),
                      fillColor: AppColors.white,
                      prefixIcon: IconButton(
                        icon: SvgPicture.asset(AppIcons.search2),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Внутренние перемещения',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: AppColors.black,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      IconButton(
                        onPressed: () {
                          navService.pushNamed(GlobalRoutes.intmove);
                        },
                        icon: SvgPicture.asset(AppIcons.next),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Профилактика',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: AppColors.black,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      IconButton(
                        onPressed: () {
                          navService.pushNamed(GlobalRoutes.prevention);
                        },
                        icon: SvgPicture.asset(AppIcons.next),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Лечение',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: AppColors.black,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      IconButton(
                        onPressed: () {
                          navService.pushNamed(GlobalRoutes.treatment);
                        },
                        icon: SvgPicture.asset(AppIcons.next),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Измерение веса',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: AppColors.black,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      IconButton(
                        onPressed: () {
                          navService.pushNamed(GlobalRoutes.weight);
                        },
                        icon: SvgPicture.asset(AppIcons.next),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Продажа',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: AppColors.black,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      IconButton(
                        onPressed: () {
                          navService.pushNamed(GlobalRoutes.sales);
                        },
                        icon: SvgPicture.asset(AppIcons.next),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Падеж/Забой',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: AppColors.black,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      IconButton(
                        onPressed: () {
                          navService.pushNamed(GlobalRoutes.slaughter);
                        },
                        icon: SvgPicture.asset(AppIcons.next),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Утеря',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: AppColors.black,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      IconButton(
                        onPressed: () {
                          navService.pushNamed(GlobalRoutes.loss);
                        },
                        icon: SvgPicture.asset(AppIcons.next),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Проверка на стельность',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: AppColors.black,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      IconButton(
                        onPressed: () {
                          navService.pushNamed(GlobalRoutes.pregnancy);
                        },
                        icon: SvgPicture.asset(AppIcons.next),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

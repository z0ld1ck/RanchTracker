import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:malshy/core/const/app_icons.dart';
import 'package:malshy/core/navigation/route_names.dart';

import '../../../../core/const/app_colors.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
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
                          context.pushNamed(RouteNames.internalMovements.name);
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
                          context.pushNamed(RouteNames.prevention.name);

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
                          context.pushNamed(RouteNames.treatment.name);

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
                          context.pushNamed(RouteNames.weight.name);

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
                          context.pushNamed(RouteNames.sales.name);

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
                          context.pushNamed(RouteNames.slaughter.name);

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
                          context.pushNamed(RouteNames.loss.name);

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
                          context.pushNamed(RouteNames.pregnancy.name);

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

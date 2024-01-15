import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:malshy/core/const/app_colors.dart';
import 'package:malshy/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:malshy/core/widgets/show_date_range_time_picker_dialog.dart';
import 'package:malshy/features/dashboard/presentation/widgets/dashboard_doughnut_chart_widget.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DashboardByTypeBloc>(
          create: (context) => DashboardBloc()..add(DashboardEvent.loadByType()),
        ),
        BlocProvider<DashboardByStatusBloc>(
          create: (context) => DashboardBloc()..add(DashboardEvent.loadByStatus()),
        ),
        BlocProvider<DashboardByActionBloc>(
          create: (context) => DashboardBloc()..add(DashboardEvent.loadByAction()),
        ),
      ],
      child: Builder(builder: (context) {
        return SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // date range picker
                  InkWell(
                    onTap: () async {
                      // date range picker
                      await showDateRangeTimePicker(
                        context: context,
                        initialDates: [DateTime.now(), DateTime.now()],
                        onSelect: (dates) {},
                      );
                    },
                    splashFactory: NoSplash.splashFactory,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                      decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(12.r)),
                      child: Row(
                        children: [
                          SvgPicture.asset('assets/icons/calendar.svg', width: 24.w),
                          SizedBox(width: 8.w),
                          Expanded(child: Text('Выберите дату')),
                          SvgPicture.asset('assets/icons/download_image.svg', width: 24.w),
                        ],
                      ),
                    ),
                  ).paddingSymmetric(vertical: 16.h),
                  // по статусу и типу
                  Container(
                    decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(12.r)),
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Column(
                      children: [
                        TabBar(
                          onTap: (index) {
                            setState(() {});
                          },
                          controller: _tabController,
                          indicatorWeight: 4.h,
                          labelColor: AppColors.primary(context),
                          labelStyle: TextStyle(
                            color: Color(0xFF2EA1D9),
                            fontSize: 14,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                          ),
                          unselectedLabelStyle: TextStyle(
                            color: Color(0xFFA7A7A7),
                            fontSize: 14,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                          ),
                          tabs: const [
                            Tab(text: 'По статусу'),
                            Tab(text: 'По типу'),
                          ],
                        ).paddingOnly(bottom: 16.h),
                        SizedBox(
                          height: 255.h,
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              BlocBuilder<DashboardByStatusBloc, DashboardState>(
                                builder: (context, state) {
                                  switch (state.status) {
                                    case DashboardStateStatus.loading:
                                      return DashboardDoughnutChartWidget(
                                        data: [for (int i = 0; i < 3; i++) DashboardDoughnutChartData('', 1)],
                                      ).applyShimmer();
                                    case DashboardStateStatus.error:
                                      return Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('Произошла ошибка').paddingOnly(bottom: 16.h),
                                          InkWell(
                                            onTap: () {
                                              context.read<DashboardByStatusBloc>().add(DashboardEvent.loadByStatus());
                                            },
                                            borderRadius: BorderRadius.circular(100),
                                            child: Container(
                                              width: 45.h,
                                              height: 45.h,
                                              decoration: BoxDecoration(
                                                color: AppColors.primary(context),
                                                borderRadius: BorderRadius.circular(ScreenUtil().setHeight(24.0)),
                                              ),
                                              child: const Center(
                                                child: Icon(
                                                  Icons.rotate_left,
                                                  color: AppColors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    case DashboardStateStatus.empty:
                                      return Center(
                                        child: Padding(
                                          padding: const EdgeInsets.only(top: 16.0, left: 24, right: 24),
                                          child: Text(
                                            'Нет данных',
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      );
                                    case DashboardStateStatus.success:
                                      return DashboardDoughnutChartWidget(
                                        data: state.byStatus
                                                ?.map(
                                                  (e) => DashboardDoughnutChartData(
                                                    e.status.ru,
                                                    e.count,
                                                  ),
                                                )
                                                .toList() ??
                                            [],
                                      );
                                  }
                                },
                              ),
                              BlocBuilder<DashboardByTypeBloc, DashboardState>(
                                builder: (context, state) {
                                  switch (state.status) {
                                    case DashboardStateStatus.loading:
                                      return DashboardDoughnutChartWidget(
                                        data: [for (int i = 0; i < 3; i++) DashboardDoughnutChartData('', 1)],
                                      ).applyShimmer();
                                    case DashboardStateStatus.error:
                                      return Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('Произошла ошибка').paddingOnly(bottom: 16.h),
                                          InkWell(
                                            onTap: () {
                                              context.read<DashboardByTypeBloc>().add(DashboardEvent.loadByType());
                                            },
                                            borderRadius: BorderRadius.circular(100),
                                            child: Container(
                                              width: 45.h,
                                              height: 45.h,
                                              decoration: BoxDecoration(
                                                color: AppColors.primary(context),
                                                borderRadius: BorderRadius.circular(ScreenUtil().setHeight(24.0)),
                                              ),
                                              child: const Center(
                                                child: Icon(
                                                  Icons.rotate_left,
                                                  color: AppColors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    case DashboardStateStatus.empty:
                                      return Center(
                                        child: Padding(
                                          padding: const EdgeInsets.only(top: 16.0, left: 24, right: 24),
                                          child: Text(
                                            'Нет данных',
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      );
                                    case DashboardStateStatus.success:
                                      return DashboardDoughnutChartWidget(
                                        data: state.byType
                                                ?.map(
                                                  (e) => DashboardDoughnutChartData(
                                                    e.type.ru,
                                                    e.count,
                                                  ),
                                                )
                                                .toList() ??
                                            [],
                                      );
                                  }
                                },
                              ),
                            ],
                          ).paddingOnly(bottom: 10.h),
                        ),
                      ],
                    ),
                  ).paddingOnly(bottom: 16.h),
                  // by action
                  BlocBuilder<DashboardByActionBloc, DashboardState>(
                    builder: (context, state) {
                      switch (state.status) {
                        case DashboardStateStatus.loading:
                          return GridView.count(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            crossAxisCount: 2,
                            childAspectRatio: 2.7131147541,
                            crossAxisSpacing: 12.w,
                            mainAxisSpacing: 8.h,
                            children: [
                              for (int i = 0; i < 8; i++) _buildTile(title: 'asdf', value: 'asdf'),
                            ],
                          ).applyShimmer();
                        case DashboardStateStatus.error:
                          return Container(
                            width: double.infinity,
                            decoration:
                                BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(12.r)),
                            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Произошла ошибка').paddingOnly(bottom: 16.h),
                                InkWell(
                                  onTap: () {
                                    context.read<DashboardByActionBloc>().add(DashboardEvent.loadByAction());
                                  },
                                  borderRadius: BorderRadius.circular(100),
                                  child: Container(
                                    width: 45.h,
                                    height: 45.h,
                                    decoration: BoxDecoration(
                                      color: AppColors.primary(context),
                                      borderRadius: BorderRadius.circular(ScreenUtil().setHeight(24.0)),
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.rotate_left,
                                        color: AppColors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        case DashboardStateStatus.empty:
                          return Container(
                            width: double.infinity,
                            decoration:
                                BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(12.r)),
                            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                            child: Text(
                              'Нет данных',
                              textAlign: TextAlign.center,
                            ),
                          );
                        case DashboardStateStatus.success:
                          return GridView.count(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            crossAxisCount: 2,
                            childAspectRatio: 2.7131147541,
                            crossAxisSpacing: 12.w,
                            mainAxisSpacing: 8.h,
                            children: [
                              _buildTile(title: 'Продажа', value: state.byAction?.sales.toString() ?? '-'),
                              _buildTile(title: 'Покупка', value: state.byAction?.buy.toString() ?? '-'),
                              _buildTile(title: 'Приплод', value: state.byAction?.born.toString() ?? '-'),
                              _buildTile(title: 'Падеж', value: state.byAction?.dead.toString() ?? '-'),
                              _buildTile(title: 'Забой', value: state.byAction?.slaughter.toString() ?? '-'),
                              _buildTile(title: 'Утеря', value: state.byAction?.lost.toString() ?? '-'),
                              _buildTile(title: 'В изолятор', value: state.byAction?.toIsolation.toString() ?? '-'),
                              _buildTile(title: 'Из изолятор', value: state.byAction?.fromIsolation.toString() ?? '-'),
                            ],
                          );
                      }
                    },
                  ),
                ],
              ).paddingSymmetric(horizontal: 16.w),
            ),
          ),
        );
      }),
    );
  }

  Container _buildTile({required String title, required String value}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            value,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0x993C3C43),
              fontSize: 16,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

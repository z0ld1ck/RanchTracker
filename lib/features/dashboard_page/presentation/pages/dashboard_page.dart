import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:malshy/core/const/app_colors.dart';
import 'package:malshy/features/dashboard_page/presentation/pages/asdf.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 16.h),
                InkWell(
                  onTap: () {
                    // date range picker
                    showDateRangeTimePicker(
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
                ),
                SizedBox(height: 16.h),
                ChartWidget(),
                SizedBox(height: 16.h),
                GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  childAspectRatio: 2.7131147541,
                  crossAxisSpacing: 12.w,
                  mainAxisSpacing: 8.h,
                  children: [
                    _buildTile(title: 'asdf', value: 'asdf'),
                    _buildTile(title: 'asdf', value: 'asdf'),
                    _buildTile(title: 'asdf', value: 'asdf'),
                    _buildTile(title: 'asdf', value: 'asdf'),
                    _buildTile(title: 'asdf', value: 'asdf'),
                    _buildTile(title: 'asdf', value: 'asdf'),
                    _buildTile(title: 'asdf', value: 'asdf'),
                    _buildTile(title: 'asdf', value: 'asdf'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
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

class ChartWidget extends StatefulWidget {
  const ChartWidget({
    super.key,
  });

  @override
  State<ChartWidget> createState() => _ChartWidgetState();
}

class _ChartWidgetState extends State<ChartWidget> with TickerProviderStateMixin {
  late List<_ChartData> data;
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    data = [
      _ChartData('David', 25, Colors.red),
      _ChartData('Steve', 38, Colors.blue),
      _ChartData('Jack', 34, Colors.orange),
      _ChartData('Others', 52, Colors.green),
      _ChartData('David', 25, Colors.pink),
    ];
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(12.r)),
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Column(
        children: [
          TabBar(
            onTap: (index) {
              data = index == 1
                  ? [
                      _ChartData('David', 25, Colors.red),
                      _ChartData('Steve', 38, Colors.blue),
                      _ChartData('Jack', 34, Colors.orange),
                      _ChartData('Others', 52, Colors.green),
                      _ChartData('David', 25, Colors.pink),
                    ]
                  : [
                      _ChartData('Fasdfid', 14, Colors.red),
                      _ChartData('Fasdfve', 81, Colors.blue),
                      _ChartData('Fasdfk', 35, Colors.orange),
                      _ChartData('Fasdfers', 59, Colors.green),
                      _ChartData('Fasdfid', 24, Colors.pink),
                    ];
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
          ),
          SizedBox(height: 16.h),
          SizedBox(
            height: 245.h,
            child: SfCircularChart(
              margin: EdgeInsets.all(0),
              legend: Legend(
                position: LegendPosition.bottom,
                legendItemBuilder: (
                  String name,
                  ChartSeries<dynamic, dynamic>? series,
                  ChartPoint<dynamic> point,
                  int index,
                ) {
                  return Row(
                    children: [
                      Container(
                        width: 10.w,
                        height: 10.w,
                        decoration: ShapeDecoration(
                          color: data[index].color, //point.color ?? Colors.orange,
                          shape: OvalBorder(),
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Text(name),
                    ],
                  );
                },
                isVisible: true,
                borderWidth: 0,
              ),
              annotations: <CircularChartAnnotation>[
                CircularChartAnnotation(
                  widget: RichText(
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    text: TextSpan(
                      text: 'Total',
                      style: TextStyle(
                        color: Color(0xFF878882),
                        fontSize: 20,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                      ),
                      children: const [
                        TextSpan(
                          text: '\n3',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              series: <CircularSeries<_ChartData, String>>[
                DoughnutSeries<_ChartData, String>(
                  animationDuration: 700,
                  dataSource: data,
                  xValueMapper: (_ChartData data, _) => data.x,
                  yValueMapper: (_ChartData data, _) => data.y,
                  pointColorMapper: (datum, index) => datum.color,
                  radius: '100%',
                )
              ],
            ),
          ),
          SizedBox(height: 10.h),
        ],
      ),
    );
  }
}

class _ChartData {
  _ChartData(this.x, this.y, this.color);

  final String x;
  final double y;
  final Color color;
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DashboardDoughnutChartWidget extends StatefulWidget {
  const DashboardDoughnutChartWidget({
    super.key,
    required this.data,
  });

  final List<DashboardDoughnutChartData> data;

  @override
  State<DashboardDoughnutChartWidget> createState() => _DashboardDoughnutChartWidgetState();
}

class _DashboardDoughnutChartWidgetState extends State<DashboardDoughnutChartWidget> {
  @override
  Widget build(BuildContext context) {
    return SfCircularChart(
      margin: EdgeInsets.all(0),
      legend: Legend(
        position: LegendPosition.bottom,
        toggleSeriesVisibility: false,
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
                  color: point.color ?? Colors.red,
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
              children: [
                TextSpan(
                  text: '\n${widget.data.map((e) => e.y).reduce((a, b) => a + b)}',
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
      series: <CircularSeries<DashboardDoughnutChartData, String>>[
        DoughnutSeries<DashboardDoughnutChartData, String>(
          animationDuration: 700,
          dataSource: widget.data,
          xValueMapper: (DashboardDoughnutChartData data, _) => data.x,
          yValueMapper: (DashboardDoughnutChartData data, _) => data.y,
          radius: '100%',
        )
      ],
    );
  }
}

class DashboardDoughnutChartData {
  DashboardDoughnutChartData(this.x, this.y);

  final String x;
  final int y;
}

import 'package:bounty_hunter/models/shop_entity.dart';
import 'package:bounty_hunter/shop/widgets/resources/app_colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class _LineChart extends StatelessWidget {
  const _LineChart({required this.isShowingMainData, required this.trends});

  final bool isShowingMainData;
  final List<ShopDataTrends> trends;

  @override
  Widget build(BuildContext context) {
    return LineChart(
      sampleData2,
      duration: const Duration(milliseconds: 250),
    );
  }

  LineChartData get sampleData2 => LineChartData(
        lineTouchData: lineTouchData2,
        gridData: gridData,
        titlesData: titlesData2,
        borderData: borderData,
        lineBarsData: lineBarsData2,
        minX: 0,
        maxX: 26,
        maxY: trends.isEmpty
            ? 6
            : trends.map((trend) => trend.eRepaymentCount ?? 0).reduce((a, b) => a > b ? a : b).toDouble(),
        minY: 0,
      );

  LineTouchData get lineTouchData1 => LineTouchData(
        handleBuiltInTouches: true,
 
      );

  FlTitlesData get titlesData1 => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(),
        ),
      );



  LineTouchData get lineTouchData2 => const LineTouchData(
        enabled: false,
      );

  FlTitlesData get titlesData2 => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(),
        ),
      );

  List<LineChartBarData> get lineBarsData2 => [
        lineChartBarData2_1,
      ];

  List<FlSpot> get trendSpots {
    final List<ShopDataTrends> sortedTrends = List.from(trends)
      ..sort((a, b) => (a.bHour ?? 0).compareTo(b.bHour ?? 0));

    return sortedTrends
        .map((trend) => FlSpot(
              (trend.bHour ?? 0).toDouble(),
              (trend.eRepaymentCount ?? 0).toDouble(),
            ))
        .toList();
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text = switch (value.toInt()) {
      1 => '',
      2 => '',
      3 => '',
      4 => '',
      5 => '',
      _ => '',
    };
    return Text(
        text,
        style: style,
        textAlign: TextAlign.center,
      );
  }

  SideTitles leftTitles() => SideTitles(
        getTitlesWidget: leftTitleWidgets,
        showTitles: true,
        interval: 1,
        reservedSize: 40,
      );

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      // fontWeight: FontWeight.bold,
      fontSize: 12,
    );
    String text = switch (value.toInt()) {
      0 => '00:00',
      3 => '03:00',
      6 => '06:00',
      9 => '09:00',
      12 => '12:00',
      15 => '15:00',
      18 => '18:00',
      21 => '21:00',
      24 => '24:00',
      _ => '',
    };

    return Text(text, style: style);
  }

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 32,
        interval: 1,
        getTitlesWidget: bottomTitleWidgets,
      );

  FlGridData get gridData => const FlGridData(show: false);

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: Border(
          bottom: BorderSide(
              color: AppColors.primary, width: 4),
          left: const BorderSide(color: Colors.transparent),
          right: const BorderSide(color: Colors.transparent),
          top: const BorderSide(color: Colors.transparent),
        ),
      );

  

  LineChartBarData get lineChartBarData2_1 => LineChartBarData(
        isCurved: true,
        // curveSmoothness: 0,
        color: AppColors.contentColorGreen,
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(
          show: true,
          color: AppColors.contentColorGreen.withOpacity(0.5),
        ),
        spots: trendSpots.isEmpty
            ? const [
                FlSpot(1, 2),
                FlSpot(2, 1),
                FlSpot(3, 0),
                FlSpot(4, 0),
                FlSpot(5, 0),
                FlSpot(6, 1),
                FlSpot(7, 2),
                FlSpot(8, 3),
                FlSpot(9, 5),
                FlSpot(10, 4),
                FlSpot(11, 2),
                FlSpot(12, 1),
                FlSpot(13, 3),
                FlSpot(14, 5),
                FlSpot(15, 6),
                FlSpot(16, 6),
                FlSpot(17, 2),
                FlSpot(18, 3),
                FlSpot(19, 6),
                FlSpot(20, 4),
                FlSpot(21, 2),
                FlSpot(22, 2),
                FlSpot(23, 3),
                FlSpot(24, 1),
              ]
            : trendSpots,
      );

}

class LineChartTrend extends StatefulWidget {
  const LineChartTrend({super.key, required this.trends, required this.title});

  final List<ShopDataTrends> trends;
  final String title;

  @override
  State<StatefulWidget> createState() => LineChartTrendState();
}

class LineChartTrendState extends State<LineChartTrend> {
  late bool isShowingMainData;

  @override
  void initState() {
    super.initState();
    isShowingMainData = true;
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.73,
      child: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(
                height: 3,
              ),
               Text(
                widget.title,
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 8,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 16, left: 6),
                  child: _LineChart(
                    isShowingMainData: false,
                    trends: widget.trends,
                  ),
                ),
              ),
              const SizedBox(
                height: 3,
              ),
            ],
          ),

        ],
      ),
    );
  }
}
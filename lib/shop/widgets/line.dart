// import 'package:fl_chart_app/presentation/resources/app_resources.dart';
import 'package:bounty_hunter/shop/widgets/resources/app_colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'bar_chart_sample7.dart';
const dateString = [
  '01/03',
  '02/03',
  '03/03',
  '04/03',
  '05/03',
  '06/03',
  '07/03',
  '08/03',
  '09/03',
  '10/03',
  '11/03',
  '12/03',
  '13/03',
  '14/03',
  '15/03',
  '16/03',
  '17/03',
  '18/03',
  '19/03',
  '20/03',
  '21/03',
  '22/03',
  '23/03',
  '24/03',
  '25/03',
  '26/03',
  '27/03',
  '28/03',
  '29/03',
  '30/03',
];
class _LineChart extends StatelessWidget {
  const _LineChart({required this.isShowingMainData});

  final bool isShowingMainData;

  @override
  Widget build(BuildContext context) {
    return isShowingMainData ? LineChart(
       sampleData1 ,
      duration: const Duration(milliseconds: 250),
    ) : BarChartSample7();
  }

  LineChartData get sampleData1 => LineChartData(
    lineTouchData: lineTouchData1,
    gridData: gridData,
    titlesData: titlesData1,
    borderData: borderData,
    lineBarsData: lineBarsData1,
    minX: 0,
    maxX: 27,
    maxY: 30,
    minY: 0,
  );

  LineTouchData get lineTouchData1 => LineTouchData(
    handleBuiltInTouches: true,
    touchTooltipData: LineTouchTooltipData(
      tooltipBgColor: Colors.blueGrey.withOpacity(0.6),
      tooltipHorizontalAlignment: FLHorizontalAlignment.right,
      tooltipMargin: -10,
      getTooltipItems: (touchedSpots) {
        return touchedSpots.map((LineBarSpot touchedSpot) {
          final textStyle = TextStyle(
            color: Colors.white ??
                touchedSpot.bar.color ??
                Colors.blueGrey,
            fontSize: 14,
          );
          return LineTooltipItem('${dateString[touchedSpot.x.toInt()]}\n', textStyle,children: [TextSpan(text: touchedSpot.y.toInt().toString(), style: const TextStyle(fontSize: 16.0,))]);
        }).toList();
      },

    ),
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
    leftTitles: const AxisTitles(
      drawBelowEverything: true,
      sideTitles: SideTitles(
        showTitles: true,
        reservedSize: 40,
      ),
    ),
  );

  List<LineChartBarData> get lineBarsData1 => [
    lineChartBarData1_1,

  ];


  SideTitles get bottomTitles => SideTitles(
    showTitles: false,
    reservedSize: 32,
    interval: 1,
  );

  FlGridData get gridData => const FlGridData(show: false);

  FlBorderData get borderData => FlBorderData(
    show: true,
    border: Border(
      bottom:
      BorderSide(color: AppColors.primary.withOpacity(0.2), width: 4),
      left: const BorderSide(color: Colors.transparent),
      right: const BorderSide(color: Colors.transparent),
      top: const BorderSide(color: Colors.transparent),
    ),
  );

  LineChartBarData get lineChartBarData1_1 => LineChartBarData(
    isCurved: true,
    color: Colors.blueAccent,
    barWidth: 2,
    isStrokeCapRound: true,
    dotData: const FlDotData(show: true),
    belowBarData: BarAreaData(show: true,          gradient: LinearGradient(
      colors: [
        Colors.blueAccent.withOpacity(0.1),
        Colors.blueAccent.withOpacity(0.2),
        Colors.blueAccent.withOpacity(0.4),
        Colors.blueAccent.withOpacity(0.6),
      ],
    ),),
    shadow: const Shadow(
      blurRadius: 0,
    ),
    spots: const [
      FlSpot(1, 11),
      FlSpot(2, 15),
      FlSpot(3, 16),
      FlSpot(4, 17),
      FlSpot(5, 15),
      FlSpot(6, 21),
      FlSpot(7, 22),
      FlSpot(8, 23),
      FlSpot(9, 25),
      FlSpot(10, 24),
      FlSpot(11, 21),
      FlSpot(12, 19),
      FlSpot(13, 17),
      FlSpot(14, 20),
      FlSpot(15, 21),
      FlSpot(16, 23),
      FlSpot(17, 26),
      FlSpot(18, 22),
      FlSpot(19, 25),
      FlSpot(20, 25),
      FlSpot(21, 21),
      FlSpot(22, 21),
      FlSpot(23, 22),
      FlSpot(24, 24),
      FlSpot(25, 21),
      FlSpot(26, 27),
      FlSpot(27, 21),
      FlSpot(28, 11),
    ],
  );

}

class LineChartSample1 extends StatefulWidget {
  const LineChartSample1({super.key});

  @override
  State<StatefulWidget> createState() => LineChartSample1State();
}

class LineChartSample1State extends State<LineChartSample1> {
  late bool isShowingMainData;

  @override
  void initState() {
    super.initState();
    isShowingMainData = true;
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.83,
      child: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(
                height: 17,
              ),
              Text(
                isShowingMainData ? 'Monthly Bounty' : 'Week Rank',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  // fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 17,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 16, left: 6),
                  child: _LineChart(isShowingMainData: isShowingMainData),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
          IconButton(
            icon: Icon(
              isShowingMainData ? Icons.stacked_bar_chart : Icons.stacked_line_chart,
              color: Colors.white.withOpacity(isShowingMainData ? 1.0 : 0.5),
            ),
            onPressed: () {
              setState(() {
                isShowingMainData = !isShowingMainData;
              });
            },
          )
        ],
      ),
    );
  }
}
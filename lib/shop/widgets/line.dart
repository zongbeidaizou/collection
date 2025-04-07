// import 'package:fl_chart_app/presentation/resources/app_resources.dart';
import 'package:bounty_hunter/shop/widgets/resources/app_colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../models/shop_entity.dart';
import 'bar_chart_sample7.dart';

const List<Map<String, dynamic>> lineData = [
  {'date':'01/03','value':12},
  {'date':'02/03','value':16},
  {'date':'03/03','value':17},
  {'date':'04/03','value':16},
  {'date':'05/03','value':19},
  {'date':'06/03','value':22},
  {'date':'07/03','value':22},
  {'date':'08/03','value':21},
  {'date':'09/03','value':23},
  {'date':'10/03','value':21},
  {'date':'11/03','value':25},
  {'date':'12/03','value':20},
  {'date':'13/03','value':22},
  {'date':'14/03','value':21},
  {'date':'15/03','value':12},
  {'date':'16/03','value':22},
  {'date':'17/03','value':12},
  {'date':'18/03','value':22},
  {'date':'19/03','value':24},
  {'date':'20/03','value':21},
  {'date':'21/03','value':19},
  {'date':'22/03','value':22},
  {'date':'23/03','value':16},
  {'date':'24/03','value':24},
  {'date':'25/03','value':19},
  {'date':'26/03','value':22},
  {'date':'27/03','value':23},
  {'date':'28/03','value':24},
  {'date':'29/03','value':23},
  {'date':'30/03','value':22},
];

const List<Map<String, dynamic>> lineData2 = [
  {'date':'01/03','value':1200},
  {'date':'02/03','value':1600},
  {'date':'03/03','value':1700},
  {'date':'04/03','value':1600},
  {'date':'05/03','value':1900},
  {'date':'06/03','value':3100},
  {'date':'07/03','value':2000},
  {'date':'08/03','value':2100},
  {'date':'09/03','value':2300},
  {'date':'10/03','value':2100},
  {'date':'11/03','value':3300},
  {'date':'12/03','value':2000},
  {'date':'13/03','value':2200},
  {'date':'14/03','value':2100},
  {'date':'15/03','value':1200},
  {'date':'16/03','value':2200},
  {'date':'17/03','value':1200},
  {'date':'18/03','value':2200},
  {'date':'19/03','value':2400},
  {'date':'20/03','value':2100},
  {'date':'21/03','value':1900},
  {'date':'22/03','value':2200},
  {'date':'23/03','value':1600},
  {'date':'24/03','value':2900},
  {'date':'25/03','value':1900},
  {'date':'26/03','value':2200},
  {'date':'27/03','value':2300},
  {'date':'28/03','value':2400},
  {'date':'29/03','value':2300},
  {'date':'30/03','value':2200},
];

class _LineChart extends StatelessWidget {
  const _LineChart({required this.isShowingMainData, required this.monthCaseData, required this.monthBonusData});

  final bool isShowingMainData;
  final List<ShopDataMonthCaseData> monthCaseData;
  final List<ShopDataMonthBonusData> monthBonusData;

  @override
  Widget build(BuildContext context) {
    return LineChart(
      isShowingMainData ?   sampleData2 : sampleData1,
      duration: const Duration(milliseconds: 250),
    );
  }

  LineChartData get sampleData1 => LineChartData(
    lineTouchData: lineTouchData1,
    gridData: gridData,
    titlesData: titlesData1,
    borderData: borderData,
    lineBarsData: lineBarsData1,
    minX: 0,
    maxX: 27,
    maxY: 40,
    minY: 0,
  );
  LineChartData get sampleData2 => LineChartData(
    lineTouchData: lineTouchData2,
    gridData: gridData,
    titlesData: titlesData2,
    borderData: borderData,
    lineBarsData: lineBarsData2,
    minX: 0,
    maxX: 27,
    maxY: 4000,
    minY: 0,
  );
  LineTouchData get lineTouchData2{
    List<String> dates = monthBonusData.map((item) => item.date!).toList();
    return  LineTouchData(
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
            return LineTooltipItem('${dates[touchedSpot.x.toInt()]}\n', textStyle,children: [TextSpan(text: touchedSpot.y.toInt().toString(), style: const TextStyle(fontSize: 16.0,))]);
          }).toList();
        },

      ),
    );}

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
    leftTitles: const AxisTitles(
      drawBelowEverything: true,
      sideTitles: SideTitles(
        showTitles: true,
        reservedSize: 40,
      ),
    ),
  );

  List<LineChartBarData> get lineBarsData2 => [
    lineChartBarData2_1,

  ];
  LineChartBarData get lineChartBarData2_1 => LineChartBarData(
    isCurved: true,
    // curveSmoothness: 0,
    // color: AppColors.contentColorGreen.withOpacity(0.5),
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
    spots: monthBonusData.asMap().map((index, item) => MapEntry(
      index,
      FlSpot(
        index.toDouble(), // x值从0开始递增
        item.value!.toDouble(), // y值取value
      ),
    ))
        .values
        .toList(),
  );


  LineTouchData get lineTouchData1{
    List<String> dates = monthCaseData.map((item) => item.date!).toList();
    return  LineTouchData(
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
          return LineTooltipItem('${dates[touchedSpot.x.toInt()]}\n', textStyle,children: [TextSpan(text: touchedSpot.y.toInt().toString(), style: const TextStyle(fontSize: 16.0,))]);
        }).toList();
      },

    ),
  );}

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

  FlBorderData get borderData{
    return FlBorderData(
      show: true,
      border: Border(
        bottom:
        BorderSide(color: AppColors.primary.withOpacity(0.2), width: 4),
        left: const BorderSide(color: Colors.transparent),
        right: const BorderSide(color: Colors.transparent),
        top: const BorderSide(color: Colors.transparent),
      ),
    );
  }

  LineChartBarData get lineChartBarData1_1{return  LineChartBarData(
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
    spots: monthCaseData.asMap().map((index, item) => MapEntry(
      index,
      FlSpot(
        index.toDouble(), // x值从0开始递增
        item.value!.toDouble(), // y值取value
      ),
    ))
        .values
        .toList(),
  );}

}

class LineChartSample1 extends StatefulWidget {
  const LineChartSample1({super.key, required this.monthCaseData, required this.monthBonusData, required this.isShowingMainData});
  final List<ShopDataMonthCaseData> monthCaseData;
  final List<ShopDataMonthBonusData> monthBonusData;
  final bool isShowingMainData;

  @override
  State<StatefulWidget> createState() => LineChartSample1State();
}

class LineChartSample1State extends State<LineChartSample1> {
  // bool _isShowingMainData;

  @override
  void initState() {
    super.initState();
    // _isShowingMainData = widget.isShowingMainData;
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
                widget.isShowingMainData ? 'My Daily Bonus Earnings Trend' : 'My Daily Case Recovery Trend',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 1,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 17,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 26, left: 6),
                  child: _LineChart(isShowingMainData: widget.isShowingMainData, monthBonusData: widget.monthBonusData, monthCaseData: widget.monthCaseData,),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
          IconButton(
            icon: Icon(
              // Icon(Icons.diamond_outlined)
              // Icon(Icons.equalizer_outlined)
              // Icon(Icons.123)
              // Icon(Icons.apps)
              // Icon(Icons.bubble_chart)
              // Icon(Icons.data_exploration)
              // Icon(Icons.leaderboard)
              // Icon(Icons.verified)
              // Icon(Icons.workspace_premium)
              // Icon(Icons.shuffle_on)
              // Icon(Icons.bubble_chart_outlined)
              widget.isShowingMainData ? Icons.diamond_outlined : Icons.bubble_chart_outlined,
              color: Colors.white.withOpacity(0.6),
            ),
            onPressed: () {
              // setState(() {
              //   // _isShowingMainData = !_isShowingMainData;
              // });
            },
          )
        ],
      ),
    );
  }
}
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../models/shop_entity.dart';
import 'LegendsListWidget.dart';
import 'app_colors.dart';

class BarChartSample6 extends StatelessWidget {
  const BarChartSample6({super.key, required this.data});
  final List<ShopDataWeekBonusData> data;

  final bColor = AppColors.contentColorCyan;
  final aColor = Colors.blue;
  final aaColor = Colors.lightBlue;
  final aaaColor = AppColors.contentColorBlue;

  final betweenSpace = 0;

  BarChartGroupData generateGroupData(
    int x,
    double b,
    double a,
    double aa,
    double aaa,
  ) {
    return BarChartGroupData(
      x: x,
      groupVertically: true,
      showingTooltipIndicators: [3],
      barRods: [
        BarChartRodData(
          fromY: 0,
          toY: b,
          color: Colors.blue[100],
          // width: 15,
        ),
        BarChartRodData(
          fromY: b + betweenSpace,
          toY: b + betweenSpace + a,
          color: Colors.blue[200],
          // width: 5,
        ),
        BarChartRodData(
          fromY: b + betweenSpace + a + betweenSpace,
          toY: b + betweenSpace + a + betweenSpace + aa,
          color: Colors.blue[400],
          // width: 5,
        ),
        BarChartRodData(
          fromY: b + betweenSpace + a + betweenSpace + aa + betweenSpace,
          toY: b + betweenSpace + a + betweenSpace + aa + betweenSpace + aaa,
          color: Colors.blue[600],
          // width: 5,
        ),
      ],
    );
  }
  String formatNumberToK(int number) {
    if (number < 1000) {
      return number.toString(); // 小于1000直接返回原数字
    }

    double result = number / 1000;
    // 处理小数部分（避免四舍五入后显示.0时仍保留一位小数）
    if (result == result.truncate()) {
      return '${result.truncate()}K'; // 无小数的情况
    } else {
      return '${result.toStringAsFixed(1)}K'; // 保留一位小数
    }
  }
  Widget bottomTitles(double value, TitleMeta meta) {
    final style = TextStyle(
      color: AppColors.contentColorBlue,
      fontWeight: FontWeight.bold,
      fontSize: data.length > 5 ? 6 : 14,
    );
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      // child: Text(data[value.toInt()].name!, style: style),
      child: RichText(text: TextSpan(children: [
        TextSpan(text: data[value.toInt()].name!, style: style),
        if (data[value.toInt()].addition! > 0)
          const TextSpan(text: '+', style: TextStyle(color:  Colors.green)),
        if (data[value.toInt()].addition! > 0)
          TextSpan(text: formatNumberToK(data[value.toInt()].addition!), style: const TextStyle(color:  Colors.green)),
      ]),),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 14),
          AspectRatio(
            aspectRatio: 2.13,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceBetween,
                titlesData: FlTitlesData(
                  leftTitles: const AxisTitles(
                    drawBelowEverything: true,
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                    ),
                  ),
                  rightTitles: const AxisTitles(),
                  topTitles: const AxisTitles(),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: bottomTitles,
                      reservedSize: 20,
                    ),
                  ),
                ),
                barTouchData: BarTouchData(
                  enabled: true,
                  handleBuiltInTouches: true,
                  touchTooltipData: BarTouchTooltipData(
                    tooltipBgColor: Colors.transparent,
                    tooltipPadding: EdgeInsets.zero,
                    tooltipMargin: 18,
                    getTooltipItem: (
                      BarChartGroupData group,
                      int groupIndex,
                      BarChartRodData rod,
                      int rodIndex,
                    ) {
                      return BarTooltipItem(
                        rod.toY.round().toString(),
                        const TextStyle(
                          color: AppColors.contentColorBlue,
                          // color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),
                ),
                borderData: FlBorderData(show: false),
                gridData: const FlGridData(show: false),
                barGroups: data.asMap().entries.map((entry) {
                  final index = entry.key;
                  final item = entry.value;
                  final gradeValues = item.gradeValues ?? [];

                  // Make sure there are at least 4 values, fill with 0 if not
                  final value1 = gradeValues.isNotEmpty ? gradeValues[0] : 0;
                  final value2 = gradeValues.length > 1 ? gradeValues[1] : 0;
                  final value3 = gradeValues.length > 2 ? gradeValues[2] : 0;
                  final value4 = gradeValues.length > 3 ? gradeValues[3] : 0;

                  return generateGroupData(
                    index,
                    value1.toDouble(),
                    value2.toDouble(),
                    value3.toDouble(),
                    value4.toDouble(),
                  );
                }).toList(),
                maxY: 40000,
                extraLinesData: ExtraLinesData(
                  horizontalLines: [
                    // HorizontalLine(
                    //   y: 0,
                    //   color: Colors.white,
                    //   strokeWidth: 2,
                    //   dashArray: [20, 4],
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

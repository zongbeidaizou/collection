import 'dart:math' as math;

import 'package:bounty_hunter/shop/widgets/resources/app_colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarChartSample7 extends StatefulWidget {
  BarChartSample7({super.key});

  final shadowColor = const Color(0xFFCCCCCC);
  final dataList = [
    const _BarData(AppColors.contentColorYellow, 18, 18),
    const _BarData(AppColors.contentColorGreen, 17, 8),
    const _BarData(AppColors.contentColorOrange, 10, 15),
    const _BarData(AppColors.contentColorPink, 2.5, 5),
    const _BarData(AppColors.contentColorBlue, 2, 2.5),
    const _BarData(AppColors.contentColorRed, 2, 2),
  ];

  @override
  State<BarChartSample7> createState() => _BarChartSample7State();
}

class _BarChartSample7State extends State<BarChartSample7> {
  BarChartGroupData generateBarGroup(
      int x,
      Color color,
      double value,
      double shadowValue,
      ) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: value,
          color: color,
          width: 6,
        ),
        BarChartRodData(
          toY: shadowValue,
          color: widget.shadowColor,
          width: 6,
        ),
      ],
      showingTooltipIndicators: touchedGroupIndex == x ? [0] : [],
    );
  }

  int touchedGroupIndex = -1;

  int rotationTurns = 1;

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceBetween,
        borderData: FlBorderData(
          show: true,
          border: Border.symmetric(
            horizontal: BorderSide(
              color: AppColors.borderColor,
            ),
          ),
        ),
        titlesData: FlTitlesData(
          show: true,
          leftTitles: const AxisTitles(
            drawBelowEverything: true,
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 36,
              getTitlesWidget: (value, meta) {
                final index = value.toInt();
                return Text("Jocab", style: TextStyle(color: widget.dataList[index].color),);
              },
            ),
          ),
          rightTitles: const AxisTitles(),
          topTitles: const AxisTitles(),
        ),
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          getDrawingHorizontalLine: (value) => FlLine(
            color: AppColors.borderColor,
            strokeWidth: 1,
          ),
        ),
        barGroups: widget.dataList.asMap().entries.map((e) {
          final index = e.key;
          final data = e.value;
          return generateBarGroup(
            index,
            data.color,
            data.value,
            data.shadowValue,
          );
        }).toList(),
        maxY: 20,
        barTouchData: BarTouchData(
          enabled: true,
          handleBuiltInTouches: false,
          touchTooltipData: BarTouchTooltipData(
            tooltipMargin: 0,
            getTooltipItem: (
                BarChartGroupData group,
                int groupIndex,
                BarChartRodData rod,
                int rodIndex,
                ) {
              return BarTooltipItem(
                rod.toY.toString(),
                TextStyle(
                  fontWeight: FontWeight.bold,
                  color: rod.color,
                  fontSize: 18,
                  shadows: const [
                    Shadow(
                      color: Colors.black26,
                      blurRadius: 12,
                    )
                  ],
                ),
              );
            },
          ),
          touchCallback: (event, response) {
            if (event.isInterestedForInteractions &&
                response != null &&
                response.spot != null) {
              setState(() {
                touchedGroupIndex = response.spot!.touchedBarGroupIndex;
              });
            } else {
              setState(() {
                touchedGroupIndex = -1;
              });
            }
          },
        ),
      ),
    );
  }
}

class _BarData {
  const _BarData(this.color, this.value, this.shadowValue);

  final Color color;
  final double value;
  final double shadowValue;
}



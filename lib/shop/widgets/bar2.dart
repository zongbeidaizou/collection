// import 'package:fl_chart_app/presentation/resources/app_resources.dart';
import 'package:bounty_hunter/shop/widgets/resources/LegendsListWidget.dart';
import 'package:bounty_hunter/shop/widgets/resources/app_colors.dart';
import 'package:bounty_hunter/shop/widgets/resources/bar_chart_sample6.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../models/shop_entity.dart';
import '../../res/gaps.dart';
import 'bar.dart';
import 'bar_chart_sample7.dart';
final pilateColor = Colors.grey;
final quickWorkoutColor = Colors.lightGreenAccent;
final cyclingColor = Colors.lightBlue;
final cyclingColor2 = Colors.lightGreen;

class _LineChart extends StatelessWidget {
  const _LineChart({required this.isShowingMainData, required this.weekCaseData, required this.weekBonusData});

  final bool isShowingMainData;
  final List<ShopDataWeekCaseData> weekCaseData;
  final List<ShopDataWeekBonusData> weekBonusData;

  @override
  Widget build(BuildContext context) {
    return isShowingMainData ? BarChartSample6(data: weekBonusData) : BarChartSample3(data: weekCaseData) ;
    // return isShowingMainData ? BarChartSample7(data: weekBonusData) : BarChartSample3(data: weekCaseData) ;
  }
}

class Bar2 extends StatefulWidget {
  const Bar2({super.key, required this.weekCaseData, required this.weekBonusData, required this.isShowingMainData});
  final List<ShopDataWeekCaseData> weekCaseData;
  final List<ShopDataWeekBonusData> weekBonusData;
  final bool isShowingMainData;

  @override
  State<StatefulWidget> createState() => Bar2State();
}

class Bar2State extends State<Bar2> {
  // late bool isShowingMainData;

  @override
  void initState() {
    super.initState();
    // isShowingMainData = true;
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: widget.isShowingMainData ? 1.43 : 1.83,
      child: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(
                height: 17,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Gaps.hGap16,
                  Expanded(
                    child: Text(
                      widget.isShowingMainData ? 'Live Weekly Bonus' : 'Live Weekly Case Rankings',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  // widget.isShowingMainData ? Gaps.hGap8: Gaps.empty,
                  widget.isShowingMainData ? LegendsListWidget(
                    legends: [
                      Legend('B', Colors.blue[100]!),
                      Legend('A', Colors.blue[200]!),
                      Legend('A+', Colors.blue[400]!),
                      Legend('A++', Colors.blue[600]!),
                    ],
                  ): Gaps.empty,
                  Gaps.hGap16,
                ],
              ),
              const SizedBox(
                height: 17,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 16, left: 6),
                  child: _LineChart(isShowingMainData: widget.isShowingMainData, weekCaseData: widget.weekCaseData, weekBonusData: widget.weekBonusData),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
          IconButton(
            icon: Icon(
              widget.isShowingMainData ? Icons.theater_comedy_outlined : Icons.text_rotation_angleup,
              color: Colors.white.withOpacity(0.6),
            ),
            onPressed: () {
              // setState(() {
              //   isShowingMainData = !isShowingMainData;
              // });
            },
          )
        ],
      ),
    );
  }
}
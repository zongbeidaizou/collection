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
  const _LineChart({required this.weekCaseData});

  final List<ShopDataWeekCaseData> weekCaseData;

  @override
  Widget build(BuildContext context) {
    return BarChartSample3(data: weekCaseData);
    // return isReceive ? BarChartSample7(data: weekBonusData) : BarChartSample3(data: weekCaseData) ;
  }
}

class BarReceive extends StatefulWidget {
  const BarReceive(
      {super.key, required this.weekCaseData, required this.isReceive});
  final List<ShopDataWeekCaseData> weekCaseData;
  final bool isReceive;

  @override
  State<StatefulWidget> createState() => BarReceiveState();
}

class BarReceiveState extends State<BarReceive> {
  // late bool isReceive;

  @override
  void initState() {
    super.initState();
    // isReceive = true;
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: widget.isReceive ? 2.63 : 2.63,
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
                      widget.isReceive
                          ? 'Live Weekly Receive Counts'
                          : 'Live Weekly Retain Days',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Gaps.hGap16,
                ],
              ),
              const SizedBox(
                height: 17,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 16, left: 6),
                  child: _LineChart(weekCaseData: widget.weekCaseData),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
          IconButton(
            icon: Icon(
              widget.isReceive
                  ? Icons.move_up
                  : Icons.repeat_one,
              color: Colors.white.withOpacity(0.6),
            ),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}

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
    // return isRegister ? BarChartSample7(data: weekBonusData) : BarChartSample3(data: weekCaseData) ;
  }
}

class BarMarketing extends StatefulWidget {
  const BarMarketing(
      {super.key, required this.weekCaseData, required this.isRegister});
  final List<ShopDataWeekCaseData> weekCaseData;
  final bool isRegister;

  @override
  State<StatefulWidget> createState() => BarMarketingState();
}

class BarMarketingState extends State<BarMarketing> {
  // late bool isRegister;

  @override
  void initState() {
    super.initState();
    // isRegister = true;
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: widget.isRegister ? 1.43 : 1.83,
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
                      widget.isRegister
                          ? 'Live Weekly Register Rankings'
                          : 'Live Weekly Apply Rankings',
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
              widget.isRegister
                  ? Icons.person_outline_outlined
                  : Icons.how_to_reg_outlined,
              color: Colors.white.withOpacity(0.6),
            ),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}

// import 'package:fl_chart_app/presentation/resources/app_resources.dart';
import 'package:bounty_hunter/shop/widgets/resources/app_colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'bar_chart_sample7.dart';


const List<Map<String, dynamic>> barData = [
  {'name': 'Tom', 'value': 160},
  {'name': 'Jerry', 'value': 142},
  {'name': 'Spike', 'value': 120},
  {'name': 'Tyke', 'value': 110}
];
class _LineChart extends StatelessWidget {
  const _LineChart({required this.isShowingMainData});

  final bool isShowingMainData;

  @override
  Widget build(BuildContext context) {
    return BarChartSample7(data: barData);
  }


}

class Bar2 extends StatefulWidget {
  const Bar2({super.key});

  @override
  State<StatefulWidget> createState() => Bar2State();
}

class Bar2State extends State<Bar2> {
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
                 'Week Rank',
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
          // IconButton(
          //   icon: Icon(
          //     isShowingMainData ? Icons.stacked_bar_chart : Icons.stacked_line_chart,
          //     color: Colors.white.withOpacity(isShowingMainData ? 1.0 : 0.5),
          //   ),
          //   onPressed: () {
          //     setState(() {
          //       isShowingMainData = !isShowingMainData;
          //     });
          //   },
          // )
        ],
      ),
    );
  }
}
// import 'package:fl_chart_app/presentation/resources/app_resources.dart';
import 'package:bounty_hunter/shop/widgets/resources/app_colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'bar.dart';
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
const List<Map<String, dynamic>> barData = [
  {'name': 'Tom', 'value': 16000},
  {'name': 'Jerry', 'value': 14200},
  {'name': 'Spike', 'value': 12000},
  {'name': 'Tyke', 'value': 11000}
];
class _LineChart extends StatelessWidget {
  const _LineChart({required this.isShowingMainData});

  final bool isShowingMainData;

  @override
  Widget build(BuildContext context) {
    return isShowingMainData ? BarChartSample7(data: barData) : BarChartSample3() ;
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
                isShowingMainData ? 'Live Bonus Rankings' : 'Live Case Rankings',
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
              isShowingMainData ? Icons.theater_comedy_outlined : Icons.text_rotation_angleup,
              color: Colors.white.withOpacity(0.6),
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
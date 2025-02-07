import 'package:bounty_hunter/shop/widgets/progerssoo.dart';
import 'package:bounty_hunter/util/theme_utils.dart';
import 'package:flutter/material.dart';

import '../../res/gaps.dart';

class LevelBar extends StatelessWidget {
  const LevelBar({super.key, required this.amountProgress, required this.levelProgress, required this.points, required this.tips});

  final List amountProgress;
  final List levelProgress;
  final List<double> points;
  final String tips;

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDark;
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      var _widgetSize = constraints.biggest;

      return Container(
        padding: EdgeInsets.only(top: 10, bottom: 10),
        height: 126,
        decoration: BoxDecoration(
          color: isDark ? Colors.blueGrey : Colors.indigoAccent,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8.0), bottomLeft: Radius.circular(8.0), bottomRight: Radius.circular(8.0), topRight: Radius.circular(8.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(color: Colors.white.withOpacity(0.4), offset: const Offset(0.1, 4.1), blurRadius: 10.0),
          ],
        ),
        child: Center(
          child: Column(
            children: [
              Gaps.vGap10,
              Container(
                padding: EdgeInsets.only(left: _widgetSize.width / 11 / 2, right: _widgetSize.width / 11 / 2),
                margin: EdgeInsets.only(bottom: 2),
                child: Progressoo(
                    progress: 0.6,
                    above: ["0", "120","180", "270"],
                    points: [0,0.44,0.67, 1],
                    below: ["lv.1", "lv.2", "lv.3", "c"],
                    belowFix: ["(4%)", "(6%)", "(9%)", "(c)"],
                    pointRadius: 7,
                    progressStrokeWidth: 6,
                    backgroundStrokeWidth: 6,
                    // backgroundColor:Colors.lightBlueAccent,
                    // progressColor:Colors.red,
                    // pointInnerRadius: 1,
                    progressStrokeCap: StrokeCap.round,
                    backgroundStrokeCap: StrokeCap.round,
                    pointColor: Colors.deepOrange[700]!,
                    pointInnerColor: Colors.white),
              ),

              Gaps.vGap10,
              Gaps.line,
              Gaps.vGap8,
              Row(
                children: [
                  Gaps.hGap16,
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(tips, style: TextStyle(color: Colors.white, fontSize: 6)),
                        Container(
                          padding: EdgeInsets.only(left: 10, right: 10, bottom: 2),
                          height: 18,
                          decoration: BoxDecoration(
                            color: isDark ? Colors.blueGrey.shade100 : Colors.indigoAccent.shade100,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(16.0),
                            ),
                            boxShadow: <BoxShadow>[
                              BoxShadow(color: Color(0xFF00B6F0).withOpacity(0.5), offset: const Offset(1.1, 1.1), blurRadius: 10.0),
                            ],
                          ),
                          child: const Center(
                            child: Text(
                              'learn more',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                                letterSpacing: 0.0,
                                color: Color(0xFFFFFFFF),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Gaps.hGap4,
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}

import 'package:bounty_hunter/shop/widgets/progerssoo.dart';
import 'package:bounty_hunter/util/theme_utils.dart';
import 'package:flutter/material.dart';

import '../../models/collection_order_entity.dart';
import '../../res/gaps.dart';
import '../../routers/fluro_navigator.dart';
import '../../util/device_utils.dart';
import '../../util/other_utils.dart';

class LevelBar extends StatelessWidget {
  const LevelBar({super.key, required this.data, required this.profile});

  final CollectionOrderOtherProgress data;
  final CollectionOrderOtherProfile profile;

  @override
  Widget build(BuildContext context) {

    void _launchWebURL(String title, String url) {
      if (Device.isMobile) {
        NavigatorUtils.goWebViewPage(context, title, url);
      } else {
        Utils.launchWebURL(url);
      }
    }

    final bool isDark = context.isDark;
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      var _widgetSize = constraints.biggest;

      return Container(
        padding: EdgeInsets.only(top: 10, bottom: 1),
        height: 136,
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
                    progress: data.currentPoint!,
                    above: data.counts!.map((i) => i.toString()).toList(),
                    points: data.points!,
                    below: data.grades!,
                    belowFix: data.commissionRates!,
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
                  Gaps.hGap4,
                  Expanded(
                    child: Stack(
                      children: [
                        RichText(
                          text: TextSpan(
                            style: TextStyle(color: Colors.white, fontSize: 8),
                            children: [
                              const TextSpan(text: 'Your recovery count for today is currently '),
                              TextSpan(
                                text: '${profile.pTodayCurrentRepayCount}',
                                style: const TextStyle(fontSize: 10), // 2 points larger than base
                              ),
                              const TextSpan(text: ' cases so far, \nplacing you at Level '),
                              TextSpan(
                                text: '${data.currentGrade}',
                                style: const TextStyle(fontSize: 10),
                              ),
                              const TextSpan(text: ' with a '),
                              TextSpan(
                                text: '${data.currentRate}',
                                style: const TextStyle(fontSize: 10),
                              ),
                              const TextSpan(text: ' bonus. \nTo reach the next level (Level '),
                              TextSpan(
                                text: '${data.nextGrade}',
                                style: const TextStyle(fontSize: 10),
                              ),
                              const TextSpan(text: ') and earn a '),
                              TextSpan(
                                text: '${data.nextRate}',
                                style: const TextStyle(fontSize: 10),
                              ),
                              const TextSpan(text: ' bonus plus an additional bonus of '),
                              TextSpan(
                                text: '${Utils.formatPrice2(data.nextAdditionBonus!)}',
                                style: const TextStyle(fontSize: 10),
                              ),
                              const TextSpan(text: ', \nyou need '),
                              TextSpan(
                                text: '${data.more}',
                                style: const TextStyle(fontSize: 10),
                              ),
                              const TextSpan(text: ' more successful recoveries today.'),
                            ],
                          ),
                        ),
                        Positioned(
                          top:0,
                            right:10,
                            child: InkWell(
                              onTap: (){
                                _launchWebURL('Bonus Rules for Collection', 'https://api.dasewan.cn/collection_h5/index.html');
                              },
                              child: Container(
                                                        padding: EdgeInsets.only(left: 10, right: 10),
                                                        height: 18,
                                                        decoration: BoxDecoration(
                              color: isDark ? Colors.blueGrey.shade100 : Colors.indigoAccent.shade100,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(16.0),
                              ),
                              // boxShadow: <BoxShadow>[
                              //   BoxShadow(color: Colors.white.withOpacity(0.5), offset: const Offset(1.1, 1.1), blurRadius: 10.0),
                              // ],
                                                        ),
                                                        child: const Center(
                              child: Text(
                                'Detail',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  letterSpacing: 0.0,
                                  color: Color(0xFFFFFFFF),
                                ),
                              ),
                                                        ),
                                                      ),
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}

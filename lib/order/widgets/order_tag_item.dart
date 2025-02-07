import 'package:flutter/material.dart';
import 'package:bounty_hunter/res/resources.dart';
import 'package:bounty_hunter/util/theme_utils.dart';
import 'package:bounty_hunter/widgets/load_image.dart';
import 'package:bounty_hunter/widgets/my_card.dart';

class OrderTagItem extends StatelessWidget {

  const OrderTagItem({
    super.key,
    required this.date,
    required this.orderTotal,
  });
  
  final String date;
  final int orderTotal;
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: MyCard(
        child: Container(
          height: 34.0,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: <Widget>[
              if (context.isDark)
                const LoadAssetImage('order/icon_calendar_dark', width: 14.0, height: 14.0) 
              else
                const LoadAssetImage('order/icon_calendar', width: 14.0, height: 14.0),
              Gaps.hGap10,
              Text(date),
              const Expanded(child: Gaps.empty),
              Text('$orderTotal单')
            ],
          ),
        )
      ),
    );
  }
}

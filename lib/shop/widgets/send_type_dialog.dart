import 'package:flutter/material.dart';
import 'package:bounty_hunter/res/resources.dart';
import 'package:bounty_hunter/routers/fluro_navigator.dart';
import 'package:bounty_hunter/widgets/base_dialog.dart';
import 'package:bounty_hunter/widgets/load_image.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

import '../../providers/user_provider.dart';

/// design/7店铺-店铺配置/index.html#artboard9
class SendTypeDialog extends StatefulWidget {
  const SendTypeDialog({
    super.key,
    required this.onPressed,
    required this.overdueDays,
  });

  final void Function(int, String) onPressed;
  final int overdueDays;
  @override
  _SendTypeDialog createState() => _SendTypeDialog();
}

class _SendTypeDialog extends State<SendTypeDialog> {
  int _value = -1;
  List<String> _buildOptions(int couponLeftCnt, int extendLeftCnt) => [
        'Block customer',
        'Fake customer contact list',
        'Issue discount coupon (10%) ($couponLeftCnt left for this week)',
        'Extend ($extendLeftCnt left for this week)',
      ];

  IconData _iconForIndex(int index) {
    switch (index) {
      case 0:
        return Icons.block;
      case 1:
        return Icons.contacts;
      case 2:
        return Icons.confirmation_number_rounded;
      case 3:
        return Icons.extension_outlined;
      default:
        return Icons.circle;
    }
  }

  Widget _buildItem(int index, List<String> options) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        child: SizedBox(
          height: 42.0,
          child: Row(
            children: <Widget>[
              Gaps.hGap16,
              Expanded(
                child: Row(
                  children: [
                    Icon(
                      _iconForIndex(index),
                      size: 18,
                      color: _value == index
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                    Gaps.hGap8,
                    Expanded(
                      child: Text(
                        options[index],
                        style: _value == index
                            ? TextStyle(
                                fontSize: Dimens.font_sp14,
                                color: Theme.of(context).primaryColor,
                              )
                            : null,
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                  visible: _value == index,
                  child: const LoadAssetImage('order/ic_check',
                      width: 16.0, height: 16.0)),
              Gaps.hGap16,
            ],
          ),
        ),
        onTap: () {
          if (mounted) {
            setState(() {
              _value = index;
            });
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final int couponLeftCnt = context.select<UserProvider, int>(
        (p) => p.userEntity.profile?.cLWeekCouponLeftCnt ?? 0);
    final int extendLeftCnt = context.select<UserProvider, int>(
        (p) => p.userEntity.profile?.cNWeekExtendCnt ?? 0);
    final options = _buildOptions(couponLeftCnt, extendLeftCnt);
    return BaseDialog(
      title: 'More Options',
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children:
              List.generate(options.length, (i) => _buildItem(i, options))),
      onPressed: () {
        if (_value == -1) {
          showToast('Please select a type');
          return;
        }
        NavigatorUtils.goBack(context);
        widget.onPressed(_value, options[_value]);
      },
    );
  }
}

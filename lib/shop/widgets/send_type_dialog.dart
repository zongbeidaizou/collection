import 'package:flutter/material.dart';
import 'package:bounty_hunter/res/resources.dart';
import 'package:bounty_hunter/routers/fluro_navigator.dart';
import 'package:bounty_hunter/widgets/base_dialog.dart';
import 'package:bounty_hunter/widgets/load_image.dart';
import 'package:oktoast/oktoast.dart';

/// design/7店铺-店铺配置/index.html#artboard9
class SendTypeDialog extends StatefulWidget {
  const SendTypeDialog({
    super.key,
    required this.onPressed,
  });

  final void Function(int, String) onPressed;

  @override
  _SendTypeDialog createState() => _SendTypeDialog();
}

class _SendTypeDialog extends State<SendTypeDialog> {
  int _value = -1;
  final _list = [
    'Block customer',
    'Fake customer contact list',
    'Retain this case'
  ];

  Widget _buildItem(int index) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        child: SizedBox(
          height: 42.0,
          child: Row(
            children: <Widget>[
              Gaps.hGap16,
              Expanded(
                child: Text(
                  _list[index],
                  style: _value == index
                      ? TextStyle(
                          fontSize: Dimens.font_sp14,
                          color: Theme.of(context).primaryColor,
                        )
                      : null,
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
    return BaseDialog(
      title: 'More Options',
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: List.generate(_list.length, (i) => _buildItem(i))),
      onPressed: () {
        if (_value == -1) {
          showToast('Please select a type');
          return;
        }
        NavigatorUtils.goBack(context);
        widget.onPressed(_value, _list[_value]);
      },
    );
  }
}

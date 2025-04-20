import 'package:flutter/material.dart';
import 'package:bounty_hunter/res/resources.dart';
import 'package:bounty_hunter/routers/fluro_navigator.dart';
import 'package:bounty_hunter/widgets/base_dialog.dart';
import 'package:bounty_hunter/widgets/load_image.dart';
import 'package:sp_util/sp_util.dart';

import '../../models/collection_log_entity.dart';

/// design/3订单/index.html#artboard5
class SmsDialog extends StatefulWidget {

  const SmsDialog({
    super.key,
    this.onPressed,
    this.repayInfo,
  });

  final void Function(int, String)? onPressed;
  final CollectionLogOtherRepayInfo? repayInfo;
  
  @override
  _SmsDialogDialog createState() => _SmsDialogDialog();
  
}

class _SmsDialogDialog extends State<SmsDialog> {

  int _value = 0;
  String _dropdownValue = "Customize Message";

  final TextEditingController _commentController = TextEditingController();

  String replacePlaceholders(String template, CollectionLogOtherRepayInfo info) {
    // 创建一个映射，将占位符与对应的属性值关联起来
    final Map<String, dynamic> placeholders = {
      '@phone@': info.phone,
      '@name@': info.name,
      '@loanAmount@': info.loanAmount,
      '@repayAmount@': info.repayAmount,
      '@expectRepayTime@': info.expectRepayTime,
      '@borrowDays@': info.borrowDays,
      '@upAmount@': info.upAmount,
      '@bankcardBank@': info.bankcardBank,
      '@overdueDays@': info.overdueDays,
      '@productName@': info.productName,
      '@recieveBank@': info.recieveBank,
      '@recieveBankNo@': info.recieveBankNo,
      '@accountNumber@': info.accountNumber,
      '@bank@': info.bank,
      '@accountName@': info.accountName,
      '@email@': info.email,
      '@whatsapp@': info.whatsapp,
    };

    // 遍历映射，替换字符串中的占位符
    placeholders.forEach((placeholder, value) {
      if (value != null) {
        template = template.replaceAll(placeholder, value.toString());
      }
    });

    return template;
  }

  bool isNumberInRange(String rangeStr, int number) {
    // 去除所有空格
    String trimmedStr = rangeStr.replaceAll(' ', '');
    if (trimmedStr.isEmpty) return false;

    // 范围格式（如"1-4"）
    if (trimmedStr.contains('-')) {
      List<String> parts = trimmedStr.split('-');
      if (parts.length != 2) return false;

      int? start = int.tryParse(parts[0]);
      int? end = int.tryParse(parts[1]);

      if (start == null || end == null) return false;
      return number >= start && number <= end;
    }
    // 多个数字格式（如"1,3,4"）
    else if (trimmedStr.contains(',')) {
      List<String> numbers = trimmedStr.split(',');
      return numbers.any((numStr) {
        int? num = int.tryParse(numStr);
        return num != null && num == number;
      });
    }
    // 单个数字格式（如"2"）
    else {
      int? singleNum = int.tryParse(trimmedStr);
      return singleNum == number;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    bool withBorder = false;
    String labelText = 'send a message';
    String errorText = 'Comment cannot be blank';
    // final templateList = ['Customize Message','Info','Link','Apply','Collection'];
    List<Map<String, dynamic>> dataList = SpUtil.getObjectList("hJSmsTemplates")!.cast<Map<String, dynamic>>();
    List<CollectionLogOtherHJSmsTemplate> templates = List<CollectionLogOtherHJSmsTemplate>.from(dataList.map((value) {
      return $CollectionLogOtherHJSmsTemplateFromJson(value);
    })).where((item) => item.eDays == null || item.eDays == '' || isNumberInRange(item.eDays!, widget.repayInfo!.overdueDays!)).toList();

    // final templateContentList = [
    //   '',
    //   'Your account number is @accountNumber@, and your bank is @bank@. The account name is @accountName@.',
    //   'Hello @name@, your phone number is @phone@ and your loan amount is @loanAmount@. Expected repay time is @expectRepayTime@.',
    //   'You have applied for the @productName@. The receiving bank is @recieveBank@, and the bank account number is @recieveBankNo@.',
    //   'Dear @name@, your loan details are as follows:\nLoan Amount: @loanAmount@\nRepayment Amount: @repayAmount@\nExpected Repayment Time: @expectRepayTime@\nOverdue Days: @overdueDays@\nBank: @bank@\nAccount Number: @accountNumber@.'
    // ];
    final templateContentIdList = [
      0,
      11,
      12,
      14,
      16,
    ];
    return BaseDialog(
      title: 'Send Message',
      width: 366,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Gaps.hGap8,
              const Text('Select an SMS template:'),
              Gaps.hGap8,
              DropdownButton<String>(
                value: _dropdownValue,
                // icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                style: const TextStyle(color: Colors.blueAccent),
                underline: Container(
                  height: 2,
                  color: Colors.blueAccent,
                ),
                onChanged: (String? value) {
                  _commentController.text = replacePlaceholders(templates.firstWhere((item) => item.sName == value).dTemplate!, widget.repayInfo!);
                  // This is called when the user selects an item.
                  setState(() {
                    _dropdownValue = value!;
                  });
                },
                items: templates.map<DropdownMenuItem<String>>((CollectionLogOtherHJSmsTemplate value) {
                  return DropdownMenuItem<String>(
                    value: value.sName,
                    child: Text(value.sName!),
                  );
                }).toList(),
              ),
              Gaps.hGap32,
            ],
          ),
          Gaps.line,
          Form(
            // key: formKey,
            child: TextFormField(
              maxLines: 4,
              minLines: 1,
              // focusNode: focusNode,
              autofocus: true,
              cursorColor: Colors.black,
              style: TextStyle(color: Colors.black),
              controller: _commentController,
              decoration: InputDecoration(
                enabledBorder: !withBorder
                    ? InputBorder.none
                    : UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black!),
                ),
                focusedBorder: !withBorder
                    ? InputBorder.none
                    : UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black!),
                ),
                border: !withBorder
                    ? InputBorder.none
                    : UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black!),
                ),
                labelText: labelText,
                focusColor: Colors.red,
                filled: true,
                fillColor: Colors.white,
                labelStyle: TextStyle(color: Colors.grey),
              ),
              validator: (value) => value!.isEmpty ? errorText : null,
            ),
          )
        ],
      ),
      onPressed: () {
        NavigatorUtils.goBack(context);
        widget.onPressed?.call(templates.firstWhere((item) => item.sName == _dropdownValue).id!, _commentController.text);
      },
    );
  }
}

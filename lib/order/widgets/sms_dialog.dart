import 'package:flutter/material.dart';
import 'package:bounty_hunter/res/resources.dart';
import 'package:bounty_hunter/routers/fluro_navigator.dart';
import 'package:bounty_hunter/widgets/base_dialog.dart';
import 'package:bounty_hunter/widgets/load_image.dart';

/// design/3订单/index.html#artboard5
class SmsDialog extends StatefulWidget {

  const SmsDialog({
    super.key,
    this.onPressed,
  });

  final void Function(int, String)? onPressed;
  
  @override
  _SmsDialogDialog createState() => _SmsDialogDialog();
  
}

class _SmsDialogDialog extends State<SmsDialog> {

  int _value = 0;
  String _dropdownValue = "Link";
  String _dropdown2Value = "Name";
  final _list = ['未收款', '支付宝', '微信', '现金'];

  final TextEditingController _commentController = TextEditingController();


  
  @override
  Widget build(BuildContext context) {
    bool withBorder = false;
    String labelText = 'send a message';
    String errorText = 'Comment cannot be blank';
    final templateList = ['No','Link','Collection1','Collection2'];
    final templateContentList = ['','hello your having a order ,please clikc http://fasic.top/DeijfS to repay','if you don\'t repay ,i will baofu you','you must repay'];
    final paramList = ['Name','Amount','Due Date','Overdue Days'];
    final paramContentList = ['Claire','3000','2024/02/21','overdue 15 days'];
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
              Text("Template:"),
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
                  _commentController.text = _commentController.text + templateContentList[templateList.indexOf(value!)];
                  // This is called when the user selects an item.
                  setState(() {
                    _dropdownValue = value!;
                  });
                },
                items: templateList.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              Gaps.hGap8,
              Text("Params:"),
              Gaps.hGap8,
              DropdownButton<String>(
                value: _dropdown2Value,
                // icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                style: const TextStyle(color: Colors.blueAccent),
                underline: Container(
                  height: 2,
                  color: Colors.blueAccent,
                ),
                onChanged: (String? value) {
                  // _commentController.text = _commentController.text + value!;
                  _commentController.text = _commentController.text + paramContentList[paramList.indexOf(value!)];
                  // This is called when the user selects an item.
                  setState(() {
                    _dropdown2Value = value!;
                  });
                },
                items: paramList.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
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
        widget.onPressed?.call(_value, _list[_value]);
      },
    );
  }
}

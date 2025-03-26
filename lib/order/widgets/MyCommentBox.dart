import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:oktoast/oktoast.dart';

import '../../routers/fluro_navigator.dart';
import '../../util/toast_utils.dart';

// ignore: must_be_immutable
class MyCommentBox extends StatefulWidget {
  Widget? child;
  Key? formKey;
  GestureTapCallback? sendButtonMethod;
  TextEditingController? commentController;
  TextEditingController? dateController;
  TextEditingController? typeController;
  String? labelText;
  String? errorText;
  Widget? sendWidget;
  Color? backgroundColor;
  Color? textColor;
  bool withBorder;
  Widget? header;
  FocusNode? focusNode;
  MyCommentBox(
      {this.child,
        this.header,
        this.sendButtonMethod,
        this.formKey,
        this.commentController,
        this.dateController,
        this.typeController,
        this.sendWidget,
        this.labelText,
        this.focusNode,
        this.errorText,
        this.withBorder = true,
        this.backgroundColor,
        this.textColor});

  @override
  State<MyCommentBox> createState() => _MyCommentBoxState();
}

class _MyCommentBoxState extends State<MyCommentBox> {
  IconData? _value = Icons.sync;
  bool _focus = false;
  final FocusNode _focusNode = FocusNode();
  DateTime? _savedDateTime;

  void _showDialog() {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Select Promiss Repay Time"), // 这个就是标题
            scrollable:true,
          actions: <Widget>[
            TextButton(
              onPressed: () => NavigatorUtils.goBack(context),
              child: const Text('cancel'),
            ),
            TextButton(
              onPressed: () {
                if(_savedDateTime == null){
                  showToast("Please select a time");
                  return;
                }
                print(123123123);
                print(_savedDateTime);
                NavigatorUtils.goBack(context);
                setState(() {
                  _focus = true;
                });
                _focusNode.requestFocus();
              },
              style: ButtonStyle(
                // 按下高亮颜色
                overlayColor: MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.error.withOpacity(0.2)),
              ),
              child: Text('write a promiss comment', style: TextStyle(color: Theme.of(context).colorScheme.error),),
            ),
          ],
          content: Container(
            height: 120, // 这个可以根据你的需要进行更改
              width: 6400,
              child: FormBuilderDateTimePicker(
                name: 'date',
                initialEntryMode: DatePickerEntryMode.calendar,
                initialValue: DateTime.now(),
                inputType: InputType.both,
                decoration: InputDecoration(
                  labelText: 'Appointment Time',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                    },
                  ),
                ),
                initialTime: const TimeOfDay(hour: 8, minute: 0),
                onChanged: (DateTime? value) {
                  setState(() {
                    _savedDateTime = value; // 实时更新选中时间
                  });
                  widget.dateController?.text = value.toString();
                  print('选中的时间: $value');
                },
                // locale: const Locale.fromSubtags(languageCode: 'fr'),
              ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<IconData> typeList = [Icons.sync, Icons.more_time, Icons.do_not_touch, Icons.phone_disabled];
    final List<int> typeList2 = [1, 2, 4, 5];
    final List<String> typeToastList = ["Under negotiation selected", "Promise to repay selected", "Refusal to repay selected","Unable to dial selected", ];

    return Column(
      children: [
        Expanded(child: widget.child!),
        Divider(
          height: 1,
        ),
        widget.header ?? SizedBox.shrink(),
        Container(
          color: Colors.blueAccent.withOpacity(0.3),
          child: ListTile(
            tileColor: widget.backgroundColor,
            leading: Container(
              height: 40.0,
              width: 50.0,
              child: DropdownButton<IconData>(
                value: _value,
                // icon: const Icon(Icons.arrow_downward),
                // elevation: 16,
                style: const TextStyle(color: Colors.blueAccent),
                underline: Container(
                  height: 1,
                  color: Colors.transparent,
                ),
                onChanged: (IconData? value) async {
                  Toast.show(typeToastList[typeList.indexOf(value!)]);
                  widget.typeController?.text = typeList2[typeList.indexOf(value!)].toString();
                  if(value == Icons.more_time){
                    _showDialog();
          /*                var results = await showCalendarDatePicker2Dialog(
                  context: context,

                  config: CalendarDatePicker2WithActionButtonsConfig(),
                  dialogSize: const Size(325, 400),
                  // value: _dates,
                  borderRadius: BorderRadius.circular(15),
                  );*/
                  }else{
                    _focusNode.requestFocus();
                  }
                  setState(() {
                    _value = value;
                  });
                },
                items: typeList.map<DropdownMenuItem<IconData>>((IconData icon) {
                  Color  iconColor = Colors.grey;
                  if(icon == Icons.sync){
                    iconColor =  Colors.grey;
                  }else if(icon == Icons.phone_disabled){
                    iconColor =  Colors.red;
                  }else if(icon == Icons.more_time){
                    iconColor =  Colors.green;
                  }else if(icon == Icons.do_not_touch){
                    iconColor =  Colors.purpleAccent;
                  }
                  return DropdownMenuItem<IconData>(
                    value: icon,
                    child: Icon(icon, color: iconColor,),
                  );
                }).toList(),
              ),
            ),
            title: Form(
              key: widget.formKey,
              child: Column(
                children: [
                  TextFormField(
                    maxLines: 4,
                    minLines: 1,
                    focusNode: _focusNode,
                    autofocus: _focus,
                    cursorColor: widget.textColor,
                    style: TextStyle(color: widget.textColor),
                    controller: widget.commentController,
                    decoration: InputDecoration(
                      enabledBorder: !widget.withBorder
                          ? InputBorder.none
                          : UnderlineInputBorder(
                        borderSide: BorderSide(color: widget.textColor!),
                      ),
                      focusedBorder: !widget.withBorder
                          ? InputBorder.none
                          : UnderlineInputBorder(
                        borderSide: BorderSide(color: widget.textColor!),
                      ),
                      border: !widget.withBorder
                          ? InputBorder.none
                          : UnderlineInputBorder(
                        borderSide: BorderSide(color: widget.textColor!),
                      ),
                      labelText: widget.labelText,
                      focusColor: Colors.red,
                      filled: true,
                      fillColor: Colors.white,
                      labelStyle: TextStyle(color: Colors.grey),
                    ),
                    validator: (value) => value!.isEmpty ? widget.errorText : null,
                  ),

                ],
              ),
            ),
            trailing: GestureDetector(
              onTap: widget.sendButtonMethod,
              child: Container(width:18, child: widget.sendWidget),
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:oktoast/oktoast.dart';

import '../../routers/fluro_navigator.dart';
import '../../util/toast_utils.dart';

// ignore: must_be_immutable
class MyCommentBox extends StatefulWidget {
  Widget? child;
  Key? formKey;
  void Function(List<XFile>?)? sendButtonMethod;
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
  List<XFile>? _pickedFiles;

  bool _showCustomTime = false;

  void _selectPresetTime(int hour) {
    final now = DateTime.now();
    final selectedTime = DateTime(now.year, now.month, now.day, hour, 0);
    _handleTimeSelection(selectedTime);
  }

  void _handleTimeSelection(DateTime selectedTime) {
    setState(() {
      _savedDateTime = selectedTime;
    });
    widget.dateController?.text = selectedTime.toString();
    widget.commentController?.text =
        'PTP by ${DateFormat('MMM d, HH:mm').format(selectedTime)}';
    NavigatorUtils.goBack(context);
    setState(() {
      _focus = true;
    });
    _focusNode.requestFocus();
  }

  void _selectEndOfDay() {
    final now = DateTime.now();
    final endOfDay = DateTime(now.year, now.month, now.day, 23, 59);
    _handleTimeSelection(endOfDay);
  }

  void _selectTomorrowTime(int hour) {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    final selectedTime =
        DateTime(tomorrow.year, tomorrow.month, tomorrow.day, hour, 0);
    _handleTimeSelection(selectedTime);
  }

  void _selectEndOfFutureDay(int daysFromNow) {
    final futureDate = DateTime.now().add(Duration(days: daysFromNow));
    final endOfDay =
        DateTime(futureDate.year, futureDate.month, futureDate.day, 23, 59);
    _handleTimeSelection(endOfDay);
  }

  void _showDialog() {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Select Promiss Repay Time"),
          scrollable: true,
          actions: <Widget>[
            TextButton(
              onPressed: () => NavigatorUtils.goBack(context),
              child: const Text('cancel'),
            ),
            TextButton(
              onPressed: () {
                if (_savedDateTime == null) {
                  showToast("Please select a time");
                  return;
                }
                NavigatorUtils.goBack(context);
                setState(() {
                  _focus = true;
                });
                _focusNode.requestFocus();
              },
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.all<Color>(
                    Theme.of(context).colorScheme.error.withOpacity(0.2)),
              ),
              child: Text(
                'write a promiss comment',
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ),
          ],
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('by 11 AM today'),
                onTap: () => _selectPresetTime(11),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              ),
              ListTile(
                title: const Text('by 7 PM today'),
                onTap: () => _selectPresetTime(19),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              ),
              ListTile(
                title: const Text('by the end of today'),
                onTap: _selectEndOfDay,
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              ),
              ListTile(
                title: const Text('by 11 AM tomorrow'),
                onTap: () => _selectTomorrowTime(11),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              ),
              ListTile(
                title: const Text('by 7 PM tomorrow'),
                onTap: () => _selectTomorrowTime(19),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              ),
              ListTile(
                title: const Text('by the end of tomorrow'),
                onTap: () => _selectEndOfFutureDay(1),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              ),
              ListTile(
                title: const Text('​​by the day after tomorrow'),
                onTap: () => _selectEndOfFutureDay(2),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              ),
              ListTile(
                title: const Text('by two days after tomorrow'),
                onTap: () => _selectEndOfFutureDay(3),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              ),
              ListTile(
                title: Container(
                  margin: const EdgeInsets.only(top: 16),
                  child: FormBuilderDateTimePicker(
                    name: 'date',
                    decoration: InputDecoration(
                      labelText: 'Other Time',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {},
                      ),
                    ),
                    initialEntryMode: DatePickerEntryMode.calendarOnly,
                    onChanged: (DateTime? value) {
                      _handleTimeSelection(value!);
                      // setState(() {
                      //   _savedDateTime = value;
                      // });
                      // widget.dateController?.text = value.toString();
                    },
                  ),
                ),
                onTap: () => setState(() => _showCustomTime = true),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<IconData> typeList = [
      Icons.sync,
      Icons.more_time,
      Icons.phone_disabled,
      Icons.transfer_within_a_station,
    ];
    final List<int> typeList2 = [1, 2, 4, 5];
    final List<String> typeToastList = [
      "Under negotiation selected",
      "Promise to repay selected",
      "Refusal to repay selected",
      "Unable to dial selected",
    ];

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
                  widget.typeController?.text =
                      typeList2[typeList.indexOf(value!)].toString();
                  if (value == Icons.more_time) {
                    _showDialog();
                    /*                var results = await showCalendarDatePicker2Dialog(
                  context: context,

                  config: CalendarDatePicker2WithActionButtonsConfig(),
                  dialogSize: const Size(325, 400),
                  // value: _dates,
                  borderRadius: BorderRadius.circular(15),
                  );*/
                  } else if (value == Icons.phone_disabled) {
                    widget.commentController?.text = 'Number unavailable.';
                    /*                var results = await showCalendarDatePicker2Dialog(
                  context: context,

                  config: CalendarDatePicker2WithActionButtonsConfig(),
                  dialogSize: const Size(325, 400),
                  // value: _dates,
                  borderRadius: BorderRadius.circular(15),
                  );*/
                  } else if (value == Icons.transfer_within_a_station) {
                    widget.commentController?.text =
                        'Temporarily assign to someone else.';
                    final ImagePicker _picker = ImagePicker();
                    List<XFile>? pickedFiles = await _picker.pickMultiImage();
                    setState(() {
                      _pickedFiles = pickedFiles;
                    });
                  } else {
                    _focusNode.requestFocus();
                  }
                  setState(() {
                    _value = value;
                  });
                },
                items:
                    typeList.map<DropdownMenuItem<IconData>>((IconData icon) {
                  Color iconColor = Colors.grey;
                  if (icon == Icons.sync) {
                    iconColor = Colors.grey;
                  } else if (icon == Icons.phone_disabled) {
                    iconColor = Colors.purpleAccent;
                  } else if (icon == Icons.more_time) {
                    iconColor = Colors.green;
                  } else if (icon == Icons.transfer_within_a_station) {
                    iconColor = Colors.red;
                  }
                  return DropdownMenuItem<IconData>(
                    value: icon,
                    child: Icon(
                      icon,
                      color: iconColor,
                    ),
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
                    validator: (value) =>
                        value!.isEmpty ? widget.errorText : null,
                  ),
                ],
              ),
            ),
            trailing: GestureDetector(
              onTap: () => widget.sendButtonMethod!(_pickedFiles),
              child: Container(width: 18, child: widget.sendWidget),
            ),
          ),
        ),
      ],
    );
  }
}

import 'dart:io' show Platform;
import 'package:bounty_hunter/order/page/sms_history_page.dart';
import 'package:bounty_hunter/order/widgets/sms_dialog.dart';
import 'package:bounty_hunter/shop/widgets/send_type_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bounty_hunter/res/resources.dart';
import 'package:bounty_hunter/routers/fluro_navigator.dart';
import 'package:bounty_hunter/util/other_utils.dart';
import 'package:bounty_hunter/util/theme_utils.dart';
import 'package:bounty_hunter/widgets/my_card.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../models/admin_entity.dart';
import '../../models/collection_log_entity.dart';
import '../../models/collection_order_entity.dart';
import '../../models/product_entity.dart';
import '../../providers/user_provider.dart';
import '../order_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:clipboard/clipboard.dart';
import 'package:dio/dio.dart';
import '../../net/net.dart';

import 'dart:ui';
import 'repayment_bill_dialog.dart';

import 'contact_dialog.dart';

const MethodChannel _contactChannel = MethodChannel('contact_channel');
const List<IconData> sourceIcon = [Icons.miscellaneous_services,Icons.loupe, Icons.repeat_one,Icons.move_up];
const List<Color> sourceColor = [Colors.blue,Colors.red, Colors.green,Colors.purple];

class OrderItem extends StatefulWidget {
  const OrderItem({
    super.key,
    required this.tabIndex,
    required this.index,
    required this.showContactDays,
    required this.item,
    required this.products,
    required this.admins,
    required this.smsHistory,
    required this.contactList,
    required this.repayInfo,
    required this.couponList,
    required this.track,
    required this.period,
    this.onSendSms,
    this.moreAction,
    this.inList = true,
    this.source = 'order',
    this.avatar = '',
    required this.allContactList,
  });

  final int tabIndex;
  final int index;
  final int showContactDays;
  final bool inList;
  final String source;
  final CollectionOrderData item;
  final List<ProductData> products;
  final List<AdminData> admins;
  final List<CollectionLogOtherContactInfo2Data> contactList;
  final List<CollectionLogOtherContactInfo2Data> allContactList;
  final List<CollectionLogOtherSmsHistory> smsHistory;
  final CollectionLogOtherRepayInfo? repayInfo;
  final List<CollectionLogOtherCouponList> couponList;
  final CollectionLogOtherTrack? track;
  final CollectionLogOtherPeriod? period;
  final void Function(int, String, {String? phone, int? contactId})? onSendSms;
  final void Function(int)? moreAction;
  final String avatar;
  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool _isRetained = false;
  int _additionBonus = 0;
  @override
  void initState() {
    super.initState();
    _isRetained = (widget.item.bBHasRetain ?? 0) == 1;
        WidgetsBinding.instance.addPostFrameCallback((_) {
        _getAdditionBonus(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDark;
    Color shadowColor = Colors.transparent;
    Color buttonColor = isDark ? Colours.dark_app_main : Colours.app_main;
    Color backgroundColor = Colors.white;
    String buttonText = '';

    if (widget.inList) {
      if (widget.item.aNCurrentDayLogCount! == 0) {
        shadowColor = isDark ? Colors.white : Colors.redAccent.withOpacity(0.2);
        buttonColor = Colors.redAccent;
      } else if (widget.item.aOCurrentDayCallCount! == 0) {
        shadowColor =
            isDark ? Colors.white : Color(0xFF3BA28D).withOpacity(0.2);
        buttonColor = Color(0xFF3BA28D);
      }
    }
    if (widget.inList) {
      if (widget.item.xCurrentViewTimes! == 0) {
        buttonText = 'Not viewed';
      } 
            if (widget.item.aOCurrentDayCallCount! == 0) {
        buttonText =  buttonText.isEmpty ? 'Not called' : '$buttonText, Not called';
      }
      if (widget.item.bFCurrentDayWa! == 0) {
        buttonText = buttonText.isEmpty ? 'WA unsent' : '$buttonText, WA unsent';
      }

      if (buttonText.isEmpty) {
        buttonText = 'Detail';
      }
    }

    // 根据包名状态设置不同的背景颜色
    backgroundColor = _getBackgroundColorByStatus(widget.item, isDark);


    return Padding(
        padding: widget.inList ? const EdgeInsets.only(top: 8.0) : EdgeInsets.zero,
        child: MyCard(
          shadowColor: shadowColor,
          onlyBottom: !widget.inList,
          color: backgroundColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
            child: _buildContent(context, buttonColor, buttonText),
          ),
        ));
  }

  // 根据报名状态返回对应的背景颜色
  Color _getBackgroundColorByStatus(CollectionOrderData item, bool isDark) {
    final appName = item.aZPackage?.toLowerCase() ?? '';
    if (appName.contains('kaka')) {
      return isDark ? const Color.fromARGB(255, 6, 81, 134) : Colors.blue.shade50;
    } else if (appName.contains('leading')) {
      return isDark ? const Color.fromARGB(255, 22, 24, 22) : Colors.green.shade50;
    } else if (appName.contains('moimoi')) {
      return isDark ? const Color.fromARGB(255, 129, 117, 97) : Colors.orange.shade50;
    }
    // 默认颜色
    return isDark ? Colors.green.shade50 : Colors.green.shade50;

    // 默认背景颜色
  }
  _getAdditionBonus(BuildContext context) {
    if(widget.item.eCollectionAdminId == widget.item.aVTmpCollectionAdminId && widget.source != 'receive'){
      return ;
    }
    for (final bonus in context.read<UserProvider>().userEntity.additionBonus!) {
      if(widget.item.aAAAAQBPeriods!.lOverdueDays! >= bonus.overdueDays![0] && widget.item.aAAAAQBPeriods!.lOverdueDays! <= bonus.overdueDays![1]) {
        setState(() {
          _additionBonus = bonus.rate ?? 0;
        });
      }
    }
  }

  Widget _buildContent(BuildContext context, Color buttonColor, String buttonText) {
    final bool isDark = context.isDark;
    final TextStyle? textTextStyle = Theme.of(context)
        .textTheme
        .bodyMedium
        ?.copyWith(fontSize: Dimens.font_sp12,color: isDark ? Colors.white : Colors.black);
    void _showModalBottomSheet() {
      widget.item.aLLastLog = '';
      final encodedItem = Uri.encodeComponent(widget.item.toString());
      NavigatorUtils.push(context,
          '${OrderRouter.notePage}?id=${widget.item.id}&item=$encodedItem');
      // return showModalBottomSheet<int>(
      //   context: context,
      //   isScrollControlled: true,
      //   builder: (BuildContext context) {
      //     return Container(
      //       height: 700,
      //       color: Colors.grey,
      //       child: Scaffold(
      //         resizeToAvoidBottomInset: true,
      //         body: AddNote(orderId: item.id!,  item: item.toString()),     //AddNote should be your Widget that will be displayed inside the bottomSheet
      //       ),
      //     );
      //   },
      // );
    }

    Future<int?> _showContactListModal({bool allContacts = false}) {
      return showModalBottomSheet<int>(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Container(
            height: 650,
            color: Colors.grey,
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              body: ContactDialog(
                contactList: _sortContactList(
                    allContacts ? widget.allContactList : widget.contactList),
                repayInfo: widget.repayInfo,
                isAllContacts: allContacts,
                collectionOrderId: widget.item.id!,
                period: widget.period!,
                showContactDays: widget.showContactDays,
                borrowCount: widget.item.aEBorrowCount ?? 0,
                onSendSms: (templateId, smsContent,
                    {String? phone, int? contactId}) {
                  widget.onSendSms?.call(templateId, smsContent,
                      contactId: contactId, phone: phone);
                  // Toast.show('收款类型：$type');
                },
              ), //AddNote should be your Widget that will be displayed inside the bottomSheet
            ),
          );
        },
      );
    }

    void _showSmsDialog(
        BuildContext context, CollectionLogOtherRepayInfo repayInfo) {
      showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return SmsDialog(
            repayInfo: repayInfo,
            onPressed: (templateId, smsContent) {
              // Toast.show('收款类型：$templateId');
              widget.onSendSms?.call(templateId, smsContent);
              // Toast.show('收款类型：$type');
            },
          );
        },
      );
    }

    void _showSendTypeDialog() {
      showElasticDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return SendTypeDialog(
            overdueDays: widget.period?.lOverdueDays ?? 0,
            onPressed: (i, value) {
              widget.moreAction?.call(i);
            },
          );
        },
      );
    }

    void _showCallPhoneDialog(BuildContext context, String phone) {
      showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('提示'),
            content: Text('是否拨打：$phone ?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => NavigatorUtils.goBack(context),
                child: const Text('取消'),
              ),
              TextButton(
                onPressed: () {
                  Utils.launchTelURL(phone);
                  NavigatorUtils.goBack(context);
                },
                style: ButtonStyle(
                  // 按下高亮颜色
                  overlayColor: MaterialStateProperty.all<Color>(
                      Theme.of(context).colorScheme.error.withOpacity(0.2)),
                ),
                child: Text(
                  '拨打',
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ),
            ],
          );
        },
      );
    }

    String maskPhoneNumber(String phone) {
      if (phone.isEmpty || phone.length < 6) {
        return phone;
      }

      // 将手机号码转换为字符数组
      List<String> phoneChars = phone.split('');

      // 隐藏第3、4、5位数字（索引为2、3、4）
      // 注意：索引从0开始，所以第3位是索引2，第4位是索引3，第5位是索引4
      if (phoneChars.length > 2) phoneChars[2] = '*';
      if (phoneChars.length > 3) phoneChars[3] = '*';
      if (phoneChars.length > 4) phoneChars[4] = '*';

      return phoneChars.join();
    }

    int calculateCalendarDaysDifference(DateTime start, DateTime end) {
      // 将两个日期都设置为午夜时间，只比较日期部分
      start = DateTime(start.year, start.month, start.day);
      end = DateTime(end.year, end.month, end.day);
      return end.difference(start).inDays;
    }

    Future<void> _addContactToPhone() async {
      final phone = widget.item.uPhone ?? '';
      if (phone.isEmpty) {
        showToast('Phone number is empty',backgroundColor: Colors.red);
        return;
      }
      if (!Platform.isAndroid) {
        showToast('Adding to contacts is supported on Android only',backgroundColor: Colors.red);
        return;
      }

      // 弹出输入框，允许用户自定义 label 和 company
      final labelController = TextEditingController(text: 'Collection');
      final companyController = TextEditingController(text: 'Collection');

      final bool? confirmed = await showDialog<bool>(
        context: context,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            title: const Text('Add to contacts'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: labelController,
                  decoration: const InputDecoration(labelText: 'Label'),
                ),
                TextField(
                  controller: companyController,
                  decoration: const InputDecoration(labelText: 'Company'),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(true),
                child: const Text('OK'),
              ),
            ],
          );
        },
      );

      if (confirmed != true) {
        return;
      }

      final String label =
          labelController.text.trim().isEmpty ? 'Collection' : labelController.text.trim();
      final String company =
          companyController.text.trim().isEmpty ? 'Collection' : companyController.text.trim();

      final PermissionStatus status = await Permission.contacts.request();
      if (!status.isGranted) {
        showToast('Please grant contacts permission first',backgroundColor: Colors.red);
        return;
      }

      try {
        await _contactChannel.invokeMethod('addContact', {
          'name': widget.item.vName ?? '',
          'phone': phone,
          'label': label,
          'company': company,
        });
        showToast('Added to contacts');
      } catch (e) {
        showToast('Failed to add to contacts',backgroundColor: Colors.red);
      }
    }

    Future<void> _retainOrder() async {
      if (widget.item.id == null) {
        showToast('Order ID is missing',backgroundColor: Colors.red);
        return;
      }

      try {
        final formData = FormData.fromMap({
          'collection_order_id': widget.item.id,
        });

        await DioUtils.instance.requestNetwork<Map<String, dynamic>>(
          Method.post,
          HttpApi.retains,
          params: formData,
          onSuccess: (data) {
            setState(() {
              _isRetained = true;
            });
            if (data != null && data.containsKey('message')) {
              showToast(data['message'] as String,backgroundColor: Colors.green);
            } else {
              showToast('Order receive successfully',backgroundColor: Colors.green);
            }
          },
          onError: (code, msg) {
            showToast(msg,backgroundColor: Colors.red);
          },
        );
      } catch (e) {
        showToast('Failed to receive order',backgroundColor: Colors.red);
      }
    }

    Future<void> _receiveOrder() async {
      if (widget.item.id == null) {
        showToast('Order ID is missing',backgroundColor: Colors.red);
        return;
      }

      try {
        final formData = FormData.fromMap({
          'collection_order_id': widget.item.id,
        });

        await DioUtils.instance.requestNetwork<Map<String, dynamic>>(
          Method.post,
          HttpApi.receives,
          params: formData,
          onSuccess: (data) {
            setState(() {
              _isRetained = true;
            });
            if (data != null && data.containsKey('message')) {
              showToast(data['message'] as String,backgroundColor: Colors.green);
            } else {
              showToast('Order receive successfully',backgroundColor: Colors.green);
            }
          },
          onError: (code, msg) {
            showToast(msg,backgroundColor: Colors.red);
          },
        );
      } catch (e) {
        showToast('Failed to retain order',backgroundColor: Colors.red);
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              // child: Text(products.where((p) => p.id == item.aJProductId).firstOrNull?.bName ?? '',                 style: const TextStyle(
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: widget.item.aZPackage!, // 保持原样式
                      style:  TextStyle(
                        fontSize: Dimens.font_sp14,
                        fontWeight: FontWeight.w500,
                        color: isDark ? Colors.white : Colors.black
                      ),
                    )
                  ],
                ),
              ),
            ),
            if (!widget.inList && widget.repayInfo != null && int.parse(widget.repayInfo!.var7!) > 0)
              InkWell(
                onTap: () {
                    showToast('This loan can be reduced by a maximum of ${widget.repayInfo!.var7!} %. ');
                    return;
                  },
                child: Row(
                  children: [
                    Icon(
                      Icons.discount,
                      color: Colors.green,
                      size: 12,
                    ),
                    Text(
                      "-${int.parse(widget.repayInfo!.var7!)}%",
                      style: TextStyle(color: Colors.green, fontSize: 12),
                    ),
                    Gaps.hGap12,
                  ],
                ),
              )
            else
              Gaps.empty,
            if (!widget.inList &&
                widget.repayInfo != null &&
                widget.repayInfo!.var5!.toInt() > 0)
              InkWell(
                onTap: () {
                    showToast('This customer has ${widget.repayInfo!.var5!} lottery draw chances.');
                    return;
                  },
                child: Row(
                  children: [
                    Icon(
                      Icons.auto_fix_normal,
                      color: Colors.orange,
                      size: 14,
                    ),
                    Text(
                      "${widget.repayInfo!.var5!.toInt()}",
                      style: TextStyle(color: Colors.orange, fontSize: 14),
                    ),
                    Gaps.hGap12,
                  ],
                ),
              )
            else
              Gaps.empty,
            if (!widget.inList &&
                widget.repayInfo != null &&
                widget.repayInfo!.var6!.toInt() > 0)
              InkWell(
                onTap: () {
                  if (widget.couponList.isEmpty) {
                    showToast('No coupon data');
                    return;
                  }
                  showDialog<void>(
                    context: context,
                    builder: (ctx) {
                      return AlertDialog(
                        title: const Text('Coupon List'),
                        content: SizedBox(
                          width: double.maxFinite,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: widget.couponList.length,
                            itemBuilder: (_, index) {
                              final coupon = widget.couponList[index];
                              return ListTile(
                                dense: true,
                                title: Text(
                                    'Discount: ${coupon.fDiscountRate ?? 0}%,  Expired at: ${DateFormat('MMM d').format(DateTime.parse(coupon.iExpireAt!).toUtc().add(const Duration(hours: 1)))}'),
                              );
                            },
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(ctx).pop(),
                            child: const Text('Close'),
                          )
                        ],
                      );
                    },
                  );
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.confirmation_number_rounded,
                      color: Colors.green,
                      size: 14,
                    ),
                    Text(
                      "${widget.repayInfo!.var6!.toInt()}",
                      style: TextStyle(color: Colors.green, fontSize: 14),
                    ),
                    Gaps.hGap12,
                  ],
                ),
              )
            else
              Gaps.empty,
            if (!widget.inList && widget.repayInfo != null && widget.repayInfo!.var3!.toInt() > 0)
              InkWell(
                onTap: () {
                    showToast('This customer has ${widget.repayInfo!.var3!} opportunities to extend..');
                    return;
                  },
                child: Row(
                  children: [
                    Icon(
                      Icons.extension_outlined,
                      color: Color.fromARGB(255, 128, 188, 225),
                      size: 14,
                    ),
                    Text(
                      "${widget.repayInfo!.var3!.toInt()}",
                      style: TextStyle(color: Color.fromARGB(255, 128, 188, 225), fontSize: 14),
                    ),
                    Gaps.hGap12,
                  ],
                ),
              )
            else
              Gaps.empty,
            if ( _additionBonus > 0)
              InkWell(
                onTap: () {
                    showToast("This case is a transferred case and will receive an additional $_additionBonus% bonus.");
                    return;
                  },
                child: Row(
                  children: [
                    Icon(
                      Icons.transfer_within_a_station,
                      color: Colors.red,
                      size: 14,
                    ),
                    Gaps.hGap2,
                    Text(
                        '${_additionBonus}% ',
                        style: TextStyle(color: Colors.red, fontSize: 14)),
                  ],
                ),
              )
            else
              Gaps.empty,
            Gaps.hGap4,
            InkWell(
                onTap: () {
                  if(!widget.inList){
                    showToast("The last time this customer used the app was ${DateFormat('MMM d, hh:mm a', 'en_US').format(DateTime.parse(widget.track?.lastActiveTime ?? '2000-07-10T18:58:39.000000Z').toUtc().add(const Duration(hours: 1)))}");
                  }
                    return;
                  },
                child: Row(
                  children: [
                    if(!widget.inList)
                    Icon(
                       Icons.login,
                      color: Theme.of(context).colorScheme.tertiary,
                      size: 14,
                    ),
                    if(!widget.inList)
                    Text(
                    (DateTime.now()
                                .difference(DateTime.parse(
                                    widget.track?.lastActiveTime ??
                                        '2000-07-10T18:58:39.000000Z'))
                                .inHours >=
                            24)
                        ? ' ${DateTime.now().difference(DateTime.parse(widget.track?.lastActiveTime ?? '2000-07-10T18:58:39.000000Z')).inDays} days ago'
                        : ' ${DateTime.now().difference(DateTime.parse(widget.track?.lastActiveTime ?? '2000-07-10T18:58:39.000000Z')).inHours} hours ago',
                style: TextStyle(
                  fontSize: Dimens.font_sp12,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
                  ],
                ),
              ),
            // Container(
            //   padding: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
            //   decoration: BoxDecoration(
            //     color: Theme.of(context).colorScheme.tertiary.withOpacity(0.1),
            //     borderRadius: const BorderRadius.all(Radius.circular(5)),
            //   ),
            //   child: Text(
            //     widget.inList
            //         ? widget.item.aKNo!
            //         : (DateTime.now()
            //                     .difference(DateTime.parse(
            //                         widget.track?.lastActiveTime ??
            //                             '2000-07-10T18:58:39.000000Z'))
            //                     .inHours >=
            //                 24)
            //             ? 'Last used: ${DateTime.now().difference(DateTime.parse(widget.track?.lastActiveTime ?? '2000-07-10T18:58:39.000000Z')).inDays} days ago'
            //             : 'Last used: ${DateTime.now().difference(DateTime.parse(widget.track?.lastActiveTime ?? '2000-07-10T18:58:39.000000Z')).inHours} hours ago',
            //     style: TextStyle(
            //       fontSize: Dimens.font_sp12,
            //       color: Theme.of(context).colorScheme.tertiary,
            //     ),
            //   ),
            // ),
          ],
        ),
        Gaps.vGap4,
        Gaps.line,
        Gaps.vGap4,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 5,
              child: InkWell(
                child: Row(
                  children: [
                    if(widget.source != 'receive')
                    Icon(sourceIcon[widget.item.bESourceType ?? 0],size: 14,color: sourceColor[widget.item.bESourceType ?? 0]),
                    if(widget.source != 'receive')
                    Gaps.hGap2,
                    RichText(
                      text: TextSpan(
                        style: textTextStyle,
                        children: <TextSpan>[
                          // TextSpan(text: 'SN:', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: Dimens.font_sp10)),
                          TextSpan(text: widget.item.aKNo!.substring(widget.item.aKNo!.length > 6 ? widget.item.aKNo!.length - 6 : 0),style: Theme.of(context).textTheme.titleSmall?.copyWith( color: Colors.grey.shade500)),
                          TextSpan(text: '(${widget.item.aEBorrowCount?.toString() ?? ''})', style: Theme.of(context).textTheme.titleMedium?.copyWith( color: Colours.app_main)),
                        ],
                      ),
                    ),
                    Gaps.hGap2,
                  ],
                ),
                onTap: () {
                  if(widget.source == 'order'){
                    FlutterClipboard.copy('${widget.item.uPhone!}-${widget.item.tBorrowSn!}');
                  }
                },
              ),
            ),
            Expanded(
              flex: widget.inList ? 9 : 11,
              child: InkWell(
                onTap: () {
                  FlutterClipboard.copy(widget.item.vName ?? '');
                },
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 1.4),
                      height: 8.0,
                      width: 8.0,
                      decoration: BoxDecoration(
                        color: Colours.app_main.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        style: textTextStyle,
                        children: <TextSpan>[
                          // TextSpan(text: 'SN:', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: Dimens.font_sp10)),
                          TextSpan(text: widget.item.vName, style: TextStyle(color: isDark ? Colors.white : Colors.black,fontSize: (widget.item.vName?.nullSafe.length ?? 0) > 22 ? ((widget.item.vName?.nullSafe.length ?? 0) > 26 ? 9 : 10) : 12)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: InkWell(
                onTap: _addContactToPhone,
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 1.4),
                      height: 8.0,
                      width: 8.0,
                      decoration: BoxDecoration(
                        color: Colours.app_main.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        style: textTextStyle,
                        children: <TextSpan>[
                          // TextSpan(text: 'SN:', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: Dimens.font_sp10)),
                          TextSpan(
                              text: widget.inList
                                  ? maskPhoneNumber(widget.item.uPhone!)
                                  : widget.item.uPhone!, style: TextStyle(color: isDark ? Colors.white : Colors.black)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Gaps.vGap8,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 5,
              child: InkWell(
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 1.4),
                      height: 8.0,
                      width: 8.0,
                      decoration: BoxDecoration(
                        color: Colours.app_main.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        style: textTextStyle,
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Paid:',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(fontSize: Dimens.font_sp10, color: isDark ? Colors.white : Colors.black)),
                          TextSpan(
                            text: Utils.formatPrice2(widget.period?.nPaidAmount ?? 0),
                            style: widget.period?.nPaidAmount == 0
                                ? TextStyle(color: isDark ? Colors.white : Colors.black)
                                : const TextStyle(
                                    fontSize: 12, color: Colors.greenAccent),
                          ),
                        ],
                      ),
                    ),
                    Gaps.hGap2,
                  ],
                ),
                onTap: () {},
              ),
            ),
            Expanded(
              flex: widget.inList ? 9 : 11,
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 1.4),
                    height: 8.0,
                    width: 8.0,
                    decoration: BoxDecoration(
                      color: Colours.app_main.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      style: textTextStyle?.copyWith(fontSize: 11),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Left:',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(fontSize: Dimens.font_sp10, color: isDark ? Colors.white : Colors.black)),
                        if (!widget.inList &&
                            widget.repayInfo != null &&
                            int.parse(widget.repayInfo!.var7!) > 0) ...[
                          TextSpan(
                              text: Utils.formatPrice2(
                                  (widget.period?.fExpectRepayTotalAmount ?? 0) -
                                      (widget.period?.qPaidServiceFee ?? 0) -
                                      (widget.period?.pPaidInterest ?? 0) -
                                      (widget.period?.sPaidOverdueAmount ?? 0) -
                                      (widget.period?.oPaidBorrowAmount ?? 0) -
                                      (widget.period?.uDeductionTotalAmount ?? 0),
                                  symbol: ''), style: TextStyle(color: isDark ? Colors.white : Colors.black)),
                          TextSpan(text: ' - ', style: TextStyle(color: isDark ? Colors.white : Colors.black)),
                          TextSpan(
                              text: Utils.formatPrice2(
                                  ((widget.period?.fExpectRepayTotalAmount ?? 0) -
                                          (widget.period?.qPaidServiceFee ?? 0) -
                                          (widget.period?.pPaidInterest ?? 0)) *
                                      (int.parse(widget.repayInfo!.var7!) / 100),
                                  symbol: ''),
                              style: TextStyle(color: Colors.red)),
                          TextSpan(text: ' = ', style: TextStyle(color: isDark ? Colors.white : Colors.black)),
                          TextSpan(
                              text: Utils.formatPrice2(
                                  (widget.period?.fExpectRepayTotalAmount ?? 0) -
                                      (widget.period?.qPaidServiceFee ?? 0) -
                                      (widget.period?.pPaidInterest ?? 0) -
                                      (widget.period?.sPaidOverdueAmount ?? 0) -
                                      (widget.period?.oPaidBorrowAmount ?? 0) -
                                      (widget.period?.uDeductionTotalAmount ?? 0) -
                                      ((widget.period?.fExpectRepayTotalAmount ?? 0) -
                                              (widget.period?.qPaidServiceFee ?? 0) -
                                              (widget.period?.pPaidInterest ?? 0)) *
                                          (int.parse(widget.repayInfo!.var7!) / 100)),
                                          style: TextStyle(color: isDark ? Colors.white : Colors.black)),
                        ] else
                          TextSpan(
                              text: Utils.formatPrice2(
                            (widget.period?.fExpectRepayTotalAmount ?? 0) -
                                (widget.period?.qPaidServiceFee ?? 0) -
                                (widget.period?.pPaidInterest ?? 0) -
                                (widget.period?.sPaidOverdueAmount ?? 0) -
                                (widget.period?.oPaidBorrowAmount ?? 0) -
                                (widget.period?.uDeductionTotalAmount ?? 0),
                          ), style: TextStyle(color: isDark ? Colors.white : Colors.black)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 1.4),
                    height: 8.0,
                    width: 8.0,
                    decoration: BoxDecoration(
                      color: Colours.app_main.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      style: textTextStyle,
                      children: <TextSpan>[
                        TextSpan(
                            text: 'overdue:',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(fontSize: Dimens.font_sp12, color: isDark ? Colors.white : Colors.black)),
                        TextSpan(
                            text: calculateCalendarDaysDifference(
                                    DateTime.parse(widget.item.pExpectRepayTime!),
                                    DateTime.now())
                                .toString(), style: TextStyle(color: isDark ? Colors.white : Colors.black)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Gaps.vGap4,
        // Gaps.line,
        if (widget.inList)
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 11, horizontal: 1),
                  height: 52,
                  decoration: BoxDecoration(
                    color: Color(0xFFFFA113).withOpacity(0.1),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        width: 48,
                        height: 48,
                        "assets/images/clock-svgrepo-com.svg",
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.source == 'order' ? ((DateTime.parse(widget.item.sFlowOutTime!)
                                      .difference(DateTime.now())
                                      .inHours >=
                                  24)
                              ? '${DateTime.parse(widget.item.sFlowOutTime!).difference(DateTime.now()).inDays} days left'
                              : '${DateTime.parse(widget.item.sFlowOutTime!).difference(DateTime.now()).inHours} hours left') : ' ----',style: textTextStyle,),
                              Gaps.vGap4,
                          Text(
                              widget.item.rFlowInTime != null &&
                                      widget.item.rFlowInTime!.isNotEmpty && widget.source == 'order'
                                  ? ' ${DateFormat('MMM d, hh:mm a', 'en_US').format(DateTime.parse(widget.item.rFlowInTime!).toUtc().add(const Duration(hours: 1)))}'
                                  : '',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(fontSize: 8,color:isDark ? Colors.white : Colors.black)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Gaps.hGap4,
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 11, horizontal: 1),
                  height: 52,
                  decoration: BoxDecoration(
                    color: Color(0xFFFFA113).withOpacity(0.1),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        width: 48,
                        height: 48,
                        "assets/images/money-earn-svgrepo-com.svg",
                      ),
                      Consumer<UserProvider>(builder: (_, provider, __) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                // ignore: unnecessary_parenthesis
                                '${_calculateBonus(provider, widget.item, widget.period)} bonus',style: textTextStyle,),
                                Gaps.vGap4,
                            Text(
                                "${_getKpiLevelDisplay(provider.userEntity.profile!.iTodayCurrentKpiLevel!)} with ${provider.userEntity.profile!.aETodayCommissionRate!}${ _additionBonus > 0 ? '+$_additionBonus' :  ''}% of amount",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(fontSize: 8,color:isDark ? Colors.white : Colors.black))
                          ],
                        );
                      }),
                      // Text(" (level 1 with 4% amount)", style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 6)),
                    ],
                  ),
                ),
              ),
            ],
          ),

        if(widget.inList) Gaps.vGap4,
        Gaps.line,
         Gaps.vGap8,
        if (widget.inList)
          Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                                  widget.item.aDLastLogTime != null &&
                                          widget.item.aDLastLogTime!.isNotEmpty
                                      ? ' ${DateFormat('MMM d, hh:mm a', 'en_US').format(DateTime.parse(widget.item.aDLastLogTime!).toUtc().add(const Duration(hours: 1)))}'
                                      : '',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(fontSize: 8,color:isDark ? Colors.white.withOpacity(0.7) : Colors.black.withOpacity(0.7))),
                        Expanded(child: Gaps.hGap4),

                      ],
                    ),
                    Text(
                      widget.item.aLLastLog!,
                      style: TextStyle(color: isDark ? Colors.white.withOpacity(0.7) : Colors.black.withOpacity(0.7), fontSize: 11),
                      maxLines: 2, // 设置最大行数为2
                      overflow: TextOverflow.ellipsis,
                    ),
                    
                  ],
                ),
              ),
              if(DateTime.parse(widget.item.sFlowOutTime!).difference(DateTime.now()).inHours< 24 && !_isRetained)
              Gaps.hGap4,
              if(DateTime.parse(widget.item.sFlowOutTime!).difference(DateTime.now()).inHours< 24  && widget.source == 'order')
              OrderItemButton(
                key: Key('order_button_4_${widget.index}'),
                icon: _isRetained ? null : Icon(Icons.repeat_one,size: 16,color: Colors.white),
                text: _isRetained ? 'Retained' : 'Retain',
                textColor: isDark ? Colours.dark_button_text : Colors.white,
                bgColor: _isRetained ? Colors.green.withOpacity(0.3) : Colors.green,
                fontSize: _isRetained ? 11 : null,
                onTap: () {
                  if(_isRetained){
                    showToast('Order already retained',backgroundColor: Colors.green);
                  }else{
                    _retainOrder();
                  }
                },
              ),
              Gaps.hGap4,
              if(widget.source == 'order')
                OrderItemButton(
                  key: Key('order_button_3_${widget.index}'),
                  text: buttonText,
                  fontSize: 11,
                  textColor: isDark ? Colours.dark_button_text : Colors.white,
                  bgColor: Colours.app_main,
                  onTap: () {
                    _showModalBottomSheet();
                  },
                ),
                if(widget.source == 'receive')
                OrderItemButton(
                  key: Key('order_button_4_${widget.index}'),
                  icon: Icon(Icons.move_up,size: 16,color: Colors.white),
                  text: 'Receive',
                  textColor: isDark ? Colours.dark_button_text : Colors.white,
                  bgColor: Colors.purple,
                  onTap: () {
                    _receiveOrder();
                  },
                )
                
            ],
          )
        else
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              OrderItemButton(
                key: Key('order_bill'),
                text: "Bill",
                icon: Icon(Icons.receipt,
                    size: 15, color: Colors.white),
                textColor: isDark ? Colours.dark_button_text : Colors.white,
                bgColor: isDark ? Colours.dark_app_main : Colours.app_main,
                onTap: () {
          showDialog<void>(
                            context: context,
                            builder: (context) {
                              return RepaymentBillDialog(
                                avatar: widget.avatar,
                                repayInfo: widget.repayInfo,
                                period: widget.period,
                                track: widget.track,
                              );
                            },
                          );
                },
              ),
              OrderItemButton(
                key: Key('order_reducation'),
                text: "Waive",
                icon: Icon(Icons.next_plan_outlined,
                    size: 15, color: Colors.white),
                textColor: isDark ? Colours.dark_button_text : Colors.white,
                bgColor: (widget.period?.lOverdueDays ?? 0) <= 0
                    ? Colors.grey
                    : (isDark ? Colours.dark_app_main : Colours.app_main),
                onTap: () {
                  if ((widget.period?.lOverdueDays ?? 0) <= 0) {
                    showToast('Case is not overdue, cannot be waived.');
                    return;
                  }
                  NavigatorUtils.push(context,
                      '${OrderRouter.orderInfoPage}?id=${widget.item.id}&track=${widget.track.toString()}&period=${widget.period.toString()}');
                },
              ),
              // OrderItemButton(
              //   key: Key('extend'),
              //   text: "Ext",
              //   icon: Icon(Icons.extension_outlined,
              //       size: 15, color: Colors.white),
              //   textColor: isDark ? Colours.dark_button_text : Colors.white,
              //   bgColor: (widget.period?.lOverdueDays ?? 0) <= 0
              //       ? Colors.grey
              //       : Colours.dark_app_main,
              //   onTap: () {
              //     if ((widget.period?.lOverdueDays ?? 0) <= 0) {
              //       showToast('Case is not overdue, cannot be waived.');
              //       return;
              //     }
              //     NavigatorUtils.push(context,
              //         '${OrderRouter.orderInfoPage}?id=${widget.item.id}&track=${widget.track.toString()}&period=${widget.period.toString()}');
              //   },
              // ),
              // Gaps.hGap4,
              OrderItemButton(
                key: Key('sms_recording'),
                text: "Sms",
                textColor: isDark ? Colours.dark_button_text : Colors.white,
                bgColor: widget.showContactDays > (widget.period?.lOverdueDays ?? 0)
                    ? Colors.grey
                    : (isDark ? Colours.dark_app_main : Colours.app_main),
                icon: Icon(Icons.forum_outlined, size: 15, color: Colors.white),
                onTap: () async {
                  if (widget.showContactDays > (widget.period?.lOverdueDays ?? 0)) {
                    showToast(
                        'Will show sms record overdue days: ${widget.showContactDays}');
                    return;
                  }
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) {
                      return Container(
                          height: 580,
                          color: Colors.grey,
                          child: SmsHistoryPage(
                            borrowId: widget.item.aBorrowId!,
                            collectionOrderId: widget.item.id!,
                            repayInfo: widget.repayInfo,
                            period: widget.period!,
                          ));
                    },
                  );
                },
              ),
              // Gaps.hGap4,
              // Gaps.hGap4,
              OrderItemButton(
                key: Key('order_button_22_${widget.index}'),
                text: "All",
                textColor: isDark ? Colours.dark_button_text : Colors.white,
                bgColor: widget.showContactDays > (widget.period?.lOverdueDays ?? 0)
                    ? Colors.grey
                    : (isDark ? Colours.dark_app_main : Colours.app_main),
                icon: Icon(Icons.group_add, size: 15, color: Colors.white),
                onTap: () async {
                  if (widget.showContactDays > (widget.period?.lOverdueDays ?? 0)) {
                    showToast(
                        'Will show all contact overdue days: ${widget.showContactDays}');
                    return;
                  }
                  _showContactListModal(allContacts: true);
                },
              ),
              // Gaps.hGap4,
              OrderItemButton(
                key: Key('order_button_2_${widget.index}'),
                text: "Contacts",
                textColor: isDark ? Colours.dark_button_text : Colors.white,
                bgColor: isDark ? Colours.dark_app_main : Colours.app_main,
                icon: Icon(Icons.people_alt_outlined,
                    size: 15, color: Colors.white),
                onTap: () async {
                  _showContactListModal();
                },
              ),
              // Gaps.hGap4,
              OrderItemButton(
                key: Key('order_button_more_${widget.index}'),
                text: "Actions",
                textColor: isDark ? Colours.dark_button_text : Colors.white,
                bgColor: isDark ? Colours.dark_app_main : Colours.app_main,
                icon: Icon(Icons.more_vert,
                    size: 15, color: Colors.white),
                onTap: () async {
                  _showSendTypeDialog();
                },
              ),
              // Gaps.hGap4,
              // InkWell(
              //     onTap: () {
              //       _showSendTypeDialog();
              //     },
              //     child: Container(
              //       padding: EdgeInsets.only(top: 7, bottom: 7),
              //       decoration: BoxDecoration(
              //         color: Colors.blueAccent,
              //         borderRadius: BorderRadius.circular(4.0),
              //       ),
              //       child: Icon(Icons.more_vert, size: 15, color: Colors.white),
              //     )),
            ],
          )
      ],
    );
  }

  /// 计算奖金金额
  ///
  /// [provider] 用户提供者
  /// [item] 订单数据
  /// [period] 期间数据
  ///
  /// 返回计算出的奖金金额
  int _calculateBonus(UserProvider provider, CollectionOrderData item,
      CollectionLogOtherPeriod? period) {
    // 基础佣金率
    final double baseCommissionRate =
        provider.userEntity.profile!.aETodayCommissionRate!;


    double additionalRate = _additionBonus.toDouble();


    // 总佣金率
    final double totalCommissionRate = baseCommissionRate + additionalRate;

    // 计算可收取金额
    int collectableAmount = 0;
    if (period?.fExpectRepayTotalAmount != null) {
      collectableAmount = period!.fExpectRepayTotalAmount! -
          period.pPaidInterest! -
          period.qPaidServiceFee! -
          period.sPaidOverdueAmount! -
          period.oPaidBorrowAmount! -
          period.uDeductionTotalAmount!;
    }

    // 计算最终奖金
    return (totalCommissionRate * collectableAmount / 100).toInt();
  }

  String _getKpiLevelDisplay(int level) {
    switch (level) {
      case 1:
        return 'Lv. BB';
      case 2:
        return 'Lv. B';
      case 3:
        return 'Lv. A';
      case 4:
        return 'Lv. AA';
      default:
        return 'lv.$level';
    }
  }

  /// 对联系人列表进行排序
  ///
  /// 排序规则：
  /// 0. lSmsCount == 999 的记录始终排在最前
  /// 1. 然后按 rWaStatus 优先级排序：40 最前；30/20 最后；其他居中
  /// 2. 然后按 aAAAAHKContactSmss 的短信条数降序
  /// 3. 最后按 tWaWeight 降序
  ///
  /// [contactList] 需要排序的联系人列表
  /// 返回排序后的联系人列表
  List<CollectionLogOtherContactInfo2Data> _sortContactList(
      List<CollectionLogOtherContactInfo2Data> contactList) {
    final List<CollectionLogOtherContactInfo2Data> sortedList =
        List.from(contactList);

    sortedList.sort((a, b) {
      final aIsPriority = a.lSmsCount == 999;
      final bIsPriority = b.lSmsCount == 999;
      if (aIsPriority && !bIsPriority) {
        return -1;
      }
      if (!aIsPriority && bIsPriority) {
        return 1;
      }

      final int aStatus = a.aAAAAHLContactWeights?.rWaStatus ?? a.rWaStatus ?? 0;
      final int bStatus = b.aAAAAHLContactWeights?.rWaStatus ?? b.rWaStatus ?? 0;

      int statusRank(int status) {
        if (status == 40) {
          return 0;
        }
        if (status == 30 || status == 20) {
          return 2;
        }
        return 1;
      }

      final int aStatusRank = statusRank(aStatus);
      final int bStatusRank = statusRank(bStatus);
      if (aStatusRank != bStatusRank) {
        return aStatusRank.compareTo(bStatusRank);
      }
      if (aStatus != bStatus) {
        return bStatus.compareTo(aStatus);
      }

      final int aSmsCount = a.aAAAAHKContactSmss?.length ?? 0;
      final int bSmsCount = b.aAAAAHKContactSmss?.length ?? 0;
      if (aSmsCount != bSmsCount) {
        return bSmsCount.compareTo(aSmsCount);
      }

      final int aWaWeight = a.aAAAAHLContactWeights?.tWaWeight ?? a.tWaWeight ?? 0;
      final int bWaWeight = b.aAAAAHLContactWeights?.tWaWeight ?? b.tWaWeight ?? 0;
      if (aWaWeight != bWaWeight) {
        return bWaWeight.compareTo(aWaWeight);
      }

      // Lowest priority:
      // empty cRelation -> last, "other" -> second last.
      int relationRank(String? relation) {
        final String value = (relation ?? '').trim().toLowerCase();
        if (value.isEmpty) {
          return 2;
        }
        if (value == 'other') {
          return 1;
        }
        return 0;
      }

      final int aRelationRank = relationRank(a.cRelation);
      final int bRelationRank = relationRank(b.cRelation);
      if (aRelationRank != bRelationRank) {
        return aRelationRank.compareTo(bRelationRank);
      }

      return 0;
    });

    return sortedList;
  }
}

class OrderItemButton extends StatelessWidget {
  const OrderItemButton(
      {super.key,
      this.bgColor,
      this.textColor,
      required this.text,
      this.onTap,
      this.icon,
      this.fontSize});

  final Color? bgColor;
  final Color? textColor;
  final GestureTapCallback? onTap;
  final String text;
  final Widget? icon;
  final double? fontSize;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 2.0),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(4.0),
        ),
        constraints: BoxConstraints(
          minWidth: icon != null ? 56 : 44,
          maxHeight: 30.0,
          minHeight: 30.0,
        ),
        child: icon != null
            ? Row(
                children: [
                  Text(text,
                      style: TextStyle(
                          fontSize: fontSize ?? 12, color: textColor)),
                  Gaps.hGap1,
                  icon!,
                ],
              )
            : Text(
                text,
                style: TextStyle(fontSize: fontSize ?? Dimens.font_sp14, color: textColor),
              ),
      ),
    );
  }
}

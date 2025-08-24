import 'package:bounty_hunter/models/s_g_contact_entity.dart';
import 'package:bounty_hunter/order/page/sms_history_page.dart';
import 'package:bounty_hunter/order/widgets/sms_dialog.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bounty_hunter/order/widgets/pay_type_dialog.dart';
import 'package:bounty_hunter/res/resources.dart';
import 'package:bounty_hunter/routers/fluro_navigator.dart';
import 'package:bounty_hunter/util/other_utils.dart';
import 'package:bounty_hunter/util/theme_utils.dart';
import 'package:bounty_hunter/util/toast_utils.dart';
import 'package:bounty_hunter/widgets/my_card.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../models/admin_entity.dart';
import '../../models/collection_log_entity.dart';
import '../../models/collection_order_entity.dart';
import '../../models/product_entity.dart';
import '../../providers/user_provider.dart';
import '../../shop/widgets/price_input_dialog.dart';
import '../order_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:clipboard/clipboard.dart';

import 'dart:ui';

import 'add_note.dart';
import 'contact_dialog.dart';

class OrderItem extends StatelessWidget {
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
    required this.track,
    required this.period,
    this.onSendSms,
    this.inList = true,
    required this.allContactList,
  });

  final int tabIndex;
  final int index;
  final int showContactDays;
  final bool inList;
  final CollectionOrderData item;
  final List<ProductData> products;
  final List<AdminData> admins;
  final List<CollectionLogOtherContactInfo2Data> contactList;
  final List<CollectionLogOtherContactInfo2Data> allContactList;
  final List<CollectionLogOtherSmsHistory> smsHistory;
  final CollectionLogOtherRepayInfo? repayInfo;
  final CollectionLogOtherTrack? track;
  final CollectionLogOtherPeriod? period;
  final void Function(int, String, {String? phone, int? contactId})? onSendSms;

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDark;
    Color shadowColor = Colors.transparent;
    Color buttonColor = isDark ? Colours.dark_app_main : Colours.app_main;
    if (inList) {
      if (item.aNCurrentDayLogCount! == 0) {
        shadowColor = isDark ? Colors.white : Colors.redAccent.withOpacity(0.2);
        buttonColor = Colors.redAccent;
      } else if (item.aOCurrentDayCallCount! == 0) {
        shadowColor =
            isDark ? Colors.white : Color(0xFF3BA28D).withOpacity(0.2);
        buttonColor = Color(0xFF3BA28D);
      }
    }
    if (item.tBorrowSn == 'QRSOSEDpZn') {
      print('');
    }
    return Padding(
        padding: inList ? const EdgeInsets.only(top: 8.0) : EdgeInsets.zero,
        child: MyCard(
          shadowColor: shadowColor,
          onlyBottom: !inList,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: _buildContent(context, buttonColor),
          ),
        ));
  }

  Widget _buildContent(BuildContext context, Color buttonColor) {
    final TextStyle? textTextStyle = Theme.of(context)
        .textTheme
        .bodyMedium
        ?.copyWith(fontSize: Dimens.font_sp12);
    final bool isDark = context.isDark;
    void _showModalBottomSheet() {
      item.aLLastLog = '';
      NavigatorUtils.push(context,
          '${OrderRouter.notePage}?id=${item.id}&item=${item.toString()}');
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
                    allContacts ? allContactList : contactList),
                repayInfo: repayInfo,
                collectionOrderId: item.id!,
                period: period!,
                showContactDays: showContactDays,
                onSendSms: (templateId, smsContent,
                    {String? phone, int? contactId}) {
                  onSendSms?.call(templateId, smsContent,
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
        barrierDismissible: false,
        builder: (BuildContext context) {
          return SmsDialog(
            repayInfo: repayInfo,
            onPressed: (templateId, smsContent) {
              // Toast.show('收款类型：$templateId');
              onSendSms?.call(templateId, smsContent);
              // Toast.show('收款类型：$type');
            },
          );
        },
      );
    }

    void _showCallPhoneDialog(BuildContext context, String phone) {
      showDialog<void>(
        context: context,
        barrierDismissible: false,
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

    int calculateCalendarDaysDifference(DateTime start, DateTime end) {
      // 将两个日期都设置为午夜时间，只比较日期部分
      start = DateTime(start.year, start.month, start.day);
      end = DateTime(end.year, end.month, end.day);
      return end.difference(start).inDays;
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
                      text: item.aZPackage!, // 保持原样式
                      style: TextStyle(
                        fontSize: Dimens.font_sp14,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
            ),
            if (item.eCollectionAdminId != item.aVTmpCollectionAdminId)
              Row(
                children: [
                  Icon(
                    Icons.transfer_within_a_station,
                    color: Colors.red,
                    size: 12,
                  ),
                  Gaps.hGap2,
                  Text(
                      "${item.eCollectionAdminId! != item.aVTmpCollectionAdminId! && (period?.lOverdueDays ?? 0) < 9 ? '+5' : (period?.lOverdueDays ?? 0) > 8 ? '+20' : ''}% ",
                      style: TextStyle(color: Colors.red, fontSize: 12)),
                ],
              )
            else
              Gaps.empty,
            Gaps.hGap4,
            Container(
              padding: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.tertiary.withOpacity(0.1),
                borderRadius: const BorderRadius.all(Radius.circular(5)),
              ),
              child: Text(
                inList
                    ? item.aKNo!
                    : (DateTime.now()
                                .difference(DateTime.parse(
                                    track?.lastActiveTime ??
                                        '2000-07-10T18:58:39.000000Z'))
                                .inHours >=
                            24)
                        ? 'Last used: ${DateTime.now().difference(DateTime.parse(track?.lastActiveTime ?? '2000-07-10T18:58:39.000000Z')).inDays} days ago'
                        : 'Last used: ${DateTime.now().difference(DateTime.parse(track?.lastActiveTime ?? '2000-07-10T18:58:39.000000Z')).inHours} hours ago',
                style: TextStyle(
                  fontSize: Dimens.font_sp12,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
            ),
          ],
        ),
        Gaps.vGap4,
        Gaps.line,
        Gaps.vGap4,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 2,
              child: InkWell(
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 4.0),
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
                          TextSpan(text: item.tBorrowSn),
                        ],
                      ),
                    ),
                    Gaps.hGap2,
                    Icon(
                      Icons.content_copy,
                      size: 14,
                      color: Colours.app_main.withOpacity(0.6),
                    ),
                  ],
                ),
                onTap: () {
                  FlutterClipboard.copy('${item.uPhone!}-${item.tBorrowSn!}');
                },
              ),
            ),
            Gaps.hGap4,
            Expanded(
              flex: 3,
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 4.0),
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
                        TextSpan(text: item.vName),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Gaps.hGap4,
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 4.0),
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
                        TextSpan(text: item.uPhone),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Gaps.vGap8,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 2,
              child: InkWell(
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 4.0),
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
                              text: Utils.formatPrice2(
                                  (period?.fExpectRepayTotalAmount ?? 0) -
                                      (period?.qPaidServiceFee ?? 0) -
                                      (period?.pPaidInterest ?? 0) -
                                      (period?.sPaidOverdueAmount ?? 0) -
                                      (period?.oPaidBorrowAmount ?? 0) -
                                      (period?.uDeductionTotalAmount ?? 0))),
                        ],
                      ),
                    ),
                    Gaps.hGap2,
                  ],
                ),
                onTap: () {},
              ),
            ),
            Gaps.hGap4,
            Expanded(
              flex: 3,
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 4.0),
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
                          text: Utils.formatPrice2(period?.nPaidAmount ?? 0),
                          style: period?.nPaidAmount == 0
                              ? textTextStyle
                              : TextStyle(
                                  fontSize: 12, color: Colors.greenAccent),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Gaps.hGap4,
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 4.0),
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
                        // TextSpan(text: 'overdue ${DateTime.parse(item.pExpectRepayTime!).difference(DateTime.now()).inDays} days'),
                        TextSpan(
                            text:
                                'overdue ${calculateCalendarDaysDifference(DateTime.parse(item.pExpectRepayTime!), DateTime.now())} days'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Gaps.vGap8,
        // Gaps.line,
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
                        Text((DateTime.parse(item.sFlowOutTime!)
                                    .difference(DateTime.now())
                                    .inHours >=
                                24)
                            ? '${DateTime.now().difference(DateTime.parse(item.sFlowOutTime!)).inDays} days left'
                            : '${DateTime.now().difference(DateTime.parse(item.sFlowOutTime!)).inHours} hours left'),
                        Text(
                            item.aDLastLogTime != null &&
                                    item.aDLastLogTime!.isNotEmpty
                                ? 'Last record: ${DateFormat('MMM d, hh:mm a', 'en_US').format(DateTime.parse(item.aDLastLogTime!))}'
                                : '',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(fontSize: 8)),
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
                              '${_calculateBonus(provider, item, period)} bonus'),
                          Text(
                              "lv.${provider.userEntity.profile!.iTodayCurrentKpiLevel!} with ${provider.userEntity.profile!.aETodayCommissionRate!}${item.eCollectionAdminId! != item.aVTmpCollectionAdminId! && (period?.lOverdueDays ?? 0) < 9 ? '+5' : (period?.lOverdueDays ?? 0) > 8 ? '+20' : ''}% of amount",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(fontSize: 8))
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

        Gaps.vGap8,
        Gaps.line,
        Gaps.vGap8,
        if (inList)
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  item.aLLastLog!,
                  style: TextStyle(color: Colors.grey, fontSize: 11),
                  maxLines: 2, // 设置最大行数为2
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Gaps.hGap4,
              OrderItemButton(
                key: Key('order_button_3_$index'),
                text: 'Detail',
                textColor: isDark ? Colours.dark_button_text : Colors.white,
                bgColor: buttonColor,
                onTap: () {
                  _showModalBottomSheet();
                },
              )
            ],
          )
        else
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              OrderItemButton(
                key: Key('order_reducation'),
                text: "Waive",
                icon: Icon(Icons.next_plan_outlined,
                    size: 15, color: Colors.white),
                textColor: isDark ? Colours.dark_button_text : Colors.white,
                bgColor: isDark ? Colours.dark_app_main : Colours.app_main,
                onTap: () {
                  NavigatorUtils.push(context,
                      '${OrderRouter.orderInfoPage}?id=${item.id}&track=${track.toString()}&period=${period.toString()}');
                },
              ),
              Gaps.hGap4,
              OrderItemButton(
                key: Key('sms_recording'),
                text: "Sms Record",
                textColor: isDark ? Colours.dark_button_text : Colors.white,
                bgColor: isDark ? Colours.dark_app_main : Colours.app_main,
                icon: Icon(Icons.forum_outlined, size: 15, color: Colors.white),
                onTap: () async {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) {
                      return Container(
                          height: 580,
                          color: Colors.grey,
                          child: SmsHistoryPage(
                            borrowId: item.aBorrowId!,
                            collectionOrderId: item.id!,
                            repayInfo: repayInfo,
                            period: period!,
                          ));
                    },
                  );
                },
              ),
              // Gaps.hGap4,
              // OrderItemButton(
              //   key: Key('whatsapp'),
              //   text: "WA",
              //   textColor: isDark ? Colours.dark_button_text : Colors.white,
              //   bgColor: isDark ? Colours.dark_app_main : Colours.app_main,
              //   icon: FaIcon(FontAwesomeIcons.whatsapp, size: 16, color: Colors.white),
              //   onTap: () async {
              //     Utils.launchWhatsAppURL("234" + item.uPhone!);
              //   },
              // ),
              // Gaps.hGap4,
              // OrderItemButton(
              //   key: Key('order_button_2_send'),
              //   text: "VA",
              //   icon: Icon(Icons.credit_card, size: 15, color: Colors.white),
              //   textColor: isDark ? Colours.dark_button_text : Colors.white,
              //   bgColor: isDark ? Colours.dark_app_main : Colours.app_main,
              //   onTap: () {
              //     _showSmsDialog(context, repayInfo!);

              //   },
              // ),
              Gaps.hGap4,
              OrderItemButton(
                key: Key('order_button_22_$index'),
                text: "All Conts",
                textColor: isDark ? Colours.dark_button_text : Colors.white,
                bgColor: isDark ? Colours.dark_app_main : Colours.app_main,
                icon: Icon(Icons.group_add, size: 15, color: Colors.white),
                onTap: () async {
                  _showContactListModal(allContacts: true);
                },
              ),
              Gaps.hGap4,
              OrderItemButton(
                key: Key('order_button_2_$index'),
                text: "Contacts",
                textColor: isDark ? Colours.dark_button_text : Colors.white,
                bgColor: isDark ? Colours.dark_app_main : Colours.app_main,
                icon: Icon(Icons.people_alt_outlined,
                    size: 15, color: Colors.white),
                onTap: () async {
                  _showContactListModal();
                },
              ),
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

    // 计算额外佣金率
    final int overdueDays = period?.lOverdueDays ?? 0;
    final bool isDifferentAdmin =
        item.eCollectionAdminId! != item.aVTmpCollectionAdminId!;

    double additionalRate = 0.0;
    if (isDifferentAdmin) {
      if (overdueDays < 9) {
        additionalRate = 5.0;
      } else if (overdueDays > 8) {
        additionalRate = 20.0;
      }
    }

    // 总佣金率
    final double totalCommissionRate = baseCommissionRate + additionalRate;

    // 计算可收取金额
    int collectableAmount = 0;
    if (period?.fExpectRepayTotalAmount != null) {
      collectableAmount = period!.fExpectRepayTotalAmount! -
          period!.pPaidInterest! -
          period!.qPaidServiceFee! -
          period!.sPaidOverdueAmount! -
          period!.oPaidBorrowAmount! -
          period!.uDeductionTotalAmount!;
    }

    // 计算最终奖金
    return (totalCommissionRate * collectableAmount / 100).toInt();
  }

  /// 对联系人列表进行排序
  ///
  /// 排序规则：
  /// 0. 最高优先级：l_sms_count = 999 的记录始终排在第一位
  /// 1. 然后按照 aAAAAHLContactWeights 中的 t_wa_weight desc, r_wa_status desc, q_phone_status desc 排序
  /// 2. 最后按照 CollectionLogOtherContactInfo2Data 的属性 t_wa_weight desc, r_wa_status desc 排序
  ///
  /// [contactList] 需要排序的联系人列表
  /// 返回排序后的联系人列表
  List<CollectionLogOtherContactInfo2Data> _sortContactList(
      List<CollectionLogOtherContactInfo2Data> contactList) {
    final List<CollectionLogOtherContactInfo2Data> sortedList =
        List.from(contactList);

    sortedList.sort((a, b) {
      // 最高优先级：l_sms_count = 999 的记录始终排在第一位
      final aIsPriority = a.lSmsCount == 999;
      final bIsPriority = b.lSmsCount == 999;

      if (aIsPriority && !bIsPriority) {
        return -1; // a是优先级记录，b不是，a排在前面
      } else if (!aIsPriority && bIsPriority) {
        return 1; // b是优先级记录，a不是，b排在前面
      } else if (aIsPriority && bIsPriority) {
        // 两个都是优先级记录，保持原有顺序
        return 0;
      }

      // 非优先级记录的排序逻辑
      // 第一级排序：按照 aAAAAHLContactWeights 中的属性排序
      final aWeights = a.aAAAAHLContactWeights;
      final bWeights = b.aAAAAHLContactWeights;

      if (aWeights != null && bWeights != null) {
        // 比较 t_wa_weight (降序)
        if (aWeights.tWaWeight != bWeights.tWaWeight) {
          return (bWeights.tWaWeight ?? 0).compareTo(aWeights.tWaWeight ?? 0);
        }

        // 比较 r_wa_status (降序)
        if (aWeights.rWaStatus != bWeights.rWaStatus) {
          return (bWeights.rWaStatus ?? 0).compareTo(aWeights.rWaStatus ?? 0);
        }

        // 比较 q_phone_status (降序)
        if (aWeights.qPhoneStatus != bWeights.qPhoneStatus) {
          return (bWeights.qPhoneStatus ?? 0)
              .compareTo(aWeights.qPhoneStatus ?? 0);
        }
      } else if (aWeights != null) {
        // a有权重，b没有权重，a排在前面
        return -1;
      } else if (bWeights != null) {
        // b有权重，a没有权重，b排在前面
        return 1;
      }

      // 第二级排序：按照 CollectionLogOtherContactInfo2Data 的属性排序
      // 比较 t_wa_weight (降序)
      if (a.tWaWeight != b.tWaWeight) {
        return (b.tWaWeight ?? 0).compareTo(a.tWaWeight ?? 0);
      }

      // 比较 r_wa_status (降序)
      if (a.rWaStatus != b.rWaStatus) {
        return (b.rWaStatus ?? 0).compareTo(a.rWaStatus ?? 0);
      }

      // 如果所有属性都相等，保持原有顺序
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
      this.icon});

  final Color? bgColor;
  final Color? textColor;
  final GestureTapCallback? onTap;
  final String text;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 6.0),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(4.0),
        ),
        constraints: BoxConstraints(
          minWidth: icon != null ? 58 : 44,
          maxHeight: 30.0,
          minHeight: 30.0,
        ),
        child: icon != null
            ? Row(
                children: [
                  Text(text,
                      style: TextStyle(
                          fontSize: Dimens.font_sp14, color: textColor)),
                  Gaps.hGap4,
                  icon!,
                ],
              )
            : Text(
                text,
                style: TextStyle(fontSize: Dimens.font_sp14, color: textColor),
              ),
      ),
    );
  }
}

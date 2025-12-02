import 'package:bounty_hunter/models/collection_order_entity.dart';
import 'package:bounty_hunter/models/h_k_contact_sms_entity.dart';
import 'package:bounty_hunter/mvp/base_page.dart';
import 'package:bounty_hunter/order/iview/sms_history_page_iview.dart';
import 'package:bounty_hunter/order/presenter/sms_history_page_presenter.dart';
import 'package:bounty_hunter/util/cache.dart';
import 'package:bounty_hunter/util/other_utils.dart';
import 'package:flutter/material.dart';
import 'package:bounty_hunter/models/collection_log_entity.dart';
import 'package:bounty_hunter/res/gaps.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:sp_util/sp_util.dart';
import 'package:url_launcher/url_launcher.dart';

class SmsHistoryPage extends StatefulWidget {
  const SmsHistoryPage({
    super.key,
    required this.repayInfo,
    required this.borrowId,
    required this.collectionOrderId,
    required this.period,
  });
  final int collectionOrderId;
  final CollectionLogOtherRepayInfo? repayInfo;
  final int borrowId;
  final CollectionLogOtherPeriod period;
  @override
  State<SmsHistoryPage> createState() => _SmsHistoryPageState();
}

class _SmsHistoryPageState extends State<SmsHistoryPage>
    with BasePageMixin<SmsHistoryPage, SmsHistoryPresenter>
    implements SmsHistoryPageMvpView {
  List<HKContactSmsData> _list = <HKContactSmsData>[];
  late SmsHistoryPresenter _smsHistoryPresenter;
  int _selectedIndex = -1;

  @override
  SmsHistoryPresenter createPresenter() {
    _smsHistoryPresenter = SmsHistoryPresenter();
    return _smsHistoryPresenter;
  }

  @override
  void onRefresh() {
    _smsHistoryPresenter.index(
        widget.borrowId, 1, true); // Implement your logic her
  }

  @override
  void setList(List<HKContactSmsData> list) {
    setState(() {
      _list = list;
    });
  }

  Future<void> _callContact(String phone) async {
    final url = 'tel:$phone';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'cant launch $url';
    }
  }

  int calculateCalendarDaysDifference(DateTime start, DateTime end) {
    // 将两个日期都设置为午夜时间，只比较日期部分
    start = DateTime(start.year, start.month, start.day);
    end = DateTime(end.year, end.month, end.day);
    return end.difference(start).inDays;
  }

  @override
  Widget build(BuildContext context) {
    final int overdueDays = calculateCalendarDaysDifference(
        DateTime.parse(widget.repayInfo!.expectRepayTime!), DateTime.now());
    final List<Map<String, dynamic>> dataList =
        SpUtil.getObjectList('hJSmsTemplates')!.cast<Map<String, dynamic>>();
    // 先过滤e_days为1的元素，再进行后续处理
    final List<CollectionLogOtherHJSmsTemplate> templates2 =
        List<CollectionLogOtherHJSmsTemplate>.from(dataList.where((value) {
      return value['c_type'] == 28;
    }).map((value) {
      final template = $CollectionLogOtherHJSmsTemplateFromJson(value);
      // 替换所有占位符
      String processedTemplate = template.dTemplate!
          .replaceAll(
              '@expect_repay_amount@',
              Utils.formatPrice2((widget.period!.fExpectRepayTotalAmount ?? 0) -
                  (widget.period!.qPaidServiceFee ?? 0) -
                  (widget.period!.pPaidInterest ?? 0) -
                  (widget.period!.sPaidOverdueAmount ?? 0) -
                  (widget.period!.oPaidBorrowAmount ?? 0) -
                  (widget.period!.uDeductionTotalAmount ?? 0)))
          .replaceAll(
              '@expect_repay_time@',
              DateFormat('MMM d, yyyy')
                  .format(DateTime.parse(widget.repayInfo!.expectRepayTime!)))
          .replaceAll(
              '@overdue_days@', widget.repayInfo!.overdueDays.toString())
          .replaceAll('@mobile@', widget.repayInfo!.mobile!)
          .replaceAll('@phone@', widget.repayInfo!.phone!)
          .replaceAll('@bvn@', widget.repayInfo!.bvn!)
          .replaceAll('@name@', widget.repayInfo!.name!)
          .replaceAll('@borrow_amount@',
              Utils.formatPrice2(widget.period!.oPaidBorrowAmount!))
          .replaceAll('@loan_amount@',
              Utils.formatPrice2(widget.period!.oPaidBorrowAmount!))
          .replaceAll('@borrow_days@', widget.repayInfo!.borrowDays.toString())
          .replaceAll('@app_name@', widget.repayInfo!.appName!)
          .replaceAll('@url@', widget.repayInfo!.url!)
          .replaceAll('@product_name@', widget.repayInfo!.productName!)
          .replaceAll('@loan_time@', widget.repayInfo!.loanTime!)
          .replaceAll('@receive_bank@', widget.repayInfo!.receiveBank!)
          .replaceAll('@receive_bank_no@', widget.repayInfo!.receiveBankNo!)
          .replaceAll('@account_name@', widget.repayInfo!.accountName!)
          .replaceAll('@account_no@', widget.repayInfo!.accountNo!)
          .replaceAll('@account_bank@', widget.repayInfo!.accountBank!)
          .replaceAll(
              '@before_credit_amount@', widget.repayInfo!.beforeCreditAmount!)
          .replaceAll(
              '@after_credit_amount@', widget.repayInfo!.afterCreditAmount!)
          .replaceAll(
              '@change_credit_amount@', widget.repayInfo!.changeCreditAmount!)
          .replaceAll('@before_credit_fraction@',
              widget.repayInfo!.beforeCreditFraction!)
          .replaceAll(
              '@after_credit_fraction@', widget.repayInfo!.afterCreditFraction!)
          .replaceAll('@change_credit_fraction@',
              widget.repayInfo!.changeCreditFraction!)
          .replaceAll('@var1@', widget.repayInfo!.var1!)
          .replaceAll('@var2@', widget.repayInfo!.var2!)
          .replaceAll('@var3@', widget.repayInfo!.var3!)
          .replaceAll('@var4@', widget.repayInfo!.var4!)
          .replaceAll('@var5@', widget.repayInfo!.var5!)
          .replaceAll('@var6@', widget.repayInfo!.var6!)
          .replaceAll('@var7@', widget.repayInfo!.var7!)
          .replaceAll('@var8@', widget.repayInfo!.var8!)
          .replaceAll('@var9@', widget.repayInfo!.var9!)
          .replaceAll('@var10@', widget.repayInfo!.var10!);
      return template.copyWith(dTemplate: processedTemplate);
    })).toList();

    Future<void> launchAction(int type, HKContactSmsData record) async {
      // 显示模板选择对话框
      if (type != 2) {
        final CollectionLogOtherHJSmsTemplate? selectedTemplate =
            await showModalBottomSheet<CollectionLogOtherHJSmsTemplate>(
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          builder: (BuildContext context) {
            return Container(
              padding: EdgeInsets.only(
                top: 16,
                left: 16,
                right: 16,
                bottom: MediaQuery.of(context).viewInsets.bottom + 16,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: templates2.map((template) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: InkWell(
                        onTap: () => Navigator.pop(context, template),
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            template.sName ?? 'Empty message.',
                            style: const TextStyle(
                              fontSize: 15,
                              height: 1.4,
                            ),
                            softWrap: true,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            );
          },
        );
        if (selectedTemplate != null) {
          if (type == 1) {
            await Cache().appendToStringList('action_sms_history',
                '$type:${widget.collectionOrderId}:${record.id}:${selectedTemplate.id}');
            Utils.launchWhatsAppURL('234${record.address!}',
                message: selectedTemplate.dTemplate);
          } else if (type == 3) {
            await Cache().appendToStringList('action_sms_history',
                '$type:${widget.collectionOrderId}:${record.id}:${selectedTemplate.id}');
            launch('sms:${record.address}?body=${selectedTemplate.dTemplate}');
          }
        }
      } else if (type == 2) {
        await Cache().appendToStringList('action_sms_history',
            '$type:${widget.collectionOrderId}:${record.id}:0');
        final url = 'tel:${record.address}';
        if (await canLaunch(url)) {
          await launch(url);
        }
      }
    }

    return Container(
      padding: const EdgeInsets.only(left: 6, right: 6, top: 6),
      color: Colors.grey.shade200,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8.0),
            topRight: Radius.circular(8.0),
          ),
        ),
        child: ListView.builder(
          itemCount: _list.length,
          itemBuilder: (context, index) {
            final record = _list[index];
            return Card(
              margin: const EdgeInsets.all(8.0),
              color: _selectedIndex == index
                  ? const Color.fromARGB(255, 210, 234, 253)
                  : Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                            record.aAContactId! > 0
                                ? Icons.perm_contact_calendar
                                : Icons.device_unknown,
                            size: 16,
                            color: record.aAContactId! > 0
                                ? Colors.blueAccent
                                : Colors.grey.shade400),
                        Text(
                          record.aBContactName != null &&
                                  record.aBContactName!.isNotEmpty
                              ? record.aBContactName!
                              : record.address!,
                          style: const TextStyle(fontSize: 14),
                        ),
                        const Expanded(child: Gaps.empty),
                        IconButton(
                          icon: const FaIcon(FontAwesomeIcons.whatsapp,
                              size: 16, color: Colors.greenAccent),
                          onPressed: () {
                            setState(() {
                              _selectedIndex = index;
                            });
                            launchAction(1, record);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.message,
                              size: 16, color: Colors.blueAccent),
                          onPressed: () {
                            setState(() {
                              _selectedIndex = index;
                            });
                            launchAction(3, record);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.call,
                              size: 16, color: Colors.blueAccent),
                          onPressed: () {
                            setState(() {
                              _selectedIndex = index;
                            });
                            launchAction(2, record);
                          },
                        ),
                      ],
                    ),
                    // Gaps.vGap8,
                    Text(
                      record.body!,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    Gaps.vGap4,
                    Row(
                      children: [
                        const Expanded(child: Gaps.empty),
                        Text(
                          DateFormat('MMM d, yyyy hh:mm a', 'en_US').format(
                              DateTime.fromMillisecondsSinceEpoch(
                                  record.dateSent! * 1000)),
                          style:
                              const TextStyle(fontSize: 10, color: Colors.grey),
                        ),
                        Gaps.hGap8
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

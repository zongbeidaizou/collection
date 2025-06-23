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
  });
  final int collectionOrderId;
  final CollectionLogOtherRepayInfo? repayInfo;
  final int borrowId;

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
        List<CollectionLogOtherHJSmsTemplate>.from(dataList
            .where((value) {
      return value['c_type'] == 28;
    }).map((value) {
      final template = $CollectionLogOtherHJSmsTemplateFromJson(value);
      // 替换所有占位符
      String processedTemplate = template.dTemplate!
          .replaceAll('@name@', widget.repayInfo!.name!)
          .replaceAll('@phone@', widget.repayInfo!.phone!)
          .replaceAll('@bvn@', widget.repayInfo!.bvn!)
          .replaceAll(
              '@expect_repay_time@',
              DateFormat('MMM d, yyyy')
                  .format(DateTime.parse(widget.repayInfo!.expectRepayTime!)))
          .replaceAll(
              '@expect_repay_amount@', widget.repayInfo!.expectRepayAmount!)
          .replaceAll(
              '@overdue_days@', widget.repayInfo!.overdueDays.toString())
          .replaceAll('@mobile@', widget.repayInfo!.mobile!)
          .replaceAll('@borrow_amount@', widget.repayInfo!.borrowAmount!)
          .replaceAll('@loan_amount@', widget.repayInfo!.loanAmount!)
          .replaceAll('@borrow_days@', widget.repayInfo!.borrowDays.toString())
          .replaceAll('@account_no@', widget.repayInfo!.accountNo!)
          .replaceAll('@account_bank@', widget.repayInfo!.accountBank!);
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
                            template.dTemplate! != '' ? template.dTemplate! : 'Custom message.',
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

import 'package:bounty_hunter/models/collection_order_entity.dart';
import 'package:bounty_hunter/models/h_k_contact_sms_entity.dart';
import 'package:bounty_hunter/mvp/base_page.dart';
import 'package:bounty_hunter/order/iview/sms_history_page_iview.dart';
import 'package:bounty_hunter/order/presenter/sms_history_page_presenter.dart';
import 'package:bounty_hunter/util/other_utils.dart';
import 'package:flutter/material.dart';
import 'package:bounty_hunter/models/collection_log_entity.dart';
import 'package:bounty_hunter/res/gaps.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class SmsHistoryPage extends StatefulWidget {
  const SmsHistoryPage({
    super.key,
    required this.repayInfo,
    required this.borrowId,
  });
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
    _smsHistoryPresenter.index(1, 1, true); // Implement your logic her
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

  @override
  Widget build(BuildContext context) {
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
                            Utils.launchWhatsAppURL('234${record.address!}',
                                message:
                                    "${widget.repayInfo!.name!}'s loan of NGN ${widget.repayInfo!.expectRepayAmount!} on the <${widget.repayInfo!.appName!}> was due on ${DateFormat('MMM d, yyyy').format(DateTime.parse(widget.repayInfo!.expectRepayTime!))}, and remains unpaid to date.");
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.call,
                              size: 16, color: Colors.blueAccent),
                          onPressed: () {
                            setState(() {
                              _selectedIndex = index;
                            });
                            _callContact(record.address!);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.message,
                              size: 16, color: Colors.blueAccent),
                          onPressed: () {
                            setState(() {
                              _selectedIndex = index;
                            });
                            launch(
                                "sms:${record.address}?body=${widget.repayInfo!.name!}'s loan of NGN ${widget.repayInfo!.expectRepayAmount!} on the <${widget.repayInfo!.appName!}> was due on ${DateFormat('MMM d, yyyy').format(DateTime.parse(widget.repayInfo!.expectRepayTime!))}, and remains unpaid to date.");
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

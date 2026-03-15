import 'package:bounty_hunter/account/account_router.dart';
import 'package:bounty_hunter/account/iview/account_record_list_iview.dart';
import 'package:bounty_hunter/account/presenter/account_record_list_presenter.dart';
import 'package:bounty_hunter/models/admin_entity.dart';
import 'package:bounty_hunter/models/collection_log2_entity.dart';
import 'package:bounty_hunter/models/product_entity.dart';
import 'package:bounty_hunter/util/other_utils.dart';
import 'package:bounty_hunter/util/screen_utils.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:bounty_hunter/res/resources.dart';
import 'package:bounty_hunter/util/theme_utils.dart';
import 'package:bounty_hunter/widgets/my_app_bar.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../goods/goods_router.dart';
import '../../models/commission_entity.dart';
import '../../mvp/base_page.dart';
import '../../order/page/order_page.dart';
import '../../providers/refresh_provider.dart';
import '../../providers/user_provider.dart';
import '../../routers/fluro_navigator.dart';
import '../../widgets/load_image.dart';
import 'package:visibility_detector/visibility_detector.dart';

const List<Color> bgColors = [
  Colors.white,
  Colors.white,
  Colors.white,
  Colors.white,
  Colors.white,
  Color(0xFFD4E2FA),
  Colors.white,
  Colors.white,
  Colors.white,
  Colors.white,
];
const List<String> groupNames = [
  '',
  'BB',
  'B',
  'A',
  'AA',
];
const typeColors = [
  Color.fromARGB(255, 65, 83, 0), //0 罚款
  Colors.green, //1结清
  Colors.purpleAccent, //2日达标奖金
  Color.fromARGB(255, 137, 139, 141),//3部分还款
  Color.fromARGB(218, 218, 125, 4),//4周排名奖金
  Color.fromARGB(255, 244, 0, 159),//5月度奖金
  Colors.red,//6转移奖金
  Color.fromARGB(255, 128, 188, 225),//7展期奖金·
  Color.fromARGB(255, 244, 234, 52),//8注册奖金
  Color.fromARGB(255, 187, 230, 118),//9申请奖金
];
const typeIcons = [
  Icons.money_off_csred_outlined, //0 罚款
  Icons.lens, //1结清
  Icons.adjust, //2日达标奖金
  Icons.radio_button_off, //3部分还款
  Icons.bar_chart_rounded, //4周排名奖金
  Icons.golf_course, //5月度奖金
  Icons.transfer_within_a_station, //6转移奖金
  Icons.extension_outlined, //7展期奖金
  Icons.person_outline_outlined, //8注册奖金
  Icons.how_to_reg_outlined, //9申请奖金

];

const typeDescriptions = [
  'Penalty', //0 罚款
  'Settled', //1结清
  'Achievement', //达标佣金
  'Partial Repayment', //3部分还款
  'Weekly Ranking Bonus', //4周排名奖金
  'Monthly Bonus', //5月度奖金
  'Transfer Bonus', //6转移奖金
  'Extension Bonus', //7展期奖金
  'Registration Bonus', //8注册奖金
  'Application Bonus', //9申请奖金
];

/// design/6店铺-账户/index.html#artboard1
class AccountRecordListPage extends StatefulWidget {
  const AccountRecordListPage({super.key, required this.searchKeyword});
  final String searchKeyword;

  @override
  _AccountRecordListPageState createState() => _AccountRecordListPageState();
}

class _AccountRecordListPageState extends State<AccountRecordListPage>
    with
        AutomaticKeepAliveClientMixin<AccountRecordListPage>,
        SingleTickerProviderStateMixin,
        BasePageMixin<AccountRecordListPage, AccountRecordListPresenter>
    implements AccountRecordListMvpView {
  final GlobalKey _addKey = GlobalKey();
  late AccountRecordListPresenter _accountRecordListPresenter;
  late int _currentPage = 1;
  final List<CommissionData> _list = [];
  bool _isLoading = false;
  late int _maxPage;
  @override
  AccountRecordListPresenter createPresenter() {
    _accountRecordListPresenter = AccountRecordListPresenter();
    return _accountRecordListPresenter;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _onRefresh();
      // _accountRecordListPresenter.index(1, true, keyword: widget.searchKeyword);
    });
  }

  @override
  void didUpdateWidget(AccountRecordListPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 当搜索关键词变化时，重新请求数据
    // if (oldWidget.searchKeyword != widget.searchKeyword) {
    //   setState(() {
    //     _list.clear();
    //   });
    //   _accountRecordListPresenter.index(1, false,
    //       keyword: widget.searchKeyword);
    // }
  }

  @override
  void onRefresh() {
    // TODO: implement onRefresh
  }

  @override
  void setAdmin(List<AdminData> admins) {
    // TODO: implement setAdmin
  }

  @override
  void setCurrentPage(int currentPage) {
    _currentPage = currentPage;
  }

  @override
  Future<void> _onRefresh() async {
    setState(() {
      _list.clear();
      _currentPage = 1;
    });
    _accountRecordListPresenter.index(1, true, keyword: widget.searchKeyword);
  }

  @override
  void setLogs(List<CommissionData> logs, {bool clear = false}) {
    if (clear) {
      _list.clear();
    }
    setState(() {
      _list.addAll(logs);
      _isLoading = false;
    });
  }

  @override
  void setPageSize(int pageSize) {
    _maxPage = pageSize;
  }

  @override
  void setProduct(List<ProductData> product) {
    // TODO: implement setProduct
  }

  bool _hasMore() {
    return _currentPage < _maxPage;
  }

  Future<void> _loadMore() async {
    if (_isLoading) {
      return;
    }
    if (!_hasMore()) {
      return;
    }
    _isLoading = true;
    setState(() {
      _currentPage++;
    });
    _accountRecordListPresenter.index(_currentPage, true,
        keyword: widget.searchKeyword);
  }

  @override
  bool get wantKeepAlive => false;
  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDark;
    final Color? iconColor = ThemeUtils.getIconColor(context);

    return Scaffold(
      appBar: widget.searchKeyword == ''
          ? AppBar(
              automaticallyImplyLeading: false,
              centerTitle: true,
              backgroundColor: Colours.app_main,
              flexibleSpace: isDark
                  ? Container(
                      height: 115.0,
                      color: Colours.dark_bg_color,
                    )
                  : LoadAssetImage(
                      'statistic/statistic_bg',
                      width: context.width,
                      height: 115.0,
                      fit: BoxFit.fill,
                    ),
              // toolbarHeight: 30,
              title: Text("Bonus Record",
                  style: TextStyle(color: ThemeUtils.getTextColor(context))),
              actions: <Widget>[
                // IconButton(
                //   tooltip: 'mark all as read',
                //   onPressed: () {
                //     _accountRecordListPresenter.markAsRead(true);
                //   },
                //   icon: Icon(
                //     Icons.auto_awesome_outlined,
                //     color: Colors.white,
                //   ),
                // ),
                IconButton(
                  tooltip: 'Search',
                  onPressed: () {
                    NavigatorUtils.push(context, AccountRouter.search);
                  },
                  icon: Icon(
                    Icons.content_paste_search_outlined,
                    color: Colors.white,
                  ),
                ),
              ],
            )
          : null,
      body: NotificationListener(
        onNotification: (ScrollNotification note) {
          if (note.metrics.pixels == note.metrics.maxScrollExtent) {
            _loadMore();
          }
          return true;
        },
        child: RefreshIndicator(
          onRefresh: _onRefresh,
          displacement: 20.0,
          child: CustomScrollView(
            slivers: _list.isNotEmpty
                ? _buildGroups()
                : [
                    const SliverFillRemaining(
                        child: Center(
                            child: Text('no data, search by phone or sn')))
                  ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildGroups() {
    // 按日期分组
    final Map<String, List<CommissionData>> groupedLog = {};
    for (final CommissionData log in _list) {
      final DateTime createdAt = DateTime.parse(log.createdAt!);

      // 将日期格式化为年月日字符串
      String date = DateFormat('MMM d', 'en_US').format(createdAt);
      if (!groupedLog.containsKey(date)) {
        groupedLog[date] = [];
      }
      groupedLog[date]!.add(log);
    }

    // 生成Sliver列表
    return groupedLog.entries.map((entry) {
      String date = entry.key;
      List<CommissionData> logList = entry.value;
      int totalBonus =
          logList.fold(0, (sum, bonus) => sum + bonus.hCommissionAmount!);
      
      // Calculate bonus sum and count for each type
      final Map<int, Map<String, int>> typeStats = {};
      for (final log in logList) {
        final type = log.oType ?? 0;
        if (!typeStats.containsKey(type)) {
          typeStats[type] = {'sum': 0, 'count': 0};
        }
        typeStats[type]!['sum'] = (typeStats[type]!['sum'] ?? 0) + (log.hCommissionAmount ?? 0);
        typeStats[type]!['count'] = (typeStats[type]!['count'] ?? 0) + 1;
      }
      return SliverMainAxisGroup(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: SliverAppBarDelegate(
              Container(
                alignment: Alignment.centerLeft,
                width: double.infinity,
                color: Colors.blue[100],
                padding: const EdgeInsets.only(left: 10.0),
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '$date total: ',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500), // 默认黑色
                      ),
                      if (totalBonus > 0) ...[
                        TextSpan(
                          text: '$totalBonus',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        // Display type statistics with icons (sorted by type)
                        ...() {
                          final sortedEntries = typeStats.entries
                              .where((entry) => (entry.value['sum'] ?? 0) > 0)
                              .toList()
                            ..sort((a, b) => a.key.compareTo(b.key));
                          return sortedEntries;
                        }().expand((entry) {
                          final type = entry.key;
                          final sum = (entry.value['sum'] as int?) ?? 0;
                          final count = (entry.value['count'] as int?) ?? 0;
                              return [
                                WidgetSpan(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        showDialog<void>(
                                          context: context,
                                          builder: (BuildContext ctx) {
                                            return AlertDialog(
                                              title: Text(typeDescriptions[type]),
                                              content: Text(
                                                'Total: ₦$sum\n'
                                                'Count: $count',
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () => Navigator.of(ctx).pop(),
                                                  child: const Text('OK'),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      child: Tooltip(
                                        message: typeDescriptions[type],
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              typeIcons[type],
                                              size: 14,
                                              color: typeColors[type],
                                            ),
                                            Text(
                                              '₦$sum($count) ',
                                              style: TextStyle(
                                                color: typeColors[type],
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ];
                            }),

                      ],
                    ],
                  ),
                ),
              ),
              38.0,
            ),
          ),
          Container(
            child: SliverList(
              delegate: SliverChildBuilderDelegate(
                (_, index) {
                  return _buildItem(logList[index], index);
                },
                childCount: logList.length,
              ),
            ),
          ),
        ],
      );
    }).toList();
  }

  Widget _buildGoodsTag(Color color, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      margin: const EdgeInsets.only(right: 4.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(2.0),
      ),
      height: 16.0,
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: Dimens.font_sp10,
          height: 1.1,
        ),
      ),
    );
  }

  Widget _buildItem(CommissionData log, int i) {
    String txt = '${log.jRate}% Bonus (lv.${groupNames[log.kLevel!]})';
    if (log.oType == 1 || log.oType == 6 ||  log.oType == 3) {
      txt =
          'Acct#${log.zAccountNumber!} paid ${Utils.formatPrice2(log.vPaidAmount!)} at ${DateFormat('hh:mm a').format(DateTime.parse(log.createdAt!).toUtc().add(const Duration(hours: 1)))}, $txt';
    } else if (log.oType == 2) {
      txt = 'Tiered Achievement (lv.${groupNames[log.kLevel!]})';
    } else if (log.oType == 0 || log.oType == 4 || log.oType == 5) {
      txt = log.aAComment!;
    } else if (log.oType == 7) {
      txt = 'Extension Bonus  ';
    } else if (log.oType == 8) {
      txt =
          'Registered at ${DateFormat('hh:mm a').format(DateTime.parse(log.createdAt!).toUtc().add(const Duration(hours: 1)))}';
    } else if (log.oType == 9) {
      txt =
          'Apply at ${DateFormat('hh:mm a').format(DateTime.parse(log.createdAt!).toUtc().add(const Duration(hours: 1)))}';
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

    return Container(
      height: 52.0,
      width: double.infinity,
      padding: const EdgeInsets.all(9.0),
      decoration: BoxDecoration(
        color: ThemeUtils.getBackgroundColor(context),
        border: Border(
          bottom: Divider.createBorderSide(context, width: 0.8),
        ),
      ),
      child: IndexedSemantics(
        index: i,
        child: Stack(
          children: <Widget>[
            Row(
              children: [
                // Gaps.hGap4,
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: maskPhoneNumber(log.pPhone!),
                        style: TextStyle(color: ThemeUtils.getTextColor(context)),
                      ),
                      TextSpan(
                        text: ' - ${log.nBorrowSn}',
                        style: TextStyle(color: ThemeUtils.getTextColor(context)),
                      ),
                    ],
                  ),
                ),
                Gaps.hGap4,
                InkWell(
                  onTap: () {
                    FlutterClipboard.copy(
                        '${log.pPhone ?? ''} - ${log.nBorrowSn ?? ''}');
                  },
                  child: Icon(
                    Icons.content_copy,
                    size: 14,
                    color: Colours.app_main.withOpacity(0.6),
                  ),
                ),
                Gaps.hGap4,
                InkWell(
                  onTap: () {
                    FlutterClipboard.copy(
                        '${log.pPhone ?? ''} - ${log.nBorrowSn ?? ''}');
                  },
                  child: Row(
                    children: <Widget>[
                      // Offstage(
                      //   offstage: !(log.oType == 2),
                      //   child: _buildGoodsTag(
                      //       Theme.of(context).colorScheme.error, 'Achievement'),
                      // ),
                      // Offstage(
                      //   offstage: !(log.oType == 5),
                      //   child: _buildGoodsTag(Colors.purple, 'Monthly Bonus'),
                      // ),
                      // Offstage(
                      //   offstage: !(log.oType == 6),
                      //   child: _buildGoodsTag(Colors.blue, 'Transfer Bonus'),
                      // ),
                      // Offstage(
                      //   offstage: !(log.oType == 4),
                      //   child: _buildGoodsTag(
                      //       const Color.fromARGB(255, 39, 197, 160),
                      //       'Weekly Bonus'),
                      // ),
                      // Offstage(
                      //   offstage: !(log.oType == 3),
                      //   child: _buildGoodsTag(
                      //       Theme.of(context).primaryColor, 'Manually Bonus'),
                      // ),
                      Offstage(
                        offstage: !(log.wReaded == 0),
                        child: _buildGoodsTag(Colors.green, 'New'),
                      ),
                      // Offstage(
                      //   offstage: !(log.oType == 8),
                      //   child: _buildGoodsTag(
                      //       const Color.fromARGB(255, 180, 177, 180),
                      //       'Register Bonus'),
                      // ),
                      // Offstage(
                      //   offstage: !(log.oType == 9),
                      //   child: _buildGoodsTag(
                      //       const Color.fromARGB(255, 95, 92, 95),
                      //       'Apply Bonus'),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: 0.0,
              right: 0.0,
              child: Row(
                children: [
                  // if (log.uIsSettled != 1 && log.oType != 7)
                  //   Text('Unsettled', style: TextStyle(fontSize: Dimens.font_sp10, color: ThemeUtils.getTextColor(context)),)
                  // else
                  //   Gaps.empty,
                  // Gaps.hGap4,
                  Text(
                    "+${log.hCommissionAmount}",
                    style: TextStyle(
                      color: typeColors[log.oType!],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gaps.hGap4,
                  Icon(typeIcons[log.oType!], size: 14, color: typeColors[log.oType!],),
                  
                ],
              ),
            ),
            // Positioned(
            //   bottom: 10.0,
            //   left: 0.0,
            //   child: Center(
            //       child: Text(log.yDayIndex!.toString(),
            //           style: TextStyle(
            //               fontSize: 14, color: Colors.grey.shade500))),
            // ),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              child: Row(
                children: [
                  Text(
                    txt,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
            ),
            // Positioned(
            //   bottom: 0.0,
            //   right: 0.0,
            //   child: Text(txt, style: Theme.of(context).textTheme.titleSmall),
            // ),
          ],
        ),
      ),
    );
  }
}

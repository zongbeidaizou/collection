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
import 'package:flutter/services.dart';
import '../../goods/goods_router.dart';
import '../../models/commission_entity.dart';
import '../../mvp/base_page.dart';
import '../../order/page/order_page.dart';
import '../../providers/refresh_provider.dart';
import '../../providers/user_provider.dart';
import '../../routers/fluro_navigator.dart';
import '../../widgets/load_image.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../util/cache.dart';

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
  Color.fromARGB(255, 180, 182, 177),//10人工发放
];
const typeIcons = [
  Icons.money_off_csred_outlined, //0 罚款
  Icons.lens, //1结清
  Icons.my_location, //2日达标奖金
  Icons.nightlight, //3部分还款
  Icons.bar_chart_rounded, //4周排名奖金
  Icons.golf_course, //5月度奖金
  Icons.transfer_within_a_station, //6转移奖金
  Icons.extension_outlined, //7展期奖金
  Icons.person_outline_outlined, //8注册奖金
  Icons.how_to_reg_outlined, //9申请奖金
  Icons.build_outlined, //10人工发放


];

const typeDescriptions = [
  'Penalty', //0 罚款
  'Settled', //1结清
  'Achievement', //2达标佣金
  'Partial Repayment', //3部分还款
  'Weekly Ranking Bonus', //4周排名奖金
  'Monthly Bonus', //5月度奖金
  'Transfer Bonus', //6转移奖金
  'Extension Bonus', //7展期奖金
  'Registration Bonus', //8注册奖金
  'Application Bonus', //9申请奖金
  'Manual Bonus', //10人工发放
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
  final TextEditingController _phoneFilterController = TextEditingController();
  String _phoneFilterKeyword = '';
  bool _isLoading = false;
  late int _maxPage;
  bool _isAnalysisMode = false;
  DateTimeRange? _analysisDateRange;
  int? _analysisBonusType;

  DateTimeRange _currentWeekRange() {
    final DateTime now = DateTime.now();
    final DateTime monday = now.subtract(Duration(days: now.weekday - 1));
    final DateTime sunday = monday.add(const Duration(days: 6));
    return DateTimeRange(
      start: DateTime(monday.year, monday.month, monday.day),
      end: DateTime(sunday.year, sunday.month, sunday.day),
    );
  }

  String _formatApiDate(DateTime date) => DateFormat('yyyy-MM-dd').format(date);

  Future<void> _requestAnalysisData({bool showLoading = true}) async {
    final DateTimeRange range = _analysisDateRange ?? _currentWeekRange();
    await _accountRecordListPresenter.index(
      1,
      showLoading,
      keyword: widget.searchKeyword,
      startDate: _formatApiDate(range.start),
      endDate: _formatApiDate(range.end),
      bonusType: _analysisBonusType,
    );
  }
  @override
  AccountRecordListPresenter createPresenter() {
    _accountRecordListPresenter = AccountRecordListPresenter();
    return _accountRecordListPresenter;
  }

  @override
  void initState() {
    super.initState();
    _phoneFilterController.addListener(_onPhoneFilterChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // Avoid keyboard auto-opening when this page is pushed from a search page.
      FocusManager.instance.primaryFocus?.unfocus();
      try {
        await SystemChannels.textInput.invokeMethod<void>('TextInput.hide');
      } catch (_) {
        // Ignore if platform channel isn't available.
      }
      _onRefresh();
      // _accountRecordListPresenter.index(1, true, keyword: widget.searchKeyword);
    });
  }

  @override
  void dispose() {
    _phoneFilterController.dispose();
    super.dispose();
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
    if (_isAnalysisMode) {
      await _requestAnalysisData(showLoading: true);
      return;
    }
    _accountRecordListPresenter.index(1, true, keyword: widget.searchKeyword);
  }

  void _onPhoneFilterChanged() {
    final String normalized = _normalizePhone(_phoneFilterController.text);
    if (normalized == _phoneFilterKeyword) return;
    if (!mounted) return;
    setState(() {
      _phoneFilterKeyword = normalized;
    });
  }

  String _normalizePhone(String input) {
    final digitsOnly = input.replaceAll(RegExp(r'[^0-9]'), '');
    if (digitsOnly.isEmpty) return '';
    // Keep the last 10 digits for stable "contains" matching.
    return digitsOnly.length > 10
        ? digitsOnly.substring(digitsOnly.length - 10)
        : digitsOnly;
  }

  List<CommissionData> _getDisplayList() {
    if (_phoneFilterKeyword.isEmpty) return _list;
    return _list.where((log) {
      final String? phone = log.pPhone;
      if (phone == null || phone.isEmpty) return false;
      final String normalizedPhone = _normalizePhone(phone);
      return normalizedPhone.contains(_phoneFilterKeyword);
    }).toList();
  }

  List<CommissionData> _getAnalysisList() {
    return _list.where((log) {
      final DateTime? createdAt = DateTime.tryParse(log.createdAt ?? '');
      if (createdAt == null) {
        return false;
      }

      if (_analysisDateRange != null) {
        final DateTime start = DateTime(
          _analysisDateRange!.start.year,
          _analysisDateRange!.start.month,
          _analysisDateRange!.start.day,
        );
        final DateTime end = DateTime(
          _analysisDateRange!.end.year,
          _analysisDateRange!.end.month,
          _analysisDateRange!.end.day,
          23,
          59,
          59,
        );
        if (createdAt.isBefore(start) || createdAt.isAfter(end)) {
          return false;
        }
      }

      if (_analysisBonusType != null && log.oType != _analysisBonusType) {
        return false;
      }

      return true;
    }).toList();
  }

  Future<void> _pickAnalysisDateRange() async {
    final DateTime now = DateTime.now();
    final DateTime minSelectableDate =
        DateTime(now.year, now.month - 2, now.day);
    final DateTime firstDate = DateTime(
      minSelectableDate.year,
      minSelectableDate.month,
      minSelectableDate.day,
    );
    final DateTime lastDate = DateTime(now.year + 1, 12, 31);
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: firstDate,
      lastDate: lastDate,
      initialDateRange: _analysisDateRange,
    );
    if (picked == null || !mounted) return;

    if (picked.start.isBefore(firstDate)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Cannot select dates earlier than 2 months ago.'),
        ),
      );
      return;
    }

    final int rangeDays = picked.end.difference(picked.start).inDays + 1;
    if (rangeDays > 31) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Time range cannot exceed 31 days.'),
        ),
      );
      return;
    }

    setState(() {
      _analysisDateRange = picked;
      _list.clear();
      _currentPage = 1;
    });
    await _requestAnalysisData(showLoading: true);
  }

  String _analysisRangeLabel() {
    if (_analysisDateRange == null) {
      return 'All dates';
    }
    return '${DateFormat('yyyy-MM-dd').format(_analysisDateRange!.start)} ~ ${DateFormat('yyyy-MM-dd').format(_analysisDateRange!.end)}';
  }

  int _safeType(int? rawType) {
    final int type = rawType ?? 0;
    if (type < 0 || type >= typeDescriptions.length) {
      return 0;
    }
    return type;
  }

  String _formatSignedAmount(int amount) {
    if (amount > 0) return '+$amount';
    return '$amount';
  }

  Widget _buildAnalysisModeView() {
    final List<CommissionData> analysisList = _getAnalysisList();
    final int totalAmount = analysisList.fold<int>(
      0,
      (sum, item) => sum + (item.hCommissionAmount ?? 0),
    );
    final Map<int, Map<String, int>> typeSummary = {};
    for (final item in analysisList) {
      final int type = item.oType ?? 0;
      typeSummary[type] ??= {'count': 0, 'amount': 0};
      typeSummary[type]!['count'] = (typeSummary[type]!['count'] ?? 0) + 1;
      typeSummary[type]!['amount'] =
          (typeSummary[type]!['amount'] ?? 0) + (item.hCommissionAmount ?? 0);
    }

    final List<MapEntry<int, Map<String, int>>> sortedSummary =
        typeSummary.entries.toList()
          ..sort((a, b) => a.key.compareTo(b.key));

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            color: ThemeUtils.getBackgroundColor(context),
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.06),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.blue.withOpacity(0.2)),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: _pickAnalysisDateRange,
                              icon: const Icon(Icons.date_range, size: 18),
                              label: Text(
                                _analysisRangeLabel(),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          SizedBox(
                            width: 130,
                            child: DropdownButtonFormField<int?>(
                              value: _analysisBonusType,
                              isExpanded: true,
                              decoration: const InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 10,
                                ),
                                border: OutlineInputBorder(),
                              ),
                              hint: const Text('Type'),
                              onChanged: (value) async {
                                setState(() {
                                  _analysisBonusType = value;
                                  _list.clear();
                                  _currentPage = 1;
                                });
                                await _requestAnalysisData(showLoading: true);
                              },
                              items: [
                                const DropdownMenuItem<int?>(
                                  value: null,
                                  child: Text('All'),
                                ),
                                ...List.generate(typeDescriptions.length, (index) {
                                  return DropdownMenuItem<int?>(
                                    value: index,
                                    child: Text(typeDescriptions[index]),
                                  );
                                }),
                              ],
                            ),
                          ),
                          IconButton(
                            tooltip: 'Reset',
                            onPressed: () async {
                              setState(() {
                                _analysisDateRange = _currentWeekRange();
                                _analysisBonusType = null;
                                _list.clear();
                                _currentPage = 1;
                              });
                              await _requestAnalysisData(showLoading: true);
                            },
                            icon: const Icon(Icons.refresh),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: _buildSummaryCard(
                              title: 'Records',
                              value: '${analysisList.length}',
                              color: Colors.blue,
                              icon: Icons.list_alt,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _buildSummaryCard(
                              title: 'Total',
                              value: _formatSignedAmount(totalAmount),
                              color: totalAmount > 0
                                  ? Colors.green
                                  : totalAmount < 0
                                      ? Colors.red
                                      : Colors.grey,
                              icon: Icons.summarize,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                if (sortedSummary.isNotEmpty)
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: sortedSummary.map((entry) {
                      final int safeType = _safeType(entry.key);
                      final int count = entry.value['count'] ?? 0;
                      final int amount = entry.value['amount'] ?? 0;
                      return Chip(
                        visualDensity: VisualDensity.compact,
                        avatar: Icon(
                          typeIcons[safeType],
                          size: 14,
                          color: typeColors[safeType],
                        ),
                        label: Text(
                          '${typeDescriptions[safeType]} $count · ${_formatSignedAmount(amount)}',
                          style: TextStyle(color: typeColors[safeType]),
                        ),
                      );
                    }).toList(),
                  ),
              ],
            ),
          ),
        ),
        if (analysisList.isEmpty)
          SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.inbox_outlined, size: 40, color: Colors.grey),
                  SizedBox(height: 10),
                  Text('No matched records'),
                  SizedBox(height: 4),
                  Text(
                    'Try adjusting date range or bonus type.',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          )
        else
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, index) => _buildItem(analysisList[index], index),
              childCount: analysisList.length,
            ),
          ),
      ],
    );
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
    super.build(context);
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
              title: Container(
                height: 32,
                decoration: BoxDecoration(
                  color: isDark ? Colours.dark_material_bg : Colours.bg_gray,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: TextField(
                  autofocus: false,
                  controller: _phoneFilterController,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                    hintText: 'Search by phone (Local)',
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.only(
                      left: -8.0,
                      right: -16.0,
                      bottom: 14.0,
                    ),
                    icon: Padding(
                      padding: const EdgeInsets.only(
                        top: 8.0,
                        bottom: 8.0,
                        left: 8.0,
                      ),
                      child: LoadAssetImage(
                        'order/order_search',
                        color: isDark
                            ? Colours.dark_text_gray
                            : Colours.text_gray_c,
                        width: 18,
                        height: 18,
                      ),
                    ),
                    suffixIcon: _phoneFilterKeyword.isEmpty
                        ? null
                        : GestureDetector(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 16.0,
                                top: 8.0,
                                bottom: 8.0,
                              ),
                              child: LoadAssetImage(
                                'order/order_delete',
                                color: isDark
                                    ? Colours.dark_text_gray
                                    : Colours.text_gray_c,
                                width: 18,
                                height: 18,
                              ),
                            ),
                            onTap: () {
                              WidgetsBinding.instance
                                  .addPostFrameCallback((_) {
                                _phoneFilterController.text = '';
                              });
                            },
                          ),
                  ),
                ),
              ),
              actions: <Widget>[
                IconButton(
                  tooltip: 'Analysis Mode',
                  onPressed: () async {
                    final bool nextMode = !_isAnalysisMode;
                    if (nextMode) {
                      setState(() {
                        _isAnalysisMode = true;
                        _analysisDateRange = _currentWeekRange();
                        _analysisBonusType = null;
                        _list.clear();
                        _currentPage = 1;
                      });
                      await _requestAnalysisData(showLoading: true);
                      return;
                    }
                    setState(() {
                      _isAnalysisMode = false;
                    });
                  },
                  icon: Icon(
                    _isAnalysisMode ? Icons.view_list : Icons.find_replace,
                    color: Colors.white,
                  ),
                ),
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
      body: _isAnalysisMode
          ? RefreshIndicator(
              onRefresh: _onRefresh,
              displacement: 20.0,
              child: _buildAnalysisModeView(),
            )
          : NotificationListener(
              onNotification: (ScrollNotification note) {
                if (note.metrics.pixels == note.metrics.maxScrollExtent) {
                  _loadMore();
                }
                return true;
              },
              child: RefreshIndicator(
                onRefresh: _onRefresh,
                displacement: 20.0,
                child: Builder(
                  builder: (_) {
                    final displayList = _getDisplayList();
                    return CustomScrollView(
                      slivers: displayList.isNotEmpty
                          ? _buildGroups(displayList)
                          : [
                              const SliverFillRemaining(
                                  child: Center(
                                      child: Text('no data, search by phone or sn')))
                            ],
                    );
                  },
                ),
              ),
            ),
    );
  }

  List<Widget> _buildGroups(List<CommissionData> sourceList) {
    // 按日期分组
    final Map<String, List<CommissionData>> groupedLog = {};
    for (final CommissionData log in sourceList) {
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
                padding: const EdgeInsets.only(left: 2.0),
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
                          text: '₦$totalBonus',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        // Display type statistics with icons (sorted by type)
                        ...() {
                          final sortedEntries = typeStats.entries
                              // .where((entry) => (entry.value['sum'] ?? 0) >= 0)
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
                                        // Filter records of this type
                                        final filteredLogs = logList.where((log) => log.oType == type).toList();
                                        showDialog<void>(
                                          context: context,
                                          builder: (BuildContext ctx) {
                                            return AlertDialog(
                                              title: Text(typeDescriptions[type]),
                                              content: SizedBox(
                                                width: double.maxFinite,
                                                child: SingleChildScrollView(
                                                  child: Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        'Total: $sum\n'
                                                        'Count: $count',
                                                        style: const TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                      const SizedBox(height: 16),
                                                      const Divider(),
                                                      const SizedBox(height: 8),
                                                      ...filteredLogs.map((log) {
                                                        String maskPhoneNumber(String phone) {
                                                          if (phone.isEmpty || phone.length < 6) {
                                                            return phone;
                                                          }
                                                          List<String> phoneChars = phone.split('');
                                                          if (phoneChars.length > 2) phoneChars[2] = '*';
                                                          if (phoneChars.length > 3) phoneChars[3] = '*';
                                                          if (phoneChars.length > 4) phoneChars[4] = '*';
                                                          return phoneChars.join();
                                                        }
                                                        
                                                        String txt = '${log.jRate}% Bonus (lv.${groupNames[log.kLevel!]})';
                                                        if (log.oType == 1 || log.oType == 6 || log.oType == 3) {
                                                          txt = 'Acct#${log.zAccountNumber!} paid ${Utils.formatPrice2(log.vPaidAmount!)} at ${DateFormat('hh:mm a').format(DateTime.parse(log.createdAt!).toUtc().add(const Duration(hours: 1)))}, $txt';
                                                        } else if (log.oType == 2) {
                                                          txt = 'Tiered Achievement (lv.${groupNames[log.kLevel!]})';
                                                        } else if (log.oType == 0 || log.oType == 4 || log.oType == 5|| log.oType == 10) {
                                                          txt = log.aAComment!;
                                                        } else if (log.oType == 7) {
                                                          txt = 'Extension Bonus';
                                                        } else if (log.oType == 8) {
                                                          txt = 'Registered at ${DateFormat('hh:mm a').format(DateTime.parse(log.createdAt!).toUtc().add(const Duration(hours: 1)))}';
                                                        } else if (log.oType == 9) {
                                                          txt = 'Apply at ${DateFormat('hh:mm a').format(DateTime.parse(log.createdAt!).toUtc().add(const Duration(hours: 1)))}';
                                                        }
                                                        
                                                        return Padding(
                                                          padding: const EdgeInsets.only(bottom: 12.0),
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Expanded(
                                                                    child: Text(
                                                                      '${maskPhoneNumber(log.pPhone!)} ${log.nBorrowSn != null && log.nBorrowSn!.isNotEmpty ? '- ${log.nBorrowSn}' : ''}',
                                                                      style: const TextStyle(
                                                                        fontWeight: FontWeight.w500,
                                                                        fontSize: 14,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    log.hCommissionAmount!= null && log.hCommissionAmount! >= 0 ? '+${log.hCommissionAmount}' : '${log.hCommissionAmount}',
                                                                    style: TextStyle(
                                                                      color: typeColors[type],
                                                                      fontWeight: FontWeight.bold,
                                                                      fontSize: 14,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              const SizedBox(height: 4),
                                                              Text(
                                                                txt,
                                                                style: TextStyle(
                                                                  fontSize: 8,
                                                                  color: Colors.grey[600],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      }),
                                                    ],
                                                  ),
                                                ),
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
                                              '$sum($count) ',
                                              style: TextStyle(
                                                color: typeColors[type],
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12,
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

  Widget _buildSummaryCard({
    required String title,
    required String value,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.25)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 12)),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
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
    final int safeType = _safeType(log.oType);
    final int safeLevel = (log.kLevel ?? 0).clamp(0, groupNames.length - 1);
    final DateTime? createdAt = DateTime.tryParse(log.createdAt ?? '');
    final String timeText = createdAt == null
        ? '--'
        : DateFormat('hh:mm a')
            .format(createdAt.toUtc().add(const Duration(hours: 1)));

    String txt = '${log.jRate ?? 0}% Bonus (lv.${groupNames[safeLevel]})';
    if (safeType == 1 || safeType == 6 || safeType == 3) {
      txt =
          'Acct#${log.zAccountNumber ?? '--'} paid ${Utils.formatPrice2(log.vPaidAmount ?? 0)} at $timeText, $txt';
    } else if (safeType == 2) {
      txt = 'Tiered Achievement (lv.${groupNames[safeLevel]})';
    } else if (safeType == 0 || safeType == 4 || safeType == 5 || safeType == 10) {
      txt = log.aAComment ?? '';
    } else if (safeType == 7) {
      txt = 'Extension Bonus';
    } else if (safeType == 8) {
      txt = 'Registered at $timeText';
    } else if (safeType == 9) {
      txt = 'Apply at $timeText';
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
                        text: maskPhoneNumber(log.pPhone ?? ''),
                        style: TextStyle(color: ThemeUtils.getTextColor(context)),
                      ),
                      if(log.nBorrowSn != null && log.nBorrowSn!.isNotEmpty)
                      TextSpan(
                        text: ' - ${log.nBorrowSn}',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      if((log.oType == 1 || log.oType == 7 || log.oType == 3) && log.aAComment != null && log.aAComment!.isNotEmpty)
                      TextSpan(
                        text: ' - ${log.aAComment}',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      
                    ],
                  ),
                ),
                Gaps.hGap4,
                InkWell(
                  onTap: () {
                    Cache().appendToStringList('app_actions','${log.mCollectionOrderId}:74:0:0');
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
                    _formatSignedAmount(log.hCommissionAmount ?? 0),
                    style: TextStyle(
                      color: typeColors[safeType],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gaps.hGap4,
                  Icon(typeIcons[safeType], size: 14, color: typeColors[safeType],),
                  
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

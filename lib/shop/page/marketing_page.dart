import 'dart:async';

import 'package:bounty_hunter/models/admin_entity.dart';
import 'package:bounty_hunter/models/marketing_entity.dart';
import 'package:bounty_hunter/models/product_entity.dart';
import 'package:bounty_hunter/res/colors.dart';
import 'package:bounty_hunter/res/dimens.dart';
import 'package:bounty_hunter/res/gaps.dart';
import 'package:bounty_hunter/shop/iview/marketing_page_iview.dart';
import 'package:bounty_hunter/shop/presenter/marketing_presenter.dart';
import 'package:bounty_hunter/util/cache.dart';
import 'package:bounty_hunter/util/other_utils.dart';
import 'package:bounty_hunter/util/screen_utils.dart';
import 'package:bounty_hunter/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bounty_hunter/util/theme_utils.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../mvp/base_page.dart';
import '../../widgets/load_image.dart';
import '../../widgets/my_card.dart';
import 'package:oktoast/oktoast.dart';

String encodeBase62(int id) {
  // 使用标准的 Base62 字符集：0-9, a-z, A-Z
  const characters =
      '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
  const base = 62;
  const minLength = 11;
  String encoded = '';

  // 处理 0 的特殊情况
  if (id == 0) {
    return '0'.padLeft(minLength, '0');
  }
  id = int.parse('9${id.toString().padLeft(minLength, '0')}');
  while (id > 0) {
    int remainder = id % base;
    encoded = characters[remainder] + encoded;
    id = id ~/ base; // 使用整数除法
  }

  return encoded;
}

const List<Color> bgColors = [
  Colours.app_main,
  Colors.orangeAccent,
  Color(0xFF3BA28D),
  Colours.dark_button_disabled,
  Colours.dark_red,
  Colours.unselected_item_color,
];
const List<String> catText = [
  'Personal ',
  'Bonus Awards',
  'Rankings ',
  'System Alerts ',
  'Promise-to-Pay Reminders ',
  'Others ',
];

// 自定义输入格式化器，只允许数字、+号和空格
class PhoneNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // 只允许数字、+号和空格
    final RegExp allowedChars = RegExp(r'[0-9+\s]');
    final String filtered = newValue.text
        .split('')
        .where((char) => allowedChars.hasMatch(char))
        .join('');

    return TextEditingValue(
      text: filtered,
      selection: TextSelection.collapsed(offset: filtered.length),
    );
  }
}

/// design/6店铺-账户/index.html#artboard1
class MarketingPage extends StatefulWidget {
  const MarketingPage({
    super.key,
  });
  @override
  _AccountRecordListPageState createState() => _AccountRecordListPageState();
}

class _AccountRecordListPageState extends State<MarketingPage>
    with
        AutomaticKeepAliveClientMixin<MarketingPage>,
        SingleTickerProviderStateMixin,
        BasePageMixin<MarketingPage, MarketingPresenter>
    implements MarketingPageMvpView {
  late MarketingPresenter _accountRecordListPresenter;
  final ScrollController _scrollController = ScrollController();
  late int _currentPage = 1;
  final List<MarketingData> _list = [];
  final List<MarketingData> _filteredList = [];
  bool _isLoading = false;
  late int _maxPage;
  late int _selectedIndex = 100000;
  late List<MarketingOtherTemplates2> _templates = [];

  // 搜索相关状态
  bool _isSearchVisible = false;
  final TextEditingController _searchController = TextEditingController();
  String _searchKeyword = '';

  // 定时器，每10秒请求一次 statistics
  Timer? _statisticsTimer;

  @override
  MarketingPresenter createPresenter() {
    _accountRecordListPresenter = MarketingPresenter();
    return _accountRecordListPresenter;
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _accountRecordListPresenter.index(1, true);
    });

    // 启动定时器，每10秒调用一次 statistics
    _statisticsTimer = Timer.periodic(const Duration(seconds: 30), (timer) {
      _accountRecordListPresenter.statistics();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _statisticsTimer?.cancel();
    super.dispose();
  }

  // 搜索相关方法
  void _onSearchChanged() {
    setState(() {
      _searchKeyword = _processSearchKeyword(_searchController.text);
      _filterList();
    });
  }

  // 处理搜索关键词：去除+号和空格，只保留最后10位数字
  String _processSearchKeyword(String input) {
    if (input.isEmpty) return '';

    // 去除+号和空格，只保留数字
    String digitsOnly = input.replaceAll(RegExp(r'[+\s]'), '');

    // 只保留最后10位数字
    if (digitsOnly.length > 10) {
      digitsOnly = digitsOnly.substring(digitsOnly.length - 10);
    }

    return digitsOnly;
  }

  void _filterList() {
    _filteredList.clear();
    if (_searchKeyword.isEmpty) {
      _filteredList.addAll(_list);
    } else {
      for (var item in _list) {
        if (item.aPhone != null) {
          // 处理手机号码：去除+号和空格，只保留数字
          String phoneDigits = item.aPhone!.replaceAll(RegExp(r'[+\s-]'), '');

          // 检查是否包含搜索关键词
          if (phoneDigits.contains(_searchKeyword)) {
            _filteredList.add(item);
          }
        }
      }
    }
  }

  void _toggleSearch() {
    setState(() {
      _isSearchVisible = !_isSearchVisible;
      if (!_isSearchVisible) {
        _searchController.clear();
        _searchKeyword = '';
        _filteredList.clear();
        _filteredList.addAll(_list);
      } else {
        _selectedIndex = 100000;
      }
    });
  }

  @override
  void didUpdateWidget(MarketingPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 当搜索关键词变化时，重新请求数据

    // _accountRecordListPresenter.index(1, false);
  }

  @override
  void onRefresh() {
    // TODO: implement onRefresh
  }

  void setAdmin(List<AdminData> admins) {
    // TODO: implement setAdmin
  }

  @override
  void setCurrentPage(int currentPage) {
    _currentPage = currentPage;
  }

  Future<void> _onRefresh() async {
    setState(() {
      _selectedIndex = 100000;
      _list.clear();
      _filteredList.clear();
      _currentPage = 1;
    });
    _accountRecordListPresenter.index(1, true);
  }

  @override
  void setLogs(List<MarketingData> logs, {bool clear = false}) {
    if (clear) {
      _list.clear();
    }
    setState(() {
      _list.addAll(logs);
      _filterList(); // 更新数据时重新过滤
      _isLoading = false;
    });
  }

  @override
  void setTemplates(
      List<MarketingOtherTemplates2> templates, String url, String appName) {
    //把模板中@url@ 替换成url,把@app_name@ 替换成app_name
    setState(() {
      _templates = templates.map((template) {
        return template.copyWith(
            message: template.message
                    ?.replaceAll('@url@', '$url/${encodeBase62(template.id!)}')
                    .replaceAll('@app_name@', appName) ??
                '');
      }).toList();
    });
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
    _accountRecordListPresenter.index(_currentPage, true);
  }

  @override
  bool get wantKeepAlive => true;

  List<Widget> _buildGroups() {
    final bool isDark = context.isDark;
    // 按 qEndAt 日期分组
    final Map<String, List<MarketingData>> groupedData = {};
    final Map<String, DateTime> dateMap = {}; // 存储日期字符串对应的 DateTime，用于排序

    for (final MarketingData item in _filteredList) {
      String dateKey = 'Unknown';
      DateTime? startDateTime;
      DateTime? dateTime;

      // 获取 qEndAt，优先使用 logs 中的，否则使用 item 中的
      String? qEndAt;
      String createdAt = '';
      if (item.aAAAASLTelemarketingDetailLogs != null &&
          item.aAAAASLTelemarketingDetailLogs!.isNotEmpty &&
          item.aAAAASLTelemarketingDetailLogs![0].qEndAt != null &&
          item.aAAAASLTelemarketingDetailLogs![0].qEndAt!.isNotEmpty) {
        qEndAt = item.aAAAASLTelemarketingDetailLogs![0].qEndAt;
        createdAt = item.aAAAASLTelemarketingDetailLogs![0].createdAt ?? '';
      } else if (item.qEndAt != null && item.qEndAt!.isNotEmpty) {
        qEndAt = item.qEndAt;
      }

      if (qEndAt != null && qEndAt.isNotEmpty) {
        try {
          final DateTime endDate = DateTime.parse(qEndAt);
          final DateTime createdDate = DateTime.parse(createdAt);
          dateKey = '${DateFormat('MMM d', 'en_US').format(createdDate)} - ${DateFormat('MMM d', 'en_US').format(endDate)}';
          dateTime = endDate;
        } catch (e) {
          dateKey = 'Unknown';
        }
      }

      if (!groupedData.containsKey(dateKey)) {
        groupedData[dateKey] = [];
        if (dateTime != null) {
          dateMap[dateKey] = dateTime;
        }
      }
      groupedData[dateKey]!.add(item);
    }

    // 对分组按键（日期）进行排序，Unknown 放在最后
    final sortedEntries = groupedData.entries.toList()
      ..sort((a, b) {
        if (a.key == 'Unknown') return 1;
        if (b.key == 'Unknown') return -1;
        final dateA = dateMap[a.key];
        final dateB = dateMap[b.key];
        if (dateA != null && dateB != null) {
          return dateB.compareTo(dateA); // 降序，最新的在前
        }
        return a.key.compareTo(b.key);
      });

    // 生成Sliver列表
    int currentGlobalIndex = 0;
    return sortedEntries.map((entry) {
      String date = entry.key;
      List<MarketingData> itemList = entry.value;
      final int registerCount =
          itemList.where((item) => _hasRegisterRecord(item)).length;
      final int applyCount =
          itemList.where((item) => _hasApplyRecord(item)).length;

      // 保存当前分组的起始索引
      final int groupStartIndex = currentGlobalIndex;
      currentGlobalIndex += itemList.length;

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
                child: RichText(
                  text: TextSpan(
                    style:  TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600]
                    ),
                    children: [
                      const TextSpan(text: 'Valid time:  '),
                      TextSpan(text: date, style:  const TextStyle(color: Colors.black)),
                      TextSpan(text: ' · ${itemList.length}'),
                      const TextSpan(text: ' items'),
                        const TextSpan(text: ' · Reg: '),
                        TextSpan(text: registerCount.toString(), style:  const TextStyle(color: Colors.red,fontWeight: FontWeight.bold)),
                      const TextSpan(text: ' · Apply: '),
                      TextSpan(text: applyCount.toString(), style:  const TextStyle(color: Colors.green,fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
              34.0,
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(left: 6.0, right: 6.0, bottom: 12.0),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (_, index) {
                  final item = itemList[index];
                  final int globalItemIndex = groupStartIndex + index;
                  final isMatched = _searchKeyword.isNotEmpty &&
                      item.aPhone != null &&
                      item.aPhone!
                          .replaceAll(RegExp(r'[+\s-]'), '')
                          .contains(_searchKeyword);

                  return _Item(
                      item: item,
                      color: isMatched ? Colors.green[50]! : Colors.white,
                      templates: _templates,
                      index: globalItemIndex,
                      selected: _selectedIndex == globalItemIndex,
                      onTap: (int itemIndex) {
                        setState(() {
                          _selectedIndex = itemIndex;
                        });
                      });
                },
                childCount: itemList.length,
              ),
            ),
          ),
        ],
      );
    }).toList();
  }

  bool _hasRegisterRecord(MarketingData item) {
    final logs = item.aAAAASLTelemarketingDetailLogs;
    if (logs == null || logs.isEmpty) {
      return false;
    }
    final registerTime = logs[0].iRegisterTime;
    return registerTime != null && registerTime.isNotEmpty;
  }

  bool _hasApplyRecord(MarketingData item) {
    final logs = item.aAAAASLTelemarketingDetailLogs;
    if (logs == null || logs.isEmpty) {
      return false;
    }
    final applyTime = logs[0].xApplyAt;
    return applyTime != null && applyTime.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final bool isDark = context.isDark;

    return Scaffold(
      appBar: AppBar(
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
        title: Text("Marketing",
            style: TextStyle(color: ThemeUtils.getIconColor(context))),
        actions: <Widget>[
          InkWell(
            onTap: _toggleSearch,
            child: Container(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Center(child: Text('Search',style: TextStyle(color: ThemeUtils.getIconColor(context))))),
          )
        ],
      ),
      body: Column(
        children: [
          // 搜索框
          if (_isSearchVisible)
            Container(
              padding: const EdgeInsets.all(16.0),
              color: isDark ? Colours.dark_bg_color : Colors.white,
              child: TextField(
                controller: _searchController,
                keyboardType: TextInputType.phone,
                inputFormatters: [PhoneNumberInputFormatter()],
                decoration: InputDecoration(
                  hintText: 'Enter phone number (digits, +, space only)...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _searchKeyword.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                          },
                        )
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  filled: true,
                  fillColor:
                      isDark ? Colours.dark_button_disabled : Colors.grey[100],
                ),
                style: TextStyle(
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
            ),
          // 列表内容
          Expanded(
            child: NotificationListener(
              onNotification: (ScrollNotification note) {
                if (note.metrics.pixels == note.metrics.maxScrollExtent) {
                  _loadMore();
                }
                return true;
              },
              child: RefreshIndicator(
                onRefresh: _onRefresh,
                displacement: 120.0,
                child: Scrollbar(
                  // 加个滚动条
                  controller: _scrollController,
                  child: CustomScrollView(
                    controller: _scrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    slivers: _filteredList.isNotEmpty
                        ? _buildGroups()
                        : [
                            const SliverFillRemaining(
                                child: Center(
                                    child:
                                        Text('no data, search by phone or sn')))
                          ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void setPageSize(int pageSize) {
    // TODO: implement setPageSize
  }
}

class _Item extends StatefulWidget {
  _Item({
    required this.item,
    required this.color,
    required this.templates,
    required this.index,
    required this.selected,
    required this.onTap,
  });
  final MarketingData item;
  final Color color;
  final List<MarketingOtherTemplates2> templates;
  final int index;
  bool selected;
  final void Function(int) onTap;
  @override
  State<_Item> createState() => _ItemState();
}

class _ItemState extends State<_Item> with WidgetsBindingObserver {
  String method = '';
  late int wPhoneStatus;
  late int vWaStatus;
  int goodsMenuType = 1;
  late int interested;
  DateTime? _appPausedTime;
  DateTime? _appResumedTime;
  bool _isWhatsAppLaunched = false;
  bool _isCallLaunched = false;
  Timer? _cleanupTimer; // 清理定时器

  @override
  void initState() {
    super.initState();
    final logs = widget.item.aAAAASLTelemarketingDetailLogs;
    wPhoneStatus =
        (logs != null && logs.isNotEmpty) ? logs[0].wPhoneStatus ?? 0 : 0;
    vWaStatus = (logs != null && logs.isNotEmpty) ? logs[0].vWaStatus ?? 0 : 0;
    interested = (logs != null && logs.isNotEmpty) ? logs[0].eStatus ?? 0 : 0;
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _cleanupTimer?.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.paused:
        // 应用进入后台（比如打开WhatsApp）
        _appPausedTime = DateTime.now();
        print('App paused at: $_appPausedTime');
        break;
      case AppLifecycleState.resumed:
        // 应用回到前台
        _appResumedTime = DateTime.now();
        print('App resumed at: $_appResumedTime');

        // 如果之前有暂停时间，计算时间差
        if (_appPausedTime != null) {
          final Duration timeSpentOutside =
              _appResumedTime!.difference(_appPausedTime!);
          print(
              'Time spent outside app: ${timeSpentOutside.inSeconds} seconds');

          // 如果是从WhatsApp返回且停留时间超过5秒，记录点击事件
          if (_isWhatsAppLaunched && timeSpentOutside.inSeconds > 3) {
            _recordWhatsAppClick();
          }
          _isWhatsAppLaunched = false;
          if (_isCallLaunched && timeSpentOutside.inSeconds > 3) {
            _recordCallClick();
          }
          _isCallLaunched = false;
          _cleanupTimer?.cancel(); // 清理定时器
        }
        break;
      default:
        break;
    }
  }

  Future<void> _recordWhatsAppClick() async {
    // 使用保存的模板ID记录点击事件
    await Cache().appendToStringList('marketing_detail_logs',
        '${widget.item.aAAAASLTelemarketingDetailLogs![0].id}#k_wa_cnt#1');

    // 重置模板ID
  }

  Future<void> _recordCallClick() async {
    // 使用保存的模板ID记录点击事件
    await Cache().appendToStringList('marketing_detail_logs',
        '${widget.item.aAAAASLTelemarketingDetailLogs![0].id}#l_phone_cnt#1');

    // 重置模板ID
  }

  Widget getIcon(String actionType) {
    // 如果 aAAAAHLContactWeights 不存在，返回空组件
    if (widget.item.aAAAASLTelemarketingDetailLogs == null ||
        widget.item.aAAAASLTelemarketingDetailLogs!.isEmpty) {
      return const SizedBox.shrink();
    }

    if (actionType == 'call') {
      if (wPhoneStatus == 10) {
        //未知
        return const SizedBox.shrink();
      } else if (wPhoneStatus == 20) {
        //没有价值
        return const Icon(
          Icons.close,
          color: Colors.red,
          size: 12,
        );
      } else if (wPhoneStatus == 30) {
        //有价值
        return const Icon(
          Icons.access_time_outlined,
          color: Colors.grey,
          size: 12,
        );
      } else if (wPhoneStatus == 40) {
        //十分有价值
        return const Icon(
          Icons.done_all,
          color: Colors.green,
          size: 12,
        );
      }
    } else if (actionType == 'whatsapp') {
      if (vWaStatus == 10) {
        return const SizedBox.shrink();
      } else if (vWaStatus == 20) {
        return const Icon(
          Icons.close,
          color: Colors.red,
          size: 12,
        );
      } else if (vWaStatus == 30) {
        return const Icon(
          Icons.access_time_outlined,
          color: Colors.grey,
          size: 12,
        );
      } else if (vWaStatus == 40) {
        return const Icon(
          Icons.done_all,
          color: Colors.green,
          size: 12,
        );
      }
    }
    return const SizedBox.shrink();
  }

  Future<void> launchAction(int type) async {
    //type 1:whatsapp 2:call 3:sms

    // 显示模板选择对话框
    if (type != 2) {
      // 默认展开第一条模板
      Set<int> expandedIndices = {0};

      final String? selectedTemplate = await showModalBottomSheet<String>(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.9,
                  minHeight: MediaQuery.of(context).size.height * 0.86,
                ),
                child: Container(
                  padding: EdgeInsets.only(
                    top: 16,
                    left: 16,
                    right: 16,
                    bottom: MediaQuery.of(context).viewInsets.bottom + 16,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // 全部展开/收缩按钮
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                setState(() {
                                  expandedIndices.clear();
                                });
                              },
                              icon: const Icon(Icons.unfold_less, size: 18),
                              label: const Text('Collapse All'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical:2),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                setState(() {
                                  expandedIndices = {
                                    for (int i = 0;
                                        i < widget.templates.length;
                                        i++)
                                      i
                                  };
                                });
                              },
                              icon: const Icon(Icons.unfold_more, size: 18),
                              label: const Text('Expand All'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 2),
                              ),
                            ),
                          ),
                          
                        ],
                      ),
                      Flexible(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: widget.templates.asMap().entries.map((entry) {
                              final int index = entry.key;
                              final template = entry.value;
                              final bool isExpanded = expandedIndices.contains(index);

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.blue[50],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.blue[50],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                width: double.infinity,
                                padding: const EdgeInsets.all(12),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.pop(context, template.message);
                                        },
                                        child: Text(
                                        template.title ?? 'Custom message.',
                                        style: const TextStyle(
                                          fontSize: 15,
                                          height: 1.4,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black87,
                                          ),
                                          softWrap: true,
                                        ),
                                      ),
                                    ),
                                     IconButton(
                                      icon: const Icon(
                                        Icons.send_outlined,
                                        size: 18,
                                        color: Colors.blue,
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context, template.message);
                                      },
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(),
                                    ),
                                    Gaps.hGap12,
                                    Gaps.hGap10,
                                    IconButton(
                                      icon: const Icon(
                                        Icons.copy,
                                        size: 18,
                                        color: Colors.blue,
                                      ),
                                      onPressed: () {
                                        final text = template.message;
                                        if (text != null && text.isNotEmpty) {
                                          Clipboard.setData(
                                              ClipboardData(text: text));
                                          showToast(
                                            'Message copied',
                                            position: ToastPosition.center,
                                            duration:
                                                const Duration(seconds: 1),
                                          );
                                        }
                                      },
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(),
                                    ),
                                    Gaps.hGap12,
                                    Gaps.hGap10,
                                    IconButton(
                                      icon: Icon(
                                        isExpanded
                                            ? Icons.expand_less
                                            : Icons.expand_more,
                                        size: 20,
                                        color: Colors.green,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          if (expandedIndices.contains(index)) {
                                            expandedIndices.remove(index);
                                          } else {
                                            expandedIndices.add(index);
                                          }
                                        });
                                      },
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(),
                                    ),
                                  ],
                                ),
                              ),
                              if (isExpanded &&
                                  (template.message != null &&
                                      template.message!.isNotEmpty))
                                InkWell(
                                  onTap: () {
                                    Navigator.pop(context, template.message);
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.fromLTRB(
                                        12, 0, 12, 12),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Divider(color: Colors.white ,thickness: 2,),
                                        Text(
                                          template.message!,
                                          style: const TextStyle(
                                            color: Colors.black87,
                                            fontSize: 14,
                                            height: 1.5,
                                          ),
                                          softWrap: true,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
          },
        );
      },
    );
      if (selectedTemplate != null) {
        if (type == 1) {
          // 启动WhatsApp
          final bool result = await Utils.launchWhatsAppURL(
              '234${widget.item.aPhone!}',
              message: selectedTemplate);
          if (result) {
            // 设置WhatsApp启动标志，等待用户返回应用
            _isWhatsAppLaunched = true;

            // 启动清理定时器，30秒后自动清理状态
            _cleanupTimer?.cancel();
            _cleanupTimer = Timer(const Duration(seconds: 30), () {
              if (mounted) {
                setState(() {
                  _isWhatsAppLaunched = false;
                });
              }
            });
            // 更新WhatsApp最后访问时间
            final currentTime = DateTime.now().toIso8601String();
            widget.item.aAAAASLTelemarketingDetailLogs![0].tLastWaAt =
                currentTime;
            // 同时更新存储中的联系人列表
            setState(() {});
          }
        } else if (type == 3) {
          final bool result = await launch(
              'sms:${widget.item.aPhone}?body=${selectedTemplate}');
          if (result) {
            // 更新SMS最后访问时间
            final currentTime = DateTime.now().toIso8601String();
            widget.item.aAAAASLTelemarketingDetailLogs![0].sLastSmsAt =
                currentTime;
            setState(() {});

            await Cache().appendToStringList('marketing_detail_logs',
                '${widget.item.aAAAASLTelemarketingDetailLogs![0].id}#j_sms_cnt#1');
          }
        }
      }
    } else if (type == 2) {
      final String currentTime = DateTime.now().toIso8601String();
      final url = 'tel:${widget.item.aPhone}';
      if (await canLaunch(url)) {
        final bool result = await launch(url);
        print('拨打电话: $result');
        if (result) {
          _isCallLaunched = true;
          // 启动清理定时器，30秒后自动清理状态
          _cleanupTimer?.cancel();
          _cleanupTimer = Timer(const Duration(seconds: 30), () {
            if (mounted) {
              setState(() {
                _isCallLaunched = false;
              });
            }
          });
          final String currentTime2 = DateTime.now().toIso8601String();

          widget.item.aAAAASLTelemarketingDetailLogs![0].rLastPhoneAt =
              currentTime2;
          setState(() {});
        }
      }
    }
  }

  String getLastClickTime(String actionType) {
    // 如果 aAAAAHLContactWeights 不存在，返回空字符串
    if (widget.item.aAAAASLTelemarketingDetailLogs == null ||
        widget.item.aAAAASLTelemarketingDetailLogs!.isEmpty) {
      return '';
    }

    String? timeString;
    if (actionType == 'call') {
      timeString = widget.item.aAAAASLTelemarketingDetailLogs![0].rLastPhoneAt;
    } else if (actionType == 'sms') {
      timeString = widget.item.aAAAASLTelemarketingDetailLogs![0].sLastSmsAt;
    } else if (actionType == 'whatsapp') {
      timeString = widget.item.aAAAASLTelemarketingDetailLogs![0].tLastWaAt;
    }

    if (timeString == null || timeString.isEmpty) {
      return '               ';
    }

    try {
      final DateTime time = DateTime.parse(timeString);
      final DateTime now = DateTime.now();
      final Duration difference = now.difference(time);

      if (difference.inDays > 0) {
        return '${difference.inDays} D ago';
      } else if (difference.inHours > 0) {
        return '${difference.inHours} H ago';
      } else if (difference.inMinutes > 0) {
        return '${difference.inMinutes} M ago';
      } else {
        return 'Just now';
      }
    } catch (e) {
      return timeString;
    }
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 0.2, right: 0.2, top: 8.0, bottom: 2.0),
      child: Stack(
        children: [
          Column(
            children: <Widget>[
              MyCard(
                shadowColor: Colors.blueAccent,
                color: widget.selected? Colors.red : ThemeUtils.getBackgroundColor(context),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 4.0, right: 4.0, top: 6.0, bottom: 6.0),
                  child: Row(
                    children: <Widget>[
                      Icon(
                          interested == 20
                              ? Icons.sentiment_dissatisfied_outlined
                              : interested == 30
                                  ? Icons.sentiment_neutral_rounded
                                  : interested == 40
                                      ? Icons.sentiment_satisfied_sharp
                                      : Icons.face_outlined,
                          size: 22,
                          color: interested == 20
                              ? Colors.red
                              : interested == 30
                                  ? Colors.orange[700]
                                  : interested == 40
                                      ? Colors.green
                                      : Colors.grey[100]),
                      Gaps.hGap4,
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              maskPhoneNumber(widget.item.aPhone ?? ''),
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: ThemeUtils.getTextColor(context),
                              ),
                            ),
                            Gaps.vGap4,
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: Colors.red.withOpacity(0.15),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    (widget.item.aAFirstRegisterBonus! + widget.item.aCSecondRegisterBonus! + widget.item.aEThirdRegisterBonus! + widget.item.aGFourthRegisterBonus! + widget.item.aIFifthRegisterBonus!).toString(),
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color:Colors.red,
                                    ),
                                  ),
                                ),
                                Gaps.hGap4,
                                Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: Colors.green.withOpacity(0.15),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    (widget.item.aBFirstApplyBonus! + widget.item.aDSecondApplyBonus! + widget.item.aFThirdApplyBonus! + widget.item.aHFourthApplyBonus! + widget.item.aJFifthApplyBonus!).toString(),
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color:Colors.green,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          if (widget
                                      .item.aAAAASLTelemarketingDetailLogs !=
                                  null &&
                              widget.item.aAAAASLTelemarketingDetailLogs!
                                  .isNotEmpty &&
                              widget.item.aAAAASLTelemarketingDetailLogs![0]
                                      .iRegisterTime !=
                                  null &&
                              widget.item.aAAAASLTelemarketingDetailLogs![0]
                                      .iRegisterTime !=
                                  '')
                            Row(
                              children: [
                                const Icon(
                                  Icons.person_outline_outlined,
                                  size: 18,
                                  color: Colors.green,
                                ),
                                Text(
                                  DateFormat('MMMd,hh:mm a').format(
                                      DateTime.parse(widget
                                          .item
                                          .aAAAASLTelemarketingDetailLogs![0]
                                          .iRegisterTime!)),
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(fontSize: 8,color: ThemeUtils.getTextColor(context)),
                                ),
                              ],
                            )
                          else
                            Gaps.empty,
                          if (widget
                                      .item.aAAAASLTelemarketingDetailLogs !=
                                  null &&
                              widget.item.aAAAASLTelemarketingDetailLogs!
                                  .isNotEmpty &&
                              widget.item.aAAAASLTelemarketingDetailLogs![0]
                                      .xApplyAt !=
                                  null &&
                              widget.item.aAAAASLTelemarketingDetailLogs![0]
                                      .xApplyAt !=
                                  '')
                            Row(
                              children: [
                                const Icon(
                                  Icons.how_to_reg_outlined,
                                  size: 18,
                                  color: Colors.green,
                                ),
                                Text(
                                  DateFormat('MMMd,hh:mm a').format(
                                      DateTime.parse(widget
                                          .item
                                          .aAAAASLTelemarketingDetailLogs![0]
                                          .xApplyAt!)),
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(fontSize: 8,color: ThemeUtils.getTextColor(context)),
                                ),
                              ],
                            )
                          else
                            Gaps.empty,
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(
                            onTap: () {
                              widget.onTap(widget.index);
                              setState(() {
                                method = 'sms';
                              });
                              launchAction(3);
                            },
                            borderRadius: BorderRadius.circular(8),
                            child: Stack(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(6),
                                  child: const Icon(
                                    Icons.message,
                                    size: 16,
                                    color: Colors.blueAccent,
                                  ),
                                ),
                                Positioned(
                                  top: -1,
                                  right: -1,
                                  child: getIcon('sms'),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            getLastClickTime('sms'),
                            style: TextStyle(
                              fontSize: 8,
                              color: ThemeUtils.getTextColor(context),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 8),
                      const SizedBox(width: 12),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(
                            onTap: () {
                              widget.onTap(widget.index);
                              setState(() {
                                method = 'call';
                                goodsMenuType = 1;
                              });
                              launchAction(2);
                            },
                            borderRadius: BorderRadius.circular(8),
                            child: Stack(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(6),
                                  child: const Icon(
                                    Icons.call,
                                    size: 16,
                                    color: Colors.blueAccent,
                                  ),
                                ),
                                Positioned(
                                  top: -1,
                                  right: -1,
                                  child: getIcon('call'),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            getLastClickTime('call'),
                            style: TextStyle(
                              fontSize: 8,
                              color: ThemeUtils.getTextColor(context),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 8),
                      const SizedBox(width: 12),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(
                            onTap: () {
                              widget.onTap(widget.index);
                              setState(() {
                                method = 'whatsapp';
                                goodsMenuType = 1;
                              });
                              launchAction(1);
                            },
                            borderRadius: BorderRadius.circular(8),
                            child: Stack(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(6),
                                  child: const Icon(
                                    FontAwesomeIcons.whatsapp,
                                    size: 16,
                                    color: Colors.green,
                                  ),
                                ),
                                Positioned(
                                  top: -1,
                                  right: -1,
                                  child: getIcon('whatsapp'),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            getLastClickTime('whatsapp'),
                            style: TextStyle(
                              fontSize: 8,
                              color: ThemeUtils.getTextColor(context),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 8),
                      const SizedBox(width: 12),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(
                            onTap: () {
                              widget.onTap(widget.index);
                              setState(() {
                                goodsMenuType = 2;
                              });
                            },
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              child: Icon(
                                Icons.edit,
                                size: 16,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '',
                            style: TextStyle(
                              fontSize: 8,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          if (widget.selected && goodsMenuType == 1)
            _buildGoodsMenu(context, method)
          else
            Gaps.empty,
          if (widget.selected && goodsMenuType == 2)
            _buildGoodsMenu2(context)
          else
            Gaps.empty,
        ],
      ),
    );
  }

  Widget _buildGoodsMenu(BuildContext context, String method) {
    return Positioned.fill(
      child: _buildGoodsMenuContent(context, method),
    );
  }

  Widget _buildGoodsMenuContent(BuildContext context, String method) {
    final bool isDark = true;
    final Color buttonColor = isDark ? Colours.dark_text : Colors.white;

    return InkWell(
        onTap: () {
          widget.selected = false;
          setState(() {});
        },
        child: ColoredBox(
          color: isDark ? const Color(0xB34D4D4D) : const Color(0x4D000000),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                MyButton(
                  key: Key('goods_edit_item_'),
                  icon: Icons.close,
                  text: method == 'call' ? 'Disconnected' : 'Not registered',
                  fontSize: Dimens.font_sp10,
                  radius: 24.0,
                  minWidth: 56.0,
                  minHeight: 56.0,
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  textColor: isDark ? Colours.dark_button_text : Colors.white,
                  backgroundColor: Colors.red,
                  onPressed: () {
                    widget.selected = false;
                    if (method == 'call') {
                      wPhoneStatus = 20;
                      Cache().appendToStringList('marketing_detail_logs',
                          '${widget.item.aAAAASLTelemarketingDetailLogs![0].id}#w_phone_status#$wPhoneStatus');
                    } else if (method == 'whatsapp') {
                      vWaStatus = 20;
                      Cache().appendToStringList('marketing_detail_logs',
                          '${widget.item.aAAAASLTelemarketingDetailLogs![0].id}#v_wa_status#$vWaStatus');
                    }
                    setState(() {});
                    showToast(
                        '${widget.item.aPhone} has been set to ${method == 'call' ? 'Disconnected' : 'Not registered'}');
                  },
                ),
                MyButton(
                  key: Key('No answer'),
                  icon: Icons.access_time_outlined,
                  text: method == 'call' ? 'No answer' : 'No reply',
                  fontSize: Dimens.font_sp10,
                  radius: 24.0,
                  minWidth: 56.0,
                  minHeight: 56.0,
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  textColor: isDark ? Colours.dark_button_text : Colors.white,
                  backgroundColor: Colors.grey,
                  onPressed: () {
                    if (method == 'call') {
                      wPhoneStatus = 30;
                      Cache().appendToStringList('marketing_detail_logs',
                          '${widget.item.aAAAASLTelemarketingDetailLogs![0].id}#w_phone_status#$wPhoneStatus');
                    } else if (method == 'whatsapp') {
                      vWaStatus = 30;
                      Cache().appendToStringList('marketing_detail_logs',
                          '${widget.item.aAAAASLTelemarketingDetailLogs![0].id}#v_wa_status#$vWaStatus');
                    }
                    widget.selected = false;
                    setState(() {});
                    showToast(
                        '${widget.item.aPhone} has been set to no reply, please re-contact it');
                  },
                ),
                MyButton(
                  key: Key('Answered'),
                  icon: Icons.done_all,
                  text: 'Answered',
                  fontSize: Dimens.font_sp10,
                  radius: 24.0,
                  minWidth: 56.0,
                  minHeight: 56.0,
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  textColor: isDark ? Colours.dark_button_text : Colors.white,
                  backgroundColor: const Color.fromARGB(255, 2, 158, 7),
                  onPressed: () {
                    if (method == 'call') {
                      wPhoneStatus = 40;
                      Cache().appendToStringList('marketing_detail_logs',
                          '${widget.item.aAAAASLTelemarketingDetailLogs![0].id}#w_phone_status#$wPhoneStatus');
                    } else if (method == 'whatsapp') {
                      vWaStatus = 40;
                      Cache().appendToStringList('marketing_detail_logs',
                          '${widget.item.aAAAASLTelemarketingDetailLogs![0].id}#v_wa_status#$vWaStatus');
                    }
                    widget.selected = false;
                    setState(() {});
                    showToast(
                        '${widget.item.aPhone} has been set to answered, please track it');
                  },
                ),
              ],
            ),
          ),
        ));
  }

  Widget _buildGoodsMenu2(BuildContext context) {
    return Positioned.fill(
      child: _buildGoodsMenuContent2(context),
    );
  }

  Widget _buildGoodsMenuContent2(BuildContext context) {
    final bool isDark = true;
    final Color buttonColor = isDark ? Colours.dark_text : Colors.white;

    return InkWell(
        onTap: () {
          widget.selected = false;
          setState(() {});
        },
        child: ColoredBox(
          color: isDark ? const Color(0xB34D4D4D) : const Color(0x4D000000),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                MyButton(
                  key: Key('Uninterested'),
                  icon: Icons.sentiment_dissatisfied_outlined,
                  text: 'Uninterested',
                  fontSize: Dimens.font_sp10,
                  radius: 24.0,
                  minWidth: 56.0,
                  minHeight: 56.0,
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  textColor: isDark ? Colours.dark_button_text : Colors.white,
                  backgroundColor: Colors.red,
                  onPressed: () {
                    interested = 20;
                    widget.selected = false;
                    Cache().appendToStringList('marketing_detail_logs',
                        '${widget.item.aAAAASLTelemarketingDetailLogs![0].id}#e_status#$interested');
                    setState(() {});
                    showToast(
                        '${widget.item.aPhone} has been set to Uninterested');
                  },
                ),
                MyButton(
                  key: Key('goods_edit_item_'),
                  icon: Icons.sentiment_neutral_rounded,
                  text: 'Unknown',
                  fontSize: Dimens.font_sp10,
                  radius: 24.0,
                  minWidth: 56.0,
                  minHeight: 56.0,
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  textColor: isDark ? Colours.dark_button_text : Colors.white,
                  backgroundColor: Colors.orange[700],
                  onPressed: () {
                    interested = 30;
                    widget.selected = false;
                    Cache().appendToStringList('marketing_detail_logs',
                        '${widget.item.aAAAASLTelemarketingDetailLogs![0].id}#e_status#$interested');
                    setState(() {});
                    showToast('${widget.item.aPhone} has been set to Unknown');
                  },
                ),
                MyButton(
                  key: Key('Interested'),
                  icon: Icons.sentiment_satisfied_sharp,
                  text: 'Interested',
                  fontSize: Dimens.font_sp10,
                  radius: 24.0,
                  minWidth: 56.0,
                  minHeight: 56.0,
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  textColor: isDark ? Colours.dark_button_text : Colors.white,
                  backgroundColor: const Color.fromARGB(255, 2, 158, 7),
                  onPressed: () {
                    interested = 40;
                    widget.selected = false;
                    Cache().appendToStringList('marketing_detail_logs',
                        '${widget.item.aAAAASLTelemarketingDetailLogs![0].id}#e_status#$interested');
                    setState(() {});
                    showToast(
                        '${widget.item.aPhone} has been set to Interested');
                  },
                ),
              ],
            ),
          ),
        ));
  }
}

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  SliverAppBarDelegate(this.widget, this.height);

  final Widget widget;
  final double height;

  // minHeight 和 maxHeight 的值设置为相同时，header就不会收缩了
  @override
  double get minExtent => height;

  @override
  double get maxExtent => height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return widget;
  }

  @override
  bool shouldRebuild(SliverAppBarDelegate oldDelegate) {
    return true;
  }
}

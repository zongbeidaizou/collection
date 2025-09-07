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
import 'package:bounty_hunter/util/theme_utils.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../mvp/base_page.dart';
import '../../widgets/load_image.dart';
import '../../widgets/my_card.dart';
import 'package:oktoast/oktoast.dart';

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
  bool _isLoading = false;
  late int _maxPage;
  late int _selectedIndex = 100000;
  @override
  MarketingPresenter createPresenter() {
    _accountRecordListPresenter = MarketingPresenter();
    return _accountRecordListPresenter;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // _accountRecordListPresenter.index(1, true);
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
      _list.clear();
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
      _isLoading = false;
    });
  }

  @override
  void setPageSize(int pageSize) {
    _maxPage = pageSize;
  }

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
    _accountRecordListPresenter.index(_currentPage, true);
  }

  List<String> templates = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'];

  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final bool isDark = context.isDark;

    return VisibilityDetector(
      key: Key('news-visibility-key'),
      onVisibilityChanged: (visibilityInfo) {
        var visiblePercentage = visibilityInfo.visibleFraction * 100;
        if (visiblePercentage > 10) {
          _onRefresh();
          // context.read<RefreshProvider>().setNewsRefresh(false);
        }
      },
      child: Scaffold(
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
          title: Text("Verify",
              style: TextStyle(color: ThemeUtils.getIconColor(context))),
          actions: <Widget>[
            InkWell(
              onTap: () {
                _accountRecordListPresenter.markAsRead(true);
              },
              child: Container(
                  padding: EdgeInsets.only(left: 16, right: 16),
                  child: Center(child: Text('Mark All as Read'))),
            )
          ],
        ),
        body: NotificationListener(
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
              child: ListView.builder(
                  itemCount: _list.length,
                  controller: _scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(
                      left: 6.0, right: 6.0, bottom: 12.0),
                  itemBuilder: (_, index) {
                    return _Item(
                        item: _list[index],
                        color: Colors.white,
                        templates: templates,
                        index: index,
                        selected: _selectedIndex == index,
                        onTap: (int itemIndex) {
                          setState(() {
                            _selectedIndex = itemIndex;
                          });
                        });
                  }),
            ),
          ),
        ),
      ),
    );
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
  final List<String> templates;
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

  void _recordWhatsAppClick() async {
    // 使用保存的模板ID记录点击事件
    await Cache().appendToStringList('marketing_detail_logs',
        '${widget.item.aAAAASLTelemarketingDetailLogs![0].id}#k_wa_cnt#1');

    // 重置模板ID
  }

  void _recordCallClick() async {
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
      final String? selectedTemplate = await showModalBottomSheet<String>(
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
                children: widget.templates.map((template) {
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
                          template != '' ? template : 'Custom message.',
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
          await Cache().appendToStringList('marketing_detail_logs',
              '${widget.item.aAAAASLTelemarketingDetailLogs![0].id}#l_phone_cnt#1');
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
                color: widget.color,
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
                          size: 28,
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
                              widget.item.aPhone!,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 4),
                            if (widget.item.aAAAASLTelemarketingDetailLogs !=
                                    null &&
                                widget.item.aAAAASLTelemarketingDetailLogs!
                                    .isNotEmpty &&
                                widget.item.aAAAASLTelemarketingDetailLogs![0]
                                        .iRegisterTime !=
                                    null)
                              RichText(
                                text: TextSpan(
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(fontSize: Dimens.font_sp12),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'cx registered at: ',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall
                                            ?.copyWith(fontSize: 8)),
                                    TextSpan(
                                        text: DateFormat('MMM d, hh:mm a')
                                            .format(DateTime.parse(widget
                                                .item
                                                .aAAAASLTelemarketingDetailLogs![
                                                    0]
                                                .iRegisterTime!)),
                                        style: TextStyle(
                                            fontSize: 10, color: Colors.black)),
                                  ],
                                ),
                              )
                            else if (widget.item.aAAAASLTelemarketingDetailLogs !=
                                    null &&
                                widget.item.aAAAASLTelemarketingDetailLogs!
                                    .isNotEmpty &&
                                widget.item.aAAAASLTelemarketingDetailLogs![0]
                                        .gViewedTime !=
                                    null)
                              RichText(
                                text: TextSpan(
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(fontSize: Dimens.font_sp12),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'cx seen at: ',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall
                                            ?.copyWith(fontSize: 8)),
                                    TextSpan(
                                        text: DateFormat('MMM d, hh:mm a')
                                            .format(DateTime.parse(widget
                                                .item
                                                .aAAAASLTelemarketingDetailLogs![
                                                    0]
                                                .gViewedTime!)),
                                        style: TextStyle(
                                            fontSize: 10, color: Colors.black)),
                                  ],
                                ),
                              )
                            else
                              Gaps.empty,
                          ],
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(
                            onTap: () {
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
                              color: Colors.grey[600],
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
                              color: Colors.grey[600],
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
                              color: Colors.grey[600],
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
                            '${DateTime.parse(widget.item.aAAAASLTelemarketingDetailLogs![0].qEndAt ?? '2000-07-10T18:58:39.000000Z').difference(DateTime.now()).inHours} H left',
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

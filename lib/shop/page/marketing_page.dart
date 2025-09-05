import 'package:bounty_hunter/models/admin_entity.dart';
import 'package:bounty_hunter/models/marketing_entity.dart';
import 'package:bounty_hunter/models/product_entity.dart';
import 'package:bounty_hunter/res/colors.dart';
import 'package:bounty_hunter/res/dimens.dart';
import 'package:bounty_hunter/res/gaps.dart';
import 'package:bounty_hunter/shop/iview/marketing_page_iview.dart';
import 'package:bounty_hunter/shop/presenter/marketing_presenter.dart';
import 'package:bounty_hunter/util/screen_utils.dart';
import 'package:bounty_hunter/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:bounty_hunter/util/theme_utils.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
    required this.index,
    required this.selected,
    required this.onTap,
  });
  final MarketingData item;
  final Color color;
  final int index;
  bool selected;
  final void Function(int) onTap;
  @override
  State<_Item> createState() => _ItemState();
}

class _ItemState extends State<_Item> {
  @override
  Widget build(BuildContext context) {
    return Stack(
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
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Phone Number',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            widget.item.aPhone!,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          onTap: () {
                            widget.onTap(widget.index);
                            showToast('Sms');
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
                                child: Icon(Icons.close,
                                    size: 12, color: Colors.transparent),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '1 min ago',
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
                            showToast('Call');
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
                                child: Icon(Icons.close,
                                    size: 12, color: Colors.red),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '1 min ago',
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
                            showToast('whatsapp');
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
                                child: Icon(Icons.check,
                                    size: 12, color: Colors.green),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '1 min ago',
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
                            showToast('edit');
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
                          'edit',
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
        if (widget.selected) _buildGoodsMenu2(context) else Gaps.empty,
      ],
    );
  }

  Widget _buildGoodsMenu(BuildContext context) {
    return Positioned.fill(
      child: _buildGoodsMenuContent(context),
    );
  }

  Widget _buildGoodsMenuContent(BuildContext context) {
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
                  text: 'Unreachable or Unacquainted',
                  fontSize: Dimens.font_sp10,
                  radius: 24.0,
                  minWidth: 56.0,
                  minHeight: 56.0,
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  textColor: isDark ? Colours.dark_button_text : Colors.white,
                  backgroundColor: Colors.red,
                  onPressed: () {
                    // _updateContactValue(20); // 20 = 没有价值
                    widget.selected = false;
                    setState(() {});
                    showToast(
                        '${widget.item.aPhone} has been set to Invalid Contact');
                  },
                ),
                MyButton(
                  key: Key('Uninterested'),
                  icon: Icons.remove_done,
                  text: 'Uninterested',
                  fontSize: Dimens.font_sp10,
                  radius: 24.0,
                  minWidth: 56.0,
                  minHeight: 56.0,
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  textColor: isDark ? Colours.dark_button_text : Colors.white,
                  backgroundColor: Colors.orange[700],
                  onPressed: () {
                    // _updateContactValue(40); // 40 = 十分有价值
                    widget.selected = false;
                    setState(() {});
                    showToast(
                        '${widget.item.aPhone} has been set to Confirms Knowing Borrower');
                  },
                ),
                MyButton(
                  key: Key('Interested'),
                  icon: Icons.done_all_rounded,
                  text: 'Interested',
                  fontSize: Dimens.font_sp10,
                  radius: 24.0,
                  minWidth: 56.0,
                  minHeight: 56.0,
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  textColor: isDark ? Colours.dark_button_text : Colors.white,
                  backgroundColor: const Color.fromARGB(255, 2, 158, 7),
                  onPressed: () {
                    // _updateContactValue(40); // 40 = 十分有价值
                    widget.selected = false;
                    setState(() {});
                    showToast(
                        '${widget.item.aPhone} has been set to Confirms Knowing Borrower');
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
                    // _updateContactValue(40); // 40 = 十分有价值
                    widget.selected = false;
                    setState(() {});
                    showToast(
                        '${widget.item.aPhone} has been set to Confirms Knowing Borrower');
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
                    // _updateContactValue(20); // 20 = 没有价值
                    widget.selected = false;
                    setState(() {});
                    showToast(
                        '${widget.item.aPhone} has been set to Invalid Contact');
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
                    // _updateContactValue(40); // 40 = 十分有价值
                    widget.selected = false;
                    setState(() {});
                    showToast(
                        '${widget.item.aPhone} has been set to Confirms Knowing Borrower');
                  },
                ),
              ],
            ),
          ),
        ));
  }
}

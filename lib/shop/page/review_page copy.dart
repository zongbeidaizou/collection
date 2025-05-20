import 'package:bounty_hunter/models/admin_entity.dart';
import 'package:bounty_hunter/models/b_f_review_borrow_entity.dart';
import 'package:bounty_hunter/models/product_entity.dart';
import 'package:bounty_hunter/res/colors.dart';
import 'package:bounty_hunter/res/gaps.dart';
import 'package:bounty_hunter/res/styles.dart';
import 'package:bounty_hunter/util/screen_utils.dart';
import 'package:flutter/material.dart';
import 'package:bounty_hunter/util/theme_utils.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../mvp/base_page.dart';
import '../../providers/refresh_provider.dart';
import '../../widgets/load_image.dart';
import '../../widgets/my_card.dart';
import '../iview/review_page_iview.dart';
import '../presenter/review_presenter.dart';

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
class ReviewPage extends StatefulWidget {
  const ReviewPage({
    super.key,
  });
  @override
  _AccountRecordListPageState createState() => _AccountRecordListPageState();
}

class _AccountRecordListPageState extends State<ReviewPage>
    with
        AutomaticKeepAliveClientMixin<ReviewPage>,
        SingleTickerProviderStateMixin,
        BasePageMixin<ReviewPage, ReviewPresenter>
    implements ReviewPageMvpView {
  late ReviewPresenter _accountRecordListPresenter;
  final ScrollController _scrollController = ScrollController();
  late int _currentPage = 1;
  final List<BFReviewBorrowData> _list = [];
  bool _isLoading = false;
  late int _maxPage;
  @override
  ReviewPresenter createPresenter() {
    _accountRecordListPresenter = ReviewPresenter();
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
  void didUpdateWidget(ReviewPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 当搜索关键词变化时，重新请求数据

    // _accountRecordListPresenter.index(1, false);
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
    _accountRecordListPresenter.index(1, true);
  }

  @override
  void setLogs(List<BFReviewBorrowData> logs, {bool clear = false}) {
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
    _accountRecordListPresenter.index(_currentPage, true);
  }

  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDark;
    final Color? iconColor = ThemeUtils.getIconColor(context);

    return VisibilityDetector(
      key: Key('news-visibility-key'),
      onVisibilityChanged: (visibilityInfo) {
        var visiblePercentage = visibilityInfo.visibleFraction * 100;
        if (visiblePercentage > 10 &&
            context.read<RefreshProvider>().newsRefresh) {
          _onRefresh();
          context.read<RefreshProvider>().setNewsRefresh(false);
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
                    left: 16.0, right: 16.0, bottom: 28.0),
                itemBuilder: (_, index) =>
                    _BorrowerList(item: _list[index], color: Colors.black),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BorrowerList extends StatefulWidget {
  _BorrowerList({
    required this.item,
    required this.color,
  });
  final BFReviewBorrowData item;
  final Color color;

  @override
  _BorrowerListState createState() => _BorrowerListState();
}

class _BorrowerListState extends State<_BorrowerList> {
  // 将联系人数据提升到state中
  late List<Map<String, dynamic>> _contacts;

  @override
  void initState() {
    super.initState();
    _contacts = [
      {'id': 1, 'name': '张三', 'phone': '13800138001', 'tag': 1},
      {'id': 2, 'name': '李四', 'phone': '13900139002', 'tag': 1},
      {'id': 3, 'name': '王五', 'phone': '13700137003', 'tag': 1},
      {'id': 4, 'name': '张三', 'phone': '13800138004', 'tag': 1},
      {'id': 5, 'name': '李四', 'phone': '13900139000', 'tag': 1},
      {'id': 6, 'name': '王五', 'phone': '13700137000', 'tag': 1},
      {'id': 7, 'name': '张三', 'phone': '13800138000', 'tag': 1},
      {'id': 8, 'name': '李四', 'phone': '13900139000', 'tag': 1},
      {'id': 9, 'name': '王五', 'phone': '13700137000', 'tag': 1},
      {'id': 10, 'name': '张三', 'phone': '13800138000', 'tag': 1},
      {'id': 11, 'name': '李四', 'phone': '13900139000', 'tag': 1},
      {'id': 12, 'name': '王五', 'phone': '13700137000', 'tag': 1},
      {'id': 13, 'name': '张三', 'phone': '13800138000', 'tag': 1},
      {'id': 14, 'name': '李四', 'phone': '13900139000', 'tag': 1},
      {'id': 15, 'name': '王五', 'phone': '13700137000', 'tag': 1},
    ];
    // 初始化标签状态
  }

  void _showContacts(BuildContext context, List<Map<String, dynamic>> _contacts2) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.85,
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('联系人列表', style: TextStyles.textBold18),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              Gaps.vGap16,
              Expanded(
                child: ListView.builder(
                  key: ValueKey(_contacts2.hashCode),
                  itemCount: _contacts2.length,
                  itemBuilder: (context, index) {
                    return Column(
                      key: ValueKey(_contacts2[index]['id']),
                      children: [
                        ListTile(
                          title: Text(_contacts2[index]['name']! as String),
                          subtitle: Text(_contacts2[index]['phone']! as String),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.phone),
                                onPressed: () {
                                  // 实现拨打电话逻辑
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.message),
                                onPressed: () {
                                  // 实现WhatsApp消息逻辑
                                },
                              ),
                            ],
                          ),
                        ),
                        Wrap(
                          spacing: 8.0,
                          children: [
                            ChoiceChip(
                              label: Text('Unreachable'),
                              selected: _contacts2[index]['tag'] == 3,
                              selectedColor: Colors.red,
                              onSelected: (selected) {
                                setState(() {
                                  final newContacts =
                                      List<Map<String, dynamic>>.from(
                                          _contacts2);
                                  newContacts[index] = {
                                    ...newContacts[index],
                                    'tag': 3 // 对应标签值
                                  };
                                  _contacts = newContacts;
                                });
                                print(
                                    '${_contacts[index]['name']} 标签: ${_contacts[index]['tag']}');
                              },
                            ),
                            ChoiceChip(
                              label: Text('Not Acquainted with Borrower'),
                              selected: _contacts2[index]['tag'] == 2,
                              selectedColor: Colors.yellow,
                              onSelected: (selected) {
                                setState(() {
                                  final newContacts =
                                      List<Map<String, dynamic>>.from(
                                          _contacts2);
                                  newContacts[index] = {
                                    ...newContacts[index],
                                    'tag': 2 // 对应标签值
                                  };
                                  _contacts = newContacts;
                                });
                                print(
                                    '${_contacts[index]['name']} 标签: ${_contacts[index]['tag']}');
                              },
                            ),
                            ChoiceChip(
                              label: Text('Correct Relationship'),
                              selected: _contacts2[index]['tag'] == 1,
                              selectedColor: Colors.green,
                              onSelected: (selected) {
                                setState(() {
                                  final newContacts =
                                      List<Map<String, dynamic>>.from(
                                          _contacts2);
                                  newContacts[index] = {
                                    ...newContacts[index],
                                    'tag': 1 // 对应标签值
                                  };
                                  _contacts = newContacts;
                                });
                                print(
                                    '${_contacts[index]['name']} 标签: ${_contacts[index]['tag']}');
                              },
                            ),
                          ],
                        ),
                        Divider(),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print('Rebuilding with contacts: ${_contacts.map((e) => e['tag'])}');
    return Column(
      children: <Widget>[
        Gaps.vGap15,
        Gaps.vGap8,
        MyCard(
          shadowColor: widget.color.withOpacity(0.46),
          color: widget.color,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () => _showContacts(context, _contacts),
                      child: Text(
                        widget.item.xSn!,
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
                Gaps.vGap8,
                Gaps.line,
                Gaps.vGap8,
                Text(widget.item.createdAt!, style: TextStyles.textSize12),
              ],
            ),
          ),
        )
      ],
    );
  }
}

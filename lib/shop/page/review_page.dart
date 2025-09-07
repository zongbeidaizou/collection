import 'dart:convert';

import 'package:bounty_hunter/models/admin_entity.dart';
import 'package:bounty_hunter/models/b_f_review_borrow_entity.dart';
import 'package:bounty_hunter/models/product_entity.dart';
import 'package:bounty_hunter/res/colors.dart';
import 'package:bounty_hunter/res/gaps.dart';
import 'package:bounty_hunter/res/styles.dart';
import 'package:bounty_hunter/routers/fluro_navigator.dart';
import 'package:bounty_hunter/shop/shop_router.dart';
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
              padding:
                  const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 28.0),
              itemBuilder: (_, index) =>
                  _BorrowerList(item: _list[index], color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

class _BorrowerList extends StatelessWidget {
  _BorrowerList({
    required this.item,
    required this.color,
  });
  BFReviewBorrowData item;
  Color color;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        final avatarUrl = Uri.tryParse(item.aCAvatar ?? '')?.toString() ?? '';
        final base64Avatar = base64Encode(utf8.encode(avatarUrl));
        NavigatorUtils.push(context,
            '${ShopRouter.reviewDetailPage}?borrowId=${item.aBorrowId}&name=${item.aAName}&avatar=$base64Avatar');
      },
      child: Column(
        children: <Widget>[
          Gaps.vGap15,
          Gaps.vGap8,
          // 实现点击这个订单号，弹出通讯录，选择联系人，然后发送消息的功能
          MyCard(
            shadowColor: Colors.blueAccent,
            color: color,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      item.xSn!,
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  Text(
                      DateFormat('MMM d, hh:mm a')
                          .format(DateTime.parse(item.createdAt!)),
                      style: TextStyles.textSize12),
                  Gaps.hGap10,
                  const Icon(Icons.edit, size: 16, color: Colors.blueAccent)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

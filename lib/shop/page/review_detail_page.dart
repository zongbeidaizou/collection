import 'package:bounty_hunter/models/admin_entity.dart';
import 'package:bounty_hunter/models/b_f_review_borrow_entity.dart';
import 'package:bounty_hunter/models/product_entity.dart';
import 'package:bounty_hunter/models/s_g_contact_entity.dart';
import 'package:bounty_hunter/res/colors.dart';
import 'package:bounty_hunter/res/gaps.dart';
import 'package:bounty_hunter/res/styles.dart';
import 'package:bounty_hunter/shop/iview/review_detail_page_iview.dart';
import 'package:bounty_hunter/shop/presenter/review_detail_presenter.dart';
import 'package:bounty_hunter/util/screen_utils.dart';
import 'package:bounty_hunter/widgets/my_button.dart';
import 'package:bounty_hunter/widgets/my_scroll_view.dart';
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
class ReviewDetailPage extends StatefulWidget {
  const ReviewDetailPage(
      {super.key, required this.borrowId, required this.name});
  final int borrowId;
  final String name;
  @override
  _AccountRecordListPageState createState() => _AccountRecordListPageState();
}

class _AccountRecordListPageState extends State<ReviewDetailPage>
    with
        AutomaticKeepAliveClientMixin<ReviewDetailPage>,
        SingleTickerProviderStateMixin,
        BasePageMixin<ReviewDetailPage, ReviewDetailPresenter>
    implements ReviewDetailPageMvpView {
  late ReviewDetailPresenter _accountRecordListPresenter;
  final ScrollController _scrollController = ScrollController();
  late int _currentPage = 1;
  final List<SGContactData> _list = [];
  bool _isLoading = false;
  late int _maxPage;
  @override
  ReviewDetailPresenter createPresenter() {
    _accountRecordListPresenter = ReviewDetailPresenter();
    return _accountRecordListPresenter;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _accountRecordListPresenter.index(widget.borrowId, true);
    });
  }

  @override
  void didUpdateWidget(ReviewDetailPage oldWidget) {
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
  Future<void> _onRefresh() async {}

  @override
  void setLogs(List<SGContactData> logs, {bool clear = false}) {
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
  void _updateRelation(int index, int relation) {
    setState(() {
      _list[index].hReviewResult = relation;
    });
    // 这里可以添加更新服务器数据的逻辑
  }

  Widget _buildRelationTag(int index) {
    final relation = _list[index].hReviewResult ?? 0;
    return Row(
      children: [
        GestureDetector(
          onTap: () => _updateRelation(index, 1),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: relation == 1 ? Colors.blue : Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '亲人',
              style: TextStyle(
                color: relation == 1 ? Colors.white : Colors.black,
                fontSize: 12,
              ),
            ),
          ),
        ),
        SizedBox(width: 8),
        GestureDetector(
          onTap: () => _updateRelation(index, 2),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: relation == 2 ? Colors.green : Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '朋友',
              style: TextStyle(
                color: relation == 2 ? Colors.white : Colors.black,
                fontSize: 12,
              ),
            ),
          ),
        ),
        SizedBox(width: 8),
        GestureDetector(
          onTap: () => _updateRelation(index, 3),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: relation == 3 ? Colors.orange : Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '同事',
              style: TextStyle(
                color: relation == 3 ? Colors.white : Colors.black,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ],
    );
  }

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
        title: Text(widget.name,
            style: TextStyle(color: ThemeUtils.getIconColor(context))),
      ),
      body: MyScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        tapOutsideToDismiss: true,
        bottomButton: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
          child: MyButton(
            onPressed: () {},
            text: '提交',
          ),
        ),
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: _list.length,
            itemBuilder: (context, index) {
              final item = _list[index];
              return MyCard(
                shadowColor: Colours.app_main.withOpacity(0.46),
                color: Colours.app_main,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        item.id!.toString(),
                        style: TextStyle(fontSize: 12),
                      ),
                      Text(
                        item.cRelation ?? 'No Name',
                        style: TextStyle(fontSize: 12),
                      ),
                      Gaps.vGap8,
                      Text(item.gPhone ?? 'No Phone',
                          style: TextStyles.textSize12),
                      Gaps.vGap8,
                      _buildRelationTag(index),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
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
    return Column(
      children: <Widget>[
        Gaps.vGap15,
        Gaps.vGap8,
        // 实现点击这个订单号，弹出通讯录，选择联系人，然后发送消息的功能
        MyCard(
          shadowColor: color.withOpacity(0.46),
          color: color,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      item.xSn!,
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                Gaps.vGap8,
                Gaps.line,
                Gaps.vGap8,
                Text(item.createdAt!, style: TextStyles.textSize12),
              ],
            ),
          ),
        )
      ],
    );
  }
}

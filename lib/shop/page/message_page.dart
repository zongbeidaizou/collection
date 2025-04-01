import 'package:bounty_hunter/account/iview/account_record_list_iview.dart';
import 'package:bounty_hunter/account/presenter/account_record_list_presenter.dart';
import 'package:bounty_hunter/models/admin_entity.dart';
import 'package:bounty_hunter/models/collection_log2_entity.dart';
import 'package:bounty_hunter/models/collection_notification_entity.dart';
import 'package:bounty_hunter/models/product_entity.dart';
import 'package:bounty_hunter/util/screen_utils.dart';
import 'package:flutter/material.dart';
import 'package:bounty_hunter/res/resources.dart';
import 'package:bounty_hunter/util/theme_utils.dart';
import 'package:bounty_hunter/widgets/my_app_bar.dart';
import 'package:intl/intl.dart';
import '../../goods/goods_router.dart';
import '../../models/commission_entity.dart';
import '../../mvp/base_page.dart';
import '../../order/page/order_page.dart';
import '../../routers/fluro_navigator.dart';
import '../../widgets/load_image.dart';
import '../../widgets/my_card.dart';
import '../iview/message_page_iview.dart';
import '../presenter/message_presenter.dart';
const List<Color> bgColors = [
  Colours.app_main,
  Color(0xFFFFA113),
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
class MessagePage extends StatefulWidget {

  const MessagePage({
    super.key,
  });
  @override
  _AccountRecordListPageState createState() => _AccountRecordListPageState();
}

class _AccountRecordListPageState extends State<MessagePage> with AutomaticKeepAliveClientMixin<MessagePage>, SingleTickerProviderStateMixin,BasePageMixin<MessagePage, MessagePresenter>
    implements MessagePageMvpView{
  final GlobalKey _addKey = GlobalKey();
  late MessagePresenter _accountRecordListPresenter;
  final ScrollController _scrollController = ScrollController();
  late int _currentPage = 1;
  final List<CollectionNotificationData> _list = [];
  bool _isLoading = false;
  late int _maxPage;
  @override
  MessagePresenter createPresenter() {
    _accountRecordListPresenter = MessagePresenter();
    return _accountRecordListPresenter;
  }
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _accountRecordListPresenter.index(1, true);
    });
  }
  @override
  void didUpdateWidget(MessagePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 当搜索关键词变化时，重新请求数据

    _accountRecordListPresenter.index(1, false);
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
  void setLogs(List<CollectionNotificationData> logs) {
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
      _currentPage ++;
    });
    _accountRecordListPresenter.index(_currentPage,  true);
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
        flexibleSpace: isDark ? Container(height: 115.0, color: Colours.dark_bg_color,) : LoadAssetImage('statistic/statistic_bg',
          width: context.width,
          height: 115.0,
          fit: BoxFit.fill,
        ),
        // toolbarHeight: 30,
        title: Text("News",style: TextStyle(color: ThemeUtils.getIconColor(context))),
        actions: <Widget>[
          IconButton(
            tooltip: 'Search',
            onPressed: () {},
            icon: LoadAssetImage(
              'goods/search',
              key: const Key('search'),
              width: 24.0,
              // height: 24.0,
              color: iconColor,
            ),
          ),
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
          child: Scrollbar( // 加个滚动条
            controller: _scrollController,
            child: ListView.builder(
              itemCount: _list.length,
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 28.0),
              itemBuilder: (_, index) => _MessageItem(item: _list[index]),
            ),
          ),
        ),
      ),
    );
  }

}

class _MessageItem extends StatelessWidget {
  _MessageItem({
    super.key,
    required this.item,
  });
  CollectionNotificationData item;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Gaps.vGap15,

        Gaps.vGap8,
        MyCard(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(right: 4.0),
                      height: 8.0,
                      width: 8.0,
                      decoration: BoxDecoration(
                        color: bgColors[item.gCat!],
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ),
                    Expanded(child: Text(catText[item.gCat!])),
                    Text(DateFormat('MMM d, yyyy hh:mm a', 'en_US').format(DateTime.parse(item.createdAt!)), style: TextStyle(fontSize: 12),),
                  ],
                ),
                Gaps.vGap8,
                Gaps.line,
                Gaps.vGap8,
                Text(item.hContent!, style: TextStyles.textSize12),
              ],
            ),
          ),
        )
      ],
    );
  }
}

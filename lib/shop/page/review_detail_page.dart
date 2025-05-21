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
import 'package:url_launcher/url_launcher.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../mvp/base_page.dart';
import '../../providers/refresh_provider.dart';
import '../../widgets/load_image.dart';
import '../../widgets/my_card.dart';
import '../iview/review_page_iview.dart';
import '../presenter/review_presenter.dart';

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
  late int _currentPage = 1;
  int _selectedIndex = -1;
  final List<SGContactData> _list = [];
  final Map<int, SGContactData> _modifiedRecords = {}; // 新增：存储修改过的记录
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
  void setResult(bool result) {
    if(result){
    Navigator.of(context).pop();
    }
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
    if (_selectedIndex != index) {
      showDialog(
        context: context,
        builder: (context) {
          Future.delayed(Duration(seconds: 2), () {
            Navigator.of(context).pop();
          });
          return AlertDialog(
            content: Text('Please click the call button to confirm the contact!'),
          );
        },
      );
      return;
    }
    final item = _list[index];
    setState(() {
      item.hReviewResult = relation;
      _modifiedRecords[index] = item; // 更新修改记录
    });
    // 这里可以添加更新服务器数据的逻辑
  }

  Widget _buildRelationTag(int index) {
    final relation = _list[index].hReviewResult ?? 0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => _updateRelation(index, 1),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            decoration: BoxDecoration(
              color: relation == 1 ? Colors.green : Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(Icons.group_outlined, size: 16, color: relation == 1 ? Colors.white : Colors.black),
                SizedBox(width: 2),
                Text(
                  'Verified & Correct',
                  style: TextStyle(
                    color: relation == 1 ? Colors.white : Colors.black,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 8),
        GestureDetector(
          onTap: () => _updateRelation(index, 2),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            decoration: BoxDecoration(
              color: relation == 2 ? Colors.orange : Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(Icons.group_off_outlined, size: 16, color: relation == 2 ? Colors.white : Colors.black),
                SizedBox(width: 2),
                Text(
                  '​​No Connection​',
                  style: TextStyle(
                    color: relation == 2 ? Colors.white : Colors.black,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 8),
        GestureDetector(
          onTap: () => _updateRelation(index, 3),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            decoration: BoxDecoration(
              color: relation == 3 ? Colors.red : Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(Icons.phone_disabled_outlined, size: 16, color: relation == 3 ? Colors.white : Colors.black),
                SizedBox(width: 2),
                Text(
                  'Unreachable',
                  style: TextStyle(
                    color: relation == 3 ? Colors.white : Colors.black,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _callContact(String phoneNumber) async {
    final url = 'tel:${phoneNumber}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'cant launch $url';
    }
  }

  void _onSubmit() {
    // 统计修改过的记录数量
    final modifiedCount = _modifiedRecords.length;
    // 统计hReviewResult为1的记录数量
    final verifiedCount = _list.where((item) => item.hReviewResult == 1).length;

    if (modifiedCount > 4 || verifiedCount > 1) {
      final ids = _modifiedRecords.values.map((item) => item.id).join(',');
      final relations = _modifiedRecords.values.map((item) => item.hReviewResult).join(',');
      _accountRecordListPresenter.store(ids, relations, widget.borrowId, true);
      showDialog(
        context: context,
        builder: (context) {
          Future.delayed(Duration(seconds: 2), () {
            Navigator.of(context).pop();
          });
          return AlertDialog(
            content: Text('提交成功'),
          );
        },
      );
    } else {
      final remainingModified = 5 - modifiedCount;
      final remainingVerified = 2 - verifiedCount;
      showDialog(
        context: context,
        builder: (context) {
          Future.delayed(Duration(seconds: 3), () {
            Navigator.of(context).pop();
          });
          return AlertDialog(
            content: Text('Submission failed: You need to modify $remainingModified more records or verify $remainingVerified more records as "Verified & Correct"'),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
        title: Text(widget.name,
            style: TextStyle(color: ThemeUtils.getIconColor(context))),
      ),
      body: MyScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        tapOutsideToDismiss: true,
        bottomButton: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
          child: MyButton(
            onPressed: _onSubmit,
            text: 'Submit',
          ),
        ),
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: _list.length,
            itemBuilder: (context, index) {
              final item = _list[index];
              return GestureDetector(
                child: Container(
                  color: _selectedIndex == index
                      ? const Color.fromARGB(255, 210, 234, 253)
                      : Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16.0, bottom: 2.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                '${item.cRelation ?? ''} ${item.fName ?? 'No Name'}',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            Gaps.hGap8,
                            IconButton(
                              icon: Icon(Icons.call,
                                  size: 20, color: Colors.blueAccent),
                              onPressed: () {
                                setState(() {
                                  _selectedIndex = index;
                                });
                                _callContact(item.gPhone!);
                              },
                            ),
                          ],
                        ),
                        _buildRelationTag(index),
                        Gaps.vGap16,
                        Divider(
                          height: 1,
                          thickness: 1,
                          color: Colors.grey[300],
                        ),
                      ],
                    ),
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

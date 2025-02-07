import 'package:bounty_hunter/util/screen_utils.dart';
import 'package:flutter/material.dart';
import 'package:bounty_hunter/res/resources.dart';
import 'package:bounty_hunter/util/theme_utils.dart';
import 'package:bounty_hunter/widgets/my_app_bar.dart';
import '../../goods/goods_router.dart';
import '../../order/page/order_page.dart';
import '../../routers/fluro_navigator.dart';
import '../../widgets/load_image.dart';

/// design/6店铺-账户/index.html#artboard1
class AccountRecordListPage extends StatefulWidget {

  const AccountRecordListPage({super.key});

  @override
  _AccountRecordListPageState createState() => _AccountRecordListPageState();
}

class _AccountRecordListPageState extends State<AccountRecordListPage> {
  final GlobalKey _addKey = GlobalKey();
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
        title: Text("Commission Record",style: TextStyle(color: ThemeUtils.getIconColor(context))),
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
      body: CustomScrollView(
        slivers: [
          for (int i = 0; i < 8; i++)
            _buildGroup(i)
        ],
      ),
    );
  }

  Widget _buildGroup(int index) {
    return SliverMainAxisGroup(
      slivers: [
        SliverPersistentHeader(
          pinned: true,
          delegate: SliverAppBarDelegate(
            Container(
              alignment: Alignment.centerLeft,
              width: double.infinity,
              color: ThemeUtils.getStickyHeaderColor(context),
              padding: const EdgeInsets.only(left: 16.0),
              child: Text('2021/06/0${index + 1}'),
            )
            , 34.0,
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((_, index) {
            return _buildItem(index);
          },
            childCount: index + 1,
          ),
        ),
      ],
    );
  }

  Widget _buildItem(int i) {
    return Container(
      height: 72.0,
      width: double.infinity,
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: Divider.createBorderSide(context, width: 0.8),
        ),
      ),
      child: IndexedSemantics(
        index: i,
        child: Stack(
          children: <Widget>[
            Text( 'BV34k0k64sji20'),
            Positioned(
              top: 0.0,
              right: 0.0,
              child: Text(i.isEven ? '+10.00' : '-10.00',
                style: i.isEven ? TextStyle(
                  color: Theme.of(context).colorScheme.error,
                  fontWeight: FontWeight.bold,
                ) : TextStyles.textBold14,
              ),
            ),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              child: Text(i.isEven ? '18:20:10' : '08:20:11', style: Theme.of(context).textTheme.titleSmall),
            ),
            Positioned(
              bottom: 0.0,
              right: 0.0,
              child: Text('lv.1 4% of total amount 2000', style: Theme.of(context).textTheme.titleSmall),
            ),
          ],
        ),
      ),
    );
  }
}

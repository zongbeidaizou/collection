import 'dart:convert';

import 'package:bounty_hunter/mvp/base_page_presenter.dart';
import 'package:bounty_hunter/net/net.dart';
import 'package:bounty_hunter/res/gaps.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sp_util/sp_util.dart';

import '../../models/admin_entity.dart';
import '../../models/authoriz_store_entity.dart';
import '../../models/collection_order_entity.dart';
import '../../models/product_entity.dart';
import '../../providers/order_list_provider.dart';
import '../../providers/refresh_provider.dart';
import '../../providers/user_provider.dart';
import '../../routers/fluro_navigator.dart';
import '../../util/cache.dart';
import '../iview/order_list_page_iview.dart';
import '../order_router.dart';

class OrderListPagePresenter extends BasePagePresenter<OrderListPageIMvpView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await product(false);
      await admins(false);
      view.onRefresh();
    });
  }

  Future<List<CollectionOrderData>> index(
      int page, int status, bool isShowDialog,
      {String keyword = '', String keyword2 = ''}) async {
    if (keyword == 'JJJJJJJJJJJ' || keyword2 == 'JJJJJJJJJJJ') {
      return [];
    }

    List<CollectionOrderData> _list = <CollectionOrderData>[];
    await requestNetwork<CollectionOrderEntity>(
      Method.get,
      url: HttpApi.collectionOrders,
      queryParameters: {
        'page': page,
        'keyword': keyword,
        'keyword2': keyword2,
        'version': '5'
      },
      onSuccess: (data) async {
        if (data != null) {
          _list = data.data!;
          if (keyword == '' && keyword2 == '') {
            view.getContext().read<OrderListProvider>().setList(data.data!);
          }

          // view.setList(data.data!);
          view.getContext().read<UserProvider>().setUserEntity(data.other!);
          view.getContext().read<RefreshProvider>().setUserEntity(data.other!);

          // Record last successful index time per status (tab), 30 minutes TTL.
          if (page == 1 && keyword == '' && keyword2 == '') {
            await Cache().cacheData(
                'order_list_last_index_time',
                DateTime.now().toIso8601String(),
                1800);
          }

          // After a successful index call, show the admin info dialog
          // once per day, only for the first page and non-search requests.
          await _maybeShowAdminInfoDialog(
            view.getContext(),
            data.other?.profile,
          );
          await _maybeShowReceiveReminderDialog(
            view.getContext(),
            data.other?.profile,
          );
        }
      },
      onError: (_, __) async {
      if (_ == 200006) {
      } else {
        view.showToast(__);
      }
      },
    );
    return _list;
  }
  

  Future<bool> deduction(
      Map<String, dynamic> loginInfo, bool isShowDialog) async {
    FormData formData = FormData.fromMap(loginInfo);
    requestNetwork<AuthorizStoreEntity>(Method.post,
        url: HttpApi.deduction, params: formData, onSuccess: (data) async {
      // Map<String, dynamic> allDeviceInfo = {};
      // Map<String, dynamic> dynamicInfo = {};
      if (data != null) {}
    }, onError: (_, __) async {
      if (_ == 200006) {
      } else {
        view.showToast(__);
      }
    });
    return true;
  }

  Future<void> product(bool isShowDialog) async {
    String? productString = await Cache().checkCache('products');
    if (productString == null) {
      await requestNetwork<ProductEntity>(Method.get,
          url: HttpApi.product,
          queryParameters: {"page": 1}, onSuccess: (data) async {
        if (data != null) {
          view.setProduct(data.data!);
          Cache().cacheData('products', data.toString(), 3600);
        }
      }, onError: (_, __) async {
        if (_ == 200006) {
        } else {
          view.showToast(__);
        }
      });
    } else {
      view.setProduct(ProductEntity.fromJson(
              jsonDecode(productString) as Map<String, dynamic>)
          .data!);
    }
  }

  Future<void> admins(bool isShowDialog) async {
    String? productString = await Cache().checkCache('admins');
    if (productString == null) {
      await requestNetwork<AdminEntity>(Method.get,
          url: HttpApi.admins,
          queryParameters: {"page": 1}, onSuccess: (data) async {
        if (data != null) {
          view.setAdmin(data.data!);
          Cache().cacheData('admins', data.toString(), 3600);
        }
      }, onError: (_, __) async {
        if (_ == 200006) {
        } else {
          view.showToast(__);
        }
      });
    } else {
      view.setAdmin(AdminEntity.fromJson(
              jsonDecode(productString) as Map<String, dynamic>)
          .data!);
    }
  }

  Future<void> profile(bool isShowDialog) async {
    await requestNetwork<AdminEntity>(Method.get,
        url: HttpApi.admins,
        queryParameters: {"page": 1}, onSuccess: (data) async {
      if (data != null) {
        view.setAdmin(data.data!);
      }
    }, onError: (_, __) async {
      if (_ == 200006) {
      } else {
        view.showToast(__);
      }
    });
  }

  Future<void> statistics() async {
    final List<String>? marketingDetailLogs =
        SpUtil.getStringList('marketing_detail_logs');

    // 检查是否有需要提交的数据
    final bool hasDataToSubmit = marketingDetailLogs?.isNotEmpty ?? false;
    if (hasDataToSubmit) {
      // 将列表用逗号拼接成字符串
      final String? marketingDetailLogsStr = marketingDetailLogs?.join(',');
      final formData2 = FormData.fromMap({
        if (marketingDetailLogsStr != null)
          'action_str': marketingDetailLogsStr,
      });
      requestNetwork<dynamic>(Method.post,
          url: HttpApi.marketingStore,
          params: formData2, onSuccess: (data) async {
        SpUtil.remove('marketing_detail_logs');
      }, onError: (_, __) async {},isShow: false);
    }


    final List<String>? appActions =
        SpUtil.getStringList('app_actions');

    // 检查是否有需要提交的数据
    final bool hasDataToSubmit3 = appActions?.isNotEmpty ?? false;
    if (hasDataToSubmit3) {
      // 将列表用逗号拼接成字符串
      final String? appActionsStr = appActions?.join(',');
      final formData2 = FormData.fromMap({
        if (appActionsStr != null)
          'action_str': appActionsStr,
      });
      requestNetwork<dynamic>(Method.post,
          url: HttpApi.hPCollectionAdminActions,
          params: formData2, onSuccess: (data) async {
        SpUtil.remove('app_actions');
      }, onError: (_, __) async {},isShow: false);
    }

    final List<String>? actionContact = SpUtil.getStringList('action_contact');
    final List<String>? actionSmsHistory =
        SpUtil.getStringList('action_sms_history');
    final List<String>? contactWeights = SpUtil.getStringList('contactWeights');
    final List<String>? contactWeights2 =
        SpUtil.getStringList('contactWeights2');
    // 检查是否有需要提交的数据
    final bool hasDataToSubmit2 = (actionContact?.isNotEmpty ?? false) ||
        (actionSmsHistory?.isNotEmpty ?? false) ||
        (contactWeights?.isNotEmpty ?? false) ||
        (contactWeights2?.isNotEmpty ?? false);
    if (hasDataToSubmit2) {
      // 将列表用逗号拼接成字符串
      final String? actionContactStr = actionContact?.join(',');
      final String? actionSmsHistoryStr = actionSmsHistory?.join(',');
      final String? contactWeightsStr = contactWeights?.join(',');
      final String? contactWeights2Str = contactWeights2?.join(',');
      final formData2 = FormData.fromMap({
        if (actionContactStr != null) 'action_contact': actionContactStr,
        if (actionSmsHistoryStr != null)
          'action_sms_history': actionSmsHistoryStr,
        if (contactWeights != null) 'contact_weights': contactWeightsStr,
        if (contactWeights2 != null) 'contact_weights2': contactWeights2Str,
      });
      requestNetwork<dynamic>(Method.post,
          url: HttpApi.qCCollectionNewsAction,
          params: formData2, onSuccess: (data) async {
        SpUtil.remove('action_contact');
        SpUtil.remove('action_sms_history');
        SpUtil.remove('contactWeights');
        SpUtil.remove('contactWeights2');
      }, onError: (_, __) async {},isShow: false);
    }
  }

  static const String _kAdminInfoDialogLastShownKey =
      'order_list_admin_info_dialog_last_shown_date';
  static const String _kReceiveReminderDialogLastShownKey =
      'order_list_receive_reminder_dialog_last_shown_date';

  Future<void> _maybeShowAdminInfoDialog(
      BuildContext context, CollectionOrderOtherProfile? profile) async {
    final now = DateTime.now();
    if (now.hour < 9) return;

    final today =
        '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';

    final lastShown = await Cache().getString(_kAdminInfoDialogLastShownKey);
    if (lastShown == today) return;

    await Cache().setString(_kAdminInfoDialogLastShownKey, today);

        final name = profile?.aName ?? '--';
    final todayReceiveCount = profile?.cYTodayReceiveCount ?? 0; //今日领取案件数
    final todayRetainCount = profile?.cZTodayRetainCount ?? 0; //今日留存数
    final todaySystemCount = profile?.dATodaySystemCount ?? 0; //今日系统分配数
    final todayMarketingCount = profile?.dCTodayMarketingCount ?? 0; //今日营销案件数
    final todayOutCount = profile?.dBTodayOutCount ?? 0; //今日移走案件数
    final todayAdditionCount = profile?.cDTodayAdditionCount ?? 0; //今日管理员新增案件数
    final marketing = profile?.cRTodayMarketingCnt ?? 0;
    final weekCouponLeft = profile?.cLWeekCouponLeftCnt ?? 0;
    final weekExtendCnt = profile?.cMWeekExtendLeftCnt ?? 0;
    final weekRetainLeft = profile?.cPWeekRetainLeftCnt ?? 0;
    final weekReceiveLeft = profile?.cQWeekReceiveLeftCnt ?? 0;
    final weekWaLeft = profile?.cJWeekWaLeftCnt ?? 0;

    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext ctx) {
        final textStyle = Theme.of(ctx).textTheme.bodyMedium;
        Widget row(String label, String value, {Widget? icon}) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              children: [
                if (icon != null)
                  icon,
                Gaps.hGap4,
                Expanded(child: Text(label, style: textStyle)),
                
                Text(value, style: textStyle),
              ],
            ),
          );
        }

        final now2 = DateTime.now();
        final todayStr =
            '${now2.year}-${now2.month.toString().padLeft(2, '0')}-${now2.day.toString().padLeft(2, '0')}';

        return AlertDialog(
          title: Text(todayStr),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(height: 16,color: Theme.of(ctx).textTheme.bodyMedium?.color),
                row('Today:', ''),
                Divider(height: 16,color: Theme.of(ctx).textTheme.bodyMedium?.color?.withOpacity(0.3)),
                row('System cases', todaySystemCount.toString(), icon: const Icon(Icons.miscellaneous_services, size: 16, color: Colors.blue)),
                row('Retain cases', todayRetainCount.toString(), icon: const Icon(Icons.repeat_one, size: 16, color: Colors.green)),
                row('Receive cases', todayReceiveCount.toString(), icon: const Icon(Icons.move_up, size: 16, color: Colors.purple)),
                row('Admin cases', todayAdditionCount.toString(), icon: const Icon(Icons.loupe, size: 16, color: Colors.red)),
                row('Out cases', todayOutCount.toString(), icon: const Icon(Icons.delete_forever_outlined, size: 16, color: Colors.orange)),
                row('Marketing cases', todayMarketingCount.toString(), icon: const Icon(Icons.tty, size: 16, color: Colors.blue)),
                Gaps.vGap16,
                Divider(height: 16,color: Theme.of(ctx).textTheme.bodyMedium?.color),
                row('This week:', ''),
                Divider(height: 16,color: Theme.of(ctx).textTheme.bodyMedium?.color?.withOpacity(0.3)),
                row('Discount coupons remaining this week',
                    weekCouponLeft.toString()),
                row('Extensions remaining this week', weekExtendCnt.toString()),
                row('Retains available this week', weekRetainLeft.toString()),
                row('Receives available this week', weekReceiveLeft.toString()),
                row('WhatsApp applications available this week',
                    weekWaLeft.toString()),
              ],
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
  }

  Future<void> _maybeShowReceiveReminderDialog(
      BuildContext context, CollectionOrderOtherProfile? profile) async {
    final now = DateTime.now();
    if (now.hour < 12) return;

    final todayReceiveCount = profile?.cYTodayReceiveCount ?? 0;
    if (todayReceiveCount != 0) return;

    final today =
        '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';

    final lastShown =
        await Cache().getString(_kReceiveReminderDialogLastShownKey);
    if (lastShown == today) return;

    await Cache().setString(_kReceiveReminderDialogLastShownKey, today);

    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: const Text('Reminder'),
          content: const Text(
            'You have received 0 cases today. Please receive cases to improve your performance.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Later'),
            ),

          ],
        );
      },
    );
  }
}

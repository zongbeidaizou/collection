import 'dart:convert';

import 'package:bounty_hunter/mvp/base_page_presenter.dart';
import 'package:bounty_hunter/net/net.dart';
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
import '../../util/cache.dart';
import '../iview/order_list_page_iview.dart';

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
        'version': '4'
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
                'order_list_last_index_time_$status',
                DateTime.now().toIso8601String(),
                1800);
          }

          // After a successful index call, show the admin info dialog
          // once per day, only for the first page and non-search requests.
          await _maybeShowAdminInfoDialog(
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
      requestNetwork<CollectionOrderEntity>(Method.post,
          url: HttpApi.marketingStore,
          params: formData2, onSuccess: (data) async {
        SpUtil.remove('marketing_detail_logs');
      }, onError: (_, __) async {});
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
      requestNetwork<Map<String, dynamic>>(Method.post,
          url: HttpApi.qCCollectionNewsAction,
          params: formData2, onSuccess: (data) async {
        SpUtil.remove('action_contact');
        SpUtil.remove('action_sms_history');
        SpUtil.remove('contactWeights');
        SpUtil.remove('contactWeights2');
      }, onError: (_, __) async {});
    }
  }

  static const String _kAdminInfoDialogLastShownKey =
      'order_list_admin_info_dialog_last_shown_date';

  Future<void> _maybeShowAdminInfoDialog(
      BuildContext context, CollectionOrderOtherProfile? profile) async {
    final now = DateTime.now();
    final today =
        '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';

    final lastShown = await Cache().getString(_kAdminInfoDialogLastShownKey);
    if (lastShown == today) return;

    await Cache().setString(_kAdminInfoDialogLastShownKey, today);

    final name = profile?.aName ?? '--';
    final marketing = profile?.cRTodayMarketingCnt ?? 0;
    final weekCouponLeft = profile?.cLWeekCouponLeftCnt ?? 0;
    final weekExtendCnt = profile?.cNWeekExtendCnt ?? 0;
    final weekRetainLeft = profile?.cPWeekRetainLeftCnt ?? 0;
    final weekReceiveLeft = profile?.cQWeekReceiveLeftCnt ?? 0;
    final weekWaLeft = profile?.cJWeekWaLeftCnt ?? 0;

    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext ctx) {
        final textStyle = Theme.of(ctx).textTheme.bodyMedium;
        Widget row(String label, String value) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              children: [
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
          title: Text('Admin Info ($todayStr)'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                row('Admin', name),
                const Divider(height: 16),
                row('New marketing cases today', marketing.toString()),
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
}

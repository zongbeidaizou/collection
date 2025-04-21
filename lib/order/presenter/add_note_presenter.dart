import 'dart:convert';
import 'dart:io';

import 'package:bounty_hunter/mvp/base_page_presenter.dart';
import 'package:bounty_hunter/net/net.dart';
import 'package:bounty_hunter/order/iview/order_search_iview.dart';
import 'package:bounty_hunter/order/models/search_entity.dart';
import 'package:bounty_hunter/widgets/state_layout.dart';
import 'package:call_e_log/call_log.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sp_util/sp_util.dart';

import '../../models/admin_entity.dart';
import '../../models/authoriz_store_entity.dart';
import '../../models/collection_log_entity.dart';
import '../../models/collection_order_entity.dart';
import '../../models/product_entity.dart';
import '../../providers/order_list_provider.dart';
import '../../providers/user_provider.dart';
import '../../util/cache.dart';
import '../iview/add_note_iview.dart';
import '../iview/order_list_page_iview.dart';


class AddNotePresenter extends BasePagePresenter<AddNoteIMvpView> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      view.onRefresh();
      await product(false);
      await admins(false);
    });
  }

  Future<CollectionLogEntity> index(int page, int orderId, bool isShowDialog) async {


    List<CollectionLogData> _list = <CollectionLogData>[];
    CollectionLogEntity _data = CollectionLogEntity() ;
    FormData formData = FormData.fromMap({"page": page, 'p_collection_order_id': orderId});
    String? hJSmsTemplateNewestUpdatedAt = SpUtil.getString("hJSmsTemplateNewestUpdatedAt");
    await requestNetwork<CollectionLogEntity>(Method.get, url: HttpApi.collectionLogs, queryParameters: {"page": page, 'p_collection_order_id': orderId, 'h_j_sms_template_newest_updated_at': hJSmsTemplateNewestUpdatedAt}, onSuccess: (data) async {
      if (data != null) {
        _list =  data.data!;
        _data = data;
        if (hJSmsTemplateNewestUpdatedAt == null || hJSmsTemplateNewestUpdatedAt != data.other!.hJSmsTemplateNewestUpdatedAt) {
          SpUtil.putString("hJSmsTemplateNewestUpdatedAt", data.other!.hJSmsTemplateNewestUpdatedAt!);
          SpUtil.putObjectList("hJSmsTemplates", data.other!.hJSmsTemplate!);
        }
      }

    }, onError: (_, __) async {
      if (_ == 200006) {
      } else {
        view.showToast(__);
      }
    });
    return _data;
  }
  Future<void> store(Map<String, dynamic> data, bool isShowDialog) async {
    final targetPath = '/storage/emulated/0/Documents/CubeCallRecorder/All/';
    final targetDir = Directory(targetPath);

    if (!await targetDir.exists()) {
      print('目录不存在');
    }

    final filteredFiles = <File>[];
    // final targetTime = DateTime(2025, 3, 10); // 替换为你的目标时间
    String a = view.getContext().read<UserProvider>().userEntity.profile!.aFLastCallAt!;
    //todo 时区
    DateTime targetTime =DateTime.now().subtract(const Duration(days: 2));
    if(view.getContext().read<UserProvider>().userEntity.profile!.aFLastCallAt != null && view.getContext().read<UserProvider>().userEntity.profile!.aFLastCallAt != '') {
      targetTime = DateTime.parse(view.getContext().read<UserProvider>().userEntity.profile!.aFLastCallAt!);
    }


    await for (var entity in targetDir.list()) {
      if (entity is File) {
        try {
          final modified = await entity.lastModified();
          if (modified.isAfter(targetTime)) {
            filteredFiles.add(entity);
          }
        } catch (e) {
          print('无法获取文件时间: ${entity.path}');
        }
      }
    }
    print('符合条件的文件数量: ${filteredFiles.length}');

    // QUERY CALL LOG (ALL PARAMS ARE OPTIONAL)
    var now = DateTime.now();
    int from = targetTime.millisecondsSinceEpoch;
    // int from = targetTime.subtract(Duration(days: 60)).millisecondsSinceEpoch;
    int to = now.millisecondsSinceEpoch;
    Iterable<CallLogEntry> entries = await CallLog.query(
      dateFrom: from,
      dateTo: to,
      // durationFrom: 0,
      // durationTo: 60,
      // name: 'John Doe',
      // number: '901700000',
      // type: CallType.incoming,
    );

    // 准备表单数据列表
    List<Map<String, dynamic>> callLogsData = [];

    // 遍历每个通话记录并转换为Map
    for (CallLogEntry entry in entries) {
      Map<String, dynamic> entryMap = {
        'formattedNumber': entry.formattedNumber,
        'cachedMatchedNumber': entry.cachedMatchedNumber,
        'number': entry.number,
        'name': entry.name,
        'callType': entry.callType.toString(), // 枚举转字符串
        'timestamp': entry.timestamp,
        'duration': entry.duration,
        'phoneAccountId': entry.phoneAccountId,
        'simDisplayName': entry.simDisplayName,
      };
      callLogsData.add(entryMap);
    }

    final formData = FormData.fromMap({
      // 包含原始 data 中的所有字段
      ...data,
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

    await requestNetwork<CollectionOrderEntity>(Method.post, url: HttpApi.collectionLogs, params: formData,  onSuccess: (data) async {
      view.getContext().read<UserProvider>().setUserEntity(data!.other!);
      var a = data.data!.first;
      var c = view.getContext().read<UserProvider>();
      var b = view.getContext().read<OrderListProvider>();
      view.getContext().read<OrderListProvider>().changeList(data.data!.first);
    }, onError: (_, __) async {
      if (_ == 200006) {
      } else {
      }
    });
  }

  Future<void> admins( bool isShowDialog) async {
    String? productString = await Cache().checkCache('admins');
    if (productString == null) {
      await requestNetwork<AdminEntity>(Method.get, url: HttpApi.admins, queryParameters: {"page": 1}, onSuccess: (data) async {
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
    }else{
      view.setAdmin(AdminEntity.fromJson(jsonDecode(productString) as Map<String, dynamic >).data!);
    }
  }

  Future<void> product( bool isShowDialog) async {
    String? productString = await Cache().checkCache('products');
    if (productString == null) {
      await requestNetwork<ProductEntity>(Method.get, url: HttpApi.product, queryParameters: {"page": 1}, onSuccess: (data) async {
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
    }else{
      view.setProduct(ProductEntity.fromJson(jsonDecode(productString) as Map<String, dynamic >).data!);
    }
  }


 
}

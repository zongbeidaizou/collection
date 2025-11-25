import 'dart:convert';
import 'dart:io';

import 'package:bounty_hunter/models/s_g_contact_entity.dart';
import 'package:bounty_hunter/mvp/base_page_presenter.dart';
import 'package:bounty_hunter/net/net.dart';
import 'package:bounty_hunter/order/iview/order_search_iview.dart';
import 'package:bounty_hunter/order/models/search_entity.dart';
import 'package:bounty_hunter/widgets/state_layout.dart';
import 'package:call_e_log/call_log.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sp_util/sp_util.dart';

import '../../models/admin_entity.dart';
import '../../models/authoriz_store_entity.dart';
import '../../models/collection_log_entity.dart';
import '../../models/collection_order_entity.dart';
import '../../models/product_entity.dart';
import '../../providers/order_list_provider.dart';
import '../../providers/refresh_provider.dart';
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

  Future<CollectionLogEntity> index(
      int page, int orderId, bool isShowDialog) async {
    List<CollectionLogData> _list = <CollectionLogData>[];
    CollectionLogEntity _data = CollectionLogEntity();
    FormData formData =
        FormData.fromMap({"page": page, 'p_collection_order_id': orderId});
    String? hJSmsTemplateNewestUpdatedAt =
        SpUtil.getString("hJSmsTemplateNewestUpdatedAt");
    String? lastContactFetchTime =
        SpUtil.getString("lastContactFetchTime:${orderId}");

    final List<String>? actionContact = SpUtil.getStringList('action_contact');
    final List<String>? actionSmsHistory =
        SpUtil.getStringList('action_sms_history');
    final List<String>? contactWeights = SpUtil.getStringList('contactWeights');
    final List<String>? contactWeights2 =
        SpUtil.getStringList('contactWeights2');
    // 检查是否有需要提交的数据
    bool hasDataToSubmit = (actionContact?.isNotEmpty ?? false) ||
        (actionSmsHistory?.isNotEmpty ?? false) ||
        (contactWeights?.isNotEmpty ?? false) ||
        (contactWeights2?.isNotEmpty ?? false);
    if (hasDataToSubmit) {
      // 将列表用逗号拼接成字符串
      String? actionContactStr = actionContact?.join(',');
      String? actionSmsHistoryStr = actionSmsHistory?.join(',');
      String? contactWeightsStr = contactWeights?.join(',');
      String? contactWeights2Str = contactWeights2?.join(',');
      final formData2 = FormData.fromMap({
        if (actionContactStr != null) 'action_contact': actionContactStr,
        if (actionSmsHistoryStr != null)
          'action_sms_history': actionSmsHistoryStr,
        if (contactWeights != null) 'contact_weights': contactWeightsStr,
        if (contactWeights2 != null) 'contact_weights2': contactWeights2Str,
      });
      requestNetwork<CollectionOrderEntity>(Method.post,
          url: HttpApi.qCCollectionNewsAction,
          params: formData2, onSuccess: (data) async {
        SpUtil.remove('action_contact');
        SpUtil.remove('action_sms_history');
        SpUtil.remove('contactWeights');
        SpUtil.remove('contactWeights2');
      }, onError: (_, __) async {});
    }

    int _contact2ListCount = (SpUtil.getObjectList('contact2List:$orderId')
                ?.map((e) => CollectionLogOtherContactInfo2Data.fromJson(
                    e as Map<String, dynamic>))
                .toList() ??
            [])
        .length;

    // String? hJSmsTemplateNewestUpdatedAt = "0";
    await requestNetwork<CollectionLogEntity>(Method.get,
        url: HttpApi.collectionLogs,
        queryParameters: {
          "page": page,
          'p_collection_order_id': orderId,
          'h_j_sms_template_newest_updated_at': hJSmsTemplateNewestUpdatedAt,
          'last_contact_fetch_time': lastContactFetchTime,
          'contact2_list_count': _contact2ListCount
        }, onSuccess: (data) async {
      if (data != null) {
        _list = data.data!;
        _data = data;
        view
            .getContext()
            .read<UserProvider>()
            .setUserEntity(data.other!.other!);
        if (hJSmsTemplateNewestUpdatedAt == null ||
            hJSmsTemplateNewestUpdatedAt !=
                data.other!.hJSmsTemplateNewestUpdatedAt) {
          SpUtil.putString("hJSmsTemplateNewestUpdatedAt",
              data.other!.hJSmsTemplateNewestUpdatedAt!);
          SpUtil.putObjectList("hJSmsTemplates", data.other!.hJSmsTemplate!);
        }
        if (lastContactFetchTime == null ||
            lastContactFetchTime != data.other!.lastContactFetchTime) {
          SpUtil.putString("lastContactFetchTime:${orderId}",
              data.other!.lastContactFetchTime!);
        }
        if (data.other!.contactInfo2 != null &&
            data.other!.contactInfo2!.data!.isNotEmpty) {
          SpUtil.putObjectList(
              "contact2List:${orderId}", data.other!.contactInfo2!.data!);
        }
        if (data.other!.contactInfo != null &&
            data.other!.contactInfo!.isNotEmpty) {
          SpUtil.putObjectList(
              "allContactList:${orderId}", data.other!.contactInfo!);
        }
        //  else {
        //   data.other!.contactInfo2!.data = SpUtil.getObjectList("contact2List")
        //       ?.map((e) => CollectionLogOtherContactInfo2Data.fromJson(e as Map<String, dynamic>))
        //       .toList();
        // }
        // if (data.other!.contactInfo != null &&
        //     data.other!.contactInfo!.isNotEmpty) {
        //   SpUtil.putObjectList("contactList", data.other!.contactInfo!);
        // }
      }
    }, onError: (_, __) async {
      if (_ == 200006) {
      } else {
        view.showToast(__);
      }
    });
    return _data;
  }

  Future<void> store(Map<String, dynamic> data, List<XFile>? pickedFiles,
      bool isShowDialog, CollectionOrderData? item) async {
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
                  .aFLastCallAt!)
              .toLocal();
        }

        await for (final entity in targetDir.list()) {
          if (entity is File) {
            try {
              final pathStr = entity.path;
              final filename = pathStr.split('/').last;
              final dateStr = filename.split('_')[1];
              final modified = DateTime.parse(
                  '${dateStr.substring(0, 8)}T${dateStr.substring(9)}');
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
    final List<Map<String, dynamic>> callLogsData = [];
    if (pickedFiles != null && pickedFiles.isNotEmpty) {
      // 处理所有图片文件并转换为MultipartFile
      List<MultipartFile> imageFiles = await Future.wait(
        pickedFiles.map((image) async {
          final String path = image.path;
          final String name = path.substring(path.lastIndexOf('/') + 1);
          return MultipartFile.fromFile(path, filename: name);
        }),
      );

      // 创建图片参数映射
      Map<String, MultipartFile> imageParams = {};
      for (int i = 0; i < imageFiles.length; i++) {
        imageParams['image${i + 1}'] = imageFiles[i];
      }

      // 合并到数据中
      data = {
        ...data,
        ...imageParams,
        'imageCount': imageFiles.length,
      };
    }

    final formData = FormData.fromMap({
      // 包含原始 data 中的所有字段
      ...data,
      'call_logs': callLogsData,
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

    await requestNetwork<CollectionOrderEntity>(Method.post,
        url: HttpApi.collectionLogs,
        params: formData, onSuccess: (data2) async {
      view.getContext().read<UserProvider>().setUserEntity(data2!.other!);
      view.getContext().read<RefreshProvider>().setUserEntity(data2.other!);
      if (item != null) {
        item.kStatus = int.parse(data['g_type'] as String);
        item.aDLastLogTime = DateTime.now().toIso8601String();
        item.aLLastLog = data['j_content'] as String;
        view.getContext().read<OrderListProvider>().changeList(item);
      }
    }, onError: (_, __) async {
      if (_ == 200006) {
      } else {}
    });
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

  Future<void> moreAction(int type, int orderId) async {
    final formData = FormData.fromMap({
      // 包含原始 data 中的所有字段
      'type': type,
      'collection_order_id': orderId,
    });
    await requestNetwork<Map<String, dynamic>>(Method.post,
        url: HttpApi.collectionOrders,
        params: formData,
        isShow: true, onSuccess: (data) async {
      if (data != null) {
        print(data);
        view.showToast(data['message'] as String);
      }
    }, onError: (_, __) async {
      if (_ == 200006) {
      } else {}
    });
  }
}

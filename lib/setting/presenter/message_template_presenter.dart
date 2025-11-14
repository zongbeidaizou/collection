import 'package:bounty_hunter/models/marketing_entity.dart';
import 'package:bounty_hunter/models/message_template_entity.dart';
import 'package:bounty_hunter/mvp/base_page_presenter.dart';
import 'package:bounty_hunter/net/net.dart';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import 'package:sp_util/sp_util.dart';

import '../../models/collection_order_entity.dart';

import '../iview/message_template_page_iview.dart';

class MessageTemplatePresenter
    extends BasePagePresenter<MessageTemplatePageMvpView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {});
  }

  Future<void> index(int currentPage, bool isShowDialog,
      {String keyword = ''}) async {
    List<MessageTemplateData> _list = <MessageTemplateData>[];
    MessageTemplateEntity _data = MessageTemplateEntity();
    await requestNetwork<MessageTemplateEntity>(Method.get,
        url: HttpApi.messageTemplate,
        queryParameters: {"page": currentPage, 'keyword': keyword},
        isShow: isShowDialog, onSuccess: (data) async {
      if (data != null) {
        _list = data.data!;
        view.setData(_list);
        _data = data;
        view.setPageSize((data.total! / data.perPage!).ceil());
        view.setCurrentPage(data.currentPage!);
        // view.setTemplates(data.other!.templates!, data.other!.url!);
      }
    }, onError: (_, __) async {
      if (_ == 200006) {
      } else {
        view.showToast(__);
      }
    });
  }

  Future<void> store(
      String title, String content, int days, int category) async {
    final formData2 = FormData.fromMap({
      'title': title,
      'message': content,
      'available_days': days,
      'category': category,
    });
    await requestNetwork<Map<String, dynamic>>(Method.post,
        url: HttpApi.messageTemplate,
        params: formData2, onSuccess: (data) async {
      if (data != null) {
        view.showToast('保存成功');
      }
    });
  }

  Future<void> update(
      int id, String title, String content, int days, int category) async {
    final formData2 = FormData.fromMap({
      'id': id,
      'title': title,
      'message': content,
      'available_days': days,
      'category': category,
    });
    await requestNetwork<Map<String, dynamic>>(Method.post,
        url: HttpApi.messageTemplate,
        params: formData2, onSuccess: (data) async {
      if (data != null) {
        view.showToast('更新成功');
      }
    });
  }

  Future<void> delete(int id) async {
    await requestNetwork<Map<String, dynamic>>(Method.delete,
        url: '${HttpApi.messageTemplate}/$id', onSuccess: (data) async {
      if (data != null) {
        view.showToast('删除成功');
      }
    });
  }
}

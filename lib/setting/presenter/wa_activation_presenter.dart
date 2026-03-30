import 'package:bounty_hunter/models/countrys_entity.dart';
import 'package:bounty_hunter/models/wa_entity.dart';
import 'package:bounty_hunter/models/wacode_entity.dart';
import 'package:bounty_hunter/mvp/base_page_presenter.dart';
import 'package:bounty_hunter/net/net.dart';
import 'package:bounty_hunter/setting/iview/wa_activation_page_iview.dart';
import 'package:flutter/cupertino.dart';

class WaActivationPresenter extends BasePagePresenter<WaActivationPageMvpView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getWaCountry();
    });
  }

  /// 获取 WhatsApp 号码
  Future<void> getWaNumber({String? country}) async {
    final Map<String, dynamic> queryParams = <String, dynamic>{};
    if (country != null && country.isNotEmpty) {
      queryParams['country'] = country;
    }
    
    await requestNetwork<WaEntity>(
      Method.get,
      url: HttpApi.waActivation,
      queryParameters: queryParams.isNotEmpty ? queryParams : null,
      isShow: true,
      onSuccess: (data) async {
        if (data != null && data.success == true) {
          view.setWaData(data.data);
        } else {
          view.showToast(data?.errorMessage ?? 'Failed to get WhatsApp number');
        }
      },
      onError: (_, __) async {
        view.showToast(__);
      },
    );
  }
  Future<void> getWaCountry() async {
    await requestNetwork<CountrysEntity>(
      Method.get,
      url: HttpApi.waCountry,
      isShow: true,
      onSuccess: (data) async {
        if (data != null && data.success == true) {
          view.setCountryData(data.data ?? []);
        } else {
          view.showToast(data?.errorMessage ?? 'Failed to get WhatsApp country');
        }
      },
      onError: (_, __) async {
        view.showToast(__);
      },
    );
  }

  /// 获取 WhatsApp 验证码
  Future<void> getWaCode(String activationId) async {
    await requestNetwork<WacodeEntity>(
      Method.get,
      url: HttpApi.waCode,
      queryParameters: {
        'activation_id': activationId,
      },
      isShow: false,
      onSuccess: (data) async {
        if (data != null && data.success == true) {
          view.setWacodeData(data.data);
        } else {
          view.showToast(data?.errorMessage ?? 'Code not ready yet');
        }
      },
      onError: (_, __) async {
        // 不显示错误，因为可能是验证码还没准备好
      },
    );
  }
}

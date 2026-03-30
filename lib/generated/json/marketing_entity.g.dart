import 'package:bounty_hunter/generated/json/base/json_convert_content.dart';
import 'package:bounty_hunter/models/marketing_entity.dart';

MarketingEntity $MarketingEntityFromJson(Map<String, dynamic> json) {
  final MarketingEntity marketingEntity = MarketingEntity();
  final bool? success = jsonConvert.convert<bool>(json['success']);
  if (success != null) {
    marketingEntity.success = success;
  }
  final String? errorMessage = jsonConvert.convert<String>(
      json['errorMessage']);
  if (errorMessage != null) {
    marketingEntity.errorMessage = errorMessage;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    marketingEntity.message = message;
  }
  final List<MarketingData>? data = (json['data'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<MarketingData>(e) as MarketingData)
      .toList();
  if (data != null) {
    marketingEntity.data = data;
  }
  final MarketingOther? other = jsonConvert.convert<MarketingOther>(
      json['other']);
  if (other != null) {
    marketingEntity.other = other;
  }
  final int? total = jsonConvert.convert<int>(json['total']);
  if (total != null) {
    marketingEntity.total = total;
  }
  final int? currentPage = jsonConvert.convert<int>(json['currentPage']);
  if (currentPage != null) {
    marketingEntity.currentPage = currentPage;
  }
  final int? perPage = jsonConvert.convert<int>(json['perPage']);
  if (perPage != null) {
    marketingEntity.perPage = perPage;
  }
  final bool? hasMorePages = jsonConvert.convert<bool>(json['hasMorePages']);
  if (hasMorePages != null) {
    marketingEntity.hasMorePages = hasMorePages;
  }
  return marketingEntity;
}

Map<String, dynamic> $MarketingEntityToJson(MarketingEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['success'] = entity.success;
  data['errorMessage'] = entity.errorMessage;
  data['message'] = entity.message;
  data['data'] = entity.data?.map((v) => v.toJson()).toList();
  data['other'] = entity.other?.toJson();
  data['total'] = entity.total;
  data['currentPage'] = entity.currentPage;
  data['perPage'] = entity.perPage;
  data['hasMorePages'] = entity.hasMorePages;
  return data;
}

extension MarketingEntityExtension on MarketingEntity {
  MarketingEntity copyWith({
    bool? success,
    String? errorMessage,
    String? message,
    List<MarketingData>? data,
    MarketingOther? other,
    int? total,
    int? currentPage,
    int? perPage,
    bool? hasMorePages,
  }) {
    return MarketingEntity()
      ..success = success ?? this.success
      ..errorMessage = errorMessage ?? this.errorMessage
      ..message = message ?? this.message
      ..data = data ?? this.data
      ..other = other ?? this.other
      ..total = total ?? this.total
      ..currentPage = currentPage ?? this.currentPage
      ..perPage = perPage ?? this.perPage
      ..hasMorePages = hasMorePages ?? this.hasMorePages;
  }
}

MarketingData $MarketingDataFromJson(Map<String, dynamic> json) {
  final MarketingData marketingData = MarketingData();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    marketingData.id = id;
  }
  final String? aPhone = jsonConvert.convert<String>(json['a_phone']);
  if (aPhone != null) {
    marketingData.aPhone = aPhone;
  }
  final int? dAdminId = jsonConvert.convert<int>(json['d_admin_id']);
  if (dAdminId != null) {
    marketingData.dAdminId = dAdminId;
  }
  final int? eStatus = jsonConvert.convert<int>(json['e_status']);
  if (eStatus != null) {
    marketingData.eStatus = eStatus;
  }
  final String? qEndAt = jsonConvert.convert<String>(json['q_end_at']);
  if (qEndAt != null) {
    marketingData.qEndAt = qEndAt;
  }
  final int? uStatus = jsonConvert.convert<int>(json['u_status']);
  if (uStatus != null) {
    marketingData.uStatus = uStatus;
  }
  final int? aAFirstRegisterBonus = jsonConvert.convert<int>(
      json['a_a_first_register_bonus']);
  if (aAFirstRegisterBonus != null) {
    marketingData.aAFirstRegisterBonus = aAFirstRegisterBonus;
  }
  final int? aBFirstApplyBonus = jsonConvert.convert<int>(
      json['a_b_first_apply_bonus']);
  if (aBFirstApplyBonus != null) {
    marketingData.aBFirstApplyBonus = aBFirstApplyBonus;
  }
  final int? aCSecondRegisterBonus = jsonConvert.convert<int>(
      json['a_c_second_register_bonus']);
  if (aCSecondRegisterBonus != null) {
    marketingData.aCSecondRegisterBonus = aCSecondRegisterBonus;
  }
  final int? aDSecondApplyBonus = jsonConvert.convert<int>(
      json['a_d_second_apply_bonus']);
  if (aDSecondApplyBonus != null) {
    marketingData.aDSecondApplyBonus = aDSecondApplyBonus;
  }
  final int? aEThirdRegisterBonus = jsonConvert.convert<int>(
      json['a_e_third_register_bonus']);
  if (aEThirdRegisterBonus != null) {
    marketingData.aEThirdRegisterBonus = aEThirdRegisterBonus;
  }
  final int? aFThirdApplyBonus = jsonConvert.convert<int>(
      json['a_f_third_apply_bonus']);
  if (aFThirdApplyBonus != null) {
    marketingData.aFThirdApplyBonus = aFThirdApplyBonus;
  }
  final int? aGFourthRegisterBonus = jsonConvert.convert<int>(
      json['a_g_fourth_register_bonus']);
  if (aGFourthRegisterBonus != null) {
    marketingData.aGFourthRegisterBonus = aGFourthRegisterBonus;
  }
  final int? aHFourthApplyBonus = jsonConvert.convert<int>(
      json['a_h_fourth_apply_bonus']);
  if (aHFourthApplyBonus != null) {
    marketingData.aHFourthApplyBonus = aHFourthApplyBonus;
  }
  final int? aIFifthRegisterBonus = jsonConvert.convert<int>(
      json['a_i_fifth_register_bonus']);
  if (aIFifthRegisterBonus != null) {
    marketingData.aIFifthRegisterBonus = aIFifthRegisterBonus;
  }
  final int? aJFifthApplyBonus = jsonConvert.convert<int>(
      json['a_j_fifth_apply_bonus']);
  if (aJFifthApplyBonus != null) {
    marketingData.aJFifthApplyBonus = aJFifthApplyBonus;
  }
  final int? aLFlowedCount = jsonConvert.convert<int>(json['a_l_flowed_count']);
  if (aLFlowedCount != null) {
    marketingData.aLFlowedCount = aLFlowedCount;
  }
  final int? aMRegAdminId = jsonConvert.convert<int>(json['a_m_reg_admin_id']);
  if (aMRegAdminId != null) {
    marketingData.aMRegAdminId = aMRegAdminId;
  }
  final int? aNApplyAdminId = jsonConvert.convert<int>(
      json['a_n_apply_admin_id']);
  if (aNApplyAdminId != null) {
    marketingData.aNApplyAdminId = aNApplyAdminId;
  }
  final List<
      MarketingDataAAAAASLTelemarketingDetailLogs>? aAAAASLTelemarketingDetailLogs = (json['a_a_a_a_a_s_l_telemarketing_detail_logs'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<MarketingDataAAAAASLTelemarketingDetailLogs>(
          e) as MarketingDataAAAAASLTelemarketingDetailLogs).toList();
  if (aAAAASLTelemarketingDetailLogs != null) {
    marketingData.aAAAASLTelemarketingDetailLogs =
        aAAAASLTelemarketingDetailLogs;
  }
  return marketingData;
}

Map<String, dynamic> $MarketingDataToJson(MarketingData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['a_phone'] = entity.aPhone;
  data['d_admin_id'] = entity.dAdminId;
  data['e_status'] = entity.eStatus;
  data['q_end_at'] = entity.qEndAt;
  data['u_status'] = entity.uStatus;
  data['a_a_first_register_bonus'] = entity.aAFirstRegisterBonus;
  data['a_b_first_apply_bonus'] = entity.aBFirstApplyBonus;
  data['a_c_second_register_bonus'] = entity.aCSecondRegisterBonus;
  data['a_d_second_apply_bonus'] = entity.aDSecondApplyBonus;
  data['a_e_third_register_bonus'] = entity.aEThirdRegisterBonus;
  data['a_f_third_apply_bonus'] = entity.aFThirdApplyBonus;
  data['a_g_fourth_register_bonus'] = entity.aGFourthRegisterBonus;
  data['a_h_fourth_apply_bonus'] = entity.aHFourthApplyBonus;
  data['a_i_fifth_register_bonus'] = entity.aIFifthRegisterBonus;
  data['a_j_fifth_apply_bonus'] = entity.aJFifthApplyBonus;
  data['a_l_flowed_count'] = entity.aLFlowedCount;
  data['a_m_reg_admin_id'] = entity.aMRegAdminId;
  data['a_n_apply_admin_id'] = entity.aNApplyAdminId;
  data['a_a_a_a_a_s_l_telemarketing_detail_logs'] =
      entity.aAAAASLTelemarketingDetailLogs?.map((v) => v.toJson()).toList();
  return data;
}

extension MarketingDataExtension on MarketingData {
  MarketingData copyWith({
    int? id,
    String? aPhone,
    int? dAdminId,
    int? eStatus,
    String? qEndAt,
    int? uStatus,
    int? aAFirstRegisterBonus,
    int? aBFirstApplyBonus,
    int? aCSecondRegisterBonus,
    int? aDSecondApplyBonus,
    int? aEThirdRegisterBonus,
    int? aFThirdApplyBonus,
    int? aGFourthRegisterBonus,
    int? aHFourthApplyBonus,
    int? aIFifthRegisterBonus,
    int? aJFifthApplyBonus,
    int? aLFlowedCount,
    int? aMRegAdminId,
    int? aNApplyAdminId,
    List<
        MarketingDataAAAAASLTelemarketingDetailLogs>? aAAAASLTelemarketingDetailLogs,
  }) {
    return MarketingData()
      ..id = id ?? this.id
      ..aPhone = aPhone ?? this.aPhone
      ..dAdminId = dAdminId ?? this.dAdminId
      ..eStatus = eStatus ?? this.eStatus
      ..qEndAt = qEndAt ?? this.qEndAt
      ..uStatus = uStatus ?? this.uStatus
      ..aAFirstRegisterBonus = aAFirstRegisterBonus ?? this.aAFirstRegisterBonus
      ..aBFirstApplyBonus = aBFirstApplyBonus ?? this.aBFirstApplyBonus
      ..aCSecondRegisterBonus = aCSecondRegisterBonus ??
          this.aCSecondRegisterBonus
      ..aDSecondApplyBonus = aDSecondApplyBonus ?? this.aDSecondApplyBonus
      ..aEThirdRegisterBonus = aEThirdRegisterBonus ?? this.aEThirdRegisterBonus
      ..aFThirdApplyBonus = aFThirdApplyBonus ?? this.aFThirdApplyBonus
      ..aGFourthRegisterBonus = aGFourthRegisterBonus ??
          this.aGFourthRegisterBonus
      ..aHFourthApplyBonus = aHFourthApplyBonus ?? this.aHFourthApplyBonus
      ..aIFifthRegisterBonus = aIFifthRegisterBonus ?? this.aIFifthRegisterBonus
      ..aJFifthApplyBonus = aJFifthApplyBonus ?? this.aJFifthApplyBonus
      ..aLFlowedCount = aLFlowedCount ?? this.aLFlowedCount
      ..aMRegAdminId = aMRegAdminId ?? this.aMRegAdminId
      ..aNApplyAdminId = aNApplyAdminId ?? this.aNApplyAdminId
      ..aAAAASLTelemarketingDetailLogs = aAAAASLTelemarketingDetailLogs ??
          this.aAAAASLTelemarketingDetailLogs;
  }
}

MarketingDataAAAAASLTelemarketingDetailLogs $MarketingDataAAAAASLTelemarketingDetailLogsFromJson(
    Map<String, dynamic> json) {
  final MarketingDataAAAAASLTelemarketingDetailLogs marketingDataAAAAASLTelemarketingDetailLogs = MarketingDataAAAAASLTelemarketingDetailLogs();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    marketingDataAAAAASLTelemarketingDetailLogs.id = id;
  }
  final int? aTelemarketingDetailId = jsonConvert.convert<int>(
      json['a_telemarketing_detail_id']);
  if (aTelemarketingDetailId != null) {
    marketingDataAAAAASLTelemarketingDetailLogs.aTelemarketingDetailId =
        aTelemarketingDetailId;
  }
  final int? dAdminId = jsonConvert.convert<int>(json['d_admin_id']);
  if (dAdminId != null) {
    marketingDataAAAAASLTelemarketingDetailLogs.dAdminId = dAdminId;
  }
  final int? eStatus = jsonConvert.convert<int>(json['e_status']);
  if (eStatus != null) {
    marketingDataAAAAASLTelemarketingDetailLogs.eStatus = eStatus;
  }
  final String? gViewedTime = jsonConvert.convert<String>(
      json['g_viewed_time']);
  if (gViewedTime != null) {
    marketingDataAAAAASLTelemarketingDetailLogs.gViewedTime = gViewedTime;
  }
  final String? hDownloadTime = jsonConvert.convert<String>(
      json['h_download_time']);
  if (hDownloadTime != null) {
    marketingDataAAAAASLTelemarketingDetailLogs.hDownloadTime = hDownloadTime;
  }
  final String? iRegisterTime = jsonConvert.convert<String>(
      json['i_register_time']);
  if (iRegisterTime != null) {
    marketingDataAAAAASLTelemarketingDetailLogs.iRegisterTime = iRegisterTime;
  }
  final int? jSmsCnt = jsonConvert.convert<int>(json['j_sms_cnt']);
  if (jSmsCnt != null) {
    marketingDataAAAAASLTelemarketingDetailLogs.jSmsCnt = jSmsCnt;
  }
  final int? kWaCnt = jsonConvert.convert<int>(json['k_wa_cnt']);
  if (kWaCnt != null) {
    marketingDataAAAAASLTelemarketingDetailLogs.kWaCnt = kWaCnt;
  }
  final int? lPhoneCnt = jsonConvert.convert<int>(json['l_phone_cnt']);
  if (lPhoneCnt != null) {
    marketingDataAAAAASLTelemarketingDetailLogs.lPhoneCnt = lPhoneCnt;
  }
  final String? qEndAt = jsonConvert.convert<String>(json['q_end_at']);
  if (qEndAt != null) {
    marketingDataAAAAASLTelemarketingDetailLogs.qEndAt = qEndAt;
  }
  final String? rLastPhoneAt = jsonConvert.convert<String>(
      json['r_last_phone_at']);
  if (rLastPhoneAt != null) {
    marketingDataAAAAASLTelemarketingDetailLogs.rLastPhoneAt = rLastPhoneAt;
  }
  final String? sLastSmsAt = jsonConvert.convert<String>(json['s_last_sms_at']);
  if (sLastSmsAt != null) {
    marketingDataAAAAASLTelemarketingDetailLogs.sLastSmsAt = sLastSmsAt;
  }
  final String? tLastWaAt = jsonConvert.convert<String>(json['t_last_wa_at']);
  if (tLastWaAt != null) {
    marketingDataAAAAASLTelemarketingDetailLogs.tLastWaAt = tLastWaAt;
  }
  final int? uStatus = jsonConvert.convert<int>(json['u_status']);
  if (uStatus != null) {
    marketingDataAAAAASLTelemarketingDetailLogs.uStatus = uStatus;
  }
  final int? vWaStatus = jsonConvert.convert<int>(json['v_wa_status']);
  if (vWaStatus != null) {
    marketingDataAAAAASLTelemarketingDetailLogs.vWaStatus = vWaStatus;
  }
  final int? wPhoneStatus = jsonConvert.convert<int>(json['w_phone_status']);
  if (wPhoneStatus != null) {
    marketingDataAAAAASLTelemarketingDetailLogs.wPhoneStatus = wPhoneStatus;
  }
  final String? xApplyAt = jsonConvert.convert<String>(json['x_apply_at']);
  if (xApplyAt != null) {
    marketingDataAAAAASLTelemarketingDetailLogs.xApplyAt = xApplyAt;
  }
  final String? createdAt = jsonConvert.convert<String>(json['created_at']);
  if (createdAt != null) {
    marketingDataAAAAASLTelemarketingDetailLogs.createdAt = createdAt;
  }
  return marketingDataAAAAASLTelemarketingDetailLogs;
}

Map<String, dynamic> $MarketingDataAAAAASLTelemarketingDetailLogsToJson(
    MarketingDataAAAAASLTelemarketingDetailLogs entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['a_telemarketing_detail_id'] = entity.aTelemarketingDetailId;
  data['d_admin_id'] = entity.dAdminId;
  data['e_status'] = entity.eStatus;
  data['g_viewed_time'] = entity.gViewedTime;
  data['h_download_time'] = entity.hDownloadTime;
  data['i_register_time'] = entity.iRegisterTime;
  data['j_sms_cnt'] = entity.jSmsCnt;
  data['k_wa_cnt'] = entity.kWaCnt;
  data['l_phone_cnt'] = entity.lPhoneCnt;
  data['q_end_at'] = entity.qEndAt;
  data['r_last_phone_at'] = entity.rLastPhoneAt;
  data['s_last_sms_at'] = entity.sLastSmsAt;
  data['t_last_wa_at'] = entity.tLastWaAt;
  data['u_status'] = entity.uStatus;
  data['v_wa_status'] = entity.vWaStatus;
  data['w_phone_status'] = entity.wPhoneStatus;
  data['x_apply_at'] = entity.xApplyAt;
  data['created_at'] = entity.createdAt;
  return data;
}

extension MarketingDataAAAAASLTelemarketingDetailLogsExtension on MarketingDataAAAAASLTelemarketingDetailLogs {
  MarketingDataAAAAASLTelemarketingDetailLogs copyWith({
    int? id,
    int? aTelemarketingDetailId,
    int? dAdminId,
    int? eStatus,
    String? gViewedTime,
    String? hDownloadTime,
    String? iRegisterTime,
    int? jSmsCnt,
    int? kWaCnt,
    int? lPhoneCnt,
    String? qEndAt,
    String? rLastPhoneAt,
    String? sLastSmsAt,
    String? tLastWaAt,
    int? uStatus,
    int? vWaStatus,
    int? wPhoneStatus,
    String? xApplyAt,
    String? createdAt,
  }) {
    return MarketingDataAAAAASLTelemarketingDetailLogs()
      ..id = id ?? this.id
      ..aTelemarketingDetailId = aTelemarketingDetailId ??
          this.aTelemarketingDetailId
      ..dAdminId = dAdminId ?? this.dAdminId
      ..eStatus = eStatus ?? this.eStatus
      ..gViewedTime = gViewedTime ?? this.gViewedTime
      ..hDownloadTime = hDownloadTime ?? this.hDownloadTime
      ..iRegisterTime = iRegisterTime ?? this.iRegisterTime
      ..jSmsCnt = jSmsCnt ?? this.jSmsCnt
      ..kWaCnt = kWaCnt ?? this.kWaCnt
      ..lPhoneCnt = lPhoneCnt ?? this.lPhoneCnt
      ..qEndAt = qEndAt ?? this.qEndAt
      ..rLastPhoneAt = rLastPhoneAt ?? this.rLastPhoneAt
      ..sLastSmsAt = sLastSmsAt ?? this.sLastSmsAt
      ..tLastWaAt = tLastWaAt ?? this.tLastWaAt
      ..uStatus = uStatus ?? this.uStatus
      ..vWaStatus = vWaStatus ?? this.vWaStatus
      ..wPhoneStatus = wPhoneStatus ?? this.wPhoneStatus
      ..xApplyAt = xApplyAt ?? this.xApplyAt
      ..createdAt = createdAt ?? this.createdAt;
  }
}

MarketingOther $MarketingOtherFromJson(Map<String, dynamic> json) {
  final MarketingOther marketingOther = MarketingOther();
  final String? url = jsonConvert.convert<String>(json['url']);
  if (url != null) {
    marketingOther.url = url;
  }
  final String? app = jsonConvert.convert<String>(json['app']);
  if (app != null) {
    marketingOther.app = app;
  }
  final List<
      MarketingOtherTemplates2>? templates2 = (json['templates2'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<MarketingOtherTemplates2>(
          e) as MarketingOtherTemplates2).toList();
  if (templates2 != null) {
    marketingOther.templates2 = templates2;
  }
  return marketingOther;
}

Map<String, dynamic> $MarketingOtherToJson(MarketingOther entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['url'] = entity.url;
  data['app'] = entity.app;
  data['templates2'] = entity.templates2?.map((v) => v.toJson()).toList();
  return data;
}

extension MarketingOtherExtension on MarketingOther {
  MarketingOther copyWith({
    String? url,
    String? app,
    List<MarketingOtherTemplates2>? templates2,
  }) {
    return MarketingOther()
      ..url = url ?? this.url
      ..app = app ?? this.app
      ..templates2 = templates2 ?? this.templates2;
  }
}

MarketingOtherTemplates2 $MarketingOtherTemplates2FromJson(
    Map<String, dynamic> json) {
  final MarketingOtherTemplates2 marketingOtherTemplates2 = MarketingOtherTemplates2();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    marketingOtherTemplates2.id = id;
  }
  final int? category = jsonConvert.convert<int>(json['category']);
  if (category != null) {
    marketingOtherTemplates2.category = category;
  }
  final int? availableDays = jsonConvert.convert<int>(json['available_days']);
  if (availableDays != null) {
    marketingOtherTemplates2.availableDays = availableDays;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    marketingOtherTemplates2.message = message;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    marketingOtherTemplates2.title = title;
  }
  return marketingOtherTemplates2;
}

Map<String, dynamic> $MarketingOtherTemplates2ToJson(
    MarketingOtherTemplates2 entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['category'] = entity.category;
  data['available_days'] = entity.availableDays;
  data['message'] = entity.message;
  data['title'] = entity.title;
  return data;
}

extension MarketingOtherTemplates2Extension on MarketingOtherTemplates2 {
  MarketingOtherTemplates2 copyWith({
    int? id,
    int? category,
    int? availableDays,
    String? message,
    String? title,
  }) {
    return MarketingOtherTemplates2()
      ..id = id ?? this.id
      ..category = category ?? this.category
      ..availableDays = availableDays ?? this.availableDays
      ..message = message ?? this.message
      ..title = title ?? this.title;
  }
}
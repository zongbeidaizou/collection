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
  final List<dynamic>? other = (json['other'] as List<dynamic>?)?.map(
          (e) => e).toList();
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
  data['other'] = entity.other;
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
    List<dynamic>? other,
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
  final dynamic hDownloadTime = json['h_download_time'];
  if (hDownloadTime != null) {
    marketingDataAAAAASLTelemarketingDetailLogs.hDownloadTime = hDownloadTime;
  }
  final dynamic iRegisterTime = json['i_register_time'];
  if (iRegisterTime != null) {
    marketingDataAAAAASLTelemarketingDetailLogs.iRegisterTime = iRegisterTime;
  }
  final dynamic gViewedTime = json['g_viewed_time'];
  if (gViewedTime != null) {
    marketingDataAAAAASLTelemarketingDetailLogs.gViewedTime = gViewedTime;
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
  return marketingDataAAAAASLTelemarketingDetailLogs;
}

Map<String, dynamic> $MarketingDataAAAAASLTelemarketingDetailLogsToJson(
    MarketingDataAAAAASLTelemarketingDetailLogs entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['a_telemarketing_detail_id'] = entity.aTelemarketingDetailId;
  data['d_admin_id'] = entity.dAdminId;
  data['e_status'] = entity.eStatus;
  data['h_download_time'] = entity.hDownloadTime;
  data['i_register_time'] = entity.iRegisterTime;
  data['g_viewed_time'] = entity.gViewedTime;
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
  return data;
}

extension MarketingDataAAAAASLTelemarketingDetailLogsExtension on MarketingDataAAAAASLTelemarketingDetailLogs {
  MarketingDataAAAAASLTelemarketingDetailLogs copyWith({
    int? id,
    int? aTelemarketingDetailId,
    int? dAdminId,
    int? eStatus,
    dynamic hDownloadTime,
    dynamic iRegisterTime,
    dynamic gViewedTime,
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
  }) {
    return MarketingDataAAAAASLTelemarketingDetailLogs()
      ..id = id ?? this.id
      ..aTelemarketingDetailId = aTelemarketingDetailId ??
          this.aTelemarketingDetailId
      ..dAdminId = dAdminId ?? this.dAdminId
      ..eStatus = eStatus ?? this.eStatus
      ..hDownloadTime = hDownloadTime ?? this.hDownloadTime
      ..iRegisterTime = iRegisterTime ?? this.iRegisterTime
      ..gViewedTime = gViewedTime ?? this.gViewedTime
      ..jSmsCnt = jSmsCnt ?? this.jSmsCnt
      ..kWaCnt = kWaCnt ?? this.kWaCnt
      ..lPhoneCnt = lPhoneCnt ?? this.lPhoneCnt
      ..qEndAt = qEndAt ?? this.qEndAt
      ..rLastPhoneAt = rLastPhoneAt ?? this.rLastPhoneAt
      ..sLastSmsAt = sLastSmsAt ?? this.sLastSmsAt
      ..tLastWaAt = tLastWaAt ?? this.tLastWaAt
      ..uStatus = uStatus ?? this.uStatus
      ..vWaStatus = vWaStatus ?? this.vWaStatus
      ..wPhoneStatus = wPhoneStatus ?? this.wPhoneStatus;
  }
}
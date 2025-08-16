import 'package:bounty_hunter/generated/json/base/json_convert_content.dart';
import 'package:bounty_hunter/models/s_g_contact_entity.dart';
import 'package:bounty_hunter/models/collection_order_entity.dart';


SGContactEntity $SGContactEntityFromJson(Map<String, dynamic> json) {
  final SGContactEntity sGContactEntity = SGContactEntity();
  final bool? success = jsonConvert.convert<bool>(json['success']);
  if (success != null) {
    sGContactEntity.success = success;
  }
  final String? errorMessage = jsonConvert.convert<String>(
      json['errorMessage']);
  if (errorMessage != null) {
    sGContactEntity.errorMessage = errorMessage;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    sGContactEntity.message = message;
  }
  final List<SGContactData>? data = (json['data'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<SGContactData>(e) as SGContactData)
      .toList();
  if (data != null) {
    sGContactEntity.data = data;
  }
  final CollectionOrderOther? other = jsonConvert.convert<CollectionOrderOther>(
      json['other']);
  if (other != null) {
    sGContactEntity.other = other;
  }
  final int? total = jsonConvert.convert<int>(json['total']);
  if (total != null) {
    sGContactEntity.total = total;
  }
  final int? currentPage = jsonConvert.convert<int>(json['currentPage']);
  if (currentPage != null) {
    sGContactEntity.currentPage = currentPage;
  }
  final int? perPage = jsonConvert.convert<int>(json['perPage']);
  if (perPage != null) {
    sGContactEntity.perPage = perPage;
  }
  final bool? hasMorePages = jsonConvert.convert<bool>(json['hasMorePages']);
  if (hasMorePages != null) {
    sGContactEntity.hasMorePages = hasMorePages;
  }
  return sGContactEntity;
}

Map<String, dynamic> $SGContactEntityToJson(SGContactEntity entity) {
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

extension SGContactEntityExtension on SGContactEntity {
  SGContactEntity copyWith({
    bool? success,
    String? errorMessage,
    String? message,
    List<SGContactData>? data,
    CollectionOrderOther? other,
    int? total,
    int? currentPage,
    int? perPage,
    bool? hasMorePages,
  }) {
    return SGContactEntity()
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

SGContactData $SGContactDataFromJson(Map<String, dynamic> json) {
  final SGContactData sGContactData = SGContactData();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    sGContactData.id = id;
  }
  final String? cRelation = jsonConvert.convert<String>(json['c_relation']);
  if (cRelation != null) {
    sGContactData.cRelation = cRelation;
  }
  final int? dCallTimes = jsonConvert.convert<int>(json['d_call_times']);
  if (dCallTimes != null) {
    sGContactData.dCallTimes = dCallTimes;
  }
  final String? eLastCallTime = jsonConvert.convert<String>(
      json['e_last_call_time']);
  if (eLastCallTime != null) {
    sGContactData.eLastCallTime = eLastCallTime;
  }
  final String? fName = jsonConvert.convert<String>(json['f_name']);
  if (fName != null) {
    sGContactData.fName = fName;
  }
  final String? gPhone = jsonConvert.convert<String>(json['g_phone']);
  if (gPhone != null) {
    sGContactData.gPhone = gPhone;
  }
  final int? hReviewResult = jsonConvert.convert<int>(json['h_review_result']);
  if (hReviewResult != null) {
    sGContactData.hReviewResult = hReviewResult;
  }
  final int? lSmsCount = jsonConvert.convert<int>(json['l_sms_count']);
  if (lSmsCount != null) {
    sGContactData.lSmsCount = lSmsCount;
  }
  final int? nCallCount = jsonConvert.convert<int>(json['n_call_count']);
  if (nCallCount != null) {
    sGContactData.nCallCount = nCallCount;
  }
  final int? QPhoneStatus = jsonConvert.convert<int>(json['q_phone_status']);
  if (QPhoneStatus != null) {
    sGContactData.QPhoneStatus = QPhoneStatus;
  }
  final int? RWaStatus = jsonConvert.convert<int>(json['r_wa_status']);
  if (RWaStatus != null) {
    sGContactData.RWaStatus = RWaStatus;
  }
  final List<
      SGContactDataAAAAANIAdminRecordings>? aAAAANIAdminRecordings = (json['a_a_a_a_a_n_i_admin_recordings'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<SGContactDataAAAAANIAdminRecordings>(
          e) as SGContactDataAAAAANIAdminRecordings).toList();
  if (aAAAANIAdminRecordings != null) {
    sGContactData.aAAAANIAdminRecordings = aAAAANIAdminRecordings;
  }
  return sGContactData;
}

Map<String, dynamic> $SGContactDataToJson(SGContactData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['c_relation'] = entity.cRelation;
  data['d_call_times'] = entity.dCallTimes;
  data['e_last_call_time'] = entity.eLastCallTime;
  data['f_name'] = entity.fName;
  data['g_phone'] = entity.gPhone;
  data['h_review_result'] = entity.hReviewResult;
  data['l_sms_count'] = entity.lSmsCount;
  data['n_call_count'] = entity.nCallCount;
  data['q_phone_status'] = entity.QPhoneStatus;
  data['r_wa_status'] = entity.RWaStatus;
  data['a_a_a_a_a_n_i_admin_recordings'] =
      entity.aAAAANIAdminRecordings?.map((v) => v.toJson()).toList();
  return data;
}

extension SGContactDataExtension on SGContactData {
  SGContactData copyWith({
    int? id,
    String? cRelation,
    int? dCallTimes,
    String? eLastCallTime,
    String? fName,
    String? gPhone,
    int? hReviewResult,
    int? lSmsCount,
    int? nCallCount,
    int? QPhoneStatus,
    int? RWaStatus,
    List<SGContactDataAAAAANIAdminRecordings>? aAAAANIAdminRecordings,
  }) {
    return SGContactData()
      ..id = id ?? this.id
      ..cRelation = cRelation ?? this.cRelation
      ..dCallTimes = dCallTimes ?? this.dCallTimes
      ..eLastCallTime = eLastCallTime ?? this.eLastCallTime
      ..fName = fName ?? this.fName
      ..gPhone = gPhone ?? this.gPhone
      ..hReviewResult = hReviewResult ?? this.hReviewResult
      ..lSmsCount = lSmsCount ?? this.lSmsCount
      ..nCallCount = nCallCount ?? this.nCallCount
      ..QPhoneStatus = QPhoneStatus ?? this.QPhoneStatus
      ..RWaStatus = RWaStatus ?? this.RWaStatus
      ..aAAAANIAdminRecordings = aAAAANIAdminRecordings ??
          this.aAAAANIAdminRecordings;
  }
}

SGContactDataAAAAANIAdminRecordings $SGContactDataAAAAANIAdminRecordingsFromJson(
    Map<String, dynamic> json) {
  final SGContactDataAAAAANIAdminRecordings sGContactDataAAAAANIAdminRecordings = SGContactDataAAAAANIAdminRecordings();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    sGContactDataAAAAANIAdminRecordings.id = id;
  }
  final int? dContactId = jsonConvert.convert<int>(json['d_contact_id']);
  if (dContactId != null) {
    sGContactDataAAAAANIAdminRecordings.dContactId = dContactId;
  }
  final String? kCallAt = jsonConvert.convert<String>(json['k_call_at']);
  if (kCallAt != null) {
    sGContactDataAAAAANIAdminRecordings.kCallAt = kCallAt;
  }
  return sGContactDataAAAAANIAdminRecordings;
}

Map<String, dynamic> $SGContactDataAAAAANIAdminRecordingsToJson(
    SGContactDataAAAAANIAdminRecordings entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['d_contact_id'] = entity.dContactId;
  data['k_call_at'] = entity.kCallAt;
  return data;
}

extension SGContactDataAAAAANIAdminRecordingsExtension on SGContactDataAAAAANIAdminRecordings {
  SGContactDataAAAAANIAdminRecordings copyWith({
    int? id,
    int? dContactId,
    String? kCallAt,
  }) {
    return SGContactDataAAAAANIAdminRecordings()
      ..id = id ?? this.id
      ..dContactId = dContactId ?? this.dContactId
      ..kCallAt = kCallAt ?? this.kCallAt;
  }
}

SGContactOther $SGContactOtherFromJson(Map<String, dynamic> json) {
  final SGContactOther sGContactOther = SGContactOther();
  return sGContactOther;
}

Map<String, dynamic> $SGContactOtherToJson(SGContactOther entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  return data;
}

extension SGContactOtherExtension on SGContactOther {
}
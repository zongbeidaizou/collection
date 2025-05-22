import 'package:bounty_hunter/generated/json/base/json_convert_content.dart';
import 'package:bounty_hunter/models/h_k_contact_sms_entity.dart';

HKContactSmsEntity $HKContactSmsEntityFromJson(Map<String, dynamic> json) {
  final HKContactSmsEntity hKContactSmsEntity = HKContactSmsEntity();
  final bool? success = jsonConvert.convert<bool>(json['success']);
  if (success != null) {
    hKContactSmsEntity.success = success;
  }
  final String? errorMessage = jsonConvert.convert<String>(
      json['errorMessage']);
  if (errorMessage != null) {
    hKContactSmsEntity.errorMessage = errorMessage;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    hKContactSmsEntity.message = message;
  }
  final List<HKContactSmsData>? data = (json['data'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<HKContactSmsData>(e) as HKContactSmsData)
      .toList();
  if (data != null) {
    hKContactSmsEntity.data = data;
  }
  final List<dynamic>? other = (json['other'] as List<dynamic>?)?.map(
          (e) => e).toList();
  if (other != null) {
    hKContactSmsEntity.other = other;
  }
  final int? total = jsonConvert.convert<int>(json['total']);
  if (total != null) {
    hKContactSmsEntity.total = total;
  }
  final int? currentPage = jsonConvert.convert<int>(json['currentPage']);
  if (currentPage != null) {
    hKContactSmsEntity.currentPage = currentPage;
  }
  final int? perPage = jsonConvert.convert<int>(json['perPage']);
  if (perPage != null) {
    hKContactSmsEntity.perPage = perPage;
  }
  final bool? hasMorePages = jsonConvert.convert<bool>(json['hasMorePages']);
  if (hasMorePages != null) {
    hKContactSmsEntity.hasMorePages = hasMorePages;
  }
  return hKContactSmsEntity;
}

Map<String, dynamic> $HKContactSmsEntityToJson(HKContactSmsEntity entity) {
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

extension HKContactSmsEntityExtension on HKContactSmsEntity {
  HKContactSmsEntity copyWith({
    bool? success,
    String? errorMessage,
    String? message,
    List<HKContactSmsData>? data,
    List<dynamic>? other,
    int? total,
    int? currentPage,
    int? perPage,
    bool? hasMorePages,
  }) {
    return HKContactSmsEntity()
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

HKContactSmsData $HKContactSmsDataFromJson(Map<String, dynamic> json) {
  final HKContactSmsData hKContactSmsData = HKContactSmsData();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    hKContactSmsData.id = id;
  }
  final int? dateSent = jsonConvert.convert<int>(json['date_sent']);
  if (dateSent != null) {
    hKContactSmsData.dateSent = dateSent;
  }
  final int? type = jsonConvert.convert<int>(json['type']);
  if (type != null) {
    hKContactSmsData.type = type;
  }
  final String? address = jsonConvert.convert<String>(json['address']);
  if (address != null) {
    hKContactSmsData.address = address;
  }
  final String? aBContactName = jsonConvert.convert<String>(
      json['a_b_contact_name']);
  if (aBContactName != null) {
    hKContactSmsData.aBContactName = aBContactName;
  }
  final String? body = jsonConvert.convert<String>(json['body']);
  if (body != null) {
    hKContactSmsData.body = body;
  }
  final int? aAContactId = jsonConvert.convert<int>(json['a_a_contact_id']);
  if (aAContactId != null) {
    hKContactSmsData.aAContactId = aAContactId;
  }
  return hKContactSmsData;
}

Map<String, dynamic> $HKContactSmsDataToJson(HKContactSmsData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['date_sent'] = entity.dateSent;
  data['type'] = entity.type;
  data['address'] = entity.address;
  data['a_b_contact_name'] = entity.aBContactName;
  data['body'] = entity.body;
  data['a_a_contact_id'] = entity.aAContactId;
  return data;
}

extension HKContactSmsDataExtension on HKContactSmsData {
  HKContactSmsData copyWith({
    int? id,
    int? dateSent,
    int? type,
    String? address,
    String? aBContactName,
    String? body,
    int? aAContactId,
  }) {
    return HKContactSmsData()
      ..id = id ?? this.id
      ..dateSent = dateSent ?? this.dateSent
      ..type = type ?? this.type
      ..address = address ?? this.address
      ..aBContactName = aBContactName ?? this.aBContactName
      ..body = body ?? this.body
      ..aAContactId = aAContactId ?? this.aAContactId;
  }
}
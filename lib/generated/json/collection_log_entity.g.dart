import 'package:bounty_hunter/generated/json/base/json_convert_content.dart';
import 'package:bounty_hunter/models/json/collection_log_entity.dart';

CollectionLogEntity $CollectionLogEntityFromJson(Map<String, dynamic> json) {
  final CollectionLogEntity collectionLogEntity = CollectionLogEntity();
  final bool? success = jsonConvert.convert<bool>(json['success']);
  if (success != null) {
    collectionLogEntity.success = success;
  }
  final String? errorMessage = jsonConvert.convert<String>(
      json['errorMessage']);
  if (errorMessage != null) {
    collectionLogEntity.errorMessage = errorMessage;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    collectionLogEntity.message = message;
  }
  final List<CollectionLogData>? data = (json['data'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<CollectionLogData>(e) as CollectionLogData)
      .toList();
  if (data != null) {
    collectionLogEntity.data = data;
  }
  final List<dynamic>? other = (json['other'] as List<dynamic>?)?.map(
          (e) => e).toList();
  if (other != null) {
    collectionLogEntity.other = other;
  }
  final int? total = jsonConvert.convert<int>(json['total']);
  if (total != null) {
    collectionLogEntity.total = total;
  }
  final int? currentPage = jsonConvert.convert<int>(json['currentPage']);
  if (currentPage != null) {
    collectionLogEntity.currentPage = currentPage;
  }
  final int? perPage = jsonConvert.convert<int>(json['perPage']);
  if (perPage != null) {
    collectionLogEntity.perPage = perPage;
  }
  final bool? hasMorePages = jsonConvert.convert<bool>(json['hasMorePages']);
  if (hasMorePages != null) {
    collectionLogEntity.hasMorePages = hasMorePages;
  }
  return collectionLogEntity;
}

Map<String, dynamic> $CollectionLogEntityToJson(CollectionLogEntity entity) {
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

extension CollectionLogEntityExtension on CollectionLogEntity {
  CollectionLogEntity copyWith({
    bool? success,
    String? errorMessage,
    String? message,
    List<CollectionLogData>? data,
    List<dynamic>? other,
    int? total,
    int? currentPage,
    int? perPage,
    bool? hasMorePages,
  }) {
    return CollectionLogEntity()
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

CollectionLogData $CollectionLogDataFromJson(Map<String, dynamic> json) {
  final CollectionLogData collectionLogData = CollectionLogData();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    collectionLogData.id = id;
  }
  final int? pCollectionOrderId = jsonConvert.convert<int>(
      json['p_collection_order_id']);
  if (pCollectionOrderId != null) {
    collectionLogData.pCollectionOrderId = pCollectionOrderId;
  }
  final int? bCollectionStageId = jsonConvert.convert<int>(
      json['b_collection_stage_id']);
  if (bCollectionStageId != null) {
    collectionLogData.bCollectionStageId = bCollectionStageId;
  }
  final int? cCollectionAgencyId = jsonConvert.convert<int>(
      json['c_collection_agency_id']);
  if (cCollectionAgencyId != null) {
    collectionLogData.cCollectionAgencyId = cCollectionAgencyId;
  }
  final int? dCollectionGroupId = jsonConvert.convert<int>(
      json['d_collection_group_id']);
  if (dCollectionGroupId != null) {
    collectionLogData.dCollectionGroupId = dCollectionGroupId;
  }
  final int? eCollectionAdminId = jsonConvert.convert<int>(
      json['e_collection_admin_id']);
  if (eCollectionAdminId != null) {
    collectionLogData.eCollectionAdminId = eCollectionAdminId;
  }
  final int? gType = jsonConvert.convert<int>(json['g_type']);
  if (gType != null) {
    collectionLogData.gType = gType;
  }
  final String? jContent = jsonConvert.convert<String>(json['j_content']);
  if (jContent != null) {
    collectionLogData.jContent = jContent;
  }
  final String? createdAt = jsonConvert.convert<String>(json['created_at']);
  if (createdAt != null) {
    collectionLogData.createdAt = createdAt;
  }
  final String? kPromiseTime = jsonConvert.convert<String>(
      json['k_promise_time']);
  if (kPromiseTime != null) {
    collectionLogData.kPromiseTime = kPromiseTime;
  }
  return collectionLogData;
}

Map<String, dynamic> $CollectionLogDataToJson(CollectionLogData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['p_collection_order_id'] = entity.pCollectionOrderId;
  data['b_collection_stage_id'] = entity.bCollectionStageId;
  data['c_collection_agency_id'] = entity.cCollectionAgencyId;
  data['d_collection_group_id'] = entity.dCollectionGroupId;
  data['e_collection_admin_id'] = entity.eCollectionAdminId;
  data['g_type'] = entity.gType;
  data['j_content'] = entity.jContent;
  data['created_at'] = entity.createdAt;
  data['k_promise_time'] = entity.kPromiseTime;
  return data;
}

extension CollectionLogDataExtension on CollectionLogData {
  CollectionLogData copyWith({
    int? id,
    int? pCollectionOrderId,
    int? bCollectionStageId,
    int? cCollectionAgencyId,
    int? dCollectionGroupId,
    int? eCollectionAdminId,
    int? gType,
    String? jContent,
    String? createdAt,
    String? kPromiseTime,
  }) {
    return CollectionLogData()
      ..id = id ?? this.id
      ..pCollectionOrderId = pCollectionOrderId ?? this.pCollectionOrderId
      ..bCollectionStageId = bCollectionStageId ?? this.bCollectionStageId
      ..cCollectionAgencyId = cCollectionAgencyId ?? this.cCollectionAgencyId
      ..dCollectionGroupId = dCollectionGroupId ?? this.dCollectionGroupId
      ..eCollectionAdminId = eCollectionAdminId ?? this.eCollectionAdminId
      ..gType = gType ?? this.gType
      ..jContent = jContent ?? this.jContent
      ..createdAt = createdAt ?? this.createdAt
      ..kPromiseTime = kPromiseTime ?? this.kPromiseTime;
  }
}
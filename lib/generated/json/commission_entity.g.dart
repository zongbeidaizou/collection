import 'package:bounty_hunter/generated/json/base/json_convert_content.dart';
import 'package:bounty_hunter/models/commission_entity.dart';
import 'package:bounty_hunter/models/collection_order_entity.dart';


CommissionEntity $CommissionEntityFromJson(Map<String, dynamic> json) {
  final CommissionEntity commissionEntity = CommissionEntity();
  final bool? success = jsonConvert.convert<bool>(json['success']);
  if (success != null) {
    commissionEntity.success = success;
  }
  final String? errorMessage = jsonConvert.convert<String>(
      json['errorMessage']);
  if (errorMessage != null) {
    commissionEntity.errorMessage = errorMessage;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    commissionEntity.message = message;
  }
  final List<CommissionData>? data = (json['data'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<CommissionData>(e) as CommissionData)
      .toList();
  if (data != null) {
    commissionEntity.data = data;
  }
  final List<dynamic>? other = (json['other'] as List<dynamic>?)?.map(
          (e) => e).toList();
  if (other != null) {
    commissionEntity.other = other;
  }
  final int? total = jsonConvert.convert<int>(json['total']);
  if (total != null) {
    commissionEntity.total = total;
  }
  final int? currentPage = jsonConvert.convert<int>(json['currentPage']);
  if (currentPage != null) {
    commissionEntity.currentPage = currentPage;
  }
  final int? perPage = jsonConvert.convert<int>(json['perPage']);
  if (perPage != null) {
    commissionEntity.perPage = perPage;
  }
  final bool? hasMorePages = jsonConvert.convert<bool>(json['hasMorePages']);
  if (hasMorePages != null) {
    commissionEntity.hasMorePages = hasMorePages;
  }
  return commissionEntity;
}

Map<String, dynamic> $CommissionEntityToJson(CommissionEntity entity) {
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

extension CommissionEntityExtension on CommissionEntity {
  CommissionEntity copyWith({
    bool? success,
    String? errorMessage,
    String? message,
    List<CommissionData>? data,
    List<dynamic>? other,
    int? total,
    int? currentPage,
    int? perPage,
    bool? hasMorePages,
  }) {
    return CommissionEntity()
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

CommissionData $CommissionDataFromJson(Map<String, dynamic> json) {
  final CommissionData commissionData = CommissionData();
  final int? aBorrowId = jsonConvert.convert<int>(json['a_borrow_id']);
  if (aBorrowId != null) {
    commissionData.aBorrowId = aBorrowId;
  }
  final int? bCollectionStageId = jsonConvert.convert<int>(
      json['b_collection_stage_id']);
  if (bCollectionStageId != null) {
    commissionData.bCollectionStageId = bCollectionStageId;
  }
  final int? cCollectionAgencyId = jsonConvert.convert<int>(
      json['c_collection_agency_id']);
  if (cCollectionAgencyId != null) {
    commissionData.cCollectionAgencyId = cCollectionAgencyId;
  }
  final int? dCollectionGroupId = jsonConvert.convert<int>(
      json['d_collection_group_id']);
  if (dCollectionGroupId != null) {
    commissionData.dCollectionGroupId = dCollectionGroupId;
  }
  final int? eCollectionAdminId = jsonConvert.convert<int>(
      json['e_collection_admin_id']);
  if (eCollectionAdminId != null) {
    commissionData.eCollectionAdminId = eCollectionAdminId;
  }
  final int? fPeriodId = jsonConvert.convert<int>(json['f_period_id']);
  if (fPeriodId != null) {
    commissionData.fPeriodId = fPeriodId;
  }
  final int? gAmount = jsonConvert.convert<int>(json['g_amount']);
  if (gAmount != null) {
    commissionData.gAmount = gAmount;
  }
  final int? hCommissionAmount = jsonConvert.convert<int>(
      json['h_commission_amount']);
  if (hCommissionAmount != null) {
    commissionData.hCommissionAmount = hCommissionAmount;
  }
  final int? iCollectionKpiId = jsonConvert.convert<int>(
      json['i_collection_kpi_id']);
  if (iCollectionKpiId != null) {
    commissionData.iCollectionKpiId = iCollectionKpiId;
  }
  final int? jRate = jsonConvert.convert<int>(json['j_rate']);
  if (jRate != null) {
    commissionData.jRate = jRate;
  }
  final int? kLevel = jsonConvert.convert<int>(json['k_level']);
  if (kLevel != null) {
    commissionData.kLevel = kLevel;
  }
  final int? lRepayLogId = jsonConvert.convert<int>(json['l_repay_log_id']);
  if (lRepayLogId != null) {
    commissionData.lRepayLogId = lRepayLogId;
  }
  final String? createdAt = jsonConvert.convert<String>(json['created_at']);
  if (createdAt != null) {
    commissionData.createdAt = createdAt;
  }
  final CollectionOrderData? aAAAAABLCollectionOrder = jsonConvert.convert<
      CollectionOrderData>(json['a_a_a_a_a_a_b_l_collection_order']);
  if (aAAAAABLCollectionOrder != null) {
    commissionData.aAAAAABLCollectionOrder = aAAAAABLCollectionOrder;
  }
  return commissionData;
}

Map<String, dynamic> $CommissionDataToJson(CommissionData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['a_borrow_id'] = entity.aBorrowId;
  data['b_collection_stage_id'] = entity.bCollectionStageId;
  data['c_collection_agency_id'] = entity.cCollectionAgencyId;
  data['d_collection_group_id'] = entity.dCollectionGroupId;
  data['e_collection_admin_id'] = entity.eCollectionAdminId;
  data['f_period_id'] = entity.fPeriodId;
  data['g_amount'] = entity.gAmount;
  data['h_commission_amount'] = entity.hCommissionAmount;
  data['i_collection_kpi_id'] = entity.iCollectionKpiId;
  data['j_rate'] = entity.jRate;
  data['k_level'] = entity.kLevel;
  data['l_repay_log_id'] = entity.lRepayLogId;
  data['created_at'] = entity.createdAt;
  data['a_a_a_a_a_a_b_l_collection_order'] =
      entity.aAAAAABLCollectionOrder?.toJson();
  return data;
}

extension CommissionDataExtension on CommissionData {
  CommissionData copyWith({
    int? aBorrowId,
    int? bCollectionStageId,
    int? cCollectionAgencyId,
    int? dCollectionGroupId,
    int? eCollectionAdminId,
    int? fPeriodId,
    int? gAmount,
    int? hCommissionAmount,
    int? iCollectionKpiId,
    int? jRate,
    int? kLevel,
    int? lRepayLogId,
    String? createdAt,
    CollectionOrderData? aAAAAABLCollectionOrder,
  }) {
    return CommissionData()
      ..aBorrowId = aBorrowId ?? this.aBorrowId
      ..bCollectionStageId = bCollectionStageId ?? this.bCollectionStageId
      ..cCollectionAgencyId = cCollectionAgencyId ?? this.cCollectionAgencyId
      ..dCollectionGroupId = dCollectionGroupId ?? this.dCollectionGroupId
      ..eCollectionAdminId = eCollectionAdminId ?? this.eCollectionAdminId
      ..fPeriodId = fPeriodId ?? this.fPeriodId
      ..gAmount = gAmount ?? this.gAmount
      ..hCommissionAmount = hCommissionAmount ?? this.hCommissionAmount
      ..iCollectionKpiId = iCollectionKpiId ?? this.iCollectionKpiId
      ..jRate = jRate ?? this.jRate
      ..kLevel = kLevel ?? this.kLevel
      ..lRepayLogId = lRepayLogId ?? this.lRepayLogId
      ..createdAt = createdAt ?? this.createdAt
      ..aAAAAABLCollectionOrder = aAAAAABLCollectionOrder ??
          this.aAAAAABLCollectionOrder;
  }
}
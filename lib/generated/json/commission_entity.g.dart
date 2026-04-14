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
  final CollectionOrderOther? other = jsonConvert.convert<CollectionOrderOther>(
      json['other']);
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
  data['other'] = entity.other?.toJson();
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
    CollectionOrderOther? other,
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
  final int? mCollectionOrderId = jsonConvert.convert<int>(
      json['m_collection_order_id']);
  if (mCollectionOrderId != null) {
    commissionData.mCollectionOrderId = mCollectionOrderId;
  }
  final double? jRate = jsonConvert.convert<double>(json['j_rate']);
  if (jRate != null) {
    commissionData.jRate = jRate;
  }
  final int? kLevel = jsonConvert.convert<int>(json['k_level']);
  if (kLevel != null) {
    commissionData.kLevel = kLevel;
  }
  final int? oType = jsonConvert.convert<int>(json['o_type']);
  if (oType != null) {
    commissionData.oType = oType;
  }
  final String? pPhone = jsonConvert.convert<String>(json['p_phone']);
  if (pPhone != null) {
    commissionData.pPhone = pPhone;
  }
  final String? nBorrowSn = jsonConvert.convert<String>(json['n_borrow_sn']);
  if (nBorrowSn != null) {
    commissionData.nBorrowSn = nBorrowSn;
  }
  final int? rCurrentRate = jsonConvert.convert<int>(json['r_current_rate']);
  if (rCurrentRate != null) {
    commissionData.rCurrentRate = rCurrentRate;
  }
  final int? vPaidAmount = jsonConvert.convert<int>(json['v_paid_amount']);
  if (vPaidAmount != null) {
    commissionData.vPaidAmount = vPaidAmount;
  }
  final String? zAccountNumber = jsonConvert.convert<String>(
      json['z_account_number']);
  if (zAccountNumber != null) {
    commissionData.zAccountNumber = zAccountNumber;
  }
  final int? lRepayLogId = jsonConvert.convert<int>(json['l_repay_log_id']);
  if (lRepayLogId != null) {
    commissionData.lRepayLogId = lRepayLogId;
  }
  final int? sAssistRate = jsonConvert.convert<int>(json['s_assist_rate']);
  if (sAssistRate != null) {
    commissionData.sAssistRate = sAssistRate;
  }
  final int? tCommissionAmountWithoutAssist = jsonConvert.convert<int>(
      json['t_commission_amount_without_assist']);
  if (tCommissionAmountWithoutAssist != null) {
    commissionData.tCommissionAmountWithoutAssist =
        tCommissionAmountWithoutAssist;
  }
  final int? wReaded = jsonConvert.convert<int>(json['w_readed']);
  if (wReaded != null) {
    commissionData.wReaded = wReaded;
  }
  final int? uIsSettled = jsonConvert.convert<int>(json['u_is_settled']);
  if (uIsSettled != null) {
    commissionData.uIsSettled = uIsSettled;
  }
  final String? xReadAt = jsonConvert.convert<String>(json['x_read_at']);
  if (xReadAt != null) {
    commissionData.xReadAt = xReadAt;
  }
  final int? yDayIndex = jsonConvert.convert<int>(json['y_day_index']);
  if (yDayIndex != null) {
    commissionData.yDayIndex = yDayIndex;
  }
  final String? createdAt = jsonConvert.convert<String>(json['created_at']);
  if (createdAt != null) {
    commissionData.createdAt = createdAt;
  }
  final String? aAComment = jsonConvert.convert<String>(json['a_a_comment']);
  if (aAComment != null) {
    commissionData.aAComment = aAComment;
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
  data['m_collection_order_id'] = entity.mCollectionOrderId;
  data['j_rate'] = entity.jRate;
  data['k_level'] = entity.kLevel;
  data['o_type'] = entity.oType;
  data['p_phone'] = entity.pPhone;
  data['n_borrow_sn'] = entity.nBorrowSn;
  data['r_current_rate'] = entity.rCurrentRate;
  data['v_paid_amount'] = entity.vPaidAmount;
  data['z_account_number'] = entity.zAccountNumber;
  data['l_repay_log_id'] = entity.lRepayLogId;
  data['s_assist_rate'] = entity.sAssistRate;
  data['t_commission_amount_without_assist'] =
      entity.tCommissionAmountWithoutAssist;
  data['w_readed'] = entity.wReaded;
  data['u_is_settled'] = entity.uIsSettled;
  data['x_read_at'] = entity.xReadAt;
  data['y_day_index'] = entity.yDayIndex;
  data['created_at'] = entity.createdAt;
  data['a_a_comment'] = entity.aAComment;
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
    int? mCollectionOrderId,
    double? jRate,
    int? kLevel,
    int? oType,
    String? pPhone,
    String? nBorrowSn,
    int? rCurrentRate,
    int? vPaidAmount,
    String? zAccountNumber,
    int? lRepayLogId,
    int? sAssistRate,
    int? tCommissionAmountWithoutAssist,
    int? wReaded,
    int? uIsSettled,
    String? xReadAt,
    int? yDayIndex,
    String? createdAt,
    String? aAComment,
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
      ..mCollectionOrderId = mCollectionOrderId ?? this.mCollectionOrderId
      ..jRate = jRate ?? this.jRate
      ..kLevel = kLevel ?? this.kLevel
      ..oType = oType ?? this.oType
      ..pPhone = pPhone ?? this.pPhone
      ..nBorrowSn = nBorrowSn ?? this.nBorrowSn
      ..rCurrentRate = rCurrentRate ?? this.rCurrentRate
      ..vPaidAmount = vPaidAmount ?? this.vPaidAmount
      ..zAccountNumber = zAccountNumber ?? this.zAccountNumber
      ..lRepayLogId = lRepayLogId ?? this.lRepayLogId
      ..sAssistRate = sAssistRate ?? this.sAssistRate
      ..tCommissionAmountWithoutAssist = tCommissionAmountWithoutAssist ??
          this.tCommissionAmountWithoutAssist
      ..wReaded = wReaded ?? this.wReaded
      ..uIsSettled = uIsSettled ?? this.uIsSettled
      ..xReadAt = xReadAt ?? this.xReadAt
      ..yDayIndex = yDayIndex ?? this.yDayIndex
      ..createdAt = createdAt ?? this.createdAt
      ..aAComment = aAComment ?? this.aAComment
      ..aAAAAABLCollectionOrder = aAAAAABLCollectionOrder ??
          this.aAAAAABLCollectionOrder;
  }
}
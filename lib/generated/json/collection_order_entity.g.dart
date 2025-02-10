import 'package:bounty_hunter/generated/json/base/json_convert_content.dart';
import 'package:bounty_hunter/models/collection_order_entity.dart';

CollectionOrderEntity $CollectionOrderEntityFromJson(
    Map<String, dynamic> json) {
  final CollectionOrderEntity collectionOrderEntity = CollectionOrderEntity();
  final bool? success = jsonConvert.convert<bool>(json['success']);
  if (success != null) {
    collectionOrderEntity.success = success;
  }
  final String? errorMessage = jsonConvert.convert<String>(
      json['errorMessage']);
  if (errorMessage != null) {
    collectionOrderEntity.errorMessage = errorMessage;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    collectionOrderEntity.message = message;
  }
  final List<CollectionOrderData>? data = (json['data'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<CollectionOrderData>(e) as CollectionOrderData)
      .toList();
  if (data != null) {
    collectionOrderEntity.data = data;
  }
  final List<dynamic>? other = (json['other'] as List<dynamic>?)?.map(
          (e) => e).toList();
  if (other != null) {
    collectionOrderEntity.other = other;
  }
  final int? total = jsonConvert.convert<int>(json['total']);
  if (total != null) {
    collectionOrderEntity.total = total;
  }
  final int? currentPage = jsonConvert.convert<int>(json['currentPage']);
  if (currentPage != null) {
    collectionOrderEntity.currentPage = currentPage;
  }
  final int? perPage = jsonConvert.convert<int>(json['perPage']);
  if (perPage != null) {
    collectionOrderEntity.perPage = perPage;
  }
  final bool? hasMorePages = jsonConvert.convert<bool>(json['hasMorePages']);
  if (hasMorePages != null) {
    collectionOrderEntity.hasMorePages = hasMorePages;
  }
  return collectionOrderEntity;
}

Map<String, dynamic> $CollectionOrderEntityToJson(
    CollectionOrderEntity entity) {
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

extension CollectionOrderEntityExtension on CollectionOrderEntity {
  CollectionOrderEntity copyWith({
    bool? success,
    String? errorMessage,
    String? message,
    List<CollectionOrderData>? data,
    List<dynamic>? other,
    int? total,
    int? currentPage,
    int? perPage,
    bool? hasMorePages,
  }) {
    return CollectionOrderEntity()
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

CollectionOrderData $CollectionOrderDataFromJson(Map<String, dynamic> json) {
  final CollectionOrderData collectionOrderData = CollectionOrderData();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    collectionOrderData.id = id;
  }
  final int? aBorrowId = jsonConvert.convert<int>(json['a_borrow_id']);
  if (aBorrowId != null) {
    collectionOrderData.aBorrowId = aBorrowId;
  }
  final int? bCollectionStageId = jsonConvert.convert<int>(
      json['b_collection_stage_id']);
  if (bCollectionStageId != null) {
    collectionOrderData.bCollectionStageId = bCollectionStageId;
  }
  final int? cCollectionAgencyId = jsonConvert.convert<int>(
      json['c_collection_agency_id']);
  if (cCollectionAgencyId != null) {
    collectionOrderData.cCollectionAgencyId = cCollectionAgencyId;
  }
  final int? dCollectionGroupId = jsonConvert.convert<int>(
      json['d_collection_group_id']);
  if (dCollectionGroupId != null) {
    collectionOrderData.dCollectionGroupId = dCollectionGroupId;
  }
  final int? eCollectionAdminId = jsonConvert.convert<int>(
      json['e_collection_admin_id']);
  if (eCollectionAdminId != null) {
    collectionOrderData.eCollectionAdminId = eCollectionAdminId;
  }
  final int? fCollectionNewsId = jsonConvert.convert<int>(
      json['f_collection_news_id']);
  if (fCollectionNewsId != null) {
    collectionOrderData.fCollectionNewsId = fCollectionNewsId;
  }
  final int? gCollectionOrderFlowHistoryCount = jsonConvert.convert<int>(
      json['g_collection_order_flow_history_count']);
  if (gCollectionOrderFlowHistoryCount != null) {
    collectionOrderData.gCollectionOrderFlowHistoryCount =
        gCollectionOrderFlowHistoryCount;
  }
  final int? hCollectionAdminLogCount = jsonConvert.convert<int>(
      json['h_collection_admin_log_count']);
  if (hCollectionAdminLogCount != null) {
    collectionOrderData.hCollectionAdminLogCount = hCollectionAdminLogCount;
  }
  final int? iCollectionAdminCallCount = jsonConvert.convert<int>(
      json['i_collection_admin_call_count']);
  if (iCollectionAdminCallCount != null) {
    collectionOrderData.iCollectionAdminCallCount = iCollectionAdminCallCount;
  }
  final int? jSystemSmsCount = jsonConvert.convert<int>(
      json['j_system_sms_count']);
  if (jSystemSmsCount != null) {
    collectionOrderData.jSystemSmsCount = jSystemSmsCount;
  }
  final int? kStatus = jsonConvert.convert<int>(json['k_status']);
  if (kStatus != null) {
    collectionOrderData.kStatus = kStatus;
  }
  final int? lCollectionAmount = jsonConvert.convert<int>(
      json['l_collection_amount']);
  if (lCollectionAmount != null) {
    collectionOrderData.lCollectionAmount = lCollectionAmount;
  }
  final int? mPeriodId = jsonConvert.convert<int>(json['m_period_id']);
  if (mPeriodId != null) {
    collectionOrderData.mPeriodId = mPeriodId;
  }
  final int? nBorrowAmount = jsonConvert.convert<int>(json['n_borrow_amount']);
  if (nBorrowAmount != null) {
    collectionOrderData.nBorrowAmount = nBorrowAmount;
  }
  final int? oPeriodIndex = jsonConvert.convert<int>(json['o_period_index']);
  if (oPeriodIndex != null) {
    collectionOrderData.oPeriodIndex = oPeriodIndex;
  }
  final String? pExpectRepayTime = jsonConvert.convert<String>(
      json['p_expect_repay_time']);
  if (pExpectRepayTime != null) {
    collectionOrderData.pExpectRepayTime = pExpectRepayTime;
  }
  final int? qLockEndStageId = jsonConvert.convert<int>(
      json['q_lock_end_stage_id']);
  if (qLockEndStageId != null) {
    collectionOrderData.qLockEndStageId = qLockEndStageId;
  }
  final String? rFlowInTime = jsonConvert.convert<String>(
      json['r_flow_in_time']);
  if (rFlowInTime != null) {
    collectionOrderData.rFlowInTime = rFlowInTime;
  }
  final String? sFlowOutTime = jsonConvert.convert<String>(
      json['s_flow_out_time']);
  if (sFlowOutTime != null) {
    collectionOrderData.sFlowOutTime = sFlowOutTime;
  }
  final String? tBorrowSn = jsonConvert.convert<String>(json['t_borrow_sn']);
  if (tBorrowSn != null) {
    collectionOrderData.tBorrowSn = tBorrowSn;
  }
  final String? uPhone = jsonConvert.convert<String>(json['u_phone']);
  if (uPhone != null) {
    collectionOrderData.uPhone = uPhone;
  }
  final String? vName = jsonConvert.convert<String>(json['v_name']);
  if (vName != null) {
    collectionOrderData.vName = vName;
  }
  final dynamic wViewTimes = json['w_view_times'];
  if (wViewTimes != null) {
    collectionOrderData.wViewTimes = wViewTimes;
  }
  final int? xCurrentViewTimes = jsonConvert.convert<int>(
      json['x_current_view_times']);
  if (xCurrentViewTimes != null) {
    collectionOrderData.xCurrentViewTimes = xCurrentViewTimes;
  }
  final int? yCurrentLogCount = jsonConvert.convert<int>(
      json['y_current_log_count']);
  if (yCurrentLogCount != null) {
    collectionOrderData.yCurrentLogCount = yCurrentLogCount;
  }
  final int? zCurrentCallCount = jsonConvert.convert<int>(
      json['z_current_call_count']);
  if (zCurrentCallCount != null) {
    collectionOrderData.zCurrentCallCount = zCurrentCallCount;
  }
  final dynamic aACommission = json['a_a_commission'];
  if (aACommission != null) {
    collectionOrderData.aACommission = aACommission;
  }
  final dynamic aBCurrentCommission = json['a_b_current_commission'];
  if (aBCurrentCommission != null) {
    collectionOrderData.aBCurrentCommission = aBCurrentCommission;
  }
  final dynamic aCExpectCurrentCommission = json['a_c_expect_current_commission'];
  if (aCExpectCurrentCommission != null) {
    collectionOrderData.aCExpectCurrentCommission = aCExpectCurrentCommission;
  }
  final dynamic aDLastLogTime = json['a_d_last_log_time'];
  if (aDLastLogTime != null) {
    collectionOrderData.aDLastLogTime = aDLastLogTime;
  }
  final int? aEBorrowCount = jsonConvert.convert<int>(json['a_e_borrow_count']);
  if (aEBorrowCount != null) {
    collectionOrderData.aEBorrowCount = aEBorrowCount;
  }
  final int? aFS0CollectionAmount = jsonConvert.convert<int>(
      json['a_f_s0_collection_amount']);
  if (aFS0CollectionAmount != null) {
    collectionOrderData.aFS0CollectionAmount = aFS0CollectionAmount;
  }
  final int? aGS1CollectionAmount = jsonConvert.convert<int>(
      json['a_g_s1_collection_amount']);
  if (aGS1CollectionAmount != null) {
    collectionOrderData.aGS1CollectionAmount = aGS1CollectionAmount;
  }
  final int? aHS2CollectionAmount = jsonConvert.convert<int>(
      json['a_h_s2_collection_amount']);
  if (aHS2CollectionAmount != null) {
    collectionOrderData.aHS2CollectionAmount = aHS2CollectionAmount;
  }
  final int? aIS3CollectionAmount = jsonConvert.convert<int>(
      json['a_i_s3_collection_amount']);
  if (aIS3CollectionAmount != null) {
    collectionOrderData.aIS3CollectionAmount = aIS3CollectionAmount;
  }
  final int? AJProductId = jsonConvert.convert<int>(json['a_j_product_id']);
  if (AJProductId != null) {
    collectionOrderData.AJProductId = AJProductId;
  }
  return collectionOrderData;
}

Map<String, dynamic> $CollectionOrderDataToJson(CollectionOrderData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['a_borrow_id'] = entity.aBorrowId;
  data['b_collection_stage_id'] = entity.bCollectionStageId;
  data['c_collection_agency_id'] = entity.cCollectionAgencyId;
  data['d_collection_group_id'] = entity.dCollectionGroupId;
  data['e_collection_admin_id'] = entity.eCollectionAdminId;
  data['f_collection_news_id'] = entity.fCollectionNewsId;
  data['g_collection_order_flow_history_count'] =
      entity.gCollectionOrderFlowHistoryCount;
  data['h_collection_admin_log_count'] = entity.hCollectionAdminLogCount;
  data['i_collection_admin_call_count'] = entity.iCollectionAdminCallCount;
  data['j_system_sms_count'] = entity.jSystemSmsCount;
  data['k_status'] = entity.kStatus;
  data['l_collection_amount'] = entity.lCollectionAmount;
  data['m_period_id'] = entity.mPeriodId;
  data['n_borrow_amount'] = entity.nBorrowAmount;
  data['o_period_index'] = entity.oPeriodIndex;
  data['p_expect_repay_time'] = entity.pExpectRepayTime;
  data['q_lock_end_stage_id'] = entity.qLockEndStageId;
  data['r_flow_in_time'] = entity.rFlowInTime;
  data['s_flow_out_time'] = entity.sFlowOutTime;
  data['t_borrow_sn'] = entity.tBorrowSn;
  data['u_phone'] = entity.uPhone;
  data['v_name'] = entity.vName;
  data['w_view_times'] = entity.wViewTimes;
  data['x_current_view_times'] = entity.xCurrentViewTimes;
  data['y_current_log_count'] = entity.yCurrentLogCount;
  data['z_current_call_count'] = entity.zCurrentCallCount;
  data['a_a_commission'] = entity.aACommission;
  data['a_b_current_commission'] = entity.aBCurrentCommission;
  data['a_c_expect_current_commission'] = entity.aCExpectCurrentCommission;
  data['a_d_last_log_time'] = entity.aDLastLogTime;
  data['a_e_borrow_count'] = entity.aEBorrowCount;
  data['a_f_s0_collection_amount'] = entity.aFS0CollectionAmount;
  data['a_g_s1_collection_amount'] = entity.aGS1CollectionAmount;
  data['a_h_s2_collection_amount'] = entity.aHS2CollectionAmount;
  data['a_i_s3_collection_amount'] = entity.aIS3CollectionAmount;
  data['a_j_product_id'] = entity.AJProductId;
  return data;
}

extension CollectionOrderDataExtension on CollectionOrderData {
  CollectionOrderData copyWith({
    int? id,
    int? aBorrowId,
    int? bCollectionStageId,
    int? cCollectionAgencyId,
    int? dCollectionGroupId,
    int? eCollectionAdminId,
    int? fCollectionNewsId,
    int? gCollectionOrderFlowHistoryCount,
    int? hCollectionAdminLogCount,
    int? iCollectionAdminCallCount,
    int? jSystemSmsCount,
    int? kStatus,
    int? lCollectionAmount,
    int? mPeriodId,
    int? nBorrowAmount,
    int? oPeriodIndex,
    String? pExpectRepayTime,
    int? qLockEndStageId,
    String? rFlowInTime,
    String? sFlowOutTime,
    String? tBorrowSn,
    String? uPhone,
    String? vName,
    dynamic wViewTimes,
    int? xCurrentViewTimes,
    int? yCurrentLogCount,
    int? zCurrentCallCount,
    dynamic aACommission,
    dynamic aBCurrentCommission,
    dynamic aCExpectCurrentCommission,
    dynamic aDLastLogTime,
    int? aEBorrowCount,
    int? aFS0CollectionAmount,
    int? aGS1CollectionAmount,
    int? aHS2CollectionAmount,
    int? aIS3CollectionAmount,
    int? AJProductId,
  }) {
    return CollectionOrderData()
      ..id = id ?? this.id
      ..aBorrowId = aBorrowId ?? this.aBorrowId
      ..bCollectionStageId = bCollectionStageId ?? this.bCollectionStageId
      ..cCollectionAgencyId = cCollectionAgencyId ?? this.cCollectionAgencyId
      ..dCollectionGroupId = dCollectionGroupId ?? this.dCollectionGroupId
      ..eCollectionAdminId = eCollectionAdminId ?? this.eCollectionAdminId
      ..fCollectionNewsId = fCollectionNewsId ?? this.fCollectionNewsId
      ..gCollectionOrderFlowHistoryCount = gCollectionOrderFlowHistoryCount ??
          this.gCollectionOrderFlowHistoryCount
      ..hCollectionAdminLogCount = hCollectionAdminLogCount ??
          this.hCollectionAdminLogCount
      ..iCollectionAdminCallCount = iCollectionAdminCallCount ??
          this.iCollectionAdminCallCount
      ..jSystemSmsCount = jSystemSmsCount ?? this.jSystemSmsCount
      ..kStatus = kStatus ?? this.kStatus
      ..lCollectionAmount = lCollectionAmount ?? this.lCollectionAmount
      ..mPeriodId = mPeriodId ?? this.mPeriodId
      ..nBorrowAmount = nBorrowAmount ?? this.nBorrowAmount
      ..oPeriodIndex = oPeriodIndex ?? this.oPeriodIndex
      ..pExpectRepayTime = pExpectRepayTime ?? this.pExpectRepayTime
      ..qLockEndStageId = qLockEndStageId ?? this.qLockEndStageId
      ..rFlowInTime = rFlowInTime ?? this.rFlowInTime
      ..sFlowOutTime = sFlowOutTime ?? this.sFlowOutTime
      ..tBorrowSn = tBorrowSn ?? this.tBorrowSn
      ..uPhone = uPhone ?? this.uPhone
      ..vName = vName ?? this.vName
      ..wViewTimes = wViewTimes ?? this.wViewTimes
      ..xCurrentViewTimes = xCurrentViewTimes ?? this.xCurrentViewTimes
      ..yCurrentLogCount = yCurrentLogCount ?? this.yCurrentLogCount
      ..zCurrentCallCount = zCurrentCallCount ?? this.zCurrentCallCount
      ..aACommission = aACommission ?? this.aACommission
      ..aBCurrentCommission = aBCurrentCommission ?? this.aBCurrentCommission
      ..aCExpectCurrentCommission = aCExpectCurrentCommission ??
          this.aCExpectCurrentCommission
      ..aDLastLogTime = aDLastLogTime ?? this.aDLastLogTime
      ..aEBorrowCount = aEBorrowCount ?? this.aEBorrowCount
      ..aFS0CollectionAmount = aFS0CollectionAmount ?? this.aFS0CollectionAmount
      ..aGS1CollectionAmount = aGS1CollectionAmount ?? this.aGS1CollectionAmount
      ..aHS2CollectionAmount = aHS2CollectionAmount ?? this.aHS2CollectionAmount
      ..aIS3CollectionAmount = aIS3CollectionAmount ?? this.aIS3CollectionAmount
      ..AJProductId = AJProductId ?? this.AJProductId;
  }
}
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
  final CollectionOrderOther? other = jsonConvert.convert<CollectionOrderOther>(
      json['other']);
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
  data['other'] = entity.other?.toJson();
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
    CollectionOrderOther? other,
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
  final int? eCollectionAdminId = jsonConvert.convert<int>(
      json['e_collection_admin_id']);
  if (eCollectionAdminId != null) {
    collectionOrderData.eCollectionAdminId = eCollectionAdminId;
  }
  final int? kStatus = jsonConvert.convert<int>(json['k_status']);
  if (kStatus != null) {
    collectionOrderData.kStatus = kStatus;
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
  final String? aKNo = jsonConvert.convert<String>(json['a_k_no']);
  if (aKNo != null) {
    collectionOrderData.aKNo = aKNo;
  }
  final int? aEBorrowCount = jsonConvert.convert<int>(json['a_e_borrow_count']);
  if (aEBorrowCount != null) {
    collectionOrderData.aEBorrowCount = aEBorrowCount;
  }
  final int? aJProductId = jsonConvert.convert<int>(json['a_j_product_id']);
  if (aJProductId != null) {
    collectionOrderData.aJProductId = aJProductId;
  }
  final String? aLLastLog = jsonConvert.convert<String>(json['a_l_last_log']);
  if (aLLastLog != null) {
    collectionOrderData.aLLastLog = aLLastLog;
  }
  final int? aNCurrentDayLogCount = jsonConvert.convert<int>(
      json['a_n_current_day_log_count']);
  if (aNCurrentDayLogCount != null) {
    collectionOrderData.aNCurrentDayLogCount = aNCurrentDayLogCount;
  }
  final int? aOCurrentDayCallCount = jsonConvert.convert<int>(
      json['a_o_current_day_call_count']);
  if (aOCurrentDayCallCount != null) {
    collectionOrderData.aOCurrentDayCallCount = aOCurrentDayCallCount;
  }
  final int? aVTmpCollectionAdminId = jsonConvert.convert<int>(
      json['a_v_tmp_collection_admin_id']);
  if (aVTmpCollectionAdminId != null) {
    collectionOrderData.aVTmpCollectionAdminId = aVTmpCollectionAdminId;
  }
  final String? aZPackage = jsonConvert.convert<String>(json['a_z_package']);
  if (aZPackage != null) {
    collectionOrderData.aZPackage = aZPackage;
  }
  final String? aDLastLogTime = jsonConvert.convert<String>(
      json['a_d_last_log_time']);
  if (aDLastLogTime != null) {
    collectionOrderData.aDLastLogTime = aDLastLogTime;
  }
  final int? bESourceType = jsonConvert.convert<int>(json['b_e_source_type']);
  if (bESourceType != null) {
    collectionOrderData.bESourceType = bESourceType;
  }
  final int? bDOverdueDays = jsonConvert.convert<int>(json['b_d_overdue_days']);
  if (bDOverdueDays != null) {
    collectionOrderData.bDOverdueDays = bDOverdueDays;
  }
  final int? bBHasRetain = jsonConvert.convert<int>(json['b_b_has_retain']);
  if (bBHasRetain != null) {
    collectionOrderData.bBHasRetain = bBHasRetain;
  }
  final CollectionLogOtherPeriod? aAAAAQBPeriods = jsonConvert.convert<
      CollectionLogOtherPeriod>(json['a_a_a_a_a_q_b_periods']);
  if (aAAAAQBPeriods != null) {
    collectionOrderData.aAAAAQBPeriods = aAAAAQBPeriods;
  }
  return collectionOrderData;
}

Map<String, dynamic> $CollectionOrderDataToJson(CollectionOrderData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['a_borrow_id'] = entity.aBorrowId;
  data['e_collection_admin_id'] = entity.eCollectionAdminId;
  data['k_status'] = entity.kStatus;
  data['n_borrow_amount'] = entity.nBorrowAmount;
  data['o_period_index'] = entity.oPeriodIndex;
  data['p_expect_repay_time'] = entity.pExpectRepayTime;
  data['t_borrow_sn'] = entity.tBorrowSn;
  data['u_phone'] = entity.uPhone;
  data['v_name'] = entity.vName;
  data['r_flow_in_time'] = entity.rFlowInTime;
  data['s_flow_out_time'] = entity.sFlowOutTime;
  data['a_k_no'] = entity.aKNo;
  data['a_e_borrow_count'] = entity.aEBorrowCount;
  data['a_j_product_id'] = entity.aJProductId;
  data['a_l_last_log'] = entity.aLLastLog;
  data['a_n_current_day_log_count'] = entity.aNCurrentDayLogCount;
  data['a_o_current_day_call_count'] = entity.aOCurrentDayCallCount;
  data['a_v_tmp_collection_admin_id'] = entity.aVTmpCollectionAdminId;
  data['a_z_package'] = entity.aZPackage;
  data['a_d_last_log_time'] = entity.aDLastLogTime;
  data['b_e_source_type'] = entity.bESourceType;
  data['b_d_overdue_days'] = entity.bDOverdueDays;
  data['b_b_has_retain'] = entity.bBHasRetain;
  data['a_a_a_a_a_q_b_periods'] = entity.aAAAAQBPeriods?.toJson();
  return data;
}

extension CollectionOrderDataExtension on CollectionOrderData {
  CollectionOrderData copyWith({
    int? id,
    int? aBorrowId,
    int? eCollectionAdminId,
    int? kStatus,
    int? nBorrowAmount,
    int? oPeriodIndex,
    String? pExpectRepayTime,
    String? tBorrowSn,
    String? uPhone,
    String? vName,
    String? rFlowInTime,
    String? sFlowOutTime,
    String? aKNo,
    int? aEBorrowCount,
    int? aJProductId,
    String? aLLastLog,
    int? aNCurrentDayLogCount,
    int? aOCurrentDayCallCount,
    int? aVTmpCollectionAdminId,
    String? aZPackage,
    String? aDLastLogTime,
    int? bESourceType,
    int? bDOverdueDays,
    int? bBHasRetain,
    CollectionLogOtherPeriod? aAAAAQBPeriods,
  }) {
    return CollectionOrderData()
      ..id = id ?? this.id
      ..aBorrowId = aBorrowId ?? this.aBorrowId
      ..eCollectionAdminId = eCollectionAdminId ?? this.eCollectionAdminId
      ..kStatus = kStatus ?? this.kStatus
      ..nBorrowAmount = nBorrowAmount ?? this.nBorrowAmount
      ..oPeriodIndex = oPeriodIndex ?? this.oPeriodIndex
      ..pExpectRepayTime = pExpectRepayTime ?? this.pExpectRepayTime
      ..tBorrowSn = tBorrowSn ?? this.tBorrowSn
      ..uPhone = uPhone ?? this.uPhone
      ..vName = vName ?? this.vName
      ..rFlowInTime = rFlowInTime ?? this.rFlowInTime
      ..sFlowOutTime = sFlowOutTime ?? this.sFlowOutTime
      ..aKNo = aKNo ?? this.aKNo
      ..aEBorrowCount = aEBorrowCount ?? this.aEBorrowCount
      ..aJProductId = aJProductId ?? this.aJProductId
      ..aLLastLog = aLLastLog ?? this.aLLastLog
      ..aNCurrentDayLogCount = aNCurrentDayLogCount ?? this.aNCurrentDayLogCount
      ..aOCurrentDayCallCount = aOCurrentDayCallCount ??
          this.aOCurrentDayCallCount
      ..aVTmpCollectionAdminId = aVTmpCollectionAdminId ??
          this.aVTmpCollectionAdminId
      ..aZPackage = aZPackage ?? this.aZPackage
      ..aDLastLogTime = aDLastLogTime ?? this.aDLastLogTime
      ..bESourceType = bESourceType ?? this.bESourceType
      ..bDOverdueDays = bDOverdueDays ?? this.bDOverdueDays
      ..bBHasRetain = bBHasRetain ?? this.bBHasRetain
      ..aAAAAQBPeriods = aAAAAQBPeriods ?? this.aAAAAQBPeriods;
  }
}

CollectionOrderDataAAAAAQBPeriods $CollectionOrderDataAAAAAQBPeriodsFromJson(
    Map<String, dynamic> json) {
  final CollectionOrderDataAAAAAQBPeriods collectionOrderDataAAAAAQBPeriods = CollectionOrderDataAAAAAQBPeriods();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    collectionOrderDataAAAAAQBPeriods.id = id;
  }
  final int? aBorrowId = jsonConvert.convert<int>(json['a_borrow_id']);
  if (aBorrowId != null) {
    collectionOrderDataAAAAAQBPeriods.aBorrowId = aBorrowId;
  }
  final int? fExpectRepayTotalAmount = jsonConvert.convert<int>(
      json['f_expect_repay_total_amount']);
  if (fExpectRepayTotalAmount != null) {
    collectionOrderDataAAAAAQBPeriods.fExpectRepayTotalAmount =
        fExpectRepayTotalAmount;
  }
  final int? pPaidInterest = jsonConvert.convert<int>(json['p_paid_interest']);
  if (pPaidInterest != null) {
    collectionOrderDataAAAAAQBPeriods.pPaidInterest = pPaidInterest;
  }
  final int? qPaidServiceFee = jsonConvert.convert<int>(
      json['q_paid_service_fee']);
  if (qPaidServiceFee != null) {
    collectionOrderDataAAAAAQBPeriods.qPaidServiceFee = qPaidServiceFee;
  }
  final int? sPaidOverdueAmount = jsonConvert.convert<int>(
      json['s_paid_overdue_amount']);
  if (sPaidOverdueAmount != null) {
    collectionOrderDataAAAAAQBPeriods.sPaidOverdueAmount = sPaidOverdueAmount;
  }
  final int? oPaidBorrowAmount = jsonConvert.convert<int>(
      json['o_paid_borrow_amount']);
  if (oPaidBorrowAmount != null) {
    collectionOrderDataAAAAAQBPeriods.oPaidBorrowAmount = oPaidBorrowAmount;
  }
  final int? gExpectBorrowAmount = jsonConvert.convert<int>(
      json['g_expect_borrow_amount']);
  if (gExpectBorrowAmount != null) {
    collectionOrderDataAAAAAQBPeriods.gExpectBorrowAmount = gExpectBorrowAmount;
  }
  final int? hExpectInterest = jsonConvert.convert<int>(
      json['h_expect_interest']);
  if (hExpectInterest != null) {
    collectionOrderDataAAAAAQBPeriods.hExpectInterest = hExpectInterest;
  }
  final int? nPaidAmount = jsonConvert.convert<int>(json['n_paid_amount']);
  if (nPaidAmount != null) {
    collectionOrderDataAAAAAQBPeriods.nPaidAmount = nPaidAmount;
  }
  final int? iExpectServiceFee = jsonConvert.convert<int>(
      json['i_expect_service_fee']);
  if (iExpectServiceFee != null) {
    collectionOrderDataAAAAAQBPeriods.iExpectServiceFee = iExpectServiceFee;
  }
  final int? jExpectViolateFee = jsonConvert.convert<int>(
      json['j_expect_violate_fee']);
  if (jExpectViolateFee != null) {
    collectionOrderDataAAAAAQBPeriods.jExpectViolateFee = jExpectViolateFee;
  }
  final int? kExpectOverdueAmount = jsonConvert.convert<int>(
      json['k_expect_overdue_amount']);
  if (kExpectOverdueAmount != null) {
    collectionOrderDataAAAAAQBPeriods.kExpectOverdueAmount =
        kExpectOverdueAmount;
  }
  final int? lOverdueDays = jsonConvert.convert<int>(json['l_overdue_days']);
  if (lOverdueDays != null) {
    collectionOrderDataAAAAAQBPeriods.lOverdueDays = lOverdueDays;
  }
  final int? tDeductionTimes = jsonConvert.convert<int>(
      json['t_deduction_times']);
  if (tDeductionTimes != null) {
    collectionOrderDataAAAAAQBPeriods.tDeductionTimes = tDeductionTimes;
  }
  final int? uDeductionTotalAmount = jsonConvert.convert<int>(
      json['u_deduction_total_amount']);
  if (uDeductionTotalAmount != null) {
    collectionOrderDataAAAAAQBPeriods.uDeductionTotalAmount =
        uDeductionTotalAmount;
  }
  final int? aHPartTimes = jsonConvert.convert<int>(json['a_h_part_times']);
  if (aHPartTimes != null) {
    collectionOrderDataAAAAAQBPeriods.aHPartTimes = aHPartTimes;
  }
  final int? aNUserId = jsonConvert.convert<int>(json['a_n_user_id']);
  if (aNUserId != null) {
    collectionOrderDataAAAAAQBPeriods.aNUserId = aNUserId;
  }
  final String? aPExpectRepayTime = jsonConvert.convert<String>(
      json['a_p_expect_repay_time']);
  if (aPExpectRepayTime != null) {
    collectionOrderDataAAAAAQBPeriods.aPExpectRepayTime = aPExpectRepayTime;
  }
  final int? aUCurrentDeductionFee = jsonConvert.convert<int>(
      json['a_u_current_deduction_fee']);
  if (aUCurrentDeductionFee != null) {
    collectionOrderDataAAAAAQBPeriods.aUCurrentDeductionFee =
        aUCurrentDeductionFee;
  }
  final int? aZLeftAmount = jsonConvert.convert<int>(json['a_z_left_amount']);
  if (aZLeftAmount != null) {
    collectionOrderDataAAAAAQBPeriods.aZLeftAmount = aZLeftAmount;
  }
  final int? zDeductionTotalOverdueAmount = jsonConvert.convert<int>(
      json['z_deduction_total_overdue_amount']);
  if (zDeductionTotalOverdueAmount != null) {
    collectionOrderDataAAAAAQBPeriods.zDeductionTotalOverdueAmount =
        zDeductionTotalOverdueAmount;
  }
  final int? bCBorrowCount = jsonConvert.convert<int>(json['b_c_borrow_count']);
  if (bCBorrowCount != null) {
    collectionOrderDataAAAAAQBPeriods.bCBorrowCount = bCBorrowCount;
  }
  return collectionOrderDataAAAAAQBPeriods;
}

Map<String, dynamic> $CollectionOrderDataAAAAAQBPeriodsToJson(
    CollectionOrderDataAAAAAQBPeriods entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['a_borrow_id'] = entity.aBorrowId;
  data['f_expect_repay_total_amount'] = entity.fExpectRepayTotalAmount;
  data['p_paid_interest'] = entity.pPaidInterest;
  data['q_paid_service_fee'] = entity.qPaidServiceFee;
  data['s_paid_overdue_amount'] = entity.sPaidOverdueAmount;
  data['o_paid_borrow_amount'] = entity.oPaidBorrowAmount;
  data['g_expect_borrow_amount'] = entity.gExpectBorrowAmount;
  data['h_expect_interest'] = entity.hExpectInterest;
  data['n_paid_amount'] = entity.nPaidAmount;
  data['i_expect_service_fee'] = entity.iExpectServiceFee;
  data['j_expect_violate_fee'] = entity.jExpectViolateFee;
  data['k_expect_overdue_amount'] = entity.kExpectOverdueAmount;
  data['l_overdue_days'] = entity.lOverdueDays;
  data['t_deduction_times'] = entity.tDeductionTimes;
  data['u_deduction_total_amount'] = entity.uDeductionTotalAmount;
  data['a_h_part_times'] = entity.aHPartTimes;
  data['a_n_user_id'] = entity.aNUserId;
  data['a_p_expect_repay_time'] = entity.aPExpectRepayTime;
  data['a_u_current_deduction_fee'] = entity.aUCurrentDeductionFee;
  data['a_z_left_amount'] = entity.aZLeftAmount;
  data['z_deduction_total_overdue_amount'] =
      entity.zDeductionTotalOverdueAmount;
  data['b_c_borrow_count'] = entity.bCBorrowCount;
  return data;
}

extension CollectionOrderDataAAAAAQBPeriodsExtension on CollectionOrderDataAAAAAQBPeriods {
  CollectionOrderDataAAAAAQBPeriods copyWith({
    int? id,
    int? aBorrowId,
    int? fExpectRepayTotalAmount,
    int? pPaidInterest,
    int? qPaidServiceFee,
    int? sPaidOverdueAmount,
    int? oPaidBorrowAmount,
    int? gExpectBorrowAmount,
    int? hExpectInterest,
    int? nPaidAmount,
    int? iExpectServiceFee,
    int? jExpectViolateFee,
    int? kExpectOverdueAmount,
    int? lOverdueDays,
    int? tDeductionTimes,
    int? uDeductionTotalAmount,
    int? aHPartTimes,
    int? aNUserId,
    String? aPExpectRepayTime,
    int? aUCurrentDeductionFee,
    int? aZLeftAmount,
    int? zDeductionTotalOverdueAmount,
    int? bCBorrowCount,
  }) {
    return CollectionOrderDataAAAAAQBPeriods()
      ..id = id ?? this.id
      ..aBorrowId = aBorrowId ?? this.aBorrowId
      ..fExpectRepayTotalAmount = fExpectRepayTotalAmount ??
          this.fExpectRepayTotalAmount
      ..pPaidInterest = pPaidInterest ?? this.pPaidInterest
      ..qPaidServiceFee = qPaidServiceFee ?? this.qPaidServiceFee
      ..sPaidOverdueAmount = sPaidOverdueAmount ?? this.sPaidOverdueAmount
      ..oPaidBorrowAmount = oPaidBorrowAmount ?? this.oPaidBorrowAmount
      ..gExpectBorrowAmount = gExpectBorrowAmount ?? this.gExpectBorrowAmount
      ..hExpectInterest = hExpectInterest ?? this.hExpectInterest
      ..nPaidAmount = nPaidAmount ?? this.nPaidAmount
      ..iExpectServiceFee = iExpectServiceFee ?? this.iExpectServiceFee
      ..jExpectViolateFee = jExpectViolateFee ?? this.jExpectViolateFee
      ..kExpectOverdueAmount = kExpectOverdueAmount ?? this.kExpectOverdueAmount
      ..lOverdueDays = lOverdueDays ?? this.lOverdueDays
      ..tDeductionTimes = tDeductionTimes ?? this.tDeductionTimes
      ..uDeductionTotalAmount = uDeductionTotalAmount ??
          this.uDeductionTotalAmount
      ..aHPartTimes = aHPartTimes ?? this.aHPartTimes
      ..aNUserId = aNUserId ?? this.aNUserId
      ..aPExpectRepayTime = aPExpectRepayTime ?? this.aPExpectRepayTime
      ..aUCurrentDeductionFee = aUCurrentDeductionFee ??
          this.aUCurrentDeductionFee
      ..aZLeftAmount = aZLeftAmount ?? this.aZLeftAmount
      ..zDeductionTotalOverdueAmount = zDeductionTotalOverdueAmount ??
          this.zDeductionTotalOverdueAmount
      ..bCBorrowCount = bCBorrowCount ?? this.bCBorrowCount;
  }
}

CollectionOrderOther $CollectionOrderOtherFromJson(Map<String, dynamic> json) {
  final CollectionOrderOther collectionOrderOther = CollectionOrderOther();
  final CollectionOrderOtherProgress? progress = jsonConvert.convert<
      CollectionOrderOtherProgress>(json['progress']);
  if (progress != null) {
    collectionOrderOther.progress = progress;
  }
  final CollectionOrderOtherProfile? profile = jsonConvert.convert<
      CollectionOrderOtherProfile>(json['profile']);
  if (profile != null) {
    collectionOrderOther.profile = profile;
  }
  final List<dynamic>? monthAdditionData = (json['monthAdditionData'] as List<
      dynamic>?)?.map(
          (e) => e).toList();
  if (monthAdditionData != null) {
    collectionOrderOther.monthAdditionData = monthAdditionData;
  }
  final List<
      CollectionOrderOtherAdditionBonus>? additionBonus = (json['additionBonus'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<CollectionOrderOtherAdditionBonus>(
          e) as CollectionOrderOtherAdditionBonus).toList();
  if (additionBonus != null) {
    collectionOrderOther.additionBonus = additionBonus;
  }
  final List<CollectionOrderOtherFines>? fines = (json['fines'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<CollectionOrderOtherFines>(
          e) as CollectionOrderOtherFines).toList();
  if (fines != null) {
    collectionOrderOther.fines = fines;
  }
  return collectionOrderOther;
}

Map<String, dynamic> $CollectionOrderOtherToJson(CollectionOrderOther entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['progress'] = entity.progress?.toJson();
  data['profile'] = entity.profile?.toJson();
  data['monthAdditionData'] = entity.monthAdditionData;
  data['additionBonus'] = entity.additionBonus?.map((v) => v.toJson()).toList();
  data['fines'] = entity.fines?.map((v) => v.toJson()).toList();
  return data;
}

extension CollectionOrderOtherExtension on CollectionOrderOther {
  CollectionOrderOther copyWith({
    CollectionOrderOtherProgress? progress,
    CollectionOrderOtherProfile? profile,
    List<dynamic>? monthAdditionData,
    List<CollectionOrderOtherAdditionBonus>? additionBonus,
    List<CollectionOrderOtherFines>? fines,
  }) {
    return CollectionOrderOther()
      ..progress = progress ?? this.progress
      ..profile = profile ?? this.profile
      ..monthAdditionData = monthAdditionData ?? this.monthAdditionData
      ..additionBonus = additionBonus ?? this.additionBonus
      ..fines = fines ?? this.fines;
  }
}

CollectionOrderOtherProgress $CollectionOrderOtherProgressFromJson(
    Map<String, dynamic> json) {
  final CollectionOrderOtherProgress collectionOrderOtherProgress = CollectionOrderOtherProgress();
  final List<double>? points = (json['points'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<double>(e) as double).toList();
  if (points != null) {
    collectionOrderOtherProgress.points = points;
  }
  final List<int>? counts = (json['counts'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<int>(e) as int).toList();
  if (counts != null) {
    collectionOrderOtherProgress.counts = counts;
  }
  final List<String>? grades = (json['grades'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (grades != null) {
    collectionOrderOtherProgress.grades = grades;
  }
  final List<String>? commissionRates = (json['commissionRates'] as List<
      dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (commissionRates != null) {
    collectionOrderOtherProgress.commissionRates = commissionRates;
  }
  final String? currentGrade = jsonConvert.convert<String>(
      json['currentGrade']);
  if (currentGrade != null) {
    collectionOrderOtherProgress.currentGrade = currentGrade;
  }
  final String? currentRate = jsonConvert.convert<String>(json['currentRate']);
  if (currentRate != null) {
    collectionOrderOtherProgress.currentRate = currentRate;
  }
  final String? nextGrade = jsonConvert.convert<String>(json['nextGrade']);
  if (nextGrade != null) {
    collectionOrderOtherProgress.nextGrade = nextGrade;
  }
  final String? nextRate = jsonConvert.convert<String>(json['nextRate']);
  if (nextRate != null) {
    collectionOrderOtherProgress.nextRate = nextRate;
  }
  final int? more = jsonConvert.convert<int>(json['more']);
  if (more != null) {
    collectionOrderOtherProgress.more = more;
  }
  final double? currentPoint = jsonConvert.convert<double>(
      json['currentPoint']);
  if (currentPoint != null) {
    collectionOrderOtherProgress.currentPoint = currentPoint;
  }
  final int? nextAdditionBonus = jsonConvert.convert<int>(
      json['nextAdditionBonus']);
  if (nextAdditionBonus != null) {
    collectionOrderOtherProgress.nextAdditionBonus = nextAdditionBonus;
  }
  return collectionOrderOtherProgress;
}

Map<String, dynamic> $CollectionOrderOtherProgressToJson(
    CollectionOrderOtherProgress entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['points'] = entity.points;
  data['counts'] = entity.counts;
  data['grades'] = entity.grades;
  data['commissionRates'] = entity.commissionRates;
  data['currentGrade'] = entity.currentGrade;
  data['currentRate'] = entity.currentRate;
  data['nextGrade'] = entity.nextGrade;
  data['nextRate'] = entity.nextRate;
  data['more'] = entity.more;
  data['currentPoint'] = entity.currentPoint;
  data['nextAdditionBonus'] = entity.nextAdditionBonus;
  return data;
}

extension CollectionOrderOtherProgressExtension on CollectionOrderOtherProgress {
  CollectionOrderOtherProgress copyWith({
    List<double>? points,
    List<int>? counts,
    List<String>? grades,
    List<String>? commissionRates,
    String? currentGrade,
    String? currentRate,
    String? nextGrade,
    String? nextRate,
    int? more,
    double? currentPoint,
    int? nextAdditionBonus,
  }) {
    return CollectionOrderOtherProgress()
      ..points = points ?? this.points
      ..counts = counts ?? this.counts
      ..grades = grades ?? this.grades
      ..commissionRates = commissionRates ?? this.commissionRates
      ..currentGrade = currentGrade ?? this.currentGrade
      ..currentRate = currentRate ?? this.currentRate
      ..nextGrade = nextGrade ?? this.nextGrade
      ..nextRate = nextRate ?? this.nextRate
      ..more = more ?? this.more
      ..currentPoint = currentPoint ?? this.currentPoint
      ..nextAdditionBonus = nextAdditionBonus ?? this.nextAdditionBonus;
  }
}

CollectionOrderOtherProfile $CollectionOrderOtherProfileFromJson(
    Map<String, dynamic> json) {
  final CollectionOrderOtherProfile collectionOrderOtherProfile = CollectionOrderOtherProfile();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    collectionOrderOtherProfile.id = id;
  }
  final String? aName = jsonConvert.convert<String>(json['a_name']);
  if (aName != null) {
    collectionOrderOtherProfile.aName = aName;
  }
  final int? bAdminId = jsonConvert.convert<int>(json['b_admin_id']);
  if (bAdminId != null) {
    collectionOrderOtherProfile.bAdminId = bAdminId;
  }
  final int? cCollectionAgencyId = jsonConvert.convert<int>(
      json['c_collection_agency_id']);
  if (cCollectionAgencyId != null) {
    collectionOrderOtherProfile.cCollectionAgencyId = cCollectionAgencyId;
  }
  final int? dCollectionGroupId = jsonConvert.convert<int>(
      json['d_collection_group_id']);
  if (dCollectionGroupId != null) {
    collectionOrderOtherProfile.dCollectionGroupId = dCollectionGroupId;
  }
  final String? eCollectionStages = jsonConvert.convert<String>(
      json['e_collection_stages']);
  if (eCollectionStages != null) {
    collectionOrderOtherProfile.eCollectionStages = eCollectionStages;
  }
  final int? fStatus = jsonConvert.convert<int>(json['f_status']);
  if (fStatus != null) {
    collectionOrderOtherProfile.fStatus = fStatus;
  }
  final String? gComment = jsonConvert.convert<String>(json['g_comment']);
  if (gComment != null) {
    collectionOrderOtherProfile.gComment = gComment;
  }
  final int? hCollectionIngOrderCount = jsonConvert.convert<int>(
      json['h_collection_ing_order_count']);
  if (hCollectionIngOrderCount != null) {
    collectionOrderOtherProfile.hCollectionIngOrderCount =
        hCollectionIngOrderCount;
  }
  final int? iTodayCurrentKpiLevel = jsonConvert.convert<int>(
      json['i_today_current_kpi_level']);
  if (iTodayCurrentKpiLevel != null) {
    collectionOrderOtherProfile.iTodayCurrentKpiLevel = iTodayCurrentKpiLevel;
  }
  final int? jTodayInitAmount = jsonConvert.convert<int>(
      json['j_today_init_amount']);
  if (jTodayInitAmount != null) {
    collectionOrderOtherProfile.jTodayInitAmount = jTodayInitAmount;
  }
  final int? kCurrentNewCount = jsonConvert.convert<int>(
      json['k_current_new_count']);
  if (kCurrentNewCount != null) {
    collectionOrderOtherProfile.kCurrentNewCount = kCurrentNewCount;
  }
  final int? lCurrentNegotiatingCount = jsonConvert.convert<int>(
      json['l_current_negotiating_count']);
  if (lCurrentNegotiatingCount != null) {
    collectionOrderOtherProfile.lCurrentNegotiatingCount =
        lCurrentNegotiatingCount;
  }
  final int? mCurrrentPromisedCount = jsonConvert.convert<int>(
      json['m_currrent_promised_count']);
  if (mCurrrentPromisedCount != null) {
    collectionOrderOtherProfile.mCurrrentPromisedCount = mCurrrentPromisedCount;
  }
  final int? nCurrentBrokenCount = jsonConvert.convert<int>(
      json['n_current_broken_count']);
  if (nCurrentBrokenCount != null) {
    collectionOrderOtherProfile.nCurrentBrokenCount = nCurrentBrokenCount;
  }
  final int? oCurrentRefusedCount = jsonConvert.convert<int>(
      json['o_current_refused_count']);
  if (oCurrentRefusedCount != null) {
    collectionOrderOtherProfile.oCurrentRefusedCount = oCurrentRefusedCount;
  }
  final int? pTodayCurrentRepayCount = jsonConvert.convert<int>(
      json['p_today_current_repay_count']);
  if (pTodayCurrentRepayCount != null) {
    collectionOrderOtherProfile.pTodayCurrentRepayCount =
        pTodayCurrentRepayCount;
  }
  final int? rTodayCurrentRepayAmount = jsonConvert.convert<int>(
      json['r_today_current_repay_amount']);
  if (rTodayCurrentRepayAmount != null) {
    collectionOrderOtherProfile.rTodayCurrentRepayAmount =
        rTodayCurrentRepayAmount;
  }
  final int? tTodayLv1Commission = jsonConvert.convert<int>(
      json['t_today_lv1_commission']);
  if (tTodayLv1Commission != null) {
    collectionOrderOtherProfile.tTodayLv1Commission = tTodayLv1Commission;
  }
  final int? uTodayLv2Commission = jsonConvert.convert<int>(
      json['u_today_lv2_commission']);
  if (uTodayLv2Commission != null) {
    collectionOrderOtherProfile.uTodayLv2Commission = uTodayLv2Commission;
  }
  final int? vTodayLv3Commission = jsonConvert.convert<int>(
      json['v_today_lv3_commission']);
  if (vTodayLv3Commission != null) {
    collectionOrderOtherProfile.vTodayLv3Commission = vTodayLv3Commission;
  }
  final int? wTodayLv4Commission = jsonConvert.convert<int>(
      json['w_today_lv4_commission']);
  if (wTodayLv4Commission != null) {
    collectionOrderOtherProfile.wTodayLv4Commission = wTodayLv4Commission;
  }
  final int? xTodayInitCount = jsonConvert.convert<int>(
      json['x_today_init_count']);
  if (xTodayInitCount != null) {
    collectionOrderOtherProfile.xTodayInitCount = xTodayInitCount;
  }
  final String? yFirstLogAt = jsonConvert.convert<String>(
      json['y_first_log_at']);
  if (yFirstLogAt != null) {
    collectionOrderOtherProfile.yFirstLogAt = yFirstLogAt;
  }
  final String? zLastLogAt = jsonConvert.convert<String>(json['z_last_log_at']);
  if (zLastLogAt != null) {
    collectionOrderOtherProfile.zLastLogAt = zLastLogAt;
  }
  final int? aAWeekLv1Commission = jsonConvert.convert<int>(
      json['a_a_week_lv1_commission']);
  if (aAWeekLv1Commission != null) {
    collectionOrderOtherProfile.aAWeekLv1Commission = aAWeekLv1Commission;
  }
  final double? aBWeekLv2Commission = jsonConvert.convert<double>(
      json['a_b_week_lv2_commission']);
  if (aBWeekLv2Commission != null) {
    collectionOrderOtherProfile.aBWeekLv2Commission = aBWeekLv2Commission;
  }
  final int? aCWeekLv3Commission = jsonConvert.convert<int>(
      json['a_c_week_lv3_commission']);
  if (aCWeekLv3Commission != null) {
    collectionOrderOtherProfile.aCWeekLv3Commission = aCWeekLv3Commission;
  }
  final int? aDWeekLv4Commission = jsonConvert.convert<int>(
      json['a_d_week_lv4_commission']);
  if (aDWeekLv4Commission != null) {
    collectionOrderOtherProfile.aDWeekLv4Commission = aDWeekLv4Commission;
  }
  final double? aETodayCommissionRate = jsonConvert.convert<double>(
      json['a_e_today_commission_rate']);
  if (aETodayCommissionRate != null) {
    collectionOrderOtherProfile.aETodayCommissionRate = aETodayCommissionRate;
  }
  final String? aFLastCallAt = jsonConvert.convert<String>(
      json['a_f_last_call_at']);
  if (aFLastCallAt != null) {
    collectionOrderOtherProfile.aFLastCallAt = aFLastCallAt;
  }
  final int? aGCollectionCommissionNewCount = jsonConvert.convert<int>(
      json['a_g_collection_commission_new_count']);
  if (aGCollectionCommissionNewCount != null) {
    collectionOrderOtherProfile.aGCollectionCommissionNewCount =
        aGCollectionCommissionNewCount;
  }
  final int? aHCollectionNotificationCount = jsonConvert.convert<int>(
      json['a_h_collection_notification_count']);
  if (aHCollectionNotificationCount != null) {
    collectionOrderOtherProfile.aHCollectionNotificationCount =
        aHCollectionNotificationCount;
  }
  final int? aIWeekRepayCount = jsonConvert.convert<int>(
      json['a_i_week_repay_count']);
  if (aIWeekRepayCount != null) {
    collectionOrderOtherProfile.aIWeekRepayCount = aIWeekRepayCount;
  }
  final int? aJWeekCommission = jsonConvert.convert<int>(
      json['a_j_week_commission']);
  if (aJWeekCommission != null) {
    collectionOrderOtherProfile.aJWeekCommission = aJWeekCommission;
  }
  final int? aKMonthRepayCount = jsonConvert.convert<int>(
      json['a_k_month_repay_count']);
  if (aKMonthRepayCount != null) {
    collectionOrderOtherProfile.aKMonthRepayCount = aKMonthRepayCount;
  }
  final int? aLMonthCommission = jsonConvert.convert<int>(
      json['a_l_month_commission']);
  if (aLMonthCommission != null) {
    collectionOrderOtherProfile.aLMonthCommission = aLMonthCommission;
  }
  final int? aMTodayCommission = jsonConvert.convert<int>(
      json['a_m_today_commission']);
  if (aMTodayCommission != null) {
    collectionOrderOtherProfile.aMTodayCommission = aMTodayCommission;
  }
  final int? aNMonthLv1Days = jsonConvert.convert<int>(
      json['a_n_month_lv1_days']);
  if (aNMonthLv1Days != null) {
    collectionOrderOtherProfile.aNMonthLv1Days = aNMonthLv1Days;
  }
  final int? aOMonthLv2Days = jsonConvert.convert<int>(
      json['a_o_month_lv2_days']);
  if (aOMonthLv2Days != null) {
    collectionOrderOtherProfile.aOMonthLv2Days = aOMonthLv2Days;
  }
  final int? aPMonthLv3Days = jsonConvert.convert<int>(
      json['a_p_month_lv3_days']);
  if (aPMonthLv3Days != null) {
    collectionOrderOtherProfile.aPMonthLv3Days = aPMonthLv3Days;
  }
  final int? aQMonthLv4Days = jsonConvert.convert<int>(
      json['a_q_month_lv4_days']);
  if (aQMonthLv4Days != null) {
    collectionOrderOtherProfile.aQMonthLv4Days = aQMonthLv4Days;
  }
  final int? aRTodayPartCount = jsonConvert.convert<int>(
      json['a_r_today_part_count']);
  if (aRTodayPartCount != null) {
    collectionOrderOtherProfile.aRTodayPartCount = aRTodayPartCount;
  }
  final int? aSTodayPartAmount = jsonConvert.convert<int>(
      json['a_s_today_part_amount']);
  if (aSTodayPartAmount != null) {
    collectionOrderOtherProfile.aSTodayPartAmount = aSTodayPartAmount;
  }
  final int? aTTodaySmsCount = jsonConvert.convert<int>(
      json['a_t_today_sms_count']);
  if (aTTodaySmsCount != null) {
    collectionOrderOtherProfile.aTTodaySmsCount = aTTodaySmsCount;
  }
  final int? aUTodayCallCount = jsonConvert.convert<int>(
      json['a_u_today_call_count']);
  if (aUTodayCallCount != null) {
    collectionOrderOtherProfile.aUTodayCallCount = aUTodayCallCount;
  }
  final int? aVTodayLogCount = jsonConvert.convert<int>(
      json['a_v_today_log_count']);
  if (aVTodayLogCount != null) {
    collectionOrderOtherProfile.aVTodayLogCount = aVTodayLogCount;
  }
  final int? aWWeekSmsCount = jsonConvert.convert<int>(
      json['a_w_week_sms_count']);
  if (aWWeekSmsCount != null) {
    collectionOrderOtherProfile.aWWeekSmsCount = aWWeekSmsCount;
  }
  final int? aXWeekCallCount = jsonConvert.convert<int>(
      json['a_x_week_call_count']);
  if (aXWeekCallCount != null) {
    collectionOrderOtherProfile.aXWeekCallCount = aXWeekCallCount;
  }
  final int? aYWeekLogCount = jsonConvert.convert<int>(
      json['a_y_week_log_count']);
  if (aYWeekLogCount != null) {
    collectionOrderOtherProfile.aYWeekLogCount = aYWeekLogCount;
  }
  final String? bAAvatar = jsonConvert.convert<String>(json['b_a_avatar']);
  if (bAAvatar != null) {
    collectionOrderOtherProfile.bAAvatar = bAAvatar;
  }
  final int? aZTodayNoLogCount = jsonConvert.convert<int>(
      json['a_z_today_no_log_count']);
  if (aZTodayNoLogCount != null) {
    collectionOrderOtherProfile.aZTodayNoLogCount = aZTodayNoLogCount;
  }
  final int? cATodayNoCallCount = jsonConvert.convert<int>(
      json['c_a_today_no_call_count']);
  if (cATodayNoCallCount != null) {
    collectionOrderOtherProfile.cATodayNoCallCount = cATodayNoCallCount;
  }
  final String? cBLastCall = jsonConvert.convert<String>(json['c_b_last_call']);
  if (cBLastCall != null) {
    collectionOrderOtherProfile.cBLastCall = cBLastCall;
  }
  final int? cCReviewingCount = jsonConvert.convert<int>(
      json['c_c_reviewing_count']);
  if (cCReviewingCount != null) {
    collectionOrderOtherProfile.cCReviewingCount = cCReviewingCount;
  }
  final int? cDTodayAdditionCount = jsonConvert.convert<int>(
      json['c_d_today_addition_count']);
  if (cDTodayAdditionCount != null) {
    collectionOrderOtherProfile.cDTodayAdditionCount = cDTodayAdditionCount;
  }
  final int? cETodayDeleteCount = jsonConvert.convert<int>(
      json['c_e_today_delete_count']);
  if (cETodayDeleteCount != null) {
    collectionOrderOtherProfile.cETodayDeleteCount = cETodayDeleteCount;
  }
  final int? cFWeekRegCnt = jsonConvert.convert<int>(json['c_f_week_reg_cnt']);
  if (cFWeekRegCnt != null) {
    collectionOrderOtherProfile.cFWeekRegCnt = cFWeekRegCnt;
  }
  final int? cGWeekApplyCnt = jsonConvert.convert<int>(
      json['c_g_week_apply_cnt']);
  if (cGWeekApplyCnt != null) {
    collectionOrderOtherProfile.cGWeekApplyCnt = cGWeekApplyCnt;
  }
  final int? cHWeekWaiveLeftCnt = jsonConvert.convert<int>(
      json['c_h_week_waive_left_cnt']);
  if (cHWeekWaiveLeftCnt != null) {
    collectionOrderOtherProfile.cHWeekWaiveLeftCnt = cHWeekWaiveLeftCnt;
  }
  final int? cIWeekBlockLeftCnt = jsonConvert.convert<int>(
      json['c_i_week_block_left_cnt']);
  if (cIWeekBlockLeftCnt != null) {
    collectionOrderOtherProfile.cIWeekBlockLeftCnt = cIWeekBlockLeftCnt;
  }
  final String? updatedAt = jsonConvert.convert<String>(json['updated_at']);
  if (updatedAt != null) {
    collectionOrderOtherProfile.updatedAt = updatedAt;
  }
  final int? cJWeekWaLeftCnt = jsonConvert.convert<int>(
      json['c_j_week_wa_left_cnt']);
  if (cJWeekWaLeftCnt != null) {
    collectionOrderOtherProfile.cJWeekWaLeftCnt = cJWeekWaLeftCnt;
  }
  final int? cKDayWaLeftCnt = jsonConvert.convert<int>(
      json['c_k_day_wa_left_cnt']);
  if (cKDayWaLeftCnt != null) {
    collectionOrderOtherProfile.cKDayWaLeftCnt = cKDayWaLeftCnt;
  }
  final int? cLWeekCouponLeftCnt = jsonConvert.convert<int>(
      json['c_l_week_coupon_left_cnt']);
  if (cLWeekCouponLeftCnt != null) {
    collectionOrderOtherProfile.cLWeekCouponLeftCnt = cLWeekCouponLeftCnt;
  }
  final int? cMWeekExtendLeftCnt = jsonConvert.convert<int>(
      json['c_m_week_extend_left_cnt']);
  if (cMWeekExtendLeftCnt != null) {
    collectionOrderOtherProfile.cMWeekExtendLeftCnt = cMWeekExtendLeftCnt;
  }
  final int? cNWeekExtendCnt = jsonConvert.convert<int>(
      json['c_n_week_extend_cnt']);
  if (cNWeekExtendCnt != null) {
    collectionOrderOtherProfile.cNWeekExtendCnt = cNWeekExtendCnt;
  }
  final int? cOMonthExtendCnt = jsonConvert.convert<int>(
      json['c_o_month_extend_cnt']);
  if (cOMonthExtendCnt != null) {
    collectionOrderOtherProfile.cOMonthExtendCnt = cOMonthExtendCnt;
  }
  final int? cPWeekRetainLeftCnt = jsonConvert.convert<int>(
      json['c_p_week_retain_left_cnt']);
  if (cPWeekRetainLeftCnt != null) {
    collectionOrderOtherProfile.cPWeekRetainLeftCnt = cPWeekRetainLeftCnt;
  }
  final int? cQWeekReceiveLeftCnt = jsonConvert.convert<int>(
      json['c_q_week_receive_left_cnt']);
  if (cQWeekReceiveLeftCnt != null) {
    collectionOrderOtherProfile.cQWeekReceiveLeftCnt = cQWeekReceiveLeftCnt;
  }
  final int? cRTodayMarketingCnt = jsonConvert.convert<int>(
      json['c_r_today_marketing_cnt']);
  if (cRTodayMarketingCnt != null) {
    collectionOrderOtherProfile.cRTodayMarketingCnt = cRTodayMarketingCnt;
  }
  final int? cYTodayReceiveCount = jsonConvert.convert<int>(
      json['c_y_today_receive_count']);
  if (cYTodayReceiveCount != null) {
    collectionOrderOtherProfile.cYTodayReceiveCount = cYTodayReceiveCount;
  }
  final int? cZTodayRetainCount = jsonConvert.convert<int>(
      json['c_z_today_retain_count']);
  if (cZTodayRetainCount != null) {
    collectionOrderOtherProfile.cZTodayRetainCount = cZTodayRetainCount;
  }
  final int? dATodaySystemCount = jsonConvert.convert<int>(
      json['d_a_today_system_count']);
  if (dATodaySystemCount != null) {
    collectionOrderOtherProfile.dATodaySystemCount = dATodaySystemCount;
  }
  final int? dBTodayOutCount = jsonConvert.convert<int>(
      json['d_b_today_out_count']);
  if (dBTodayOutCount != null) {
    collectionOrderOtherProfile.dBTodayOutCount = dBTodayOutCount;
  }
  final int? dCTodayMarketingCount = jsonConvert.convert<int>(
      json['d_c_today_marketing_count']);
  if (dCTodayMarketingCount != null) {
    collectionOrderOtherProfile.dCTodayMarketingCount = dCTodayMarketingCount;
  }
  return collectionOrderOtherProfile;
}

Map<String, dynamic> $CollectionOrderOtherProfileToJson(
    CollectionOrderOtherProfile entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['a_name'] = entity.aName;
  data['b_admin_id'] = entity.bAdminId;
  data['c_collection_agency_id'] = entity.cCollectionAgencyId;
  data['d_collection_group_id'] = entity.dCollectionGroupId;
  data['e_collection_stages'] = entity.eCollectionStages;
  data['f_status'] = entity.fStatus;
  data['g_comment'] = entity.gComment;
  data['h_collection_ing_order_count'] = entity.hCollectionIngOrderCount;
  data['i_today_current_kpi_level'] = entity.iTodayCurrentKpiLevel;
  data['j_today_init_amount'] = entity.jTodayInitAmount;
  data['k_current_new_count'] = entity.kCurrentNewCount;
  data['l_current_negotiating_count'] = entity.lCurrentNegotiatingCount;
  data['m_currrent_promised_count'] = entity.mCurrrentPromisedCount;
  data['n_current_broken_count'] = entity.nCurrentBrokenCount;
  data['o_current_refused_count'] = entity.oCurrentRefusedCount;
  data['p_today_current_repay_count'] = entity.pTodayCurrentRepayCount;
  data['r_today_current_repay_amount'] = entity.rTodayCurrentRepayAmount;
  data['t_today_lv1_commission'] = entity.tTodayLv1Commission;
  data['u_today_lv2_commission'] = entity.uTodayLv2Commission;
  data['v_today_lv3_commission'] = entity.vTodayLv3Commission;
  data['w_today_lv4_commission'] = entity.wTodayLv4Commission;
  data['x_today_init_count'] = entity.xTodayInitCount;
  data['y_first_log_at'] = entity.yFirstLogAt;
  data['z_last_log_at'] = entity.zLastLogAt;
  data['a_a_week_lv1_commission'] = entity.aAWeekLv1Commission;
  data['a_b_week_lv2_commission'] = entity.aBWeekLv2Commission;
  data['a_c_week_lv3_commission'] = entity.aCWeekLv3Commission;
  data['a_d_week_lv4_commission'] = entity.aDWeekLv4Commission;
  data['a_e_today_commission_rate'] = entity.aETodayCommissionRate;
  data['a_f_last_call_at'] = entity.aFLastCallAt;
  data['a_g_collection_commission_new_count'] =
      entity.aGCollectionCommissionNewCount;
  data['a_h_collection_notification_count'] =
      entity.aHCollectionNotificationCount;
  data['a_i_week_repay_count'] = entity.aIWeekRepayCount;
  data['a_j_week_commission'] = entity.aJWeekCommission;
  data['a_k_month_repay_count'] = entity.aKMonthRepayCount;
  data['a_l_month_commission'] = entity.aLMonthCommission;
  data['a_m_today_commission'] = entity.aMTodayCommission;
  data['a_n_month_lv1_days'] = entity.aNMonthLv1Days;
  data['a_o_month_lv2_days'] = entity.aOMonthLv2Days;
  data['a_p_month_lv3_days'] = entity.aPMonthLv3Days;
  data['a_q_month_lv4_days'] = entity.aQMonthLv4Days;
  data['a_r_today_part_count'] = entity.aRTodayPartCount;
  data['a_s_today_part_amount'] = entity.aSTodayPartAmount;
  data['a_t_today_sms_count'] = entity.aTTodaySmsCount;
  data['a_u_today_call_count'] = entity.aUTodayCallCount;
  data['a_v_today_log_count'] = entity.aVTodayLogCount;
  data['a_w_week_sms_count'] = entity.aWWeekSmsCount;
  data['a_x_week_call_count'] = entity.aXWeekCallCount;
  data['a_y_week_log_count'] = entity.aYWeekLogCount;
  data['b_a_avatar'] = entity.bAAvatar;
  data['a_z_today_no_log_count'] = entity.aZTodayNoLogCount;
  data['c_a_today_no_call_count'] = entity.cATodayNoCallCount;
  data['c_b_last_call'] = entity.cBLastCall;
  data['c_c_reviewing_count'] = entity.cCReviewingCount;
  data['c_d_today_addition_count'] = entity.cDTodayAdditionCount;
  data['c_e_today_delete_count'] = entity.cETodayDeleteCount;
  data['c_f_week_reg_cnt'] = entity.cFWeekRegCnt;
  data['c_g_week_apply_cnt'] = entity.cGWeekApplyCnt;
  data['c_h_week_waive_left_cnt'] = entity.cHWeekWaiveLeftCnt;
  data['c_i_week_block_left_cnt'] = entity.cIWeekBlockLeftCnt;
  data['updated_at'] = entity.updatedAt;
  data['c_j_week_wa_left_cnt'] = entity.cJWeekWaLeftCnt;
  data['c_k_day_wa_left_cnt'] = entity.cKDayWaLeftCnt;
  data['c_l_week_coupon_left_cnt'] = entity.cLWeekCouponLeftCnt;
  data['c_m_week_extend_left_cnt'] = entity.cMWeekExtendLeftCnt;
  data['c_n_week_extend_cnt'] = entity.cNWeekExtendCnt;
  data['c_o_month_extend_cnt'] = entity.cOMonthExtendCnt;
  data['c_p_week_retain_left_cnt'] = entity.cPWeekRetainLeftCnt;
  data['c_q_week_receive_left_cnt'] = entity.cQWeekReceiveLeftCnt;
  data['c_r_today_marketing_cnt'] = entity.cRTodayMarketingCnt;
  data['c_y_today_receive_count'] = entity.cYTodayReceiveCount;
  data['c_z_today_retain_count'] = entity.cZTodayRetainCount;
  data['d_a_today_system_count'] = entity.dATodaySystemCount;
  data['d_b_today_out_count'] = entity.dBTodayOutCount;
  data['d_c_today_marketing_count'] = entity.dCTodayMarketingCount;
  return data;
}

extension CollectionOrderOtherProfileExtension on CollectionOrderOtherProfile {
  CollectionOrderOtherProfile copyWith({
    int? id,
    String? aName,
    int? bAdminId,
    int? cCollectionAgencyId,
    int? dCollectionGroupId,
    String? eCollectionStages,
    int? fStatus,
    String? gComment,
    int? hCollectionIngOrderCount,
    int? iTodayCurrentKpiLevel,
    int? jTodayInitAmount,
    int? kCurrentNewCount,
    int? lCurrentNegotiatingCount,
    int? mCurrrentPromisedCount,
    int? nCurrentBrokenCount,
    int? oCurrentRefusedCount,
    int? pTodayCurrentRepayCount,
    int? rTodayCurrentRepayAmount,
    int? tTodayLv1Commission,
    int? uTodayLv2Commission,
    int? vTodayLv3Commission,
    int? wTodayLv4Commission,
    int? xTodayInitCount,
    String? yFirstLogAt,
    String? zLastLogAt,
    int? aAWeekLv1Commission,
    double? aBWeekLv2Commission,
    int? aCWeekLv3Commission,
    int? aDWeekLv4Commission,
    double? aETodayCommissionRate,
    String? aFLastCallAt,
    int? aGCollectionCommissionNewCount,
    int? aHCollectionNotificationCount,
    int? aIWeekRepayCount,
    int? aJWeekCommission,
    int? aKMonthRepayCount,
    int? aLMonthCommission,
    int? aMTodayCommission,
    int? aNMonthLv1Days,
    int? aOMonthLv2Days,
    int? aPMonthLv3Days,
    int? aQMonthLv4Days,
    int? aRTodayPartCount,
    int? aSTodayPartAmount,
    int? aTTodaySmsCount,
    int? aUTodayCallCount,
    int? aVTodayLogCount,
    int? aWWeekSmsCount,
    int? aXWeekCallCount,
    int? aYWeekLogCount,
    String? bAAvatar,
    int? aZTodayNoLogCount,
    int? cATodayNoCallCount,
    String? cBLastCall,
    int? cCReviewingCount,
    int? cDTodayAdditionCount,
    int? cETodayDeleteCount,
    int? cFWeekRegCnt,
    int? cGWeekApplyCnt,
    int? cHWeekWaiveLeftCnt,
    int? cIWeekBlockLeftCnt,
    String? updatedAt,
    int? cJWeekWaLeftCnt,
    int? cKDayWaLeftCnt,
    int? cLWeekCouponLeftCnt,
    int? cMWeekExtendLeftCnt,
    int? cNWeekExtendCnt,
    int? cOMonthExtendCnt,
    int? cPWeekRetainLeftCnt,
    int? cQWeekReceiveLeftCnt,
    int? cRTodayMarketingCnt,
    int? cYTodayReceiveCount,
    int? cZTodayRetainCount,
    int? dATodaySystemCount,
    int? dBTodayOutCount,
    int? dCTodayMarketingCount,
  }) {
    return CollectionOrderOtherProfile()
      ..id = id ?? this.id
      ..aName = aName ?? this.aName
      ..bAdminId = bAdminId ?? this.bAdminId
      ..cCollectionAgencyId = cCollectionAgencyId ?? this.cCollectionAgencyId
      ..dCollectionGroupId = dCollectionGroupId ?? this.dCollectionGroupId
      ..eCollectionStages = eCollectionStages ?? this.eCollectionStages
      ..fStatus = fStatus ?? this.fStatus
      ..gComment = gComment ?? this.gComment
      ..hCollectionIngOrderCount = hCollectionIngOrderCount ??
          this.hCollectionIngOrderCount
      ..iTodayCurrentKpiLevel = iTodayCurrentKpiLevel ??
          this.iTodayCurrentKpiLevel
      ..jTodayInitAmount = jTodayInitAmount ?? this.jTodayInitAmount
      ..kCurrentNewCount = kCurrentNewCount ?? this.kCurrentNewCount
      ..lCurrentNegotiatingCount = lCurrentNegotiatingCount ??
          this.lCurrentNegotiatingCount
      ..mCurrrentPromisedCount = mCurrrentPromisedCount ??
          this.mCurrrentPromisedCount
      ..nCurrentBrokenCount = nCurrentBrokenCount ?? this.nCurrentBrokenCount
      ..oCurrentRefusedCount = oCurrentRefusedCount ?? this.oCurrentRefusedCount
      ..pTodayCurrentRepayCount = pTodayCurrentRepayCount ??
          this.pTodayCurrentRepayCount
      ..rTodayCurrentRepayAmount = rTodayCurrentRepayAmount ??
          this.rTodayCurrentRepayAmount
      ..tTodayLv1Commission = tTodayLv1Commission ?? this.tTodayLv1Commission
      ..uTodayLv2Commission = uTodayLv2Commission ?? this.uTodayLv2Commission
      ..vTodayLv3Commission = vTodayLv3Commission ?? this.vTodayLv3Commission
      ..wTodayLv4Commission = wTodayLv4Commission ?? this.wTodayLv4Commission
      ..xTodayInitCount = xTodayInitCount ?? this.xTodayInitCount
      ..yFirstLogAt = yFirstLogAt ?? this.yFirstLogAt
      ..zLastLogAt = zLastLogAt ?? this.zLastLogAt
      ..aAWeekLv1Commission = aAWeekLv1Commission ?? this.aAWeekLv1Commission
      ..aBWeekLv2Commission = aBWeekLv2Commission ?? this.aBWeekLv2Commission
      ..aCWeekLv3Commission = aCWeekLv3Commission ?? this.aCWeekLv3Commission
      ..aDWeekLv4Commission = aDWeekLv4Commission ?? this.aDWeekLv4Commission
      ..aETodayCommissionRate = aETodayCommissionRate ??
          this.aETodayCommissionRate
      ..aFLastCallAt = aFLastCallAt ?? this.aFLastCallAt
      ..aGCollectionCommissionNewCount = aGCollectionCommissionNewCount ??
          this.aGCollectionCommissionNewCount
      ..aHCollectionNotificationCount = aHCollectionNotificationCount ??
          this.aHCollectionNotificationCount
      ..aIWeekRepayCount = aIWeekRepayCount ?? this.aIWeekRepayCount
      ..aJWeekCommission = aJWeekCommission ?? this.aJWeekCommission
      ..aKMonthRepayCount = aKMonthRepayCount ?? this.aKMonthRepayCount
      ..aLMonthCommission = aLMonthCommission ?? this.aLMonthCommission
      ..aMTodayCommission = aMTodayCommission ?? this.aMTodayCommission
      ..aNMonthLv1Days = aNMonthLv1Days ?? this.aNMonthLv1Days
      ..aOMonthLv2Days = aOMonthLv2Days ?? this.aOMonthLv2Days
      ..aPMonthLv3Days = aPMonthLv3Days ?? this.aPMonthLv3Days
      ..aQMonthLv4Days = aQMonthLv4Days ?? this.aQMonthLv4Days
      ..aRTodayPartCount = aRTodayPartCount ?? this.aRTodayPartCount
      ..aSTodayPartAmount = aSTodayPartAmount ?? this.aSTodayPartAmount
      ..aTTodaySmsCount = aTTodaySmsCount ?? this.aTTodaySmsCount
      ..aUTodayCallCount = aUTodayCallCount ?? this.aUTodayCallCount
      ..aVTodayLogCount = aVTodayLogCount ?? this.aVTodayLogCount
      ..aWWeekSmsCount = aWWeekSmsCount ?? this.aWWeekSmsCount
      ..aXWeekCallCount = aXWeekCallCount ?? this.aXWeekCallCount
      ..aYWeekLogCount = aYWeekLogCount ?? this.aYWeekLogCount
      ..bAAvatar = bAAvatar ?? this.bAAvatar
      ..aZTodayNoLogCount = aZTodayNoLogCount ?? this.aZTodayNoLogCount
      ..cATodayNoCallCount = cATodayNoCallCount ?? this.cATodayNoCallCount
      ..cBLastCall = cBLastCall ?? this.cBLastCall
      ..cCReviewingCount = cCReviewingCount ?? this.cCReviewingCount
      ..cDTodayAdditionCount = cDTodayAdditionCount ?? this.cDTodayAdditionCount
      ..cETodayDeleteCount = cETodayDeleteCount ?? this.cETodayDeleteCount
      ..cFWeekRegCnt = cFWeekRegCnt ?? this.cFWeekRegCnt
      ..cGWeekApplyCnt = cGWeekApplyCnt ?? this.cGWeekApplyCnt
      ..cHWeekWaiveLeftCnt = cHWeekWaiveLeftCnt ?? this.cHWeekWaiveLeftCnt
      ..cIWeekBlockLeftCnt = cIWeekBlockLeftCnt ?? this.cIWeekBlockLeftCnt
      ..updatedAt = updatedAt ?? this.updatedAt
      ..cJWeekWaLeftCnt = cJWeekWaLeftCnt ?? this.cJWeekWaLeftCnt
      ..cKDayWaLeftCnt = cKDayWaLeftCnt ?? this.cKDayWaLeftCnt
      ..cLWeekCouponLeftCnt = cLWeekCouponLeftCnt ?? this.cLWeekCouponLeftCnt
      ..cMWeekExtendLeftCnt = cMWeekExtendLeftCnt ?? this.cMWeekExtendLeftCnt
      ..cNWeekExtendCnt = cNWeekExtendCnt ?? this.cNWeekExtendCnt
      ..cOMonthExtendCnt = cOMonthExtendCnt ?? this.cOMonthExtendCnt
      ..cPWeekRetainLeftCnt = cPWeekRetainLeftCnt ?? this.cPWeekRetainLeftCnt
      ..cQWeekReceiveLeftCnt = cQWeekReceiveLeftCnt ?? this.cQWeekReceiveLeftCnt
      ..cRTodayMarketingCnt = cRTodayMarketingCnt ?? this.cRTodayMarketingCnt
      ..cYTodayReceiveCount = cYTodayReceiveCount ?? this.cYTodayReceiveCount
      ..cZTodayRetainCount = cZTodayRetainCount ?? this.cZTodayRetainCount
      ..dATodaySystemCount = dATodaySystemCount ?? this.dATodaySystemCount
      ..dBTodayOutCount = dBTodayOutCount ?? this.dBTodayOutCount
      ..dCTodayMarketingCount = dCTodayMarketingCount ??
          this.dCTodayMarketingCount;
  }
}

CollectionOrderOtherAdditionBonus $CollectionOrderOtherAdditionBonusFromJson(
    Map<String, dynamic> json) {
  final CollectionOrderOtherAdditionBonus collectionOrderOtherAdditionBonus = CollectionOrderOtherAdditionBonus();
  final List<int>? overdueDays = (json['overdue_days'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<int>(e) as int).toList();
  if (overdueDays != null) {
    collectionOrderOtherAdditionBonus.overdueDays = overdueDays;
  }
  final int? rate = jsonConvert.convert<int>(json['rate']);
  if (rate != null) {
    collectionOrderOtherAdditionBonus.rate = rate;
  }
  return collectionOrderOtherAdditionBonus;
}

Map<String, dynamic> $CollectionOrderOtherAdditionBonusToJson(
    CollectionOrderOtherAdditionBonus entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['overdue_days'] = entity.overdueDays;
  data['rate'] = entity.rate;
  return data;
}

extension CollectionOrderOtherAdditionBonusExtension on CollectionOrderOtherAdditionBonus {
  CollectionOrderOtherAdditionBonus copyWith({
    List<int>? overdueDays,
    int? rate,
  }) {
    return CollectionOrderOtherAdditionBonus()
      ..overdueDays = overdueDays ?? this.overdueDays
      ..rate = rate ?? this.rate;
  }
}

CollectionOrderOtherFines $CollectionOrderOtherFinesFromJson(
    Map<String, dynamic> json) {
  final CollectionOrderOtherFines collectionOrderOtherFines = CollectionOrderOtherFines();
  final List<int>? borrowCount = (json['borrow_count'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<int>(e) as int).toList();
  if (borrowCount != null) {
    collectionOrderOtherFines.borrowCount = borrowCount;
  }
  final List<int>? fines = (json['fines'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<int>(e) as int).toList();
  if (fines != null) {
    collectionOrderOtherFines.fines = fines;
  }
  return collectionOrderOtherFines;
}

Map<String, dynamic> $CollectionOrderOtherFinesToJson(
    CollectionOrderOtherFines entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['borrow_count'] = entity.borrowCount;
  data['fines'] = entity.fines;
  return data;
}

extension CollectionOrderOtherFinesExtension on CollectionOrderOtherFines {
  CollectionOrderOtherFines copyWith({
    List<int>? borrowCount,
    List<int>? fines,
  }) {
    return CollectionOrderOtherFines()
      ..borrowCount = borrowCount ?? this.borrowCount
      ..fines = fines ?? this.fines;
  }
}
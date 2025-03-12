import 'package:bounty_hunter/generated/json/base/json_convert_content.dart';
import 'package:bounty_hunter/models/collection_log_entity.dart';

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
  final CollectionLogOther? other = jsonConvert.convert<CollectionLogOther>(
      json['other']);
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
  data['other'] = entity.other?.toJson();
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
    CollectionLogOther? other,
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
  final int? nBorrowId = jsonConvert.convert<int>(json['n_borrow_id']);
  if (nBorrowId != null) {
    collectionLogData.nBorrowId = nBorrowId;
  }
  final int? oPeriodId = jsonConvert.convert<int>(json['o_period_id']);
  if (oPeriodId != null) {
    collectionLogData.oPeriodId = oPeriodId;
  }
  final int? aParentId = jsonConvert.convert<int>(json['a_parent_id']);
  if (aParentId != null) {
    collectionLogData.aParentId = aParentId;
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
  final int? fCat = jsonConvert.convert<int>(json['f_cat']);
  if (fCat != null) {
    collectionLogData.fCat = fCat;
  }
  final int? gType = jsonConvert.convert<int>(json['g_type']);
  if (gType != null) {
    collectionLogData.gType = gType;
  }
  final String? hPhone = jsonConvert.convert<String>(json['h_phone']);
  if (hPhone != null) {
    collectionLogData.hPhone = hPhone;
  }
  final int? iTarget = jsonConvert.convert<int>(json['i_target']);
  if (iTarget != null) {
    collectionLogData.iTarget = iTarget;
  }
  final String? jContent = jsonConvert.convert<String>(json['j_content']);
  if (jContent != null) {
    collectionLogData.jContent = jContent;
  }
  final String? kPromiseTime = jsonConvert.convert<String>(
      json['k_promise_time']);
  if (kPromiseTime != null) {
    collectionLogData.kPromiseTime = kPromiseTime;
  }
  final int? lStageDayIndex = jsonConvert.convert<int>(
      json['l_stage_day_index']);
  if (lStageDayIndex != null) {
    collectionLogData.lStageDayIndex = lStageDayIndex;
  }
  final int? mOverdueDays = jsonConvert.convert<int>(json['m_overdue_days']);
  if (mOverdueDays != null) {
    collectionLogData.mOverdueDays = mOverdueDays;
  }
  final int? nSmsTemplateId = jsonConvert.convert<int>(
      json['n_sms_template_id']);
  if (nSmsTemplateId != null) {
    collectionLogData.nSmsTemplateId = nSmsTemplateId;
  }
  final int? oContactId = jsonConvert.convert<int>(json['o_contact_id']);
  if (oContactId != null) {
    collectionLogData.oContactId = oContactId;
  }
  final String? createdAt = jsonConvert.convert<String>(json['created_at']);
  if (createdAt != null) {
    collectionLogData.createdAt = createdAt;
  }
  return collectionLogData;
}

Map<String, dynamic> $CollectionLogDataToJson(CollectionLogData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['n_borrow_id'] = entity.nBorrowId;
  data['o_period_id'] = entity.oPeriodId;
  data['a_parent_id'] = entity.aParentId;
  data['p_collection_order_id'] = entity.pCollectionOrderId;
  data['b_collection_stage_id'] = entity.bCollectionStageId;
  data['c_collection_agency_id'] = entity.cCollectionAgencyId;
  data['d_collection_group_id'] = entity.dCollectionGroupId;
  data['e_collection_admin_id'] = entity.eCollectionAdminId;
  data['f_cat'] = entity.fCat;
  data['g_type'] = entity.gType;
  data['h_phone'] = entity.hPhone;
  data['i_target'] = entity.iTarget;
  data['j_content'] = entity.jContent;
  data['k_promise_time'] = entity.kPromiseTime;
  data['l_stage_day_index'] = entity.lStageDayIndex;
  data['m_overdue_days'] = entity.mOverdueDays;
  data['n_sms_template_id'] = entity.nSmsTemplateId;
  data['o_contact_id'] = entity.oContactId;
  data['created_at'] = entity.createdAt;
  return data;
}

extension CollectionLogDataExtension on CollectionLogData {
  CollectionLogData copyWith({
    int? id,
    int? nBorrowId,
    int? oPeriodId,
    int? aParentId,
    int? pCollectionOrderId,
    int? bCollectionStageId,
    int? cCollectionAgencyId,
    int? dCollectionGroupId,
    int? eCollectionAdminId,
    int? fCat,
    int? gType,
    String? hPhone,
    int? iTarget,
    String? jContent,
    String? kPromiseTime,
    int? lStageDayIndex,
    int? mOverdueDays,
    int? nSmsTemplateId,
    int? oContactId,
    String? createdAt,
  }) {
    return CollectionLogData()
      ..id = id ?? this.id
      ..nBorrowId = nBorrowId ?? this.nBorrowId
      ..oPeriodId = oPeriodId ?? this.oPeriodId
      ..aParentId = aParentId ?? this.aParentId
      ..pCollectionOrderId = pCollectionOrderId ?? this.pCollectionOrderId
      ..bCollectionStageId = bCollectionStageId ?? this.bCollectionStageId
      ..cCollectionAgencyId = cCollectionAgencyId ?? this.cCollectionAgencyId
      ..dCollectionGroupId = dCollectionGroupId ?? this.dCollectionGroupId
      ..eCollectionAdminId = eCollectionAdminId ?? this.eCollectionAdminId
      ..fCat = fCat ?? this.fCat
      ..gType = gType ?? this.gType
      ..hPhone = hPhone ?? this.hPhone
      ..iTarget = iTarget ?? this.iTarget
      ..jContent = jContent ?? this.jContent
      ..kPromiseTime = kPromiseTime ?? this.kPromiseTime
      ..lStageDayIndex = lStageDayIndex ?? this.lStageDayIndex
      ..mOverdueDays = mOverdueDays ?? this.mOverdueDays
      ..nSmsTemplateId = nSmsTemplateId ?? this.nSmsTemplateId
      ..oContactId = oContactId ?? this.oContactId
      ..createdAt = createdAt ?? this.createdAt;
  }
}

CollectionLogOther $CollectionLogOtherFromJson(Map<String, dynamic> json) {
  final CollectionLogOther collectionLogOther = CollectionLogOther();
  final CollectionLogOtherTrack? track = jsonConvert.convert<
      CollectionLogOtherTrack>(json['track']);
  if (track != null) {
    collectionLogOther.track = track;
  }
  final CollectionLogOtherPeriod? period = jsonConvert.convert<
      CollectionLogOtherPeriod>(json['period']);
  if (period != null) {
    collectionLogOther.period = period;
  }
  final CollectionLogOtherRepayInfo? repayInfo = jsonConvert.convert<
      CollectionLogOtherRepayInfo>(json['repay_info']);
  if (repayInfo != null) {
    collectionLogOther.repayInfo = repayInfo;
  }
  final List<
      CollectionLogOtherContactInfo>? contactInfo = (json['contact_info'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<CollectionLogOtherContactInfo>(
          e) as CollectionLogOtherContactInfo).toList();
  if (contactInfo != null) {
    collectionLogOther.contactInfo = contactInfo;
  }
  final List<
      CollectionLogOtherSmsHistory>? smsHistory = (json['sms_history'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<CollectionLogOtherSmsHistory>(
          e) as CollectionLogOtherSmsHistory).toList();
  if (smsHistory != null) {
    collectionLogOther.smsHistory = smsHistory;
  }
  return collectionLogOther;
}

Map<String, dynamic> $CollectionLogOtherToJson(CollectionLogOther entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['track'] = entity.track?.toJson();
  data['period'] = entity.period?.toJson();
  data['repay_info'] = entity.repayInfo?.toJson();
  data['contact_info'] = entity.contactInfo?.map((v) => v.toJson()).toList();
  data['sms_history'] = entity.smsHistory?.map((v) => v.toJson()).toList();
  return data;
}

extension CollectionLogOtherExtension on CollectionLogOther {
  CollectionLogOther copyWith({
    CollectionLogOtherTrack? track,
    CollectionLogOtherPeriod? period,
    CollectionLogOtherRepayInfo? repayInfo,
    List<CollectionLogOtherContactInfo>? contactInfo,
    List<CollectionLogOtherSmsHistory>? smsHistory,
  }) {
    return CollectionLogOther()
      ..track = track ?? this.track
      ..period = period ?? this.period
      ..repayInfo = repayInfo ?? this.repayInfo
      ..contactInfo = contactInfo ?? this.contactInfo
      ..smsHistory = smsHistory ?? this.smsHistory;
  }
}

CollectionLogOtherTrack $CollectionLogOtherTrackFromJson(
    Map<String, dynamic> json) {
  final CollectionLogOtherTrack collectionLogOtherTrack = CollectionLogOtherTrack();
  final String? applyTime = jsonConvert.convert<String>(json['apply_time']);
  if (applyTime != null) {
    collectionLogOtherTrack.applyTime = applyTime;
  }
  final int? borrowAmount = jsonConvert.convert<int>(json['borrow_amount']);
  if (borrowAmount != null) {
    collectionLogOtherTrack.borrowAmount = borrowAmount;
  }
  final String? loanTime = jsonConvert.convert<String>(json['loan_time']);
  if (loanTime != null) {
    collectionLogOtherTrack.loanTime = loanTime;
  }
  final String? loanBank = jsonConvert.convert<String>(json['loan_bank']);
  if (loanBank != null) {
    collectionLogOtherTrack.loanBank = loanBank;
  }
  final int? loanAmount = jsonConvert.convert<int>(json['loan_amount']);
  if (loanAmount != null) {
    collectionLogOtherTrack.loanAmount = loanAmount;
  }
  final String? loanActiveTime = jsonConvert.convert<String>(
      json['loan_active_time']);
  if (loanActiveTime != null) {
    collectionLogOtherTrack.loanActiveTime = loanActiveTime;
  }
  return collectionLogOtherTrack;
}

Map<String, dynamic> $CollectionLogOtherTrackToJson(
    CollectionLogOtherTrack entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['apply_time'] = entity.applyTime;
  data['borrow_amount'] = entity.borrowAmount;
  data['loan_time'] = entity.loanTime;
  data['loan_bank'] = entity.loanBank;
  data['loan_amount'] = entity.loanAmount;
  data['loan_active_time'] = entity.loanActiveTime;
  return data;
}

extension CollectionLogOtherTrackExtension on CollectionLogOtherTrack {
  CollectionLogOtherTrack copyWith({
    String? applyTime,
    int? borrowAmount,
    String? loanTime,
    String? loanBank,
    int? loanAmount,
    String? loanActiveTime,
  }) {
    return CollectionLogOtherTrack()
      ..applyTime = applyTime ?? this.applyTime
      ..borrowAmount = borrowAmount ?? this.borrowAmount
      ..loanTime = loanTime ?? this.loanTime
      ..loanBank = loanBank ?? this.loanBank
      ..loanAmount = loanAmount ?? this.loanAmount
      ..loanActiveTime = loanActiveTime ?? this.loanActiveTime;
  }
}

CollectionLogOtherPeriod $CollectionLogOtherPeriodFromJson(
    Map<String, dynamic> json) {
  final CollectionLogOtherPeriod collectionLogOtherPeriod = CollectionLogOtherPeriod();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    collectionLogOtherPeriod.id = id;
  }
  final int? aBorrowId = jsonConvert.convert<int>(json['a_borrow_id']);
  if (aBorrowId != null) {
    collectionLogOtherPeriod.aBorrowId = aBorrowId;
  }
  final int? fExpectRepayTotalAmount = jsonConvert.convert<int>(
      json['f_expect_repay_total_amount']);
  if (fExpectRepayTotalAmount != null) {
    collectionLogOtherPeriod.fExpectRepayTotalAmount = fExpectRepayTotalAmount;
  }
  final int? pPaidInterest = jsonConvert.convert<int>(json['p_paid_interest']);
  if (pPaidInterest != null) {
    collectionLogOtherPeriod.pPaidInterest = pPaidInterest;
  }
  final int? qPaidServiceFee = jsonConvert.convert<int>(
      json['q_paid_service_fee']);
  if (qPaidServiceFee != null) {
    collectionLogOtherPeriod.qPaidServiceFee = qPaidServiceFee;
  }
  final int? sPaidOverdueAmount = jsonConvert.convert<int>(
      json['s_paid_overdue_amount']);
  if (sPaidOverdueAmount != null) {
    collectionLogOtherPeriod.sPaidOverdueAmount = sPaidOverdueAmount;
  }
  final int? oPaidBorrowAmount = jsonConvert.convert<int>(
      json['o_paid_borrow_amount']);
  if (oPaidBorrowAmount != null) {
    collectionLogOtherPeriod.oPaidBorrowAmount = oPaidBorrowAmount;
  }
  final int? gExpectBorrowAmount = jsonConvert.convert<int>(
      json['g_expect_borrow_amount']);
  if (gExpectBorrowAmount != null) {
    collectionLogOtherPeriod.gExpectBorrowAmount = gExpectBorrowAmount;
  }
  final int? hExpectInterest = jsonConvert.convert<int>(
      json['h_expect_interest']);
  if (hExpectInterest != null) {
    collectionLogOtherPeriod.hExpectInterest = hExpectInterest;
  }
  final int? nPaidAmount = jsonConvert.convert<int>(json['n_paid_amount']);
  if (nPaidAmount != null) {
    collectionLogOtherPeriod.nPaidAmount = nPaidAmount;
  }
  final int? iExpectServiceFee = jsonConvert.convert<int>(
      json['i_expect_service_fee']);
  if (iExpectServiceFee != null) {
    collectionLogOtherPeriod.iExpectServiceFee = iExpectServiceFee;
  }
  final int? jExpectViolateFee = jsonConvert.convert<int>(
      json['j_expect_violate_fee']);
  if (jExpectViolateFee != null) {
    collectionLogOtherPeriod.jExpectViolateFee = jExpectViolateFee;
  }
  final int? kExpectOverdueAmount = jsonConvert.convert<int>(
      json['k_expect_overdue_amount']);
  if (kExpectOverdueAmount != null) {
    collectionLogOtherPeriod.kExpectOverdueAmount = kExpectOverdueAmount;
  }
  final int? lOverdueDays = jsonConvert.convert<int>(json['l_overdue_days']);
  if (lOverdueDays != null) {
    collectionLogOtherPeriod.lOverdueDays = lOverdueDays;
  }
  final int? tDeductionTimes = jsonConvert.convert<int>(
      json['t_deduction_times']);
  if (tDeductionTimes != null) {
    collectionLogOtherPeriod.tDeductionTimes = tDeductionTimes;
  }
  final int? uDeductionTotalAmount = jsonConvert.convert<int>(
      json['u_deduction_total_amount']);
  if (uDeductionTotalAmount != null) {
    collectionLogOtherPeriod.uDeductionTotalAmount = uDeductionTotalAmount;
  }
  final int? aHPartTimes = jsonConvert.convert<int>(json['a_h_part_times']);
  if (aHPartTimes != null) {
    collectionLogOtherPeriod.aHPartTimes = aHPartTimes;
  }
  final int? aUCurrentDeductionFee = jsonConvert.convert<int>(
      json['a_u_current_deduction_fee']);
  if (aUCurrentDeductionFee != null) {
    collectionLogOtherPeriod.aUCurrentDeductionFee = aUCurrentDeductionFee;
  }
  final int? aZLeftAmount = jsonConvert.convert<int>(json['a_z_left_amount']);
  if (aZLeftAmount != null) {
    collectionLogOtherPeriod.aZLeftAmount = aZLeftAmount;
  }
  final String? aPExpectRepayTime = jsonConvert.convert<String>(
      json['a_p_expect_repay_time']);
  if (aPExpectRepayTime != null) {
    collectionLogOtherPeriod.aPExpectRepayTime = aPExpectRepayTime;
  }
  return collectionLogOtherPeriod;
}

Map<String, dynamic> $CollectionLogOtherPeriodToJson(
    CollectionLogOtherPeriod entity) {
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
  data['a_u_current_deduction_fee'] = entity.aUCurrentDeductionFee;
  data['a_z_left_amount'] = entity.aZLeftAmount;
  data['a_p_expect_repay_time'] = entity.aPExpectRepayTime;
  return data;
}

extension CollectionLogOtherPeriodExtension on CollectionLogOtherPeriod {
  CollectionLogOtherPeriod copyWith({
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
    int? aUCurrentDeductionFee,
    int? aZLeftAmount,
    String? aPExpectRepayTime,
  }) {
    return CollectionLogOtherPeriod()
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
      ..aUCurrentDeductionFee = aUCurrentDeductionFee ??
          this.aUCurrentDeductionFee
      ..aZLeftAmount = aZLeftAmount ?? this.aZLeftAmount
      ..aPExpectRepayTime = aPExpectRepayTime ?? this.aPExpectRepayTime;
  }
}

CollectionLogOtherRepayInfo $CollectionLogOtherRepayInfoFromJson(
    Map<String, dynamic> json) {
  final CollectionLogOtherRepayInfo collectionLogOtherRepayInfo = CollectionLogOtherRepayInfo();
  final String? phone = jsonConvert.convert<String>(json['phone']);
  if (phone != null) {
    collectionLogOtherRepayInfo.phone = phone;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    collectionLogOtherRepayInfo.name = name;
  }
  final int? loanAmount = jsonConvert.convert<int>(json['loan_amount']);
  if (loanAmount != null) {
    collectionLogOtherRepayInfo.loanAmount = loanAmount;
  }
  final int? repayAmount = jsonConvert.convert<int>(json['repay_amount']);
  if (repayAmount != null) {
    collectionLogOtherRepayInfo.repayAmount = repayAmount;
  }
  final String? expectRepayTime = jsonConvert.convert<String>(
      json['expect_repay_time']);
  if (expectRepayTime != null) {
    collectionLogOtherRepayInfo.expectRepayTime = expectRepayTime;
  }
  final int? borrowDays = jsonConvert.convert<int>(json['borrow_days']);
  if (borrowDays != null) {
    collectionLogOtherRepayInfo.borrowDays = borrowDays;
  }
  final int? upAmount = jsonConvert.convert<int>(json['up_amount']);
  if (upAmount != null) {
    collectionLogOtherRepayInfo.upAmount = upAmount;
  }
  final String? bankcardBank = jsonConvert.convert<String>(
      json['bankcard_bank']);
  if (bankcardBank != null) {
    collectionLogOtherRepayInfo.bankcardBank = bankcardBank;
  }
  final int? overdueDays = jsonConvert.convert<int>(json['overdue_days']);
  if (overdueDays != null) {
    collectionLogOtherRepayInfo.overdueDays = overdueDays;
  }
  final String? productName = jsonConvert.convert<String>(json['product_name']);
  if (productName != null) {
    collectionLogOtherRepayInfo.productName = productName;
  }
  final String? recieveBank = jsonConvert.convert<String>(json['recieve_bank']);
  if (recieveBank != null) {
    collectionLogOtherRepayInfo.recieveBank = recieveBank;
  }
  final String? recieveBankNo = jsonConvert.convert<String>(
      json['recieve_bank_no']);
  if (recieveBankNo != null) {
    collectionLogOtherRepayInfo.recieveBankNo = recieveBankNo;
  }
  final String? accountNumber = jsonConvert.convert<String>(
      json['account_number']);
  if (accountNumber != null) {
    collectionLogOtherRepayInfo.accountNumber = accountNumber;
  }
  final String? bank = jsonConvert.convert<String>(json['bank']);
  if (bank != null) {
    collectionLogOtherRepayInfo.bank = bank;
  }
  final String? accountName = jsonConvert.convert<String>(json['account_name']);
  if (accountName != null) {
    collectionLogOtherRepayInfo.accountName = accountName;
  }
  final String? email = jsonConvert.convert<String>(json['email']);
  if (email != null) {
    collectionLogOtherRepayInfo.email = email;
  }
  final String? whatsapp = jsonConvert.convert<String>(json['whatsapp']);
  if (whatsapp != null) {
    collectionLogOtherRepayInfo.whatsapp = whatsapp;
  }
  return collectionLogOtherRepayInfo;
}

Map<String, dynamic> $CollectionLogOtherRepayInfoToJson(
    CollectionLogOtherRepayInfo entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['phone'] = entity.phone;
  data['name'] = entity.name;
  data['loan_amount'] = entity.loanAmount;
  data['repay_amount'] = entity.repayAmount;
  data['expect_repay_time'] = entity.expectRepayTime;
  data['borrow_days'] = entity.borrowDays;
  data['up_amount'] = entity.upAmount;
  data['bankcard_bank'] = entity.bankcardBank;
  data['overdue_days'] = entity.overdueDays;
  data['product_name'] = entity.productName;
  data['recieve_bank'] = entity.recieveBank;
  data['recieve_bank_no'] = entity.recieveBankNo;
  data['account_number'] = entity.accountNumber;
  data['bank'] = entity.bank;
  data['account_name'] = entity.accountName;
  data['email'] = entity.email;
  data['whatsapp'] = entity.whatsapp;
  return data;
}

extension CollectionLogOtherRepayInfoExtension on CollectionLogOtherRepayInfo {
  CollectionLogOtherRepayInfo copyWith({
    String? phone,
    String? name,
    int? loanAmount,
    int? repayAmount,
    String? expectRepayTime,
    int? borrowDays,
    int? upAmount,
    String? bankcardBank,
    int? overdueDays,
    String? productName,
    String? recieveBank,
    String? recieveBankNo,
    String? accountNumber,
    String? bank,
    String? accountName,
    String? email,
    String? whatsapp,
  }) {
    return CollectionLogOtherRepayInfo()
      ..phone = phone ?? this.phone
      ..name = name ?? this.name
      ..loanAmount = loanAmount ?? this.loanAmount
      ..repayAmount = repayAmount ?? this.repayAmount
      ..expectRepayTime = expectRepayTime ?? this.expectRepayTime
      ..borrowDays = borrowDays ?? this.borrowDays
      ..upAmount = upAmount ?? this.upAmount
      ..bankcardBank = bankcardBank ?? this.bankcardBank
      ..overdueDays = overdueDays ?? this.overdueDays
      ..productName = productName ?? this.productName
      ..recieveBank = recieveBank ?? this.recieveBank
      ..recieveBankNo = recieveBankNo ?? this.recieveBankNo
      ..accountNumber = accountNumber ?? this.accountNumber
      ..bank = bank ?? this.bank
      ..accountName = accountName ?? this.accountName
      ..email = email ?? this.email
      ..whatsapp = whatsapp ?? this.whatsapp;
  }
}

CollectionLogOtherContactInfo $CollectionLogOtherContactInfoFromJson(
    Map<String, dynamic> json) {
  final CollectionLogOtherContactInfo collectionLogOtherContactInfo = CollectionLogOtherContactInfo();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    collectionLogOtherContactInfo.id = id;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    collectionLogOtherContactInfo.name = name;
  }
  final String? relationship = jsonConvert.convert<String>(
      json['relationship']);
  if (relationship != null) {
    collectionLogOtherContactInfo.relationship = relationship;
  }
  final String? phoneNumber = jsonConvert.convert<String>(json['phoneNumber']);
  if (phoneNumber != null) {
    collectionLogOtherContactInfo.phoneNumber = phoneNumber;
  }
  final List<
      CollectionLogOtherContactInfoCallRecords>? callRecords = (json['callRecords'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<CollectionLogOtherContactInfoCallRecords>(
          e) as CollectionLogOtherContactInfoCallRecords).toList();
  if (callRecords != null) {
    collectionLogOtherContactInfo.callRecords = callRecords;
  }
  return collectionLogOtherContactInfo;
}

Map<String, dynamic> $CollectionLogOtherContactInfoToJson(
    CollectionLogOtherContactInfo entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['name'] = entity.name;
  data['relationship'] = entity.relationship;
  data['phoneNumber'] = entity.phoneNumber;
  data['callRecords'] = entity.callRecords?.map((v) => v.toJson()).toList();
  return data;
}

extension CollectionLogOtherContactInfoExtension on CollectionLogOtherContactInfo {
  CollectionLogOtherContactInfo copyWith({
    int? id,
    String? name,
    String? relationship,
    String? phoneNumber,
    List<CollectionLogOtherContactInfoCallRecords>? callRecords,
  }) {
    return CollectionLogOtherContactInfo()
      ..id = id ?? this.id
      ..name = name ?? this.name
      ..relationship = relationship ?? this.relationship
      ..phoneNumber = phoneNumber ?? this.phoneNumber
      ..callRecords = callRecords ?? this.callRecords;
  }
}

CollectionLogOtherContactInfoCallRecords $CollectionLogOtherContactInfoCallRecordsFromJson(
    Map<String, dynamic> json) {
  final CollectionLogOtherContactInfoCallRecords collectionLogOtherContactInfoCallRecords = CollectionLogOtherContactInfoCallRecords();
  final String? time = jsonConvert.convert<String>(json['time']);
  if (time != null) {
    collectionLogOtherContactInfoCallRecords.time = time;
  }
  final int? duration = jsonConvert.convert<int>(json['duration']);
  if (duration != null) {
    collectionLogOtherContactInfoCallRecords.duration = duration;
  }
  final int? adminId = jsonConvert.convert<int>(json['admin_id']);
  if (adminId != null) {
    collectionLogOtherContactInfoCallRecords.adminId = adminId;
  }
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    collectionLogOtherContactInfoCallRecords.id = id;
  }
  return collectionLogOtherContactInfoCallRecords;
}

Map<String, dynamic> $CollectionLogOtherContactInfoCallRecordsToJson(
    CollectionLogOtherContactInfoCallRecords entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['time'] = entity.time;
  data['duration'] = entity.duration;
  data['admin_id'] = entity.adminId;
  data['id'] = entity.id;
  return data;
}

extension CollectionLogOtherContactInfoCallRecordsExtension on CollectionLogOtherContactInfoCallRecords {
  CollectionLogOtherContactInfoCallRecords copyWith({
    String? time,
    int? duration,
    int? adminId,
    int? id,
  }) {
    return CollectionLogOtherContactInfoCallRecords()
      ..time = time ?? this.time
      ..duration = duration ?? this.duration
      ..adminId = adminId ?? this.adminId
      ..id = id ?? this.id;
  }
}

CollectionLogOtherSmsHistory $CollectionLogOtherSmsHistoryFromJson(
    Map<String, dynamic> json) {
  final CollectionLogOtherSmsHistory collectionLogOtherSmsHistory = CollectionLogOtherSmsHistory();
  final int? cAdminId = jsonConvert.convert<int>(json['c_admin_id']);
  if (cAdminId != null) {
    collectionLogOtherSmsHistory.cAdminId = cAdminId;
  }
  final String? fTo = jsonConvert.convert<String>(json['f_to']);
  if (fTo != null) {
    collectionLogOtherSmsHistory.fTo = fTo;
  }
  final String? gText = jsonConvert.convert<String>(json['g_text']);
  if (gText != null) {
    collectionLogOtherSmsHistory.gText = gText;
  }
  final int? kSendStatus = jsonConvert.convert<int>(json['k_send_status']);
  if (kSendStatus != null) {
    collectionLogOtherSmsHistory.kSendStatus = kSendStatus;
  }
  final String? createdAt = jsonConvert.convert<String>(json['created_at']);
  if (createdAt != null) {
    collectionLogOtherSmsHistory.createdAt = createdAt;
  }
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    collectionLogOtherSmsHistory.id = id;
  }
  return collectionLogOtherSmsHistory;
}

Map<String, dynamic> $CollectionLogOtherSmsHistoryToJson(
    CollectionLogOtherSmsHistory entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['c_admin_id'] = entity.cAdminId;
  data['f_to'] = entity.fTo;
  data['g_text'] = entity.gText;
  data['k_send_status'] = entity.kSendStatus;
  data['created_at'] = entity.createdAt;
  data['id'] = entity.id;
  return data;
}

extension CollectionLogOtherSmsHistoryExtension on CollectionLogOtherSmsHistory {
  CollectionLogOtherSmsHistory copyWith({
    int? cAdminId,
    String? fTo,
    String? gText,
    int? kSendStatus,
    String? createdAt,
    int? id,
  }) {
    return CollectionLogOtherSmsHistory()
      ..cAdminId = cAdminId ?? this.cAdminId
      ..fTo = fTo ?? this.fTo
      ..gText = gText ?? this.gText
      ..kSendStatus = kSendStatus ?? this.kSendStatus
      ..createdAt = createdAt ?? this.createdAt
      ..id = id ?? this.id;
  }
}
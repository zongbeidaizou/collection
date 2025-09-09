import 'package:bounty_hunter/generated/json/base/json_convert_content.dart';
import 'package:bounty_hunter/models/collection_log_entity.dart';
import 'package:bounty_hunter/models/collection_order_entity.dart';


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
  final int? mOverdueDays = jsonConvert.convert<int>(json['m_overdue_days']);
  if (mOverdueDays != null) {
    collectionLogData.mOverdueDays = mOverdueDays;
  }
  final String? kPromiseTime = jsonConvert.convert<String>(
      json['k_promise_time']);
  if (kPromiseTime != null) {
    collectionLogData.kPromiseTime = kPromiseTime;
  }
  final int? qSmsTemplateId = jsonConvert.convert<int>(
      json['q_sms_template_id']);
  if (qSmsTemplateId != null) {
    collectionLogData.qSmsTemplateId = qSmsTemplateId;
  }
  final int? rContactId = jsonConvert.convert<int>(json['r_contact_id']);
  if (rContactId != null) {
    collectionLogData.rContactId = rContactId;
  }
  final String? sBorrowSn = jsonConvert.convert<String>(json['s_borrow_sn']);
  if (sBorrowSn != null) {
    collectionLogData.sBorrowSn = sBorrowSn;
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
  data['e_collection_admin_id'] = entity.eCollectionAdminId;
  data['f_cat'] = entity.fCat;
  data['g_type'] = entity.gType;
  data['h_phone'] = entity.hPhone;
  data['i_target'] = entity.iTarget;
  data['j_content'] = entity.jContent;
  data['m_overdue_days'] = entity.mOverdueDays;
  data['k_promise_time'] = entity.kPromiseTime;
  data['q_sms_template_id'] = entity.qSmsTemplateId;
  data['r_contact_id'] = entity.rContactId;
  data['s_borrow_sn'] = entity.sBorrowSn;
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
    int? eCollectionAdminId,
    int? fCat,
    int? gType,
    String? hPhone,
    int? iTarget,
    String? jContent,
    int? mOverdueDays,
    String? kPromiseTime,
    int? qSmsTemplateId,
    int? rContactId,
    String? sBorrowSn,
    String? createdAt,
  }) {
    return CollectionLogData()
      ..id = id ?? this.id
      ..nBorrowId = nBorrowId ?? this.nBorrowId
      ..oPeriodId = oPeriodId ?? this.oPeriodId
      ..aParentId = aParentId ?? this.aParentId
      ..pCollectionOrderId = pCollectionOrderId ?? this.pCollectionOrderId
      ..eCollectionAdminId = eCollectionAdminId ?? this.eCollectionAdminId
      ..fCat = fCat ?? this.fCat
      ..gType = gType ?? this.gType
      ..hPhone = hPhone ?? this.hPhone
      ..iTarget = iTarget ?? this.iTarget
      ..jContent = jContent ?? this.jContent
      ..mOverdueDays = mOverdueDays ?? this.mOverdueDays
      ..kPromiseTime = kPromiseTime ?? this.kPromiseTime
      ..qSmsTemplateId = qSmsTemplateId ?? this.qSmsTemplateId
      ..rContactId = rContactId ?? this.rContactId
      ..sBorrowSn = sBorrowSn ?? this.sBorrowSn
      ..createdAt = createdAt ?? this.createdAt;
  }
}

CollectionLogOther $CollectionLogOtherFromJson(Map<String, dynamic> json) {
  final CollectionLogOther collectionLogOther = CollectionLogOther();
  final String? avatar = jsonConvert.convert<String>(json['avatar']);
  if (avatar != null) {
    collectionLogOther.avatar = avatar;
  }
  final int? showContactDays = jsonConvert.convert<int>(
      json['show_contact_days']);
  if (showContactDays != null) {
    collectionLogOther.showContactDays = showContactDays;
  }
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
      CollectionLogOtherContactInfo2Data>? contactInfo = (json['contact_info'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<CollectionLogOtherContactInfo2Data>(
          e) as CollectionLogOtherContactInfo2Data).toList();
  if (contactInfo != null) {
    collectionLogOther.contactInfo = contactInfo;
  }
  final CollectionLogOtherContactInfo2? contactInfo2 = jsonConvert.convert<
      CollectionLogOtherContactInfo2>(json['contact_info2']);
  if (contactInfo2 != null) {
    collectionLogOther.contactInfo2 = contactInfo2;
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
  final String? hJSmsTemplateNewestUpdatedAt = jsonConvert.convert<String>(
      json['h_j_sms_template_newest_updated_at']);
  if (hJSmsTemplateNewestUpdatedAt != null) {
    collectionLogOther.hJSmsTemplateNewestUpdatedAt =
        hJSmsTemplateNewestUpdatedAt;
  }
  final List<
      CollectionLogOtherHJSmsTemplate>? hJSmsTemplate = (json['h_j_sms_template'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<CollectionLogOtherHJSmsTemplate>(
          e) as CollectionLogOtherHJSmsTemplate).toList();
  if (hJSmsTemplate != null) {
    collectionLogOther.hJSmsTemplate = hJSmsTemplate;
  }
  final CollectionOrderOther? other = jsonConvert.convert<CollectionOrderOther>(
      json['other']);
  if (other != null) {
    collectionLogOther.other = other;
  }
  final String? lastContactFetchTime = jsonConvert.convert<String>(
      json['last_contact_fetch_time']);
  if (lastContactFetchTime != null) {
    collectionLogOther.lastContactFetchTime = lastContactFetchTime;
  }
  return collectionLogOther;
}

Map<String, dynamic> $CollectionLogOtherToJson(CollectionLogOther entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['avatar'] = entity.avatar;
  data['show_contact_days'] = entity.showContactDays;
  data['track'] = entity.track?.toJson();
  data['period'] = entity.period?.toJson();
  data['repay_info'] = entity.repayInfo?.toJson();
  data['contact_info'] = entity.contactInfo?.map((v) => v.toJson()).toList();
  data['contact_info2'] = entity.contactInfo2?.toJson();
  data['sms_history'] = entity.smsHistory?.map((v) => v.toJson()).toList();
  data['h_j_sms_template_newest_updated_at'] =
      entity.hJSmsTemplateNewestUpdatedAt;
  data['h_j_sms_template'] =
      entity.hJSmsTemplate?.map((v) => v.toJson()).toList();
  data['other'] = entity.other?.toJson();
  data['last_contact_fetch_time'] = entity.lastContactFetchTime;
  return data;
}

extension CollectionLogOtherExtension on CollectionLogOther {
  CollectionLogOther copyWith({
    String? avatar,
    int? showContactDays,
    CollectionLogOtherTrack? track,
    CollectionLogOtherPeriod? period,
    CollectionLogOtherRepayInfo? repayInfo,
    List<CollectionLogOtherContactInfo2Data>? contactInfo,
    CollectionLogOtherContactInfo2? contactInfo2,
    List<CollectionLogOtherSmsHistory>? smsHistory,
    String? hJSmsTemplateNewestUpdatedAt,
    List<CollectionLogOtherHJSmsTemplate>? hJSmsTemplate,
    CollectionOrderOther? other,
    String? lastContactFetchTime,
  }) {
    return CollectionLogOther()
      ..avatar = avatar ?? this.avatar
      ..showContactDays = showContactDays ?? this.showContactDays
      ..track = track ?? this.track
      ..period = period ?? this.period
      ..repayInfo = repayInfo ?? this.repayInfo
      ..contactInfo = contactInfo ?? this.contactInfo
      ..contactInfo2 = contactInfo2 ?? this.contactInfo2
      ..smsHistory = smsHistory ?? this.smsHistory
      ..hJSmsTemplateNewestUpdatedAt = hJSmsTemplateNewestUpdatedAt ??
          this.hJSmsTemplateNewestUpdatedAt
      ..hJSmsTemplate = hJSmsTemplate ?? this.hJSmsTemplate
      ..other = other ?? this.other
      ..lastContactFetchTime = lastContactFetchTime ??
          this.lastContactFetchTime;
  }
}

CollectionLogOtherTrack $CollectionLogOtherTrackFromJson(
    Map<String, dynamic> json) {
  final CollectionLogOtherTrack collectionLogOtherTrack = CollectionLogOtherTrack();
  final String? lastActiveTime = jsonConvert.convert<String>(
      json['last_active_time']);
  if (lastActiveTime != null) {
    collectionLogOtherTrack.lastActiveTime = lastActiveTime;
  }
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
  data['last_active_time'] = entity.lastActiveTime;
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
    String? lastActiveTime,
    String? applyTime,
    int? borrowAmount,
    String? loanTime,
    String? loanBank,
    int? loanAmount,
    String? loanActiveTime,
  }) {
    return CollectionLogOtherTrack()
      ..lastActiveTime = lastActiveTime ?? this.lastActiveTime
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
  final int? aNUserId = jsonConvert.convert<int>(json['a_n_user_id']);
  if (aNUserId != null) {
    collectionLogOtherPeriod.aNUserId = aNUserId;
  }
  final String? aPExpectRepayTime = jsonConvert.convert<String>(
      json['a_p_expect_repay_time']);
  if (aPExpectRepayTime != null) {
    collectionLogOtherPeriod.aPExpectRepayTime = aPExpectRepayTime;
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
  data['a_n_user_id'] = entity.aNUserId;
  data['a_p_expect_repay_time'] = entity.aPExpectRepayTime;
  data['a_u_current_deduction_fee'] = entity.aUCurrentDeductionFee;
  data['a_z_left_amount'] = entity.aZLeftAmount;
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
    int? aNUserId,
    String? aPExpectRepayTime,
    int? aUCurrentDeductionFee,
    int? aZLeftAmount,
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
      ..aNUserId = aNUserId ?? this.aNUserId
      ..aPExpectRepayTime = aPExpectRepayTime ?? this.aPExpectRepayTime
      ..aUCurrentDeductionFee = aUCurrentDeductionFee ??
          this.aUCurrentDeductionFee
      ..aZLeftAmount = aZLeftAmount ?? this.aZLeftAmount;
  }
}

CollectionLogOtherRepayInfo $CollectionLogOtherRepayInfoFromJson(
    Map<String, dynamic> json) {
  final CollectionLogOtherRepayInfo collectionLogOtherRepayInfo = CollectionLogOtherRepayInfo();
  final int? expectRepayAmount = jsonConvert.convert<int>(
      json['expect_repay_amount']);
  if (expectRepayAmount != null) {
    collectionLogOtherRepayInfo.expectRepayAmount = expectRepayAmount;
  }
  final String? expectRepayTime = jsonConvert.convert<String>(
      json['expect_repay_time']);
  if (expectRepayTime != null) {
    collectionLogOtherRepayInfo.expectRepayTime = expectRepayTime;
  }
  final int? overdueDays = jsonConvert.convert<int>(json['overdue_days']);
  if (overdueDays != null) {
    collectionLogOtherRepayInfo.overdueDays = overdueDays;
  }
  final String? mobile = jsonConvert.convert<String>(json['mobile']);
  if (mobile != null) {
    collectionLogOtherRepayInfo.mobile = mobile;
  }
  final String? phone = jsonConvert.convert<String>(json['phone']);
  if (phone != null) {
    collectionLogOtherRepayInfo.phone = phone;
  }
  final String? bvn = jsonConvert.convert<String>(json['bvn']);
  if (bvn != null) {
    collectionLogOtherRepayInfo.bvn = bvn;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    collectionLogOtherRepayInfo.name = name;
  }
  final int? borrowAmount = jsonConvert.convert<int>(json['borrow_amount']);
  if (borrowAmount != null) {
    collectionLogOtherRepayInfo.borrowAmount = borrowAmount;
  }
  final int? loanAmount = jsonConvert.convert<int>(json['loan_amount']);
  if (loanAmount != null) {
    collectionLogOtherRepayInfo.loanAmount = loanAmount;
  }
  final int? borrowDays = jsonConvert.convert<int>(json['borrow_days']);
  if (borrowDays != null) {
    collectionLogOtherRepayInfo.borrowDays = borrowDays;
  }
  final String? appName = jsonConvert.convert<String>(json['app_name']);
  if (appName != null) {
    collectionLogOtherRepayInfo.appName = appName;
  }
  final String? url = jsonConvert.convert<String>(json['url']);
  if (url != null) {
    collectionLogOtherRepayInfo.url = url;
  }
  final String? productName = jsonConvert.convert<String>(json['product_name']);
  if (productName != null) {
    collectionLogOtherRepayInfo.productName = productName;
  }
  final String? loanTime = jsonConvert.convert<String>(json['loan_time']);
  if (loanTime != null) {
    collectionLogOtherRepayInfo.loanTime = loanTime;
  }
  final String? receiveBank = jsonConvert.convert<String>(json['receive_bank']);
  if (receiveBank != null) {
    collectionLogOtherRepayInfo.receiveBank = receiveBank;
  }
  final String? receiveBankNo = jsonConvert.convert<String>(
      json['receive_bank_no']);
  if (receiveBankNo != null) {
    collectionLogOtherRepayInfo.receiveBankNo = receiveBankNo;
  }
  final String? accountName = jsonConvert.convert<String>(json['account_name']);
  if (accountName != null) {
    collectionLogOtherRepayInfo.accountName = accountName;
  }
  final String? accountNo = jsonConvert.convert<String>(json['account_no']);
  if (accountNo != null) {
    collectionLogOtherRepayInfo.accountNo = accountNo;
  }
  final String? accountBank = jsonConvert.convert<String>(json['account_bank']);
  if (accountBank != null) {
    collectionLogOtherRepayInfo.accountBank = accountBank;
  }
  final String? beforeCreditAmount = jsonConvert.convert<String>(
      json['before_credit_amount']);
  if (beforeCreditAmount != null) {
    collectionLogOtherRepayInfo.beforeCreditAmount = beforeCreditAmount;
  }
  final String? afterCreditAmount = jsonConvert.convert<String>(
      json['after_credit_amount']);
  if (afterCreditAmount != null) {
    collectionLogOtherRepayInfo.afterCreditAmount = afterCreditAmount;
  }
  final String? changeCreditAmount = jsonConvert.convert<String>(
      json['change_credit_amount']);
  if (changeCreditAmount != null) {
    collectionLogOtherRepayInfo.changeCreditAmount = changeCreditAmount;
  }
  final String? beforeCreditFraction = jsonConvert.convert<String>(
      json['before_credit_fraction']);
  if (beforeCreditFraction != null) {
    collectionLogOtherRepayInfo.beforeCreditFraction = beforeCreditFraction;
  }
  final String? afterCreditFraction = jsonConvert.convert<String>(
      json['after_credit_fraction']);
  if (afterCreditFraction != null) {
    collectionLogOtherRepayInfo.afterCreditFraction = afterCreditFraction;
  }
  final String? changeCreditFraction = jsonConvert.convert<String>(
      json['change_credit_fraction']);
  if (changeCreditFraction != null) {
    collectionLogOtherRepayInfo.changeCreditFraction = changeCreditFraction;
  }
  final String? var1 = jsonConvert.convert<String>(json['var1']);
  if (var1 != null) {
    collectionLogOtherRepayInfo.var1 = var1;
  }
  final String? var2 = jsonConvert.convert<String>(json['var2']);
  if (var2 != null) {
    collectionLogOtherRepayInfo.var2 = var2;
  }
  final String? var3 = jsonConvert.convert<String>(json['var3']);
  if (var3 != null) {
    collectionLogOtherRepayInfo.var3 = var3;
  }
  final String? var4 = jsonConvert.convert<String>(json['var4']);
  if (var4 != null) {
    collectionLogOtherRepayInfo.var4 = var4;
  }
  final String? var5 = jsonConvert.convert<String>(json['var5']);
  if (var5 != null) {
    collectionLogOtherRepayInfo.var5 = var5;
  }
  final String? var6 = jsonConvert.convert<String>(json['var6']);
  if (var6 != null) {
    collectionLogOtherRepayInfo.var6 = var6;
  }
  final String? var7 = jsonConvert.convert<String>(json['var7']);
  if (var7 != null) {
    collectionLogOtherRepayInfo.var7 = var7;
  }
  final String? var8 = jsonConvert.convert<String>(json['var8']);
  if (var8 != null) {
    collectionLogOtherRepayInfo.var8 = var8;
  }
  final String? var9 = jsonConvert.convert<String>(json['var9']);
  if (var9 != null) {
    collectionLogOtherRepayInfo.var9 = var9;
  }
  final String? var10 = jsonConvert.convert<String>(json['var10']);
  if (var10 != null) {
    collectionLogOtherRepayInfo.var10 = var10;
  }
  return collectionLogOtherRepayInfo;
}

Map<String, dynamic> $CollectionLogOtherRepayInfoToJson(
    CollectionLogOtherRepayInfo entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['expect_repay_amount'] = entity.expectRepayAmount;
  data['expect_repay_time'] = entity.expectRepayTime;
  data['overdue_days'] = entity.overdueDays;
  data['mobile'] = entity.mobile;
  data['phone'] = entity.phone;
  data['bvn'] = entity.bvn;
  data['name'] = entity.name;
  data['borrow_amount'] = entity.borrowAmount;
  data['loan_amount'] = entity.loanAmount;
  data['borrow_days'] = entity.borrowDays;
  data['app_name'] = entity.appName;
  data['url'] = entity.url;
  data['product_name'] = entity.productName;
  data['loan_time'] = entity.loanTime;
  data['receive_bank'] = entity.receiveBank;
  data['receive_bank_no'] = entity.receiveBankNo;
  data['account_name'] = entity.accountName;
  data['account_no'] = entity.accountNo;
  data['account_bank'] = entity.accountBank;
  data['before_credit_amount'] = entity.beforeCreditAmount;
  data['after_credit_amount'] = entity.afterCreditAmount;
  data['change_credit_amount'] = entity.changeCreditAmount;
  data['before_credit_fraction'] = entity.beforeCreditFraction;
  data['after_credit_fraction'] = entity.afterCreditFraction;
  data['change_credit_fraction'] = entity.changeCreditFraction;
  data['var1'] = entity.var1;
  data['var2'] = entity.var2;
  data['var3'] = entity.var3;
  data['var4'] = entity.var4;
  data['var5'] = entity.var5;
  data['var6'] = entity.var6;
  data['var7'] = entity.var7;
  data['var8'] = entity.var8;
  data['var9'] = entity.var9;
  data['var10'] = entity.var10;
  return data;
}

extension CollectionLogOtherRepayInfoExtension on CollectionLogOtherRepayInfo {
  CollectionLogOtherRepayInfo copyWith({
    int? expectRepayAmount,
    String? expectRepayTime,
    int? overdueDays,
    String? mobile,
    String? phone,
    String? bvn,
    String? name,
    int? borrowAmount,
    int? loanAmount,
    int? borrowDays,
    String? appName,
    String? url,
    String? productName,
    String? loanTime,
    String? receiveBank,
    String? receiveBankNo,
    String? accountName,
    String? accountNo,
    String? accountBank,
    String? beforeCreditAmount,
    String? afterCreditAmount,
    String? changeCreditAmount,
    String? beforeCreditFraction,
    String? afterCreditFraction,
    String? changeCreditFraction,
    String? var1,
    String? var2,
    String? var3,
    String? var4,
    String? var5,
    String? var6,
    String? var7,
    String? var8,
    String? var9,
    String? var10,
  }) {
    return CollectionLogOtherRepayInfo()
      ..expectRepayAmount = expectRepayAmount ?? this.expectRepayAmount
      ..expectRepayTime = expectRepayTime ?? this.expectRepayTime
      ..overdueDays = overdueDays ?? this.overdueDays
      ..mobile = mobile ?? this.mobile
      ..phone = phone ?? this.phone
      ..bvn = bvn ?? this.bvn
      ..name = name ?? this.name
      ..borrowAmount = borrowAmount ?? this.borrowAmount
      ..loanAmount = loanAmount ?? this.loanAmount
      ..borrowDays = borrowDays ?? this.borrowDays
      ..appName = appName ?? this.appName
      ..url = url ?? this.url
      ..productName = productName ?? this.productName
      ..loanTime = loanTime ?? this.loanTime
      ..receiveBank = receiveBank ?? this.receiveBank
      ..receiveBankNo = receiveBankNo ?? this.receiveBankNo
      ..accountName = accountName ?? this.accountName
      ..accountNo = accountNo ?? this.accountNo
      ..accountBank = accountBank ?? this.accountBank
      ..beforeCreditAmount = beforeCreditAmount ?? this.beforeCreditAmount
      ..afterCreditAmount = afterCreditAmount ?? this.afterCreditAmount
      ..changeCreditAmount = changeCreditAmount ?? this.changeCreditAmount
      ..beforeCreditFraction = beforeCreditFraction ?? this.beforeCreditFraction
      ..afterCreditFraction = afterCreditFraction ?? this.afterCreditFraction
      ..changeCreditFraction = changeCreditFraction ?? this.changeCreditFraction
      ..var1 = var1 ?? this.var1
      ..var2 = var2 ?? this.var2
      ..var3 = var3 ?? this.var3
      ..var4 = var4 ?? this.var4
      ..var5 = var5 ?? this.var5
      ..var6 = var6 ?? this.var6
      ..var7 = var7 ?? this.var7
      ..var8 = var8 ?? this.var8
      ..var9 = var9 ?? this.var9
      ..var10 = var10 ?? this.var10;
  }
}

CollectionLogOtherContactInfo2 $CollectionLogOtherContactInfo2FromJson(
    Map<String, dynamic> json) {
  final CollectionLogOtherContactInfo2 collectionLogOtherContactInfo2 = CollectionLogOtherContactInfo2();
  final int? currentPage = jsonConvert.convert<int>(json['current_page']);
  if (currentPage != null) {
    collectionLogOtherContactInfo2.currentPage = currentPage;
  }
  final List<CollectionLogOtherContactInfo2Data>? data = (json['data'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<CollectionLogOtherContactInfo2Data>(
          e) as CollectionLogOtherContactInfo2Data).toList();
  if (data != null) {
    collectionLogOtherContactInfo2.data = data;
  }
  final String? firstPageUrl = jsonConvert.convert<String>(
      json['first_page_url']);
  if (firstPageUrl != null) {
    collectionLogOtherContactInfo2.firstPageUrl = firstPageUrl;
  }
  final int? from = jsonConvert.convert<int>(json['from']);
  if (from != null) {
    collectionLogOtherContactInfo2.from = from;
  }
  final int? lastPage = jsonConvert.convert<int>(json['last_page']);
  if (lastPage != null) {
    collectionLogOtherContactInfo2.lastPage = lastPage;
  }
  final String? lastPageUrl = jsonConvert.convert<String>(
      json['last_page_url']);
  if (lastPageUrl != null) {
    collectionLogOtherContactInfo2.lastPageUrl = lastPageUrl;
  }
  final List<
      CollectionLogOtherContactInfo2Links>? links = (json['links'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<CollectionLogOtherContactInfo2Links>(
          e) as CollectionLogOtherContactInfo2Links).toList();
  if (links != null) {
    collectionLogOtherContactInfo2.links = links;
  }
  final dynamic nextPageUrl = json['next_page_url'];
  if (nextPageUrl != null) {
    collectionLogOtherContactInfo2.nextPageUrl = nextPageUrl;
  }
  final String? path = jsonConvert.convert<String>(json['path']);
  if (path != null) {
    collectionLogOtherContactInfo2.path = path;
  }
  final int? perPage = jsonConvert.convert<int>(json['per_page']);
  if (perPage != null) {
    collectionLogOtherContactInfo2.perPage = perPage;
  }
  final dynamic prevPageUrl = json['prev_page_url'];
  if (prevPageUrl != null) {
    collectionLogOtherContactInfo2.prevPageUrl = prevPageUrl;
  }
  final int? to = jsonConvert.convert<int>(json['to']);
  if (to != null) {
    collectionLogOtherContactInfo2.to = to;
  }
  final int? total = jsonConvert.convert<int>(json['total']);
  if (total != null) {
    collectionLogOtherContactInfo2.total = total;
  }
  return collectionLogOtherContactInfo2;
}

Map<String, dynamic> $CollectionLogOtherContactInfo2ToJson(
    CollectionLogOtherContactInfo2 entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['current_page'] = entity.currentPage;
  data['data'] = entity.data?.map((v) => v.toJson()).toList();
  data['first_page_url'] = entity.firstPageUrl;
  data['from'] = entity.from;
  data['last_page'] = entity.lastPage;
  data['last_page_url'] = entity.lastPageUrl;
  data['links'] = entity.links?.map((v) => v.toJson()).toList();
  data['next_page_url'] = entity.nextPageUrl;
  data['path'] = entity.path;
  data['per_page'] = entity.perPage;
  data['prev_page_url'] = entity.prevPageUrl;
  data['to'] = entity.to;
  data['total'] = entity.total;
  return data;
}

extension CollectionLogOtherContactInfo2Extension on CollectionLogOtherContactInfo2 {
  CollectionLogOtherContactInfo2 copyWith({
    int? currentPage,
    List<CollectionLogOtherContactInfo2Data>? data,
    String? firstPageUrl,
    int? from,
    int? lastPage,
    String? lastPageUrl,
    List<CollectionLogOtherContactInfo2Links>? links,
    dynamic nextPageUrl,
    String? path,
    int? perPage,
    dynamic prevPageUrl,
    int? to,
    int? total,
  }) {
    return CollectionLogOtherContactInfo2()
      ..currentPage = currentPage ?? this.currentPage
      ..data = data ?? this.data
      ..firstPageUrl = firstPageUrl ?? this.firstPageUrl
      ..from = from ?? this.from
      ..lastPage = lastPage ?? this.lastPage
      ..lastPageUrl = lastPageUrl ?? this.lastPageUrl
      ..links = links ?? this.links
      ..nextPageUrl = nextPageUrl ?? this.nextPageUrl
      ..path = path ?? this.path
      ..perPage = perPage ?? this.perPage
      ..prevPageUrl = prevPageUrl ?? this.prevPageUrl
      ..to = to ?? this.to
      ..total = total ?? this.total;
  }
}

CollectionLogOtherContactInfo2Data $CollectionLogOtherContactInfo2DataFromJson(
    Map<String, dynamic> json) {
  final CollectionLogOtherContactInfo2Data collectionLogOtherContactInfo2Data = CollectionLogOtherContactInfo2Data();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    collectionLogOtherContactInfo2Data.id = id;
  }
  final String? cRelation = jsonConvert.convert<String>(json['c_relation']);
  if (cRelation != null) {
    collectionLogOtherContactInfo2Data.cRelation = cRelation;
  }
  final String? fName = jsonConvert.convert<String>(json['f_name']);
  if (fName != null) {
    collectionLogOtherContactInfo2Data.fName = fName;
  }
  final String? gPhone = jsonConvert.convert<String>(json['g_phone']);
  if (gPhone != null) {
    collectionLogOtherContactInfo2Data.gPhone = gPhone;
  }
  final int? lSmsCount = jsonConvert.convert<int>(json['l_sms_count']);
  if (lSmsCount != null) {
    collectionLogOtherContactInfo2Data.lSmsCount = lSmsCount;
  }
  final int? mRelationLevel = jsonConvert.convert<int>(
      json['m_relation_level']);
  if (mRelationLevel != null) {
    collectionLogOtherContactInfo2Data.mRelationLevel = mRelationLevel;
  }
  final int? qPhoneStatus = jsonConvert.convert<int>(json['q_phone_status']);
  if (qPhoneStatus != null) {
    collectionLogOtherContactInfo2Data.qPhoneStatus = qPhoneStatus;
  }
  final int? rWaStatus = jsonConvert.convert<int>(json['r_wa_status']);
  if (rWaStatus != null) {
    collectionLogOtherContactInfo2Data.rWaStatus = rWaStatus;
  }
  final int? tWaWeight = jsonConvert.convert<int>(json['t_wa_weight']);
  if (tWaWeight != null) {
    collectionLogOtherContactInfo2Data.tWaWeight = tWaWeight;
  }
  final CollectionLogOtherContactInfo2DataAAAAAHLContactWeights? aAAAAHLContactWeights = jsonConvert
      .convert<CollectionLogOtherContactInfo2DataAAAAAHLContactWeights>(
      json['a_a_a_a_a_h_l_contact_weights']);
  if (aAAAAHLContactWeights != null) {
    collectionLogOtherContactInfo2Data.aAAAAHLContactWeights =
        aAAAAHLContactWeights;
  }
  return collectionLogOtherContactInfo2Data;
}

Map<String, dynamic> $CollectionLogOtherContactInfo2DataToJson(
    CollectionLogOtherContactInfo2Data entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['c_relation'] = entity.cRelation;
  data['f_name'] = entity.fName;
  data['g_phone'] = entity.gPhone;
  data['l_sms_count'] = entity.lSmsCount;
  data['m_relation_level'] = entity.mRelationLevel;
  data['q_phone_status'] = entity.qPhoneStatus;
  data['r_wa_status'] = entity.rWaStatus;
  data['t_wa_weight'] = entity.tWaWeight;
  data['a_a_a_a_a_h_l_contact_weights'] =
      entity.aAAAAHLContactWeights?.toJson();
  return data;
}

extension CollectionLogOtherContactInfo2DataExtension on CollectionLogOtherContactInfo2Data {
  CollectionLogOtherContactInfo2Data copyWith({
    int? id,
    String? cRelation,
    String? fName,
    String? gPhone,
    int? lSmsCount,
    int? mRelationLevel,
    int? qPhoneStatus,
    int? rWaStatus,
    int? tWaWeight,
    CollectionLogOtherContactInfo2DataAAAAAHLContactWeights? aAAAAHLContactWeights,
  }) {
    return CollectionLogOtherContactInfo2Data()
      ..id = id ?? this.id
      ..cRelation = cRelation ?? this.cRelation
      ..fName = fName ?? this.fName
      ..gPhone = gPhone ?? this.gPhone
      ..lSmsCount = lSmsCount ?? this.lSmsCount
      ..mRelationLevel = mRelationLevel ?? this.mRelationLevel
      ..qPhoneStatus = qPhoneStatus ?? this.qPhoneStatus
      ..rWaStatus = rWaStatus ?? this.rWaStatus
      ..tWaWeight = tWaWeight ?? this.tWaWeight
      ..aAAAAHLContactWeights = aAAAAHLContactWeights ??
          this.aAAAAHLContactWeights;
  }
}

CollectionLogOtherContactInfo2DataAAAAAHLContactWeights $CollectionLogOtherContactInfo2DataAAAAAHLContactWeightsFromJson(
    Map<String, dynamic> json) {
  final CollectionLogOtherContactInfo2DataAAAAAHLContactWeights collectionLogOtherContactInfo2DataAAAAAHLContactWeights = CollectionLogOtherContactInfo2DataAAAAAHLContactWeights();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    collectionLogOtherContactInfo2DataAAAAAHLContactWeights.id = id;
  }
  final int? aContactId = jsonConvert.convert<int>(json['a_contact_id']);
  if (aContactId != null) {
    collectionLogOtherContactInfo2DataAAAAAHLContactWeights.aContactId =
        aContactId;
  }
  final int? cCollectionAdminId = jsonConvert.convert<int>(
      json['c_collection_admin_id']);
  if (cCollectionAdminId != null) {
    collectionLogOtherContactInfo2DataAAAAAHLContactWeights.cCollectionAdminId =
        cCollectionAdminId;
  }
  final int? dCallTimes = jsonConvert.convert<int>(json['d_call_times']);
  if (dCallTimes != null) {
    collectionLogOtherContactInfo2DataAAAAAHLContactWeights.dCallTimes =
        dCallTimes;
  }
  final String? eLastCallTime = jsonConvert.convert<String>(
      json['e_last_call_time']);
  if (eLastCallTime != null) {
    collectionLogOtherContactInfo2DataAAAAAHLContactWeights.eLastCallTime =
        eLastCallTime;
  }
  final int? lSmsCount = jsonConvert.convert<int>(json['l_sms_count']);
  if (lSmsCount != null) {
    collectionLogOtherContactInfo2DataAAAAAHLContactWeights.lSmsCount =
        lSmsCount;
  }
  final int? qPhoneStatus = jsonConvert.convert<int>(json['q_phone_status']);
  if (qPhoneStatus != null) {
    collectionLogOtherContactInfo2DataAAAAAHLContactWeights.qPhoneStatus =
        qPhoneStatus;
  }
  final int? rWaStatus = jsonConvert.convert<int>(json['r_wa_status']);
  if (rWaStatus != null) {
    collectionLogOtherContactInfo2DataAAAAAHLContactWeights.rWaStatus =
        rWaStatus;
  }
  final int? sPhoneWeight = jsonConvert.convert<int>(json['s_phone_weight']);
  if (sPhoneWeight != null) {
    collectionLogOtherContactInfo2DataAAAAAHLContactWeights.sPhoneWeight =
        sPhoneWeight;
  }
  final int? tWaWeight = jsonConvert.convert<int>(json['t_wa_weight']);
  if (tWaWeight != null) {
    collectionLogOtherContactInfo2DataAAAAAHLContactWeights.tWaWeight =
        tWaWeight;
  }
  final String? uSmsLastAt = jsonConvert.convert<String>(json['u_sms_last_at']);
  if (uSmsLastAt != null) {
    collectionLogOtherContactInfo2DataAAAAAHLContactWeights.uSmsLastAt =
        uSmsLastAt;
  }
  final String? vWaLastAt = jsonConvert.convert<String>(json['v_wa_last_at']);
  if (vWaLastAt != null) {
    collectionLogOtherContactInfo2DataAAAAAHLContactWeights.vWaLastAt =
        vWaLastAt;
  }
  final int? wWaCt = jsonConvert.convert<int>(json['w_wa_ct']);
  if (wWaCt != null) {
    collectionLogOtherContactInfo2DataAAAAAHLContactWeights.wWaCt = wWaCt;
  }
  final String? xComment = jsonConvert.convert<String>(json['x_comment']);
  if (xComment != null) {
    collectionLogOtherContactInfo2DataAAAAAHLContactWeights.xComment = xComment;
  }
  return collectionLogOtherContactInfo2DataAAAAAHLContactWeights;
}

Map<String,
    dynamic> $CollectionLogOtherContactInfo2DataAAAAAHLContactWeightsToJson(
    CollectionLogOtherContactInfo2DataAAAAAHLContactWeights entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['a_contact_id'] = entity.aContactId;
  data['c_collection_admin_id'] = entity.cCollectionAdminId;
  data['d_call_times'] = entity.dCallTimes;
  data['e_last_call_time'] = entity.eLastCallTime;
  data['l_sms_count'] = entity.lSmsCount;
  data['q_phone_status'] = entity.qPhoneStatus;
  data['r_wa_status'] = entity.rWaStatus;
  data['s_phone_weight'] = entity.sPhoneWeight;
  data['t_wa_weight'] = entity.tWaWeight;
  data['u_sms_last_at'] = entity.uSmsLastAt;
  data['v_wa_last_at'] = entity.vWaLastAt;
  data['w_wa_ct'] = entity.wWaCt;
  data['x_comment'] = entity.xComment;
  return data;
}

extension CollectionLogOtherContactInfo2DataAAAAAHLContactWeightsExtension on CollectionLogOtherContactInfo2DataAAAAAHLContactWeights {
  CollectionLogOtherContactInfo2DataAAAAAHLContactWeights copyWith({
    int? id,
    int? aContactId,
    int? cCollectionAdminId,
    int? dCallTimes,
    String? eLastCallTime,
    int? lSmsCount,
    int? qPhoneStatus,
    int? rWaStatus,
    int? sPhoneWeight,
    int? tWaWeight,
    String? uSmsLastAt,
    String? vWaLastAt,
    int? wWaCt,
    String? xComment,
  }) {
    return CollectionLogOtherContactInfo2DataAAAAAHLContactWeights()
      ..id = id ?? this.id
      ..aContactId = aContactId ?? this.aContactId
      ..cCollectionAdminId = cCollectionAdminId ?? this.cCollectionAdminId
      ..dCallTimes = dCallTimes ?? this.dCallTimes
      ..eLastCallTime = eLastCallTime ?? this.eLastCallTime
      ..lSmsCount = lSmsCount ?? this.lSmsCount
      ..qPhoneStatus = qPhoneStatus ?? this.qPhoneStatus
      ..rWaStatus = rWaStatus ?? this.rWaStatus
      ..sPhoneWeight = sPhoneWeight ?? this.sPhoneWeight
      ..tWaWeight = tWaWeight ?? this.tWaWeight
      ..uSmsLastAt = uSmsLastAt ?? this.uSmsLastAt
      ..vWaLastAt = vWaLastAt ?? this.vWaLastAt
      ..wWaCt = wWaCt ?? this.wWaCt
      ..xComment = xComment ?? this.xComment;
  }
}

CollectionLogOtherContactInfo2Links $CollectionLogOtherContactInfo2LinksFromJson(
    Map<String, dynamic> json) {
  final CollectionLogOtherContactInfo2Links collectionLogOtherContactInfo2Links = CollectionLogOtherContactInfo2Links();
  final String? url = jsonConvert.convert<String>(json['url']);
  if (url != null) {
    collectionLogOtherContactInfo2Links.url = url;
  }
  final String? label = jsonConvert.convert<String>(json['label']);
  if (label != null) {
    collectionLogOtherContactInfo2Links.label = label;
  }
  final bool? active = jsonConvert.convert<bool>(json['active']);
  if (active != null) {
    collectionLogOtherContactInfo2Links.active = active;
  }
  return collectionLogOtherContactInfo2Links;
}

Map<String, dynamic> $CollectionLogOtherContactInfo2LinksToJson(
    CollectionLogOtherContactInfo2Links entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['url'] = entity.url;
  data['label'] = entity.label;
  data['active'] = entity.active;
  return data;
}

extension CollectionLogOtherContactInfo2LinksExtension on CollectionLogOtherContactInfo2Links {
  CollectionLogOtherContactInfo2Links copyWith({
    String? url,
    String? label,
    bool? active,
  }) {
    return CollectionLogOtherContactInfo2Links()
      ..url = url ?? this.url
      ..label = label ?? this.label
      ..active = active ?? this.active;
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

CollectionLogOtherHJSmsTemplate $CollectionLogOtherHJSmsTemplateFromJson(
    Map<String, dynamic> json) {
  final CollectionLogOtherHJSmsTemplate collectionLogOtherHJSmsTemplate = CollectionLogOtherHJSmsTemplate();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    collectionLogOtherHJSmsTemplate.id = id;
  }
  final String? dTemplate = jsonConvert.convert<String>(json['d_template']);
  if (dTemplate != null) {
    collectionLogOtherHJSmsTemplate.dTemplate = dTemplate;
  }
  final String? sName = jsonConvert.convert<String>(json['s_name']);
  if (sName != null) {
    collectionLogOtherHJSmsTemplate.sName = sName;
  }
  final int? cType = jsonConvert.convert<int>(json['c_type']);
  if (cType != null) {
    collectionLogOtherHJSmsTemplate.cType = cType;
  }
  final String? eDays = jsonConvert.convert<String>(json['e_days']);
  if (eDays != null) {
    collectionLogOtherHJSmsTemplate.eDays = eDays;
  }
  return collectionLogOtherHJSmsTemplate;
}

Map<String, dynamic> $CollectionLogOtherHJSmsTemplateToJson(
    CollectionLogOtherHJSmsTemplate entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['d_template'] = entity.dTemplate;
  data['s_name'] = entity.sName;
  data['c_type'] = entity.cType;
  data['e_days'] = entity.eDays;
  return data;
}

extension CollectionLogOtherHJSmsTemplateExtension on CollectionLogOtherHJSmsTemplate {
  CollectionLogOtherHJSmsTemplate copyWith({
    int? id,
    String? dTemplate,
    String? sName,
    int? cType,
    String? eDays,
  }) {
    return CollectionLogOtherHJSmsTemplate()
      ..id = id ?? this.id
      ..dTemplate = dTemplate ?? this.dTemplate
      ..sName = sName ?? this.sName
      ..cType = cType ?? this.cType
      ..eDays = eDays ?? this.eDays;
  }
}

CollectionLogOtherOther $CollectionLogOtherOtherFromJson(
    Map<String, dynamic> json) {
  final CollectionLogOtherOther collectionLogOtherOther = CollectionLogOtherOther();
  final CollectionLogOtherOtherProgress? progress = jsonConvert.convert<
      CollectionLogOtherOtherProgress>(json['progress']);
  if (progress != null) {
    collectionLogOtherOther.progress = progress;
  }
  final CollectionLogOtherOtherProfile? profile = jsonConvert.convert<
      CollectionLogOtherOtherProfile>(json['profile']);
  if (profile != null) {
    collectionLogOtherOther.profile = profile;
  }
  final List<dynamic>? monthAdditionData = (json['monthAdditionData'] as List<
      dynamic>?)?.map(
          (e) => e).toList();
  if (monthAdditionData != null) {
    collectionLogOtherOther.monthAdditionData = monthAdditionData;
  }
  return collectionLogOtherOther;
}

Map<String, dynamic> $CollectionLogOtherOtherToJson(
    CollectionLogOtherOther entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['progress'] = entity.progress?.toJson();
  data['profile'] = entity.profile?.toJson();
  data['monthAdditionData'] = entity.monthAdditionData;
  return data;
}

extension CollectionLogOtherOtherExtension on CollectionLogOtherOther {
  CollectionLogOtherOther copyWith({
    CollectionLogOtherOtherProgress? progress,
    CollectionLogOtherOtherProfile? profile,
    List<dynamic>? monthAdditionData,
  }) {
    return CollectionLogOtherOther()
      ..progress = progress ?? this.progress
      ..profile = profile ?? this.profile
      ..monthAdditionData = monthAdditionData ?? this.monthAdditionData;
  }
}

CollectionLogOtherOtherProgress $CollectionLogOtherOtherProgressFromJson(
    Map<String, dynamic> json) {
  final CollectionLogOtherOtherProgress collectionLogOtherOtherProgress = CollectionLogOtherOtherProgress();
  final List<int>? points = (json['points'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<int>(e) as int).toList();
  if (points != null) {
    collectionLogOtherOtherProgress.points = points;
  }
  final List<int>? counts = (json['counts'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<int>(e) as int).toList();
  if (counts != null) {
    collectionLogOtherOtherProgress.counts = counts;
  }
  final List<String>? grades = (json['grades'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (grades != null) {
    collectionLogOtherOtherProgress.grades = grades;
  }
  final List<String>? commissionRates = (json['commissionRates'] as List<
      dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (commissionRates != null) {
    collectionLogOtherOtherProgress.commissionRates = commissionRates;
  }
  final String? currentGrade = jsonConvert.convert<String>(
      json['currentGrade']);
  if (currentGrade != null) {
    collectionLogOtherOtherProgress.currentGrade = currentGrade;
  }
  final String? currentRate = jsonConvert.convert<String>(json['currentRate']);
  if (currentRate != null) {
    collectionLogOtherOtherProgress.currentRate = currentRate;
  }
  final String? nextGrade = jsonConvert.convert<String>(json['nextGrade']);
  if (nextGrade != null) {
    collectionLogOtherOtherProgress.nextGrade = nextGrade;
  }
  final String? nextRate = jsonConvert.convert<String>(json['nextRate']);
  if (nextRate != null) {
    collectionLogOtherOtherProgress.nextRate = nextRate;
  }
  final int? more = jsonConvert.convert<int>(json['more']);
  if (more != null) {
    collectionLogOtherOtherProgress.more = more;
  }
  final int? currentPoint = jsonConvert.convert<int>(json['currentPoint']);
  if (currentPoint != null) {
    collectionLogOtherOtherProgress.currentPoint = currentPoint;
  }
  final int? nextAdditionBonus = jsonConvert.convert<int>(
      json['nextAdditionBonus']);
  if (nextAdditionBonus != null) {
    collectionLogOtherOtherProgress.nextAdditionBonus = nextAdditionBonus;
  }
  return collectionLogOtherOtherProgress;
}

Map<String, dynamic> $CollectionLogOtherOtherProgressToJson(
    CollectionLogOtherOtherProgress entity) {
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

extension CollectionLogOtherOtherProgressExtension on CollectionLogOtherOtherProgress {
  CollectionLogOtherOtherProgress copyWith({
    List<int>? points,
    List<int>? counts,
    List<String>? grades,
    List<String>? commissionRates,
    String? currentGrade,
    String? currentRate,
    String? nextGrade,
    String? nextRate,
    int? more,
    int? currentPoint,
    int? nextAdditionBonus,
  }) {
    return CollectionLogOtherOtherProgress()
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

CollectionLogOtherOtherProfile $CollectionLogOtherOtherProfileFromJson(
    Map<String, dynamic> json) {
  final CollectionLogOtherOtherProfile collectionLogOtherOtherProfile = CollectionLogOtherOtherProfile();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    collectionLogOtherOtherProfile.id = id;
  }
  final String? aName = jsonConvert.convert<String>(json['a_name']);
  if (aName != null) {
    collectionLogOtherOtherProfile.aName = aName;
  }
  final int? bAdminId = jsonConvert.convert<int>(json['b_admin_id']);
  if (bAdminId != null) {
    collectionLogOtherOtherProfile.bAdminId = bAdminId;
  }
  final int? cCollectionAgencyId = jsonConvert.convert<int>(
      json['c_collection_agency_id']);
  if (cCollectionAgencyId != null) {
    collectionLogOtherOtherProfile.cCollectionAgencyId = cCollectionAgencyId;
  }
  final int? dCollectionGroupId = jsonConvert.convert<int>(
      json['d_collection_group_id']);
  if (dCollectionGroupId != null) {
    collectionLogOtherOtherProfile.dCollectionGroupId = dCollectionGroupId;
  }
  final String? eCollectionStages = jsonConvert.convert<String>(
      json['e_collection_stages']);
  if (eCollectionStages != null) {
    collectionLogOtherOtherProfile.eCollectionStages = eCollectionStages;
  }
  final int? fStatus = jsonConvert.convert<int>(json['f_status']);
  if (fStatus != null) {
    collectionLogOtherOtherProfile.fStatus = fStatus;
  }
  final String? gComment = jsonConvert.convert<String>(json['g_comment']);
  if (gComment != null) {
    collectionLogOtherOtherProfile.gComment = gComment;
  }
  final int? hCollectionIngOrderCount = jsonConvert.convert<int>(
      json['h_collection_ing_order_count']);
  if (hCollectionIngOrderCount != null) {
    collectionLogOtherOtherProfile.hCollectionIngOrderCount =
        hCollectionIngOrderCount;
  }
  final int? iTodayCurrentKpiLevel = jsonConvert.convert<int>(
      json['i_today_current_kpi_level']);
  if (iTodayCurrentKpiLevel != null) {
    collectionLogOtherOtherProfile.iTodayCurrentKpiLevel =
        iTodayCurrentKpiLevel;
  }
  final int? jTodayInitAmount = jsonConvert.convert<int>(
      json['j_today_init_amount']);
  if (jTodayInitAmount != null) {
    collectionLogOtherOtherProfile.jTodayInitAmount = jTodayInitAmount;
  }
  final int? kCurrentNewCount = jsonConvert.convert<int>(
      json['k_current_new_count']);
  if (kCurrentNewCount != null) {
    collectionLogOtherOtherProfile.kCurrentNewCount = kCurrentNewCount;
  }
  final int? lCurrentNegotiatingCount = jsonConvert.convert<int>(
      json['l_current_negotiating_count']);
  if (lCurrentNegotiatingCount != null) {
    collectionLogOtherOtherProfile.lCurrentNegotiatingCount =
        lCurrentNegotiatingCount;
  }
  final int? mCurrrentPromisedCount = jsonConvert.convert<int>(
      json['m_currrent_promised_count']);
  if (mCurrrentPromisedCount != null) {
    collectionLogOtherOtherProfile.mCurrrentPromisedCount =
        mCurrrentPromisedCount;
  }
  final int? nCurrentBrokenCount = jsonConvert.convert<int>(
      json['n_current_broken_count']);
  if (nCurrentBrokenCount != null) {
    collectionLogOtherOtherProfile.nCurrentBrokenCount = nCurrentBrokenCount;
  }
  final int? oCurrentRefusedCount = jsonConvert.convert<int>(
      json['o_current_refused_count']);
  if (oCurrentRefusedCount != null) {
    collectionLogOtherOtherProfile.oCurrentRefusedCount = oCurrentRefusedCount;
  }
  final int? pTodayCurrentRepayCount = jsonConvert.convert<int>(
      json['p_today_current_repay_count']);
  if (pTodayCurrentRepayCount != null) {
    collectionLogOtherOtherProfile.pTodayCurrentRepayCount =
        pTodayCurrentRepayCount;
  }
  final int? rTodayCurrentRepayAmount = jsonConvert.convert<int>(
      json['r_today_current_repay_amount']);
  if (rTodayCurrentRepayAmount != null) {
    collectionLogOtherOtherProfile.rTodayCurrentRepayAmount =
        rTodayCurrentRepayAmount;
  }
  final int? tTodayLv1Commission = jsonConvert.convert<int>(
      json['t_today_lv1_commission']);
  if (tTodayLv1Commission != null) {
    collectionLogOtherOtherProfile.tTodayLv1Commission = tTodayLv1Commission;
  }
  final int? uTodayLv2Commission = jsonConvert.convert<int>(
      json['u_today_lv2_commission']);
  if (uTodayLv2Commission != null) {
    collectionLogOtherOtherProfile.uTodayLv2Commission = uTodayLv2Commission;
  }
  final int? vTodayLv3Commission = jsonConvert.convert<int>(
      json['v_today_lv3_commission']);
  if (vTodayLv3Commission != null) {
    collectionLogOtherOtherProfile.vTodayLv3Commission = vTodayLv3Commission;
  }
  final int? wTodayLv4Commission = jsonConvert.convert<int>(
      json['w_today_lv4_commission']);
  if (wTodayLv4Commission != null) {
    collectionLogOtherOtherProfile.wTodayLv4Commission = wTodayLv4Commission;
  }
  final int? xTodayInitCount = jsonConvert.convert<int>(
      json['x_today_init_count']);
  if (xTodayInitCount != null) {
    collectionLogOtherOtherProfile.xTodayInitCount = xTodayInitCount;
  }
  final String? yFirstLogAt = jsonConvert.convert<String>(
      json['y_first_log_at']);
  if (yFirstLogAt != null) {
    collectionLogOtherOtherProfile.yFirstLogAt = yFirstLogAt;
  }
  final String? zLastLogAt = jsonConvert.convert<String>(json['z_last_log_at']);
  if (zLastLogAt != null) {
    collectionLogOtherOtherProfile.zLastLogAt = zLastLogAt;
  }
  final int? aAWeekLv1Commission = jsonConvert.convert<int>(
      json['a_a_week_lv1_commission']);
  if (aAWeekLv1Commission != null) {
    collectionLogOtherOtherProfile.aAWeekLv1Commission = aAWeekLv1Commission;
  }
  final int? aBWeekLv2Commission = jsonConvert.convert<int>(
      json['a_b_week_lv2_commission']);
  if (aBWeekLv2Commission != null) {
    collectionLogOtherOtherProfile.aBWeekLv2Commission = aBWeekLv2Commission;
  }
  final int? aCWeekLv3Commission = jsonConvert.convert<int>(
      json['a_c_week_lv3_commission']);
  if (aCWeekLv3Commission != null) {
    collectionLogOtherOtherProfile.aCWeekLv3Commission = aCWeekLv3Commission;
  }
  final int? aDWeekLv4Commission = jsonConvert.convert<int>(
      json['a_d_week_lv4_commission']);
  if (aDWeekLv4Commission != null) {
    collectionLogOtherOtherProfile.aDWeekLv4Commission = aDWeekLv4Commission;
  }
  final int? aETodayCommissionRate = jsonConvert.convert<int>(
      json['a_e_today_commission_rate']);
  if (aETodayCommissionRate != null) {
    collectionLogOtherOtherProfile.aETodayCommissionRate =
        aETodayCommissionRate;
  }
  final String? aFLastCallAt = jsonConvert.convert<String>(
      json['a_f_last_call_at']);
  if (aFLastCallAt != null) {
    collectionLogOtherOtherProfile.aFLastCallAt = aFLastCallAt;
  }
  final int? aGCollectionCommissionNewCount = jsonConvert.convert<int>(
      json['a_g_collection_commission_new_count']);
  if (aGCollectionCommissionNewCount != null) {
    collectionLogOtherOtherProfile.aGCollectionCommissionNewCount =
        aGCollectionCommissionNewCount;
  }
  final int? aHCollectionNotificationCount = jsonConvert.convert<int>(
      json['a_h_collection_notification_count']);
  if (aHCollectionNotificationCount != null) {
    collectionLogOtherOtherProfile.aHCollectionNotificationCount =
        aHCollectionNotificationCount;
  }
  final int? aIWeekRepayCount = jsonConvert.convert<int>(
      json['a_i_week_repay_count']);
  if (aIWeekRepayCount != null) {
    collectionLogOtherOtherProfile.aIWeekRepayCount = aIWeekRepayCount;
  }
  final int? aJWeekCommission = jsonConvert.convert<int>(
      json['a_j_week_commission']);
  if (aJWeekCommission != null) {
    collectionLogOtherOtherProfile.aJWeekCommission = aJWeekCommission;
  }
  final int? aKMonthRepayCount = jsonConvert.convert<int>(
      json['a_k_month_repay_count']);
  if (aKMonthRepayCount != null) {
    collectionLogOtherOtherProfile.aKMonthRepayCount = aKMonthRepayCount;
  }
  final int? aLMonthCommission = jsonConvert.convert<int>(
      json['a_l_month_commission']);
  if (aLMonthCommission != null) {
    collectionLogOtherOtherProfile.aLMonthCommission = aLMonthCommission;
  }
  final int? aMTodayCommission = jsonConvert.convert<int>(
      json['a_m_today_commission']);
  if (aMTodayCommission != null) {
    collectionLogOtherOtherProfile.aMTodayCommission = aMTodayCommission;
  }
  final int? aNMonthLv1Days = jsonConvert.convert<int>(
      json['a_n_month_lv1_days']);
  if (aNMonthLv1Days != null) {
    collectionLogOtherOtherProfile.aNMonthLv1Days = aNMonthLv1Days;
  }
  final int? aOMonthLv2Days = jsonConvert.convert<int>(
      json['a_o_month_lv2_days']);
  if (aOMonthLv2Days != null) {
    collectionLogOtherOtherProfile.aOMonthLv2Days = aOMonthLv2Days;
  }
  final int? aPMonthLv3Days = jsonConvert.convert<int>(
      json['a_p_month_lv3_days']);
  if (aPMonthLv3Days != null) {
    collectionLogOtherOtherProfile.aPMonthLv3Days = aPMonthLv3Days;
  }
  final int? aQMonthLv4Days = jsonConvert.convert<int>(
      json['a_q_month_lv4_days']);
  if (aQMonthLv4Days != null) {
    collectionLogOtherOtherProfile.aQMonthLv4Days = aQMonthLv4Days;
  }
  final int? aRTodayPartCount = jsonConvert.convert<int>(
      json['a_r_today_part_count']);
  if (aRTodayPartCount != null) {
    collectionLogOtherOtherProfile.aRTodayPartCount = aRTodayPartCount;
  }
  final int? aSTodayPartAmount = jsonConvert.convert<int>(
      json['a_s_today_part_amount']);
  if (aSTodayPartAmount != null) {
    collectionLogOtherOtherProfile.aSTodayPartAmount = aSTodayPartAmount;
  }
  final int? aTTodaySmsCount = jsonConvert.convert<int>(
      json['a_t_today_sms_count']);
  if (aTTodaySmsCount != null) {
    collectionLogOtherOtherProfile.aTTodaySmsCount = aTTodaySmsCount;
  }
  final int? aUTodayCallCount = jsonConvert.convert<int>(
      json['a_u_today_call_count']);
  if (aUTodayCallCount != null) {
    collectionLogOtherOtherProfile.aUTodayCallCount = aUTodayCallCount;
  }
  final int? aVTodayLogCount = jsonConvert.convert<int>(
      json['a_v_today_log_count']);
  if (aVTodayLogCount != null) {
    collectionLogOtherOtherProfile.aVTodayLogCount = aVTodayLogCount;
  }
  final int? aWWeekSmsCount = jsonConvert.convert<int>(
      json['a_w_week_sms_count']);
  if (aWWeekSmsCount != null) {
    collectionLogOtherOtherProfile.aWWeekSmsCount = aWWeekSmsCount;
  }
  final int? aXWeekCallCount = jsonConvert.convert<int>(
      json['a_x_week_call_count']);
  if (aXWeekCallCount != null) {
    collectionLogOtherOtherProfile.aXWeekCallCount = aXWeekCallCount;
  }
  final int? aYWeekLogCount = jsonConvert.convert<int>(
      json['a_y_week_log_count']);
  if (aYWeekLogCount != null) {
    collectionLogOtherOtherProfile.aYWeekLogCount = aYWeekLogCount;
  }
  final String? bAAvatar = jsonConvert.convert<String>(json['b_a_avatar']);
  if (bAAvatar != null) {
    collectionLogOtherOtherProfile.bAAvatar = bAAvatar;
  }
  final int? aZTodayNoLogCount = jsonConvert.convert<int>(
      json['a_z_today_no_log_count']);
  if (aZTodayNoLogCount != null) {
    collectionLogOtherOtherProfile.aZTodayNoLogCount = aZTodayNoLogCount;
  }
  final int? cATodayNoCallCount = jsonConvert.convert<int>(
      json['c_a_today_no_call_count']);
  if (cATodayNoCallCount != null) {
    collectionLogOtherOtherProfile.cATodayNoCallCount = cATodayNoCallCount;
  }
  final String? cBLastCall = jsonConvert.convert<String>(json['c_b_last_call']);
  if (cBLastCall != null) {
    collectionLogOtherOtherProfile.cBLastCall = cBLastCall;
  }
  final dynamic cCReviewingCount = json['c_c_reviewing_count'];
  if (cCReviewingCount != null) {
    collectionLogOtherOtherProfile.cCReviewingCount = cCReviewingCount;
  }
  final int? cDTodayAdditionCount = jsonConvert.convert<int>(
      json['c_d_today_addition_count']);
  if (cDTodayAdditionCount != null) {
    collectionLogOtherOtherProfile.cDTodayAdditionCount = cDTodayAdditionCount;
  }
  final int? cETodayDeleteCount = jsonConvert.convert<int>(
      json['c_e_today_delete_count']);
  if (cETodayDeleteCount != null) {
    collectionLogOtherOtherProfile.cETodayDeleteCount = cETodayDeleteCount;
  }
  final String? updatedAt = jsonConvert.convert<String>(json['updated_at']);
  if (updatedAt != null) {
    collectionLogOtherOtherProfile.updatedAt = updatedAt;
  }
  return collectionLogOtherOtherProfile;
}

Map<String, dynamic> $CollectionLogOtherOtherProfileToJson(
    CollectionLogOtherOtherProfile entity) {
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
  data['updated_at'] = entity.updatedAt;
  return data;
}

extension CollectionLogOtherOtherProfileExtension on CollectionLogOtherOtherProfile {
  CollectionLogOtherOtherProfile copyWith({
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
    int? aBWeekLv2Commission,
    int? aCWeekLv3Commission,
    int? aDWeekLv4Commission,
    int? aETodayCommissionRate,
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
    dynamic cCReviewingCount,
    int? cDTodayAdditionCount,
    int? cETodayDeleteCount,
    String? updatedAt,
  }) {
    return CollectionLogOtherOtherProfile()
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
      ..updatedAt = updatedAt ?? this.updatedAt;
  }
}
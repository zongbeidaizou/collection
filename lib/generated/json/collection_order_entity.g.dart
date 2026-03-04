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
  final int? wViewTimes = jsonConvert.convert<int>(json['w_view_times']);
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
  final int? aACommission = jsonConvert.convert<int>(json['a_a_commission']);
  if (aACommission != null) {
    collectionOrderData.aACommission = aACommission;
  }
  final int? aBCurrentCommission = jsonConvert.convert<int>(
      json['a_b_current_commission']);
  if (aBCurrentCommission != null) {
    collectionOrderData.aBCurrentCommission = aBCurrentCommission;
  }
  final int? aCExpectCurrentCommission = jsonConvert.convert<int>(
      json['a_c_expect_current_commission']);
  if (aCExpectCurrentCommission != null) {
    collectionOrderData.aCExpectCurrentCommission = aCExpectCurrentCommission;
  }
  final String? aDLastLogTime = jsonConvert.convert<String>(
      json['a_d_last_log_time']);
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
  final int? aFS3CollectionAmount = jsonConvert.convert<int>(
      json['a_f_s3_collection_amount']);
  if (aFS3CollectionAmount != null) {
    collectionOrderData.aFS3CollectionAmount = aFS3CollectionAmount;
  }
  final int? aJProductId = jsonConvert.convert<int>(json['a_j_product_id']);
  if (aJProductId != null) {
    collectionOrderData.aJProductId = aJProductId;
  }
  final String? aKNo = jsonConvert.convert<String>(json['a_k_no']);
  if (aKNo != null) {
    collectionOrderData.aKNo = aKNo;
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
  data['a_f_s3_collection_amount'] = entity.aFS3CollectionAmount;
  data['a_j_product_id'] = entity.aJProductId;
  data['a_k_no'] = entity.aKNo;
  data['a_l_last_log'] = entity.aLLastLog;
  data['a_n_current_day_log_count'] = entity.aNCurrentDayLogCount;
  data['a_o_current_day_call_count'] = entity.aOCurrentDayCallCount;
  data['a_v_tmp_collection_admin_id'] = entity.aVTmpCollectionAdminId;
  data['a_z_package'] = entity.aZPackage;
  data['a_a_a_a_a_q_b_periods'] = entity.aAAAAQBPeriods?.toJson();
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
    int? wViewTimes,
    int? xCurrentViewTimes,
    int? yCurrentLogCount,
    int? zCurrentCallCount,
    int? aACommission,
    int? aBCurrentCommission,
    int? aCExpectCurrentCommission,
    String? aDLastLogTime,
    int? aEBorrowCount,
    int? aFS0CollectionAmount,
    int? aGS1CollectionAmount,
    int? aHS2CollectionAmount,
    int? aFS3CollectionAmount,
    int? aJProductId,
    String? aKNo,
    String? aLLastLog,
    int? aNCurrentDayLogCount,
    int? aOCurrentDayCallCount,
    int? aVTmpCollectionAdminId,
    String? aZPackage,
    CollectionLogOtherPeriod? aAAAAQBPeriods,
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
      ..aFS3CollectionAmount = aFS3CollectionAmount ?? this.aFS3CollectionAmount
      ..aJProductId = aJProductId ?? this.aJProductId
      ..aKNo = aKNo ?? this.aKNo
      ..aLLastLog = aLLastLog ?? this.aLLastLog
      ..aNCurrentDayLogCount = aNCurrentDayLogCount ?? this.aNCurrentDayLogCount
      ..aOCurrentDayCallCount = aOCurrentDayCallCount ??
          this.aOCurrentDayCallCount
      ..aVTmpCollectionAdminId = aVTmpCollectionAdminId ??
          this.aVTmpCollectionAdminId
      ..aZPackage = aZPackage ?? this.aZPackage
      ..aAAAAQBPeriods = aAAAAQBPeriods ?? this.aAAAAQBPeriods;
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
  return collectionOrderOther;
}

Map<String, dynamic> $CollectionOrderOtherToJson(CollectionOrderOther entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['progress'] = entity.progress?.toJson();
  data['profile'] = entity.profile?.toJson();
  return data;
}

extension CollectionOrderOtherExtension on CollectionOrderOther {
  CollectionOrderOther copyWith({
    CollectionOrderOtherProgress? progress,
    CollectionOrderOtherProfile? profile,
  }) {
    return CollectionOrderOther()
      ..progress = progress ?? this.progress
      ..profile = profile ?? this.profile;
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
  final int? nextAdditionBonus = jsonConvert.convert<int>(
      json['nextAdditionBonus']);
  if (nextAdditionBonus != null) {
    collectionOrderOtherProgress.nextAdditionBonus = nextAdditionBonus;
  }
  final double? currentPoint = jsonConvert.convert<double>(
      json['currentPoint']);
  if (currentPoint != null) {
    collectionOrderOtherProgress.currentPoint = currentPoint;
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
  data['nextAdditionBonus'] = entity.nextAdditionBonus;
  data['currentPoint'] = entity.currentPoint;
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
    int? nextAdditionBonus,
    double? currentPoint,
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
      ..nextAdditionBonus = nextAdditionBonus ?? this.nextAdditionBonus
      ..currentPoint = currentPoint ?? this.currentPoint;
  }
}

CollectionOrderOtherProgressLevelProgress $CollectionOrderOtherProgressLevelProgressFromJson(
    Map<String, dynamic> json) {
  final CollectionOrderOtherProgressLevelProgress collectionOrderOtherProgressLevelProgress = CollectionOrderOtherProgressLevelProgress();
  final String? level = jsonConvert.convert<String>(json['level']);
  if (level != null) {
    collectionOrderOtherProgressLevelProgress.level = level;
  }
  final int? type = jsonConvert.convert<int>(json['type']);
  if (type != null) {
    collectionOrderOtherProgressLevelProgress.type = type;
  }
  return collectionOrderOtherProgressLevelProgress;
}

Map<String, dynamic> $CollectionOrderOtherProgressLevelProgressToJson(
    CollectionOrderOtherProgressLevelProgress entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['level'] = entity.level;
  data['type'] = entity.type;
  return data;
}

extension CollectionOrderOtherProgressLevelProgressExtension on CollectionOrderOtherProgressLevelProgress {
  CollectionOrderOtherProgressLevelProgress copyWith({
    String? level,
    int? type,
  }) {
    return CollectionOrderOtherProgressLevelProgress()
      ..level = level ?? this.level
      ..type = type ?? this.type;
  }
}

CollectionOrderOtherProgressAmountProgress $CollectionOrderOtherProgressAmountProgressFromJson(
    Map<String, dynamic> json) {
  final CollectionOrderOtherProgressAmountProgress collectionOrderOtherProgressAmountProgress = CollectionOrderOtherProgressAmountProgress();
  final int? amount = jsonConvert.convert<int>(json['amount']);
  if (amount != null) {
    collectionOrderOtherProgressAmountProgress.amount = amount;
  }
  final int? type = jsonConvert.convert<int>(json['type']);
  if (type != null) {
    collectionOrderOtherProgressAmountProgress.type = type;
  }
  return collectionOrderOtherProgressAmountProgress;
}

Map<String, dynamic> $CollectionOrderOtherProgressAmountProgressToJson(
    CollectionOrderOtherProgressAmountProgress entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['amount'] = entity.amount;
  data['type'] = entity.type;
  return data;
}

extension CollectionOrderOtherProgressAmountProgressExtension on CollectionOrderOtherProgressAmountProgress {
  CollectionOrderOtherProgressAmountProgress copyWith({
    int? amount,
    int? type,
  }) {
    return CollectionOrderOtherProgressAmountProgress()
      ..amount = amount ?? this.amount
      ..type = type ?? this.type;
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
  final int? aAMonthLv1Commission = jsonConvert.convert<int>(
      json['a_a_month_lv1_commission']);
  if (aAMonthLv1Commission != null) {
    collectionOrderOtherProfile.aAMonthLv1Commission = aAMonthLv1Commission;
  }
  final int? aBMonthLv2Commission = jsonConvert.convert<int>(
      json['a_b_month_lv2_commission']);
  if (aBMonthLv2Commission != null) {
    collectionOrderOtherProfile.aBMonthLv2Commission = aBMonthLv2Commission;
  }
  final int? aCMonthLv3Commission = jsonConvert.convert<int>(
      json['a_c_month_lv3_commission']);
  if (aCMonthLv3Commission != null) {
    collectionOrderOtherProfile.aCMonthLv3Commission = aCMonthLv3Commission;
  }
  final int? aDMonthLv4Commission = jsonConvert.convert<int>(
      json['a_d_month_lv4_commission']);
  if (aDMonthLv4Commission != null) {
    collectionOrderOtherProfile.aDMonthLv4Commission = aDMonthLv4Commission;
  }
  final double? aETodayCommissionRate = jsonConvert.convert<double>(
      json['a_e_today_commission_rate']);
  if (aETodayCommissionRate != null) {
    collectionOrderOtherProfile.aETodayCommissionRate = aETodayCommissionRate;
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
  final int? cCReviewingCount = jsonConvert.convert<int>(json['a_j_week_rank']);
  if (cCReviewingCount != null) {
    collectionOrderOtherProfile.cCReviewingCount = cCReviewingCount;
  }
  final int? aJWeekRank = jsonConvert.convert<int>(json['c_c_reviewing_count']);
  if (aJWeekRank != null) {
    collectionOrderOtherProfile.aJWeekRank = aJWeekRank;
  }
  final String? updatedAt = jsonConvert.convert<String>(json['updated_at']);
  if (updatedAt != null) {
    collectionOrderOtherProfile.updatedAt = updatedAt;
  }
  final String? aFLastCallAt = jsonConvert.convert<String>(
      json['a_f_last_call_at']);
  if (aFLastCallAt != null) {
    collectionOrderOtherProfile.aFLastCallAt = aFLastCallAt;
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
  data['a_a_month_lv1_commission'] = entity.aAMonthLv1Commission;
  data['a_b_month_lv2_commission'] = entity.aBMonthLv2Commission;
  data['a_c_month_lv3_commission'] = entity.aCMonthLv3Commission;
  data['a_d_month_lv4_commission'] = entity.aDMonthLv4Commission;
  data['a_e_today_commission_rate'] = entity.aETodayCommissionRate;
  data['a_g_collection_commission_new_count'] =
      entity.aGCollectionCommissionNewCount;
  data['a_h_collection_notification_count'] =
      entity.aHCollectionNotificationCount;
  data['a_i_week_repay_count'] = entity.aIWeekRepayCount;
  data['a_j_week_rank'] = entity.cCReviewingCount;
  data['c_c_reviewing_count'] = entity.aJWeekRank;
  data['updated_at'] = entity.updatedAt;
  data['a_f_last_call_at'] = entity.aFLastCallAt;
  data['c_f_week_reg_cnt'] = entity.cFWeekRegCnt;
  data['c_g_week_apply_cnt'] = entity.cGWeekApplyCnt;
  data['c_h_week_waive_left_cnt'] = entity.cHWeekWaiveLeftCnt;
  data['c_i_week_block_left_cnt'] = entity.cIWeekBlockLeftCnt;
  data['c_j_week_wa_left_cnt'] = entity.cJWeekWaLeftCnt;
  data['c_k_day_wa_left_cnt'] = entity.cKDayWaLeftCnt;
  data['c_l_week_coupon_left_cnt'] = entity.cLWeekCouponLeftCnt;
  data['c_m_week_extend_left_cnt'] = entity.cMWeekExtendLeftCnt;
  data['c_n_week_extend_cnt'] = entity.cNWeekExtendCnt;
  data['c_o_month_extend_cnt'] = entity.cOMonthExtendCnt;
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
    int? aAMonthLv1Commission,
    int? aBMonthLv2Commission,
    int? aCMonthLv3Commission,
    int? aDMonthLv4Commission,
    double? aETodayCommissionRate,
    int? aGCollectionCommissionNewCount,
    int? aHCollectionNotificationCount,
    int? aIWeekRepayCount,
    int? cCReviewingCount,
    int? aJWeekRank,
    String? updatedAt,
    String? aFLastCallAt,
    int? cFWeekRegCnt,
    int? cGWeekApplyCnt,
    int? cHWeekWaiveLeftCnt,
    int? cIWeekBlockLeftCnt,
    int? cJWeekWaLeftCnt,
    int? cKDayWaLeftCnt,
    int? cLWeekCouponLeftCnt,
    int? cMWeekExtendLeftCnt,
    int? cNWeekExtendCnt,
    int? cOMonthExtendCnt,
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
      ..aAMonthLv1Commission = aAMonthLv1Commission ?? this.aAMonthLv1Commission
      ..aBMonthLv2Commission = aBMonthLv2Commission ?? this.aBMonthLv2Commission
      ..aCMonthLv3Commission = aCMonthLv3Commission ?? this.aCMonthLv3Commission
      ..aDMonthLv4Commission = aDMonthLv4Commission ?? this.aDMonthLv4Commission
      ..aETodayCommissionRate = aETodayCommissionRate ??
          this.aETodayCommissionRate
      ..aGCollectionCommissionNewCount = aGCollectionCommissionNewCount ??
          this.aGCollectionCommissionNewCount
      ..aHCollectionNotificationCount = aHCollectionNotificationCount ??
          this.aHCollectionNotificationCount
      ..aIWeekRepayCount = aIWeekRepayCount ?? this.aIWeekRepayCount
      ..cCReviewingCount = cCReviewingCount ?? this.cCReviewingCount
      ..aJWeekRank = aJWeekRank ?? this.aJWeekRank
      ..updatedAt = updatedAt ?? this.updatedAt
      ..aFLastCallAt = aFLastCallAt ?? this.aFLastCallAt
      ..cFWeekRegCnt = cFWeekRegCnt ?? this.cFWeekRegCnt
      ..cGWeekApplyCnt = cGWeekApplyCnt ?? this.cGWeekApplyCnt
      ..cHWeekWaiveLeftCnt = cHWeekWaiveLeftCnt ?? this.cHWeekWaiveLeftCnt
      ..cIWeekBlockLeftCnt = cIWeekBlockLeftCnt ?? this.cIWeekBlockLeftCnt
      ..cJWeekWaLeftCnt = cJWeekWaLeftCnt ?? this.cJWeekWaLeftCnt
      ..cKDayWaLeftCnt = cKDayWaLeftCnt ?? this.cKDayWaLeftCnt
      ..cLWeekCouponLeftCnt = cLWeekCouponLeftCnt ?? this.cLWeekCouponLeftCnt
      ..cMWeekExtendLeftCnt = cMWeekExtendLeftCnt ?? this.cMWeekExtendLeftCnt
      ..cNWeekExtendCnt = cNWeekExtendCnt ?? this.cNWeekExtendCnt
      ..cOMonthExtendCnt = cOMonthExtendCnt ?? this.cOMonthExtendCnt;
  }
}
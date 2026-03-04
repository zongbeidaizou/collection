import 'package:bounty_hunter/generated/json/base/json_field.dart';
import 'package:bounty_hunter/generated/json/collection_log_entity.g.dart';
import 'dart:convert';

// import 'collection_order_entity.dart';
import 'package:bounty_hunter/models/collection_order_entity.dart';
export 'package:bounty_hunter/generated/json/collection_log_entity.g.dart';

@JsonSerializable()
class CollectionLogEntity {
  bool? success = false;
  String? errorMessage = '';
  String? message = '';
  List<CollectionLogData>? data = [];
  CollectionLogOther? other;
  int? total = 0;
  int? currentPage = 0;
  int? perPage = 0;
  bool? hasMorePages = false;

  CollectionLogEntity();

  factory CollectionLogEntity.fromJson(Map<String, dynamic> json) =>
      $CollectionLogEntityFromJson(json);

  Map<String, dynamic> toJson() => $CollectionLogEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class CollectionLogData {
  int? id = 0;
  @JSONField(name: 'n_borrow_id')
  int? nBorrowId = 0;
  @JSONField(name: 'o_period_id')
  int? oPeriodId = 0;
  @JSONField(name: 'a_parent_id')
  int? aParentId = 0;
  @JSONField(name: 'p_collection_order_id')
  int? pCollectionOrderId = 0;
  @JSONField(name: 'e_collection_admin_id')
  int? eCollectionAdminId = 0;
  @JSONField(name: 'f_cat')
  int? fCat = 0;
  @JSONField(name: 'g_type')
  int? gType = 0;
  @JSONField(name: 'h_phone')
  String? hPhone = '';
  @JSONField(name: 'i_target')
  int? iTarget = 0;
  @JSONField(name: 'j_content')
  String? jContent = '';
  @JSONField(name: 'm_overdue_days')
  int? mOverdueDays = 0;
  @JSONField(name: 'k_promise_time')
  String kPromiseTime = '';
  @JSONField(name: 'q_sms_template_id')
  int? qSmsTemplateId = 0;
  @JSONField(name: 'r_contact_id')
  int? rContactId = 0;
  @JSONField(name: 's_borrow_sn')
  String? sBorrowSn = '';
  @JSONField(name: 'created_at')
  String? createdAt = '';

  CollectionLogData();

  factory CollectionLogData.fromJson(Map<String, dynamic> json) =>
      $CollectionLogDataFromJson(json);

  Map<String, dynamic> toJson() => $CollectionLogDataToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class CollectionLogOther {
  String? avatar = '';
  @JSONField(name: 'show_contact_days')
  int? showContactDays = 0;
  CollectionLogOtherTrack? track;
  CollectionLogOtherPeriod? period;
  @JSONField(name: 'repay_info')
  CollectionLogOtherRepayInfo? repayInfo;
  @JSONField(name: 'contact_info')
  List<CollectionLogOtherContactInfo2Data>? contactInfo = [];
  @JSONField(name: 'contact_info2')
  CollectionLogOtherContactInfo2? contactInfo2;
  @JSONField(name: 'sms_history')
  List<CollectionLogOtherSmsHistory>? smsHistory = [];
  @JSONField(name: 'h_j_sms_template_newest_updated_at')
  String? hJSmsTemplateNewestUpdatedAt = '';
  @JSONField(name: 'h_j_sms_template')
  List<CollectionLogOtherHJSmsTemplate>? hJSmsTemplate = [];
  CollectionOrderOther? other;
  @JSONField(name: 'last_contact_fetch_time')
  String? lastContactFetchTime = '';

  CollectionLogOther();

  factory CollectionLogOther.fromJson(Map<String, dynamic> json) =>
      $CollectionLogOtherFromJson(json);

  Map<String, dynamic> toJson() => $CollectionLogOtherToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class CollectionLogOtherTrack {
  @JSONField(name: 'last_active_time')
  String? lastActiveTime = '';
  @JSONField(name: 'apply_time')
  String? applyTime = '';
  @JSONField(name: 'borrow_amount')
  int? borrowAmount = 0;
  @JSONField(name: 'loan_time')
  String? loanTime = '';
  @JSONField(name: 'loan_bank')
  String? loanBank = '';
  @JSONField(name: 'loan_amount')
  int? loanAmount = 0;
  @JSONField(name: 'loan_active_time')
  String? loanActiveTime = '';

  CollectionLogOtherTrack();

  factory CollectionLogOtherTrack.fromJson(Map<String, dynamic> json) =>
      $CollectionLogOtherTrackFromJson(json);

  Map<String, dynamic> toJson() => $CollectionLogOtherTrackToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class CollectionLogOtherPeriod {
  int? id = 0;
  @JSONField(name: 'a_borrow_id')
  int? aBorrowId = 0;
  @JSONField(name: 'f_expect_repay_total_amount')
  int? fExpectRepayTotalAmount = 0;
  @JSONField(name: 'p_paid_interest')
  int? pPaidInterest = 0;
  @JSONField(name: 'q_paid_service_fee')
  int? qPaidServiceFee = 0;
  @JSONField(name: 's_paid_overdue_amount')
  int? sPaidOverdueAmount = 0;
  @JSONField(name: 'o_paid_borrow_amount')
  int? oPaidBorrowAmount = 0;
  @JSONField(name: 'g_expect_borrow_amount')
  int? gExpectBorrowAmount = 0;
  @JSONField(name: 'h_expect_interest')
  int? hExpectInterest = 0;
  @JSONField(name: 'n_paid_amount')
  int? nPaidAmount = 0;
  @JSONField(name: 'i_expect_service_fee')
  int? iExpectServiceFee = 0;
  @JSONField(name: 'j_expect_violate_fee')
  int? jExpectViolateFee = 0;
  @JSONField(name: 'k_expect_overdue_amount')
  int? kExpectOverdueAmount = 0;
  @JSONField(name: 'l_overdue_days')
  int? lOverdueDays = 0;
  @JSONField(name: 't_deduction_times')
  int? tDeductionTimes = 0;
  @JSONField(name: 'u_deduction_total_amount')
  int? uDeductionTotalAmount = 0;
  @JSONField(name: 'a_h_part_times')
  int? aHPartTimes = 0;
  @JSONField(name: 'a_n_user_id')
  int? aNUserId = 0;
  @JSONField(name: 'a_p_expect_repay_time')
  String? aPExpectRepayTime = '';
  @JSONField(name: 'a_u_current_deduction_fee')
  int? aUCurrentDeductionFee = 0;
  @JSONField(name: 'a_z_left_amount')
  int? aZLeftAmount = 0;
  @JSONField(name: 'z_deduction_total_overdue_amount')
  int? zDeductionTotalOverdueAmount = 0;
  @JSONField(name: 'b_b_coupon_amount')
  int? bBCouponAmount = 0;  
  @JSONField(name: 'b_c_borrow_count')
  int? bCCouponAmount = 0;    

  CollectionLogOtherPeriod();

  factory CollectionLogOtherPeriod.fromJson(Map<String, dynamic> json) =>
      $CollectionLogOtherPeriodFromJson(json);

  Map<String, dynamic> toJson() => $CollectionLogOtherPeriodToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class CollectionLogOtherRepayInfo {
  @JSONField(name: 'expect_repay_amount')
  int? expectRepayAmount = 0;
  @JSONField(name: 'expect_repay_time')
  String? expectRepayTime = '';
  @JSONField(name: 'overdue_days')
  int? overdueDays = 0;
  String? mobile = '';
  String? phone = '';
  String? bvn = '';
  String? name = '';
  @JSONField(name: 'borrow_amount')
  int? borrowAmount = 0;
  @JSONField(name: 'loan_amount')
  int? loanAmount = 0;
  @JSONField(name: 'borrow_days')
  int? borrowDays = 0;
  @JSONField(name: 'app_name')
  String? appName = '';
  String? url = '';
  @JSONField(name: 'product_name')
  String? productName = '';
  @JSONField(name: 'loan_time')
  String? loanTime = '';
  @JSONField(name: 'receive_bank')
  String? receiveBank = '';
  @JSONField(name: 'receive_bank_no')
  String? receiveBankNo = '';
  @JSONField(name: 'account_name')
  String? accountName = '';
  @JSONField(name: 'account_no')
  String? accountNo = '';
  @JSONField(name: 'account_bank')
  String? accountBank = '';
  @JSONField(name: 'before_credit_amount')
  String? beforeCreditAmount = '';
  @JSONField(name: 'after_credit_amount')
  String? afterCreditAmount = '';
  @JSONField(name: 'change_credit_amount')
  String? changeCreditAmount = '';
  @JSONField(name: 'before_credit_fraction')
  String? beforeCreditFraction = '';
  @JSONField(name: 'after_credit_fraction')
  String? afterCreditFraction = '';
  @JSONField(name: 'change_credit_fraction')
  String? changeCreditFraction = '';
  String? var1 = '';
  String? var2 = '';
  String? var3 = '';
  String? var4 = '';
  String? var5 = '';
  String? var6 = '';
  String? var7 = '';
  String? var8 = '';
  String? var9 = '';
  String? var10 = '';

  CollectionLogOtherRepayInfo();

  factory CollectionLogOtherRepayInfo.fromJson(Map<String, dynamic> json) =>
      $CollectionLogOtherRepayInfoFromJson(json);

  Map<String, dynamic> toJson() => $CollectionLogOtherRepayInfoToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class CollectionLogOtherContactInfo2 {
  @JSONField(name: 'current_page')
  int? currentPage = 0;
  List<CollectionLogOtherContactInfo2Data>? data = [];
  @JSONField(name: 'first_page_url')
  String? firstPageUrl = '';
  int? from = 0;
  @JSONField(name: 'last_page')
  int? lastPage = 0;
  @JSONField(name: 'last_page_url')
  String? lastPageUrl = '';
  List<CollectionLogOtherContactInfo2Links>? links = [];
  @JSONField(name: 'next_page_url')
  dynamic nextPageUrl;
  String? path = '';
  @JSONField(name: 'per_page')
  int? perPage = 0;
  @JSONField(name: 'prev_page_url')
  dynamic prevPageUrl;
  int? to = 0;
  int? total = 0;

  CollectionLogOtherContactInfo2();

  factory CollectionLogOtherContactInfo2.fromJson(Map<String, dynamic> json) =>
      $CollectionLogOtherContactInfo2FromJson(json);

  Map<String, dynamic> toJson() => $CollectionLogOtherContactInfo2ToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class CollectionLogOtherContactInfo2Data {
  int? id = 0;
  @JSONField(name: 'c_relation')
  String? cRelation = '';
  @JSONField(name: 'f_name')
  String? fName = '';
  @JSONField(name: 'g_phone')
  String? gPhone = '';
  @JSONField(name: 'l_sms_count')
  int? lSmsCount = 0;
  @JSONField(name: 'm_relation_level')
  int? mRelationLevel = 0;
  @JSONField(name: 'q_phone_status')
  int? qPhoneStatus = 0;
  @JSONField(name: 'r_wa_status')
  int? rWaStatus = 0;
  @JSONField(name: 't_wa_weight')
  int? tWaWeight = 0;
  @JSONField(name: 'a_a_a_a_a_h_l_contact_weights')
  CollectionLogOtherContactInfo2DataAAAAAHLContactWeights?
      aAAAAHLContactWeights;

  CollectionLogOtherContactInfo2Data();

  factory CollectionLogOtherContactInfo2Data.fromJson(
          Map<String, dynamic> json) =>
      $CollectionLogOtherContactInfo2DataFromJson(json);

  Map<String, dynamic> toJson() =>
      $CollectionLogOtherContactInfo2DataToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class CollectionLogOtherContactInfo2DataAAAAAHLContactWeights {
  int? id = 0;
  @JSONField(name: 'a_contact_id')
  int? aContactId = 0;
  @JSONField(name: 'c_collection_admin_id')
  int? cCollectionAdminId = 0;
  @JSONField(name: 'd_call_times')
  int? dCallTimes = 0;
  @JSONField(name: 'e_last_call_time')
  String? eLastCallTime = '';
  @JSONField(name: 'l_sms_count')
  int? lSmsCount = 0;
  @JSONField(name: 'q_phone_status')
  int? qPhoneStatus = 0;
  @JSONField(name: 'r_wa_status')
  int? rWaStatus = 0;
  @JSONField(name: 's_phone_weight')
  int? sPhoneWeight = 0;
  @JSONField(name: 't_wa_weight')
  int? tWaWeight = 0;
  @JSONField(name: 'u_sms_last_at')
  String? uSmsLastAt = '';
  @JSONField(name: 'v_wa_last_at')
  String? vWaLastAt = '';
  @JSONField(name: 'w_wa_ct')
  int? wWaCt = 0;
  @JSONField(name: 'x_comment')
  String? xComment = '';

  CollectionLogOtherContactInfo2DataAAAAAHLContactWeights();

  factory CollectionLogOtherContactInfo2DataAAAAAHLContactWeights.fromJson(
          Map<String, dynamic> json) =>
      $CollectionLogOtherContactInfo2DataAAAAAHLContactWeightsFromJson(json);

  Map<String, dynamic> toJson() =>
      $CollectionLogOtherContactInfo2DataAAAAAHLContactWeightsToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class CollectionLogOtherContactInfo2Links {
  String? url = '';
  String? label = '';
  bool? active = false;

  CollectionLogOtherContactInfo2Links();

  factory CollectionLogOtherContactInfo2Links.fromJson(
          Map<String, dynamic> json) =>
      $CollectionLogOtherContactInfo2LinksFromJson(json);

  Map<String, dynamic> toJson() =>
      $CollectionLogOtherContactInfo2LinksToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class CollectionLogOtherSmsHistory {
  @JSONField(name: 'c_admin_id')
  int? cAdminId = 0;
  @JSONField(name: 'f_to')
  String? fTo = '';
  @JSONField(name: 'g_text')
  String? gText = '';
  @JSONField(name: 'k_send_status')
  int? kSendStatus = 0;
  @JSONField(name: 'created_at')
  String? createdAt = '';
  int? id = 0;

  CollectionLogOtherSmsHistory();

  factory CollectionLogOtherSmsHistory.fromJson(Map<String, dynamic> json) =>
      $CollectionLogOtherSmsHistoryFromJson(json);

  Map<String, dynamic> toJson() => $CollectionLogOtherSmsHistoryToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class CollectionLogOtherHJSmsTemplate {
  int? id = 0;
  @JSONField(name: 'd_template')
  String? dTemplate = '';
  @JSONField(name: 's_name')
  String? sName = '';
  @JSONField(name: 'c_type')
  int? cType = 0;
  @JSONField(name: 'e_days')
  String? eDays = '';

  CollectionLogOtherHJSmsTemplate();

  factory CollectionLogOtherHJSmsTemplate.fromJson(Map<String, dynamic> json) =>
      $CollectionLogOtherHJSmsTemplateFromJson(json);

  Map<String, dynamic> toJson() => $CollectionLogOtherHJSmsTemplateToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class CollectionLogOtherOther {
  CollectionLogOtherOtherProgress? progress;
  CollectionLogOtherOtherProfile? profile;
  List<dynamic>? monthAdditionData = [];

  CollectionLogOtherOther();

  factory CollectionLogOtherOther.fromJson(Map<String, dynamic> json) =>
      $CollectionLogOtherOtherFromJson(json);

  Map<String, dynamic> toJson() => $CollectionLogOtherOtherToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class CollectionLogOtherOtherProgress {
  List<int>? points = [];
  List<int>? counts = [];
  List<String>? grades = [];
  List<String>? commissionRates = [];
  String? currentGrade = '';
  String? currentRate = '';
  String? nextGrade = '';
  String? nextRate = '';
  int? more = 0;
  int? currentPoint = 0;
  int? nextAdditionBonus = 0;

  CollectionLogOtherOtherProgress();

  factory CollectionLogOtherOtherProgress.fromJson(Map<String, dynamic> json) =>
      $CollectionLogOtherOtherProgressFromJson(json);

  Map<String, dynamic> toJson() => $CollectionLogOtherOtherProgressToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class CollectionLogOtherOtherProfile {
  int? id = 0;
  @JSONField(name: 'a_name')
  String? aName = '';
  @JSONField(name: 'b_admin_id')
  int? bAdminId = 0;
  @JSONField(name: 'c_collection_agency_id')
  int? cCollectionAgencyId = 0;
  @JSONField(name: 'd_collection_group_id')
  int? dCollectionGroupId = 0;
  @JSONField(name: 'e_collection_stages')
  String? eCollectionStages = '';
  @JSONField(name: 'f_status')
  int? fStatus = 0;
  @JSONField(name: 'g_comment')
  String? gComment = '';
  @JSONField(name: 'h_collection_ing_order_count')
  int? hCollectionIngOrderCount = 0;
  @JSONField(name: 'i_today_current_kpi_level')
  int? iTodayCurrentKpiLevel = 0;
  @JSONField(name: 'j_today_init_amount')
  int? jTodayInitAmount = 0;
  @JSONField(name: 'k_current_new_count')
  int? kCurrentNewCount = 0;
  @JSONField(name: 'l_current_negotiating_count')
  int? lCurrentNegotiatingCount = 0;
  @JSONField(name: 'm_currrent_promised_count')
  int? mCurrrentPromisedCount = 0;
  @JSONField(name: 'n_current_broken_count')
  int? nCurrentBrokenCount = 0;
  @JSONField(name: 'o_current_refused_count')
  int? oCurrentRefusedCount = 0;
  @JSONField(name: 'p_today_current_repay_count')
  int? pTodayCurrentRepayCount = 0;
  @JSONField(name: 'r_today_current_repay_amount')
  int? rTodayCurrentRepayAmount = 0;
  @JSONField(name: 't_today_lv1_commission')
  int? tTodayLv1Commission = 0;
  @JSONField(name: 'u_today_lv2_commission')
  int? uTodayLv2Commission = 0;
  @JSONField(name: 'v_today_lv3_commission')
  int? vTodayLv3Commission = 0;
  @JSONField(name: 'w_today_lv4_commission')
  int? wTodayLv4Commission = 0;
  @JSONField(name: 'x_today_init_count')
  int? xTodayInitCount = 0;
  @JSONField(name: 'y_first_log_at')
  String? yFirstLogAt = '';
  @JSONField(name: 'z_last_log_at')
  String? zLastLogAt = '';
  @JSONField(name: 'a_a_week_lv1_commission')
  int? aAWeekLv1Commission = 0;
  @JSONField(name: 'a_b_week_lv2_commission')
  int? aBWeekLv2Commission = 0;
  @JSONField(name: 'a_c_week_lv3_commission')
  int? aCWeekLv3Commission = 0;
  @JSONField(name: 'a_d_week_lv4_commission')
  int? aDWeekLv4Commission = 0;
  @JSONField(name: 'a_e_today_commission_rate')
  int? aETodayCommissionRate = 0;
  @JSONField(name: 'a_f_last_call_at')
  String? aFLastCallAt = '';
  @JSONField(name: 'a_g_collection_commission_new_count')
  int? aGCollectionCommissionNewCount = 0;
  @JSONField(name: 'a_h_collection_notification_count')
  int? aHCollectionNotificationCount = 0;
  @JSONField(name: 'a_i_week_repay_count')
  int? aIWeekRepayCount = 0;
  @JSONField(name: 'a_j_week_commission')
  int? aJWeekCommission = 0;
  @JSONField(name: 'a_k_month_repay_count')
  int? aKMonthRepayCount = 0;
  @JSONField(name: 'a_l_month_commission')
  int? aLMonthCommission = 0;
  @JSONField(name: 'a_m_today_commission')
  int? aMTodayCommission = 0;
  @JSONField(name: 'a_n_month_lv1_days')
  int? aNMonthLv1Days = 0;
  @JSONField(name: 'a_o_month_lv2_days')
  int? aOMonthLv2Days = 0;
  @JSONField(name: 'a_p_month_lv3_days')
  int? aPMonthLv3Days = 0;
  @JSONField(name: 'a_q_month_lv4_days')
  int? aQMonthLv4Days = 0;
  @JSONField(name: 'a_r_today_part_count')
  int? aRTodayPartCount = 0;
  @JSONField(name: 'a_s_today_part_amount')
  int? aSTodayPartAmount = 0;
  @JSONField(name: 'a_t_today_sms_count')
  int? aTTodaySmsCount = 0;
  @JSONField(name: 'a_u_today_call_count')
  int? aUTodayCallCount = 0;
  @JSONField(name: 'a_v_today_log_count')
  int? aVTodayLogCount = 0;
  @JSONField(name: 'a_w_week_sms_count')
  int? aWWeekSmsCount = 0;
  @JSONField(name: 'a_x_week_call_count')
  int? aXWeekCallCount = 0;
  @JSONField(name: 'a_y_week_log_count')
  int? aYWeekLogCount = 0;
  @JSONField(name: 'b_a_avatar')
  String? bAAvatar = '';
  @JSONField(name: 'a_z_today_no_log_count')
  int? aZTodayNoLogCount = 0;
  @JSONField(name: 'c_a_today_no_call_count')
  int? cATodayNoCallCount = 0;
  @JSONField(name: 'c_b_last_call')
  String? cBLastCall = '';
  @JSONField(name: 'c_c_reviewing_count')
  dynamic cCReviewingCount;
  @JSONField(name: 'c_d_today_addition_count')
  int? cDTodayAdditionCount = 0;
  @JSONField(name: 'c_e_today_delete_count')
  int? cETodayDeleteCount = 0;
  @JSONField(name: 'updated_at')
  String? updatedAt = '';

  CollectionLogOtherOtherProfile();

  factory CollectionLogOtherOtherProfile.fromJson(Map<String, dynamic> json) =>
      $CollectionLogOtherOtherProfileFromJson(json);

  Map<String, dynamic> toJson() => $CollectionLogOtherOtherProfileToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

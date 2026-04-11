import 'package:bounty_hunter/generated/json/base/json_field.dart';
import 'package:bounty_hunter/generated/json/collection_order_entity.g.dart';
import 'dart:convert';
import 'collection_log_entity.dart';
export 'package:bounty_hunter/models/collection_log_entity.dart';

@JsonSerializable()
class CollectionOrderEntity {
	bool? success = false;
	String? errorMessage = '';
	String? message = '';
	List<CollectionOrderData>? data = [];
	CollectionOrderOther? other;
	int? total = 0;
	int? currentPage = 0;
	int? perPage = 0;
	bool? hasMorePages = false;

	CollectionOrderEntity();

	factory CollectionOrderEntity.fromJson(Map<String, dynamic> json) => $CollectionOrderEntityFromJson(json);

	Map<String, dynamic> toJson() => $CollectionOrderEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class CollectionOrderData {
	int? id = 0;
	@JSONField(name: 'a_borrow_id')
	int? aBorrowId = 0;
	@JSONField(name: 'e_collection_admin_id')
	int? eCollectionAdminId = 0;
	@JSONField(name: 'k_status')
	int? kStatus = 0;
	@JSONField(name: 'n_borrow_amount')
	int? nBorrowAmount = 0;
	@JSONField(name: 'o_period_index')
	int? oPeriodIndex = 0;
	@JSONField(name: 'p_expect_repay_time')
	String? pExpectRepayTime = '';
	@JSONField(name: 't_borrow_sn')
	String? tBorrowSn = '';
	@JSONField(name: 'u_phone')
	String? uPhone = '';
	@JSONField(name: 'v_name')
	String? vName = '';
	@JSONField(name: 'r_flow_in_time')
	String? rFlowInTime = '';  
	@JSONField(name: 's_flow_out_time')
	String? sFlowOutTime = '';
	@JSONField(name: 'a_k_no')
	String? aKNo = '';
	@JSONField(name: 'a_e_borrow_count')
	int? aEBorrowCount = 0;
	@JSONField(name: 'a_j_product_id')
	int? aJProductId = 0;
	@JSONField(name: 'a_l_last_log')
	String? aLLastLog = '';
	@JSONField(name: 'a_n_current_day_log_count')
	int? aNCurrentDayLogCount = 0;
	@JSONField(name: 'a_o_current_day_call_count')
	int? aOCurrentDayCallCount = 0;
	@JSONField(name: 'x_current_view_times')
	int? xCurrentViewTimes = 0;
	@JSONField(name: 'b_f_current_day_wa')
	int? bFCurrentDayWa = 0;    
	@JSONField(name: 'a_v_tmp_collection_admin_id')
	int? aVTmpCollectionAdminId = 0;
	@JSONField(name: 'a_z_package')
	String? aZPackage = '';
	@JSONField(name: 'a_d_last_log_time')
	String? aDLastLogTime = '';
	@JSONField(name: 'b_e_source_type')
	int? bESourceType = 0;
	@JSONField(name: 'b_d_overdue_days')
	int? bDOverdueDays = 0;
	@JSONField(name: 'b_b_has_retain')
	int? bBHasRetain = 0;
	@JSONField(name: 'a_a_a_a_a_q_b_periods')
	CollectionLogOtherPeriod? aAAAAQBPeriods;

	CollectionOrderData();

	factory CollectionOrderData.fromJson(Map<String, dynamic> json) => $CollectionOrderDataFromJson(json);

	Map<String, dynamic> toJson() => $CollectionOrderDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class CollectionOrderDataAAAAAQBPeriods {
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
	@JSONField(name: 'b_c_borrow_count')
	int? bCBorrowCount = 0;

	CollectionOrderDataAAAAAQBPeriods();

	factory CollectionOrderDataAAAAAQBPeriods.fromJson(Map<String, dynamic> json) => $CollectionOrderDataAAAAAQBPeriodsFromJson(json);

	Map<String, dynamic> toJson() => $CollectionOrderDataAAAAAQBPeriodsToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class CollectionOrderOther {
	CollectionOrderOtherProgress? progress;
	CollectionOrderOtherProfile? profile;
	List<dynamic>? monthAdditionData = [];
	List<CollectionOrderOtherAdditionBonus>? additionBonus = [];
	List<CollectionOrderOtherFines>? fines = [];
  String? latestVersion = '';

	CollectionOrderOther();

	factory CollectionOrderOther.fromJson(Map<String, dynamic> json) => $CollectionOrderOtherFromJson(json);

	Map<String, dynamic> toJson() => $CollectionOrderOtherToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class CollectionOrderOtherProgress {
	List<double>? points = [];
	List<int>? counts = [];
	List<String>? grades = [];
	List<String>? commissionRates = [];
	String? currentGrade = '';
	String? currentRate = '';
	String? nextGrade = '';
	String? nextRate = '';
	int? more = 0;
	double? currentPoint;
	int? nextAdditionBonus = 0;

	CollectionOrderOtherProgress();

	factory CollectionOrderOtherProgress.fromJson(Map<String, dynamic> json) => $CollectionOrderOtherProgressFromJson(json);

	Map<String, dynamic> toJson() => $CollectionOrderOtherProgressToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class CollectionOrderOtherProfile {
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
	double? aBWeekLv2Commission = 0;
	@JSONField(name: 'a_c_week_lv3_commission')
	int? aCWeekLv3Commission = 0;
	@JSONField(name: 'a_d_week_lv4_commission')
	int? aDWeekLv4Commission = 0;
	@JSONField(name: 'a_e_today_commission_rate')
	double? aETodayCommissionRate = 0;
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
	int? cCReviewingCount = 0;
	@JSONField(name: 'c_d_today_addition_count')
	int? cDTodayAdditionCount = 0;
	@JSONField(name: 'c_e_today_delete_count')
	int? cETodayDeleteCount = 0;
	@JSONField(name: 'c_f_week_reg_cnt')
	int? cFWeekRegCnt = 0;
	@JSONField(name: 'c_g_week_apply_cnt')
	int? cGWeekApplyCnt = 0;
	@JSONField(name: 'c_h_week_waive_left_cnt')
	int? cHWeekWaiveLeftCnt = 0;
	@JSONField(name: 'c_i_week_block_left_cnt')
	int? cIWeekBlockLeftCnt = 0;
	@JSONField(name: 'updated_at')
	String? updatedAt = '';
	@JSONField(name: 'c_j_week_wa_left_cnt')
	int? cJWeekWaLeftCnt = 0;
	@JSONField(name: 'c_k_day_wa_left_cnt')
	int? cKDayWaLeftCnt = 0;
	@JSONField(name: 'c_l_week_coupon_left_cnt')
	int? cLWeekCouponLeftCnt = 0;
	@JSONField(name: 'c_m_week_extend_left_cnt')
	int? cMWeekExtendLeftCnt = 0;
	@JSONField(name: 'c_n_week_extend_cnt')
	int? cNWeekExtendCnt = 0;
	@JSONField(name: 'c_o_month_extend_cnt')
	int? cOMonthExtendCnt = 0;
	@JSONField(name: 'c_p_week_retain_left_cnt')
	int? cPWeekRetainLeftCnt = 0;
	@JSONField(name: 'c_q_week_receive_left_cnt')
	int? cQWeekReceiveLeftCnt = 0;
	@JSONField(name: 'c_r_today_marketing_cnt')
	int? cRTodayMarketingCnt = 0;
  @JSONField(name: 'c_y_today_receive_count')
	int? cYTodayReceiveCount = 0;
  @JSONField(name: 'c_z_today_retain_count')
	int? cZTodayRetainCount = 0;
  @JSONField(name: 'd_a_today_system_count')
	int? dATodaySystemCount = 0;
  @JSONField(name: 'd_b_today_out_count')
	int? dBTodayOutCount = 0;
  @JSONField(name: 'd_c_today_marketing_count')
	int? dCTodayMarketingCount = 0;
  @JSONField(name: 'd_o_call_log_time')
	int? dOCallLogTime = 0;
         

	CollectionOrderOtherProfile();

	factory CollectionOrderOtherProfile.fromJson(Map<String, dynamic> json) => $CollectionOrderOtherProfileFromJson(json);

	Map<String, dynamic> toJson() => $CollectionOrderOtherProfileToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class CollectionOrderOtherAdditionBonus {
	@JSONField(name: 'overdue_days')
	List<int>? overdueDays = [];
	int? rate = 0;

	CollectionOrderOtherAdditionBonus();

	factory CollectionOrderOtherAdditionBonus.fromJson(Map<String, dynamic> json) => $CollectionOrderOtherAdditionBonusFromJson(json);

	Map<String, dynamic> toJson() => $CollectionOrderOtherAdditionBonusToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class CollectionOrderOtherFines {
	@JSONField(name: 'borrow_count')
	List<int>? borrowCount = [];
	List<int>? fines = [];

	CollectionOrderOtherFines();

	factory CollectionOrderOtherFines.fromJson(Map<String, dynamic> json) => $CollectionOrderOtherFinesFromJson(json);

	Map<String, dynamic> toJson() => $CollectionOrderOtherFinesToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}
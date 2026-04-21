import 'package:bounty_hunter/generated/json/base/json_field.dart';
import 'package:bounty_hunter/generated/json/shop_entity.g.dart';
import 'dart:convert';

import 'package:bounty_hunter/models/collection_order_entity.dart';

export 'package:bounty_hunter/generated/json/shop_entity.g.dart';

@JsonSerializable()
class ShopEntity {
	bool? success = false;
	ShopData? data;
	CollectionOrderOther? other;
	String? message = '';

	ShopEntity();

	factory ShopEntity.fromJson(Map<String, dynamic> json) => $ShopEntityFromJson(json);

	Map<String, dynamic> toJson() => $ShopEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ShopData {
	@JSONField(name: 'web_url')
	String? webUrl = '';
	@JSONField(name: 'show_month_data')
	bool? showMonthData = false;
	@JSONField(name: 'month_data')
	List<ShopDataMonthData>? monthData = [];
	@JSONField(name: 'show_month_repay_data')
	bool? showMonthRepayData = false;
	@JSONField(name: 'month_repay_data')
	List<ShopDataMonthData>? monthRepayData = [];
	@JSONField(name: 'show_month_addition_bonus_data')
	bool? showMonthAdditionBonusData = false;
	@JSONField(name: 'month_addition_bonus_data')
	List<ShopDataMonthData>? monthAdditionBonusData = [];  
	@JSONField(name: 'show_month_reg_bonus_data')
	bool? showMonthRegBonusData = false;
	@JSONField(name: 'month_reg_bonus_data')
	List<ShopDataMonthData>? monthRegBonusData = [];
	@JSONField(name: 'show_month_apply_bonus_data')
	bool? showMonthApplyBonusData = false;
	@JSONField(name: 'month_apply_bonus_data')
	List<ShopDataMonthData>? monthApplyBonusData = [];
	@JSONField(name: 'show_week_case_data')
	bool? showWeekCaseData = false;
	@JSONField(name: 'week_case_data')
	List<ShopDataWeekCaseData>? weekCaseData = [];
	@JSONField(name: 'show_week_bonus_data')
	bool? showWeekBonusData = false;
	@JSONField(name: 'week_bonus_data')
	List<ShopDataWeekBonusData>? weekBonusData = [];
	@JSONField(name: 'show_month_case_data')
	bool? showMonthCaseData = false;
	@JSONField(name: 'month_case_data')
	List<ShopDataMonthCaseData>? monthCaseData = [];
	@JSONField(name: 'show_month_bonus_data')
	bool? showMonthBonusData = false;
	@JSONField(name: 'month_bonus_data')
	List<ShopDataMonthBonusData>? monthBonusData = [];
	@JSONField(name: 'show_month_addition_data')
	bool? showMonthAdditionData = false;
	@JSONField(name: 'month_addition_data')
	List<ShopDataMonthAdditionData>? monthAdditionData = [];
	@JSONField(name: 'show_week_register_data')
	bool? showWeekRegisterData = false;
	@JSONField(name: 'week_register_data')
	List<ShopDataWeekCaseData>? weekRegisterData = [];
	@JSONField(name: 'show_week_apply_data')
	bool? showWeekApplyData = false;
	@JSONField(name: 'week_apply_data')
	List<ShopDataWeekCaseData>? weekApplyData = [];
	@JSONField(name: 'notification_data')
	List<String>? notificationData = [];
	@JSONField(name: 'notification_show_date')
	String? notificationShowDate = '';
	List<ShopDataTrends>? trends = [];
	@JSONField(name: 'manual_update_at')
	String? manualUpdateAt = '';
	@JSONField(name: 'salary_update_at')
	String? salaryUpdateAt = '';
	@JSONField(name: 'daily_update_at')
	String? dailyUpdateAt = '';
	@JSONField(name: 'template_update_at')
	String? templateUpdateAt = '';
	@JSONField(name: 'settomg_update_at')
	String? settomgUpdateAt = '';

  @JSONField(name: 'show_week_coupon_data')
	bool? showWeekCouponData = false;
	@JSONField(name: 'week_coupon_data')
	List<ShopDataWeekCaseData>? weekCouponData = [];

  	@JSONField(name: 'show_week_extend_data')
	bool? showWeekExtendData = false;
	@JSONField(name: 'week_extend_data')
	List<ShopDataWeekCaseData>? weekExtendData = [];

  	@JSONField(name: 'show_week_retain_data')
	bool? showWeekRetainData = false;
	@JSONField(name: 'week_retain_data')
	List<ShopDataWeekCaseData>? weekRetainData = [];

  	@JSONField(name: 'show_week_receive_data')
	  bool? showWeekReceiveData = false;
	@JSONField(name: 'week_receive_data')
	List<ShopDataWeekCaseData>? weekReceiveData = [];

	ShopData();

	factory ShopData.fromJson(Map<String, dynamic> json) => $ShopDataFromJson(json);

	Map<String, dynamic> toJson() => $ShopDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ShopDataMonthData {
	String? avatar = '';
	String? name = '';
	int? value = 0;
	int? addition = 0;
	int? addition2 = 0;

	ShopDataMonthData();

	factory ShopDataMonthData.fromJson(Map<String, dynamic> json) => $ShopDataMonthDataFromJson(json);

	Map<String, dynamic> toJson() => $ShopDataMonthDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ShopDataMonthRepayData {
	String? avatar = '';
	String? name = '';
	int? value = 0;
	int? addition = 0;
	int? addition2 = 0;

	ShopDataMonthRepayData();

	factory ShopDataMonthRepayData.fromJson(Map<String, dynamic> json) => $ShopDataMonthRepayDataFromJson(json);

	Map<String, dynamic> toJson() => $ShopDataMonthRepayDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ShopDataMonthRegBonusData {
	String? avatar = '';
	String? name = '';
	int? value = 0;
	int? addition = 0;
	int? addition2 = 0;

	ShopDataMonthRegBonusData();

	factory ShopDataMonthRegBonusData.fromJson(Map<String, dynamic> json) => $ShopDataMonthRegBonusDataFromJson(json);

	Map<String, dynamic> toJson() => $ShopDataMonthRegBonusDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ShopDataMonthApplyBonusData {
	String? avatar = '';
	String? name = '';
	int? value = 0;
	int? addition = 0;
	int? addition2 = 0;

	ShopDataMonthApplyBonusData();

	factory ShopDataMonthApplyBonusData.fromJson(Map<String, dynamic> json) => $ShopDataMonthApplyBonusDataFromJson(json);

	Map<String, dynamic> toJson() => $ShopDataMonthApplyBonusDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ShopDataWeekCaseData {
	String? name = '';
	int? value = 0;
	int? addition = 0;
	int? addition2 = 0;

	ShopDataWeekCaseData();

	factory ShopDataWeekCaseData.fromJson(Map<String, dynamic> json) => $ShopDataWeekCaseDataFromJson(json);

	Map<String, dynamic> toJson() => $ShopDataWeekCaseDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ShopDataWeekBonusData {
	String? name = '';
	int? value = 0;
	List<int>? gradeValues = [];
	int? addition = 0;

	ShopDataWeekBonusData();

	factory ShopDataWeekBonusData.fromJson(Map<String, dynamic> json) => $ShopDataWeekBonusDataFromJson(json);

	Map<String, dynamic> toJson() => $ShopDataWeekBonusDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ShopDataMonthCaseData {
	String? date = '';
	int? value = 0;

	ShopDataMonthCaseData();

	factory ShopDataMonthCaseData.fromJson(Map<String, dynamic> json) => $ShopDataMonthCaseDataFromJson(json);

	Map<String, dynamic> toJson() => $ShopDataMonthCaseDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ShopDataMonthBonusData {
	String? date = '';
	int? value = 0;

	ShopDataMonthBonusData();

	factory ShopDataMonthBonusData.fromJson(Map<String, dynamic> json) => $ShopDataMonthBonusDataFromJson(json);

	Map<String, dynamic> toJson() => $ShopDataMonthBonusDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ShopDataMonthAdditionData {
	String? level = '';
	int? days = 0;
	int? bonus = 0;
	@JSONField(name: 'complete_days')
	int? completeDays = 0;

	ShopDataMonthAdditionData();

	factory ShopDataMonthAdditionData.fromJson(Map<String, dynamic> json) => $ShopDataMonthAdditionDataFromJson(json);

	Map<String, dynamic> toJson() => $ShopDataMonthAdditionDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ShopDataWeekRegisterData {
	String? name = '';
	int? value = 0;
	int? addition = 0;

	ShopDataWeekRegisterData();

	factory ShopDataWeekRegisterData.fromJson(Map<String, dynamic> json) => $ShopDataWeekRegisterDataFromJson(json);

	Map<String, dynamic> toJson() => $ShopDataWeekRegisterDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ShopDataWeekApplyData {
	String? name = '';
	int? value = 0;
	int? addition = 0;

	ShopDataWeekApplyData();

	factory ShopDataWeekApplyData.fromJson(Map<String, dynamic> json) => $ShopDataWeekApplyDataFromJson(json);

	Map<String, dynamic> toJson() => $ShopDataWeekApplyDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ShopDataTrends {
	@JSONField(name: 'b_hour')
	int? bHour = 0;
	@JSONField(name: 'e_repayment_count')
	int? eRepaymentCount = 0;
	@JSONField(name: 'c_action_count')
	int? cActionCount = 0;

	ShopDataTrends();

	factory ShopDataTrends.fromJson(Map<String, dynamic> json) => $ShopDataTrendsFromJson(json);

	Map<String, dynamic> toJson() => $ShopDataTrendsToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ShopOther {
	ShopOtherProgress? progress;
	ShopOtherProfile? profile;
	List<ShopOtherMonthAdditionData>? monthAdditionData = [];
	List<ShopOtherAdditionBonus>? additionBonus = [];
	List<ShopOtherFines>? fines = [];
	String? latestVersion = '';

	ShopOther();

	factory ShopOther.fromJson(Map<String, dynamic> json) => $ShopOtherFromJson(json);

	Map<String, dynamic> toJson() => $ShopOtherToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ShopOtherProgress {
	List<int>? points = [];
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

	ShopOtherProgress();

	factory ShopOtherProgress.fromJson(Map<String, dynamic> json) => $ShopOtherProgressFromJson(json);

	Map<String, dynamic> toJson() => $ShopOtherProgressToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ShopOtherProfile {
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
	@JSONField(name: 'c_s_week_reg_bonus')
	int? cSWeekRegBonus = 0;
	@JSONField(name: 'c_t_week_apply_bonus')
	int? cTWeekApplyBonus = 0;
	@JSONField(name: 'c_u_month_reg_bonus')
	int? cUMonthRegBonus = 0;
	@JSONField(name: 'c_v_month_apply_bonus')
	int? cVMonthApplyBonus = 0;
	@JSONField(name: 'c_w_month_reg_cnt')
	int? cWMonthRegCnt = 0;
	@JSONField(name: 'c_x_month_apply_cnt')
	int? cXMonthApplyCnt = 0;
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
	@JSONField(name: 'd_d_other_bonus')
	int? dDOtherBonus = 0;
	@JSONField(name: 'd_e_week_airtime_bonus')
	int? dEWeekAirtimeBonus = 0;
	@JSONField(name: 'd_f_week_airtime_cnt')
	int? dFWeekAirtimeCnt = 0;
	@JSONField(name: 'd_g_month_airtime_bonus')
	int? dGMonthAirtimeBonus = 0;
	@JSONField(name: 'd_h_month_airtime_cnt')
	int? dHMonthAirtimeCnt = 0;
	@JSONField(name: 'd_i_week_airtime2_bonus')
	int? dIWeekAirtime2Bonus = 0;
	@JSONField(name: 'd_j_week_airtime2_cnt')
	int? dJWeekAirtime2Cnt = 0;
	@JSONField(name: 'd_k_month_airtime2_bonus')
	int? dKMonthAirtime2Bonus = 0;
	@JSONField(name: 'd_l_month_airtime2_cnt')
	int? dLMonthAirtime2Cnt = 0;
	@JSONField(name: 'd_m_day_airtime_bonus')
	int? dMDayAirtimeBonus = 0;
	@JSONField(name: 'd_n_day_airtime2_bonus')
	int? dNDayAirtime2Bonus = 0;

	ShopOtherProfile();

	factory ShopOtherProfile.fromJson(Map<String, dynamic> json) => $ShopOtherProfileFromJson(json);

	Map<String, dynamic> toJson() => $ShopOtherProfileToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ShopOtherMonthAdditionData {
	String? level = '';
	int? days = 0;
	int? bonus = 0;
	@JSONField(name: 'complete_days')
	int? completeDays = 0;

	ShopOtherMonthAdditionData();

	factory ShopOtherMonthAdditionData.fromJson(Map<String, dynamic> json) => $ShopOtherMonthAdditionDataFromJson(json);

	Map<String, dynamic> toJson() => $ShopOtherMonthAdditionDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ShopOtherAdditionBonus {
	@JSONField(name: 'overdue_days')
	List<int>? overdueDays = [];
	int? rate = 0;

	ShopOtherAdditionBonus();

	factory ShopOtherAdditionBonus.fromJson(Map<String, dynamic> json) => $ShopOtherAdditionBonusFromJson(json);

	Map<String, dynamic> toJson() => $ShopOtherAdditionBonusToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ShopOtherFines {
	@JSONField(name: 'borrow_count')
	List<int>? borrowCount = [];
	List<int>? fines = [];

	ShopOtherFines();

	factory ShopOtherFines.fromJson(Map<String, dynamic> json) => $ShopOtherFinesFromJson(json);

	Map<String, dynamic> toJson() => $ShopOtherFinesToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}
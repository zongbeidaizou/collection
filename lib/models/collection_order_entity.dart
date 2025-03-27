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
	@JSONField(name: "a_borrow_id")
	int? aBorrowId = 0;
	@JSONField(name: "b_collection_stage_id")
	int? bCollectionStageId = 0;
	@JSONField(name: "c_collection_agency_id")
	int? cCollectionAgencyId = 0;
	@JSONField(name: "d_collection_group_id")
	int? dCollectionGroupId = 0;
	@JSONField(name: "e_collection_admin_id")
	int? eCollectionAdminId = 0;
	@JSONField(name: "f_collection_news_id")
	int? fCollectionNewsId = 0;
	@JSONField(name: "g_collection_order_flow_history_count")
	int? gCollectionOrderFlowHistoryCount = 0;
	@JSONField(name: "h_collection_admin_log_count")
	int? hCollectionAdminLogCount = 0;
	@JSONField(name: "i_collection_admin_call_count")
	int? iCollectionAdminCallCount = 0;
	@JSONField(name: "j_system_sms_count")
	int? jSystemSmsCount = 0;
	@JSONField(name: "k_status")
	int? kStatus = 0;
	@JSONField(name: "l_collection_amount")
	int? lCollectionAmount = 0;
	@JSONField(name: "m_period_id")
	int? mPeriodId = 0;
	@JSONField(name: "n_borrow_amount")
	int? nBorrowAmount = 0;
	@JSONField(name: "o_period_index")
	int? oPeriodIndex = 0;
	@JSONField(name: "p_expect_repay_time")
	String? pExpectRepayTime = '';
	@JSONField(name: "q_lock_end_stage_id")
	int? qLockEndStageId = 0;
	@JSONField(name: "r_flow_in_time")
	String? rFlowInTime = '';
	@JSONField(name: "s_flow_out_time")
	String? sFlowOutTime = '';
	@JSONField(name: "t_borrow_sn")
	String? tBorrowSn = '';
	@JSONField(name: "u_phone")
	String? uPhone = '';
	@JSONField(name: "v_name")
	String? vName = '';
	@JSONField(name: "w_view_times")
	int? wViewTimes = 0;
	@JSONField(name: "x_current_view_times")
	int? xCurrentViewTimes = 0;
	@JSONField(name: "y_current_log_count")
	int? yCurrentLogCount = 0;
	@JSONField(name: "z_current_call_count")
	int? zCurrentCallCount = 0;
	@JSONField(name: "a_a_commission")
	int? aACommission = 0;
	@JSONField(name: "a_b_current_commission")
	int? aBCurrentCommission = 0;
	@JSONField(name: "a_c_expect_current_commission")
	int? aCExpectCurrentCommission = 0;
	@JSONField(name: "a_d_last_log_time")
	String? aDLastLogTime = '';
	@JSONField(name: "a_e_borrow_count")
	int? aEBorrowCount = 0;
	@JSONField(name: "a_f_s0_collection_amount")
	int? aFS0CollectionAmount = 0;
	@JSONField(name: "a_g_s1_collection_amount")
	int? aGS1CollectionAmount = 0;
	@JSONField(name: "a_h_s2_collection_amount")
	int? aHS2CollectionAmount = 0;
	@JSONField(name: "a_f_s3_collection_amount")
	int? aFS3CollectionAmount = 0;
	@JSONField(name: "a_j_product_id")
	int? aJProductId = 0;
	@JSONField(name: "a_k_no")
	String? aKNo = '';
	@JSONField(name: "a_l_last_log")
	String? aLLastLog = '';
	@JSONField(name: "a_n_current_day_log_count")
	int? aNCurrentDayLogCount = 0;
	@JSONField(name: "a_o_current_day_call_count")
	int? aOCurrentDayCallCount = 0;
	@JSONField(name: "a_a_a_a_a_q_b_periods")
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
class CollectionOrderOther {
	CollectionOrderOtherProgress? progress;
	CollectionOrderOtherProfile? profile;

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
	List<int>? points = [];
	List<CollectionOrderOtherProgressLevelProgress>? levelProgress = [];
	List<CollectionOrderOtherProgressAmountProgress>? amountProgress = [];
	List<int>? amountProgress2 = [];
	int? currentLevel = 0;
	int? nextAmount = 0;
	int? nextLevel = 0;
	int? currentKey = 0;

	CollectionOrderOtherProgress();

	factory CollectionOrderOtherProgress.fromJson(Map<String, dynamic> json) => $CollectionOrderOtherProgressFromJson(json);

	Map<String, dynamic> toJson() => $CollectionOrderOtherProgressToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class CollectionOrderOtherProgressLevelProgress {
	String? level = '';
	int? type = 0;

	CollectionOrderOtherProgressLevelProgress();

	factory CollectionOrderOtherProgressLevelProgress.fromJson(Map<String, dynamic> json) => $CollectionOrderOtherProgressLevelProgressFromJson(json);

	Map<String, dynamic> toJson() => $CollectionOrderOtherProgressLevelProgressToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class CollectionOrderOtherProgressAmountProgress {
	int? amount = 0;
	int? type = 0;

	CollectionOrderOtherProgressAmountProgress();

	factory CollectionOrderOtherProgressAmountProgress.fromJson(Map<String, dynamic> json) => $CollectionOrderOtherProgressAmountProgressFromJson(json);

	Map<String, dynamic> toJson() => $CollectionOrderOtherProgressAmountProgressToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class CollectionOrderOtherProfile {
	@JSONField(name: "a_name")
	String? aName = '';
	@JSONField(name: "b_admin_id")
	int? bAdminId = 0;
	@JSONField(name: "c_collection_agency_id")
	int? cCollectionAgencyId = 0;
	@JSONField(name: "d_collection_group_id")
	int? dCollectionGroupId = 0;
	@JSONField(name: "e_collection_stages")
	String? eCollectionStages = '';
	@JSONField(name: "f_status")
	int? fStatus = 0;
	@JSONField(name: "g_comment")
	String? gComment = '';
	@JSONField(name: "h_collection_ing_order_count")
	int? hCollectionIngOrderCount = 0;
	@JSONField(name: "i_today_current_kpi_level")
	int? iTodayCurrentKpiLevel = 0;
	@JSONField(name: "j_today_init_amount")
	int? jTodayInitAmount = 0;
	@JSONField(name: "k_current_new_count")
	int? kCurrentNewCount = 0;
	@JSONField(name: "l_current_negotiating_count")
	int? lCurrentNegotiatingCount = 0;
	@JSONField(name: "m_currrent_promised_count")
	int? mCurrrentPromisedCount = 0;
	@JSONField(name: "n_current_broken_count")
	int? nCurrentBrokenCount = 0;
	@JSONField(name: "o_current_refused_count")
	int? oCurrentRefusedCount = 0;
	@JSONField(name: "p_today_current_repay_count")
	int? pTodayCurrentRepayCount = 0;
	@JSONField(name: "r_today_current_repay_amount")
	int? rTodayCurrentRepayAmount = 0;
	@JSONField(name: "t_today_lv1_commission")
	int? tTodayLv1Commission = 0;
	@JSONField(name: "u_today_lv2_commission")
	int? uTodayLv2Commission = 0;
	@JSONField(name: "v_today_lv3_commission")
	int? vTodayLv3Commission = 0;
	@JSONField(name: "w_today_lv4_commission")
	int? wTodayLv4Commission = 0;
	@JSONField(name: "a_a_month_lv1_commission")
	int? aAMonthLv1Commission = 0;
	@JSONField(name: "a_b_month_lv2_commission")
	int? aBMonthLv2Commission = 0;
	@JSONField(name: "a_c_month_lv3_commission")
	int? aCMonthLv3Commission = 0;
	@JSONField(name: "a_d_month_lv4_commission")
	int? aDMonthLv4Commission = 0;
	@JSONField(name: "a_e_today_commission_rate")
	double? aETodayCommissionRate = 0;
	@JSONField(name: "updated_at")
	String? updatedAt = '';

	CollectionOrderOtherProfile();

	factory CollectionOrderOtherProfile.fromJson(Map<String, dynamic> json) => $CollectionOrderOtherProfileFromJson(json);

	Map<String, dynamic> toJson() => $CollectionOrderOtherProfileToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}
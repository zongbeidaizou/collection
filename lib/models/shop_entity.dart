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
	ShopDataOther? other;
	@JSONField(name: 'show_month_data')
	bool? showMonthData = false;
	@JSONField(name: 'month_data')
	List<ShopDataMonthData>? monthData = [];

	@JSONField(name: 'show_month_repay_data')
	bool? showMonthRepayData = false;
	@JSONField(name: 'month_repay_data')
	List<ShopDataMonthData>? monthRepayData = [];

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
	@JSONField(name: 'show_week_register_data')
	bool? showWeekRegisterData = false;
	@JSONField(name: 'week_register_data')
	List<ShopDataWeekCaseData>? weekRegisterData = [];
	@JSONField(name: 'show_week_apply_data')
	bool? showWeekApplyData = false;
	@JSONField(name: 'week_apply_data')
	List<ShopDataWeekCaseData>? weekApplyData = [];
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
  @JSONField(name: 'notification_data')
	List<String>? notificationData = [];
  @JSONField(name: 'notification_show_date')
	int? notificationShowDate = 0;


	ShopData();

	factory ShopData.fromJson(Map<String, dynamic> json) => $ShopDataFromJson(json);

	Map<String, dynamic> toJson() => $ShopDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ShopDataOther {
	ShopDataOtherProgress? progress;
	ShopDataOtherProfile? profile;

	ShopDataOther();

	factory ShopDataOther.fromJson(Map<String, dynamic> json) => $ShopDataOtherFromJson(json);

	Map<String, dynamic> toJson() => $ShopDataOtherToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ShopDataOtherProgress {
	List<int>? points = [];
	List<ShopDataOtherProgressLevelProgress>? levelProgress = [];
	List<ShopDataOtherProgressAmountProgress>? amountProgress = [];
	List<int>? amountProgress2 = [];
	int? currentLevel = 0;
	int? nextAmount = 0;
	int? nextLevel = 0;
	int? currentKey = 0;

	ShopDataOtherProgress();

	factory ShopDataOtherProgress.fromJson(Map<String, dynamic> json) => $ShopDataOtherProgressFromJson(json);

	Map<String, dynamic> toJson() => $ShopDataOtherProgressToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ShopDataOtherProgressLevelProgress {
	String? level = '';
	int? type = 0;

	ShopDataOtherProgressLevelProgress();

	factory ShopDataOtherProgressLevelProgress.fromJson(Map<String, dynamic> json) => $ShopDataOtherProgressLevelProgressFromJson(json);

	Map<String, dynamic> toJson() => $ShopDataOtherProgressLevelProgressToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ShopDataOtherProgressAmountProgress {
	int? amount = 0;
	int? type = 0;

	ShopDataOtherProgressAmountProgress();

	factory ShopDataOtherProgressAmountProgress.fromJson(Map<String, dynamic> json) => $ShopDataOtherProgressAmountProgressFromJson(json);

	Map<String, dynamic> toJson() => $ShopDataOtherProgressAmountProgressToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ShopDataOtherProfile {
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
	dynamic yFirstLogAt;
	@JSONField(name: 'z_last_log_at')
	dynamic zLastLogAt;
	@JSONField(name: 'a_a_month_lv1_commission')
	dynamic aAMonthLv1Commission;
	@JSONField(name: 'a_b_month_lv2_commission')
	int? aBMonthLv2Commission = 0;
	@JSONField(name: 'a_c_month_lv3_commission')
	dynamic aCMonthLv3Commission;
	@JSONField(name: 'a_d_month_lv4_commission')
	dynamic aDMonthLv4Commission;
	@JSONField(name: 'a_e_today_commission_rate')
	int? aETodayCommissionRate = 0;
	@JSONField(name: 'a_f_last_call_at')
	dynamic aFLastCallAt;
	@JSONField(name: 'a_g_collection_commission_new_count')
	int? aGCollectionCommissionNewCount = 0;
	@JSONField(name: 'a_h_collection_notification_count')
	dynamic aHCollectionNotificationCount;
	@JSONField(name: 'a_i_week_repay_count')
	dynamic aIWeekRepayCount;
	@JSONField(name: 'a_j_week_rank')
	dynamic aJWeekRank;
	@JSONField(name: 'updated_at')
	String? updatedAt = '';

	ShopDataOtherProfile();

	factory ShopDataOtherProfile.fromJson(Map<String, dynamic> json) => $ShopDataOtherProfileFromJson(json);

	Map<String, dynamic> toJson() => $ShopDataOtherProfileToJson(this);

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
class ShopDataWeekCaseData {
	String? name = '';
	int? value = 0;
  int? addition = 0;

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
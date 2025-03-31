import 'package:bounty_hunter/generated/json/base/json_field.dart';
import 'package:bounty_hunter/generated/json/collection_notification_entity.g.dart';
import 'dart:convert';

import 'collection_order_entity.dart';
export 'package:bounty_hunter/generated/json/collection_notification_entity.g.dart';

@JsonSerializable()
class CollectionNotificationEntity {
	bool? success = false;
	String? errorMessage = '';
	String? message = '';
	List<CollectionNotificationData>? data = [];
	CollectionOrderOther? other;
	int? total = 0;
	int? currentPage = 0;
	int? perPage = 0;
	bool? hasMorePages = false;

	CollectionNotificationEntity();

	factory CollectionNotificationEntity.fromJson(Map<String, dynamic> json) => $CollectionNotificationEntityFromJson(json);

	Map<String, dynamic> toJson() => $CollectionNotificationEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class CollectionNotificationData {
	int? id = 0;
	@JSONField(name: "a_collection_stage_id")
	int? aCollectionStageId = 0;
	@JSONField(name: "b_collection_agency_id")
	int? bCollectionAgencyId = 0;
	@JSONField(name: "c_collection_group_id")
	int? cCollectionGroupId = 0;
	@JSONField(name: "d_collection_admin_id")
	int? dCollectionAdminId = 0;
	@JSONField(name: "e_readed")
	int? eReaded = 0;
	@JSONField(name: "f_read_at")
	String? fReadAt = '';
	@JSONField(name: "g_cat")
	int? gCat = 0;
	@JSONField(name: "h_content")
	String? hContent = '';
	@JSONField(name: "i_collection_stage_id")
	int? iCollectionStageId = 0;
	@JSONField(name: "g_collection_agency_id")
	int? gCollectionAgencyId = 0;
	@JSONField(name: "k_collection_group_id")
	int? kCollectionGroupId = 0;
	@JSONField(name: "l_collection_admin_id")
	int? lCollectionAdminId = 0;
	@JSONField(name: "created_at")
	String? createdAt = '';

	CollectionNotificationData();

	factory CollectionNotificationData.fromJson(Map<String, dynamic> json) => $CollectionNotificationDataFromJson(json);

	Map<String, dynamic> toJson() => $CollectionNotificationDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class CollectionNotificationOther {
	CollectionNotificationOtherProgress? progress;
	CollectionNotificationOtherProfile? profile;

	CollectionNotificationOther();

	factory CollectionNotificationOther.fromJson(Map<String, dynamic> json) => $CollectionNotificationOtherFromJson(json);

	Map<String, dynamic> toJson() => $CollectionNotificationOtherToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class CollectionNotificationOtherProgress {
	List<int>? points = [];
	List<CollectionNotificationOtherProgressLevelProgress>? levelProgress = [];
	List<CollectionNotificationOtherProgressAmountProgress>? amountProgress = [];
	List<int>? amountProgress2 = [];
	int? currentLevel = 0;
	int? nextAmount = 0;
	int? nextLevel = 0;
	int? currentKey = 0;

	CollectionNotificationOtherProgress();

	factory CollectionNotificationOtherProgress.fromJson(Map<String, dynamic> json) => $CollectionNotificationOtherProgressFromJson(json);

	Map<String, dynamic> toJson() => $CollectionNotificationOtherProgressToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class CollectionNotificationOtherProgressLevelProgress {
	String? level = '';
	int? type = 0;

	CollectionNotificationOtherProgressLevelProgress();

	factory CollectionNotificationOtherProgressLevelProgress.fromJson(Map<String, dynamic> json) => $CollectionNotificationOtherProgressLevelProgressFromJson(json);

	Map<String, dynamic> toJson() => $CollectionNotificationOtherProgressLevelProgressToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class CollectionNotificationOtherProgressAmountProgress {
	int? amount = 0;
	int? type = 0;

	CollectionNotificationOtherProgressAmountProgress();

	factory CollectionNotificationOtherProgressAmountProgress.fromJson(Map<String, dynamic> json) => $CollectionNotificationOtherProgressAmountProgressFromJson(json);

	Map<String, dynamic> toJson() => $CollectionNotificationOtherProgressAmountProgressToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class CollectionNotificationOtherProfile {
	int? id = 0;
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
	@JSONField(name: "x_today_init_count")
	int? xTodayInitCount = 0;
	@JSONField(name: "y_first_log_at")
	String? yFirstLogAt = '';
	@JSONField(name: "z_last_log_at")
	String? zLastLogAt = '';
	@JSONField(name: "a_a_month_lv1_commission")
	int? aAMonthLv1Commission = 0;
	@JSONField(name: "a_b_month_lv2_commission")
	int? aBMonthLv2Commission = 0;
	@JSONField(name: "a_c_month_lv3_commission")
	int? aCMonthLv3Commission = 0;
	@JSONField(name: "a_d_month_lv4_commission")
	int? aDMonthLv4Commission = 0;
	@JSONField(name: "a_e_today_commission_rate")
	double? aETodayCommissionRate;
	@JSONField(name: "a_f_last_call_at")
	String? aFLastCallAt = '';
	@JSONField(name: "a_g_collection_commission_new_count")
	int? aGCollectionCommissionNewCount = 0;
	@JSONField(name: "a_h_collection_notification_count")
	int? aHCollectionNotificationCount = 0;
	@JSONField(name: "a_i_week_repay_count")
	dynamic aIWeekRepayCount;
	@JSONField(name: "a_j_week_rank")
	dynamic aJWeekRank;
	@JSONField(name: "updated_at")
	String? updatedAt = '';

	CollectionNotificationOtherProfile();

	factory CollectionNotificationOtherProfile.fromJson(Map<String, dynamic> json) => $CollectionNotificationOtherProfileFromJson(json);

	Map<String, dynamic> toJson() => $CollectionNotificationOtherProfileToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}
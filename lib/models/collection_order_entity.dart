import 'package:bounty_hunter/generated/json/base/json_field.dart';
import 'package:bounty_hunter/generated/json/collection_order_entity.g.dart';
import 'dart:convert';
export 'package:bounty_hunter/generated/json/collection_order_entity.g.dart';

@JsonSerializable()
class CollectionOrderEntity {
	bool? success = false;
	String? errorMessage = '';
	String? message = '';
	List<CollectionOrderData>? data = [];
	List<dynamic>? other = [];
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
	dynamic wViewTimes;
	@JSONField(name: "x_current_view_times")
	int? xCurrentViewTimes = 0;
	@JSONField(name: "y_current_log_count")
	int? yCurrentLogCount = 0;
	@JSONField(name: "z_current_call_count")
	int? zCurrentCallCount = 0;
	@JSONField(name: "a_a_commission")
	dynamic aACommission;
	@JSONField(name: "a_b_current_commission")
	dynamic aBCurrentCommission;
	@JSONField(name: "a_c_expect_current_commission")
	dynamic aCExpectCurrentCommission;
	@JSONField(name: "a_d_last_log_time")
	dynamic aDLastLogTime;
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

	CollectionOrderData();

	factory CollectionOrderData.fromJson(Map<String, dynamic> json) => $CollectionOrderDataFromJson(json);

	Map<String, dynamic> toJson() => $CollectionOrderDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}
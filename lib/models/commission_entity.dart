import 'package:bounty_hunter/generated/json/base/json_field.dart';
import 'package:bounty_hunter/generated/json/commission_entity.g.dart';
import 'dart:convert';

import 'collection_order_entity.dart';
export 'package:bounty_hunter/generated/json/commission_entity.g.dart';

@JsonSerializable()
class CommissionEntity {
	bool? success = false;
	String? errorMessage = '';
	String? message = '';
	List<CommissionData>? data = [];
	CollectionOrderOther? other;
	int? total = 0;
	int? currentPage = 0;
	int? perPage = 0;
	bool? hasMorePages = false;

	CommissionEntity();

	factory CommissionEntity.fromJson(Map<String, dynamic> json) => $CommissionEntityFromJson(json);

	Map<String, dynamic> toJson() => $CommissionEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class CommissionData {
	@JSONField(name: 'a_borrow_id')
	int? aBorrowId = 0;
	@JSONField(name: 'b_collection_stage_id')
	int? bCollectionStageId = 0;
	@JSONField(name: 'c_collection_agency_id')
	int? cCollectionAgencyId = 0;
	@JSONField(name: 'd_collection_group_id')
	int? dCollectionGroupId = 0;
	@JSONField(name: 'e_collection_admin_id')
	int? eCollectionAdminId = 0;
	@JSONField(name: 'f_period_id')
	int? fPeriodId = 0;
	@JSONField(name: 'g_amount')
	int? gAmount = 0;
	@JSONField(name: 'h_commission_amount')
	int? hCommissionAmount = 0;
	@JSONField(name: 'i_collection_kpi_id')
	int? iCollectionKpiId = 0;
	@JSONField(name: 'j_rate')
	double? jRate = 0;
	@JSONField(name: 'k_level')
	int? kLevel = 0;
	@JSONField(name: 'o_type')
	int? oType = 0;
	@JSONField(name: 'p_phone')
	String? pPhone = '';
	@JSONField(name: 'n_borrow_sn')
	String? nBorrowSn = '';

	@JSONField(name: 'r_current_rate')
	int? rCurrentRate = 0;

	@JSONField(name: 'v_paid_amount')
	int? vPaidAmount = 0;

	@JSONField(name: 'z_account_number')
	String? zAccountNumber = '';

	@JSONField(name: 'l_repay_log_id')
	int? lRepayLogId = 0;
	@JSONField(name: 's_assist_rate')
	int? sAssistRate = 0;
	@JSONField(name: 't_commission_amount_without_assist')
	int? tCommissionAmountWithoutAssist = 0;
	@JSONField(name: 'w_readed')
	int? wReaded = 0;
	@JSONField(name: 'x_read_at')
	String? xReadAt = '';
	@JSONField(name: 'y_day_index')
	int? yDayIndex = 0;
	@JSONField(name: "created_at")
	String? createdAt = '';
	@JSONField(name: "a_a_a_a_a_a_b_l_collection_order")
	CollectionOrderData? aAAAAABLCollectionOrder;

	CommissionData();

	factory CommissionData.fromJson(Map<String, dynamic> json) => $CommissionDataFromJson(json);

	Map<String, dynamic> toJson() => $CommissionDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}
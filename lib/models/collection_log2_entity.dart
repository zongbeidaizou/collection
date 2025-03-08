import 'package:bounty_hunter/generated/json/base/json_field.dart';
import 'package:bounty_hunter/generated/json/collection_log2_entity.g.dart';
import 'dart:convert';
export 'package:bounty_hunter/generated/json/collection_log2_entity.g.dart';

@JsonSerializable()
class CollectionLog2Entity {
	bool? success = false;
	String? errorMessage = '';
	String? message = '';
	List<CollectionLog2Data>? data = [];
	List<dynamic>? other = [];
	int? total = 0;
	int? currentPage = 0;
	int? perPage = 0;
	bool? hasMorePages = false;

	CollectionLog2Entity();

	factory CollectionLog2Entity.fromJson(Map<String, dynamic> json) => $CollectionLog2EntityFromJson(json);

	Map<String, dynamic> toJson() => $CollectionLog2EntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class CollectionLog2Data {
	int? id = 0;
	@JSONField(name: "p_collection_order_id")
	int? pCollectionOrderId = 0;
	@JSONField(name: "f_cat")
	int? fCat = 0;
	@JSONField(name: "g_type")
	int? gType = 0;
	@JSONField(name: "h_phone")
	String? hPhone = '';
	@JSONField(name: "j_content")
	String? jContent = '';
	@JSONField(name: "k_promise_time")
	String? kPromiseTime = '';
	@JSONField(name: "m_overdue_days")
	int? mOverdueDays = 0;
	@JSONField(name: "created_at")
	String? createdAt = '';
	@JSONField(name: "a_a_a_a_a_a_b_l_collection_order")
	CollectionLog2DataAAAAAABLCollectionOrder? aAAAAABLCollectionOrder;

	CollectionLog2Data();

	factory CollectionLog2Data.fromJson(Map<String, dynamic> json) => $CollectionLog2DataFromJson(json);

	Map<String, dynamic> toJson() => $CollectionLog2DataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class CollectionLog2DataAAAAAABLCollectionOrder {
	int? id = 0;
	@JSONField(name: "k_status")
	int? kStatus = 0;
	@JSONField(name: "n_borrow_amount")
	int? nBorrowAmount = 0;
	@JSONField(name: "o_period_index")
	int? oPeriodIndex = 0;
	@JSONField(name: "p_expect_repay_time")
	String? pExpectRepayTime = '';
	@JSONField(name: "t_borrow_sn")
	String? tBorrowSn = '';
	@JSONField(name: "u_phone")
	String? uPhone = '';
	@JSONField(name: "v_name")
	String? vName = '';
	@JSONField(name: "s_flow_out_time")
	String? sFlowOutTime = '';
	@JSONField(name: "a_e_borrow_count")
	int? aEBorrowCount = 0;
	@JSONField(name: "a_j_product_id")
	int? aJProductId = 0;


	CollectionLog2DataAAAAAABLCollectionOrder();

	factory CollectionLog2DataAAAAAABLCollectionOrder.fromJson(Map<String, dynamic> json) => $CollectionLog2DataAAAAAABLCollectionOrderFromJson(json);

	Map<String, dynamic> toJson() => $CollectionLog2DataAAAAAABLCollectionOrderToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}
import 'package:bounty_hunter/generated/json/base/json_field.dart';
import 'package:bounty_hunter/generated/json/collection_log_entity.g.dart';
import 'dart:convert';
export 'package:bounty_hunter/generated/json/collection_log_entity.g.dart';

@JsonSerializable()
class CollectionLogEntity {
	bool? success = false;
	String? errorMessage = '';
	String? message = '';
	List<CollectionLogData>? data = [];
	List<dynamic>? other = [];
	int? total = 0;
	int? currentPage = 0;
	int? perPage = 0;
	bool? hasMorePages = false;

	CollectionLogEntity();

	factory CollectionLogEntity.fromJson(Map<String, dynamic> json) => $CollectionLogEntityFromJson(json);

	Map<String, dynamic> toJson() => $CollectionLogEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class CollectionLogData {
	int? id = 0;
	@JSONField(name: "p_collection_order_id")
	int? pCollectionOrderId = 0;
	@JSONField(name: "b_collection_stage_id")
	int? bCollectionStageId = 0;
	@JSONField(name: "c_collection_agency_id")
	int? cCollectionAgencyId = 0;
	@JSONField(name: "d_collection_group_id")
	int? dCollectionGroupId = 0;
	@JSONField(name: "e_collection_admin_id")
	int? eCollectionAdminId = 0;
	@JSONField(name: "g_type")
	int? gType = 0;
	@JSONField(name: "j_content")
	String? jContent = '';
	@JSONField(name: "created_at")
	String? createdAt = '';

	CollectionLogData();

	factory CollectionLogData.fromJson(Map<String, dynamic> json) => $CollectionLogDataFromJson(json);

	Map<String, dynamic> toJson() => $CollectionLogDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}
import 'package:bounty_hunter/generated/json/base/json_field.dart';
import 'package:bounty_hunter/generated/json/s_g_contact_entity.g.dart';
import 'dart:convert';
import 'package:bounty_hunter/models/collection_order_entity.dart';
export 'package:bounty_hunter/generated/json/s_g_contact_entity.g.dart';


@JsonSerializable()
class SGContactEntity {
	bool? success = false;
	String? errorMessage = '';
	String? message = '';
	List<SGContactData>? data = [];
	CollectionOrderOther? other;
	int? total = 0;
	int? currentPage = 0;
	int? perPage = 0;
	bool? hasMorePages = false;

	SGContactEntity();

	factory SGContactEntity.fromJson(Map<String, dynamic> json) => $SGContactEntityFromJson(json);

	Map<String, dynamic> toJson() => $SGContactEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class SGContactData {
	int? id = 0;
	@JSONField(name: 'a_idnumber')
	String? aIdnumber = '';
	@JSONField(name: 'b_user_id')
	int? bUserId = 0;
	@JSONField(name: 'c_relation')
	String? cRelation = '';
	@JSONField(name: 'd_call_times')
	int? dCallTimes = 0;
	@JSONField(name: 'e_last_call_time')
	String? eLastCallTime = '';
	@JSONField(name: 'f_name')
	String? fName = '';
	@JSONField(name: 'g_phone')
	String? gPhone = '';
	@JSONField(name: 'h_review_result')
	int? hReviewResult = 0;
	@JSONField(name: 'i_need_review')
	int? iNeedReview = 0;

	SGContactData();

	factory SGContactData.fromJson(Map<String, dynamic> json) => $SGContactDataFromJson(json);

	Map<String, dynamic> toJson() => $SGContactDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}
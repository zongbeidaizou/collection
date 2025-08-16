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
	@JSONField(name: 'l_sms_count')
	int? lSmsCount = 0;
	@JSONField(name: 'n_call_count')
	int? nCallCount = 0;
	@JSONField(name: 'q_phone_status')
	int? QPhoneStatus = 0;
	@JSONField(name: 'r_wa_status')
	int? RWaStatus = 0;
	@JSONField(name: 'a_a_a_a_a_n_i_admin_recordings')
	List<SGContactDataAAAAANIAdminRecordings>? aAAAANIAdminRecordings = [];

	SGContactData();

	factory SGContactData.fromJson(Map<String, dynamic> json) => $SGContactDataFromJson(json);

	Map<String, dynamic> toJson() => $SGContactDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class SGContactDataAAAAANIAdminRecordings {
	int? id = 0;
	@JSONField(name: 'd_contact_id')
	int? dContactId = 0;
	@JSONField(name: 'k_call_at')
	String? kCallAt = '';

	SGContactDataAAAAANIAdminRecordings();

	factory SGContactDataAAAAANIAdminRecordings.fromJson(Map<String, dynamic> json) => $SGContactDataAAAAANIAdminRecordingsFromJson(json);

	Map<String, dynamic> toJson() => $SGContactDataAAAAANIAdminRecordingsToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class SGContactOther {


	SGContactOther();

	factory SGContactOther.fromJson(Map<String, dynamic> json) => $SGContactOtherFromJson(json);

	Map<String, dynamic> toJson() => $SGContactOtherToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}
import 'package:bounty_hunter/generated/json/base/json_field.dart';
import 'package:bounty_hunter/generated/json/h_k_contact_sms_entity.g.dart';
import 'dart:convert';
export 'package:bounty_hunter/generated/json/h_k_contact_sms_entity.g.dart';

@JsonSerializable()
class HKContactSmsEntity {
	bool? success = false;
	String? errorMessage = '';
	String? message = '';
	List<HKContactSmsData>? data = [];
	List<dynamic>? other = [];
	int? total = 0;
	int? currentPage = 0;
	int? perPage = 0;
	bool? hasMorePages = false;

	HKContactSmsEntity();

	factory HKContactSmsEntity.fromJson(Map<String, dynamic> json) => $HKContactSmsEntityFromJson(json);

	Map<String, dynamic> toJson() => $HKContactSmsEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class HKContactSmsData {
	int? id = 0;
	@JSONField(name: 'date_sent')
	int? dateSent = 0;
	int? type = 0;
	String? address = '';
	String? body = '';
	@JSONField(name: 'a_a_contact_id')
	int? aAContactId = 0;

	HKContactSmsData();

	factory HKContactSmsData.fromJson(Map<String, dynamic> json) => $HKContactSmsDataFromJson(json);

	Map<String, dynamic> toJson() => $HKContactSmsDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}
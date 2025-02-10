import 'package:bounty_hunter/generated/json/base/json_field.dart';
import 'package:bounty_hunter/generated/json/admin_entity.g.dart';
import 'dart:convert';
export 'package:bounty_hunter/generated/json/admin_entity.g.dart';

@JsonSerializable()
class AdminEntity {
	List<AdminData>? data = [];
	bool? success = false;
	String? errorMessage = '';
	int? total = 0;

	AdminEntity();

	factory AdminEntity.fromJson(Map<String, dynamic> json) => $AdminEntityFromJson(json);

	Map<String, dynamic> toJson() => $AdminEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class AdminData {
	int? id = 0;
	@JSONField(name: "a_name")
	String? aName = '';

	AdminData();

	factory AdminData.fromJson(Map<String, dynamic> json) => $AdminDataFromJson(json);

	Map<String, dynamic> toJson() => $AdminDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}
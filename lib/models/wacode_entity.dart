import 'package:bounty_hunter/generated/json/base/json_field.dart';
import 'package:bounty_hunter/generated/json/wacode_entity.g.dart';
import 'dart:convert';
export 'package:bounty_hunter/generated/json/wacode_entity.g.dart';

@JsonSerializable()
class WacodeEntity {
	bool? success = false;
	String? errorMessage = '';
	String? message = '';
	WacodeData? data;

	WacodeEntity();

	factory WacodeEntity.fromJson(Map<String, dynamic> json) => $WacodeEntityFromJson(json);

	Map<String, dynamic> toJson() => $WacodeEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class WacodeData {
	String? code = '';

	WacodeData();

	factory WacodeData.fromJson(Map<String, dynamic> json) => $WacodeDataFromJson(json);

	Map<String, dynamic> toJson() => $WacodeDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}
import 'package:bounty_hunter/generated/json/base/json_field.dart';
import 'package:bounty_hunter/generated/json/wa_entity.g.dart';
import 'dart:convert';
export 'package:bounty_hunter/generated/json/wa_entity.g.dart';

@JsonSerializable()
class WaEntity {
	bool? success = false;
	String? errorMessage = '';
	String? message = '';
	WaData? data;

	WaEntity();

	factory WaEntity.fromJson(Map<String, dynamic> json) => $WaEntityFromJson(json);

	Map<String, dynamic> toJson() => $WaEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class WaData {
	String? wa = '';
	@JSONField(name: 'activation_id')
	String? activationId = '';
	String? tip = '';
	String? tip2 = '';

	WaData();

	factory WaData.fromJson(Map<String, dynamic> json) => $WaDataFromJson(json);

	Map<String, dynamic> toJson() => $WaDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}
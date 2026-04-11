import 'package:bounty_hunter/generated/json/base/json_field.dart';
import 'package:bounty_hunter/generated/json/setting_entity.g.dart';
import 'dart:convert';
export 'package:bounty_hunter/generated/json/setting_entity.g.dart';

@JsonSerializable()
class SettingEntity {
	bool? success = false;
	SettingData? data;
	List<dynamic>? other = [];
	String? message = '';

	SettingEntity();

	factory SettingEntity.fromJson(Map<String, dynamic> json) => $SettingEntityFromJson(json);

	Map<String, dynamic> toJson() => $SettingEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class SettingData {
	List<SettingDataProducts>? products = [];

	SettingData();

	factory SettingData.fromJson(Map<String, dynamic> json) => $SettingDataFromJson(json);

	Map<String, dynamic> toJson() => $SettingDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class SettingDataProducts {
	String? title = '';
	String? value = '';
	String? logo = '';

	SettingDataProducts();

	factory SettingDataProducts.fromJson(Map<String, dynamic> json) => $SettingDataProductsFromJson(json);

	Map<String, dynamic> toJson() => $SettingDataProductsToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}
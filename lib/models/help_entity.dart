import 'package:bounty_hunter/generated/json/base/json_field.dart';
import 'package:bounty_hunter/generated/json/help_entity.g.dart';
import 'dart:convert';
export 'package:bounty_hunter/generated/json/help_entity.g.dart';

@JsonSerializable()
class HelpEntity {
	bool? success = false;
	String? errorMessage = '';
	String? message = '';
	List<HelpData>? data = [];
	HelpOther? other;
	int? total = 0;
	int? currentPage = 0;
	int? perPage = 0;
	bool? hasMorePages = false;

	HelpEntity();

	factory HelpEntity.fromJson(Map<String, dynamic> json) => $HelpEntityFromJson(json);

	Map<String, dynamic> toJson() => $HelpEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class HelpData {
	String? tab = '';
	List<HelpDataItems>? items = [];

	HelpData();

	factory HelpData.fromJson(Map<String, dynamic> json) => $HelpDataFromJson(json);

	Map<String, dynamic> toJson() => $HelpDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class HelpDataItems {
	String? title = '';
	String? image = '';
	String? instruction = '';
	String? fit = '';
	List<HelpDataItemsSteps>? steps = [];

	HelpDataItems();

	factory HelpDataItems.fromJson(Map<String, dynamic> json) => $HelpDataItemsFromJson(json);

	Map<String, dynamic> toJson() => $HelpDataItemsToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class HelpDataItemsSteps {
	int? no = 0;
	String? title = '';
	String? description = '';
	List<HelpDataItemsStepsIcons>? icons = [];

	HelpDataItemsSteps();

	factory HelpDataItemsSteps.fromJson(Map<String, dynamic> json) => $HelpDataItemsStepsFromJson(json);

	Map<String, dynamic> toJson() => $HelpDataItemsStepsToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class HelpDataItemsStepsIcons {
	String? icon = '';
	String? text = '';

	HelpDataItemsStepsIcons();

	factory HelpDataItemsStepsIcons.fromJson(Map<String, dynamic> json) => $HelpDataItemsStepsIconsFromJson(json);

	Map<String, dynamic> toJson() => $HelpDataItemsStepsIconsToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class HelpOther {
	String? h5 = '';
	String? foo = '';
	String? bar = '';

	HelpOther();

	factory HelpOther.fromJson(Map<String, dynamic> json) => $HelpOtherFromJson(json);

	Map<String, dynamic> toJson() => $HelpOtherToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}
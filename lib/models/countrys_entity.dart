import 'package:bounty_hunter/generated/json/base/json_field.dart';
import 'package:bounty_hunter/generated/json/countrys_entity.g.dart';
import 'dart:convert';
export 'package:bounty_hunter/generated/json/countrys_entity.g.dart';

@JsonSerializable()
class CountrysEntity {
	bool? success = false;
	String? errorMessage = '';
	String? message = '';
	List<CountrysData>? data = [];
	List<dynamic>? other = [];
	int? total = 0;
	int? currentPage = 0;
	int? perPage = 0;
	bool? hasMorePages = false;

	CountrysEntity();

	factory CountrysEntity.fromJson(Map<String, dynamic> json) => $CountrysEntityFromJson(json);

	Map<String, dynamic> toJson() => $CountrysEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class CountrysData {
	String? code = '';
	String? name = '';
  int? rate = 0;

	CountrysData();

	factory CountrysData.fromJson(Map<String, dynamic> json) => $CountrysDataFromJson(json);

	Map<String, dynamic> toJson() => $CountrysDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}
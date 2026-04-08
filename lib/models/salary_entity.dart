import 'package:bounty_hunter/generated/json/base/json_field.dart';
import 'package:bounty_hunter/generated/json/salary_entity.g.dart';
import 'dart:convert';
export 'package:bounty_hunter/generated/json/salary_entity.g.dart';

@JsonSerializable()
class SalaryEntity {
	bool? success = false;
	SalaryData? data;
	List<dynamic>? other = [];
	String? message = '';

	SalaryEntity();

	factory SalaryEntity.fromJson(Map<String, dynamic> json) => $SalaryEntityFromJson(json);

	Map<String, dynamic> toJson() => $SalaryEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class SalaryData {
	@JSONField(name: 'show_week_salary')
	bool? showWeekSalary = false;
	@JSONField(name: 'week_salary_comment')
	String? weekSalaryComment = '';
	@JSONField(name: 'week_salary_total')
	int? weekSalaryTotal = 0;
	@JSONField(name: 'week_salary_data')
	List<SalaryDataWeekSalaryData>? weekSalaryData = [];
	@JSONField(name: 'show_month_salary')
	bool? showMonthSalary = false;
	@JSONField(name: 'month_salary_comment')
	String? monthSalaryComment = '';
	@JSONField(name: 'month_salary_total')
	int? monthSalaryTotal = 0;
	@JSONField(name: 'month_salary_data')
	List<SalaryDataMonthSalaryData>? monthSalaryData = [];

	SalaryData();

	factory SalaryData.fromJson(Map<String, dynamic> json) => $SalaryDataFromJson(json);

	Map<String, dynamic> toJson() => $SalaryDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class SalaryDataWeekSalaryData {
	String? title = '';
	int? value = 0;
	String? comment = '';

	SalaryDataWeekSalaryData();

	factory SalaryDataWeekSalaryData.fromJson(Map<String, dynamic> json) => $SalaryDataWeekSalaryDataFromJson(json);

	Map<String, dynamic> toJson() => $SalaryDataWeekSalaryDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class SalaryDataMonthSalaryData {
	String? title = '';
	int? value = 0;
	String? comment = '';

	SalaryDataMonthSalaryData();

	factory SalaryDataMonthSalaryData.fromJson(Map<String, dynamic> json) => $SalaryDataMonthSalaryDataFromJson(json);

	Map<String, dynamic> toJson() => $SalaryDataMonthSalaryDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}
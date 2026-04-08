import 'package:bounty_hunter/generated/json/base/json_convert_content.dart';
import 'package:bounty_hunter/models/salary_entity.dart';

SalaryEntity $SalaryEntityFromJson(Map<String, dynamic> json) {
  final SalaryEntity salaryEntity = SalaryEntity();
  final bool? success = jsonConvert.convert<bool>(json['success']);
  if (success != null) {
    salaryEntity.success = success;
  }
  final SalaryData? data = jsonConvert.convert<SalaryData>(json['data']);
  if (data != null) {
    salaryEntity.data = data;
  }
  final List<dynamic>? other = (json['other'] as List<dynamic>?)?.map(
          (e) => e).toList();
  if (other != null) {
    salaryEntity.other = other;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    salaryEntity.message = message;
  }
  return salaryEntity;
}

Map<String, dynamic> $SalaryEntityToJson(SalaryEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['success'] = entity.success;
  data['data'] = entity.data?.toJson();
  data['other'] = entity.other;
  data['message'] = entity.message;
  return data;
}

extension SalaryEntityExtension on SalaryEntity {
  SalaryEntity copyWith({
    bool? success,
    SalaryData? data,
    List<dynamic>? other,
    String? message,
  }) {
    return SalaryEntity()
      ..success = success ?? this.success
      ..data = data ?? this.data
      ..other = other ?? this.other
      ..message = message ?? this.message;
  }
}

SalaryData $SalaryDataFromJson(Map<String, dynamic> json) {
  final SalaryData salaryData = SalaryData();
  final bool? showWeekSalary = jsonConvert.convert<bool>(
      json['show_week_salary']);
  if (showWeekSalary != null) {
    salaryData.showWeekSalary = showWeekSalary;
  }
  final String? weekSalaryComment = jsonConvert.convert<String>(
      json['week_salary_comment']);
  if (weekSalaryComment != null) {
    salaryData.weekSalaryComment = weekSalaryComment;
  }
  final int? weekSalaryTotal = jsonConvert.convert<int>(
      json['week_salary_total']);
  if (weekSalaryTotal != null) {
    salaryData.weekSalaryTotal = weekSalaryTotal;
  }
  final List<
      SalaryDataWeekSalaryData>? weekSalaryData = (json['week_salary_data'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<SalaryDataWeekSalaryData>(
          e) as SalaryDataWeekSalaryData).toList();
  if (weekSalaryData != null) {
    salaryData.weekSalaryData = weekSalaryData;
  }
  final bool? showMonthSalary = jsonConvert.convert<bool>(
      json['show_month_salary']);
  if (showMonthSalary != null) {
    salaryData.showMonthSalary = showMonthSalary;
  }
  final String? monthSalaryComment = jsonConvert.convert<String>(
      json['month_salary_comment']);
  if (monthSalaryComment != null) {
    salaryData.monthSalaryComment = monthSalaryComment;
  }
  final int? monthSalaryTotal = jsonConvert.convert<int>(
      json['month_salary_total']);
  if (monthSalaryTotal != null) {
    salaryData.monthSalaryTotal = monthSalaryTotal;
  }
  final List<
      SalaryDataMonthSalaryData>? monthSalaryData = (json['month_salary_data'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<SalaryDataMonthSalaryData>(
          e) as SalaryDataMonthSalaryData).toList();
  if (monthSalaryData != null) {
    salaryData.monthSalaryData = monthSalaryData;
  }
  return salaryData;
}

Map<String, dynamic> $SalaryDataToJson(SalaryData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['show_week_salary'] = entity.showWeekSalary;
  data['week_salary_comment'] = entity.weekSalaryComment;
  data['week_salary_total'] = entity.weekSalaryTotal;
  data['week_salary_data'] =
      entity.weekSalaryData?.map((v) => v.toJson()).toList();
  data['show_month_salary'] = entity.showMonthSalary;
  data['month_salary_comment'] = entity.monthSalaryComment;
  data['month_salary_total'] = entity.monthSalaryTotal;
  data['month_salary_data'] =
      entity.monthSalaryData?.map((v) => v.toJson()).toList();
  return data;
}

extension SalaryDataExtension on SalaryData {
  SalaryData copyWith({
    bool? showWeekSalary,
    String? weekSalaryComment,
    int? weekSalaryTotal,
    List<SalaryDataWeekSalaryData>? weekSalaryData,
    bool? showMonthSalary,
    String? monthSalaryComment,
    int? monthSalaryTotal,
    List<SalaryDataMonthSalaryData>? monthSalaryData,
  }) {
    return SalaryData()
      ..showWeekSalary = showWeekSalary ?? this.showWeekSalary
      ..weekSalaryComment = weekSalaryComment ?? this.weekSalaryComment
      ..weekSalaryTotal = weekSalaryTotal ?? this.weekSalaryTotal
      ..weekSalaryData = weekSalaryData ?? this.weekSalaryData
      ..showMonthSalary = showMonthSalary ?? this.showMonthSalary
      ..monthSalaryComment = monthSalaryComment ?? this.monthSalaryComment
      ..monthSalaryTotal = monthSalaryTotal ?? this.monthSalaryTotal
      ..monthSalaryData = monthSalaryData ?? this.monthSalaryData;
  }
}

SalaryDataWeekSalaryData $SalaryDataWeekSalaryDataFromJson(
    Map<String, dynamic> json) {
  final SalaryDataWeekSalaryData salaryDataWeekSalaryData = SalaryDataWeekSalaryData();
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    salaryDataWeekSalaryData.title = title;
  }
  final int? value = jsonConvert.convert<int>(json['value']);
  if (value != null) {
    salaryDataWeekSalaryData.value = value;
  }
  final String? comment = jsonConvert.convert<String>(json['comment']);
  if (comment != null) {
    salaryDataWeekSalaryData.comment = comment;
  }
  return salaryDataWeekSalaryData;
}

Map<String, dynamic> $SalaryDataWeekSalaryDataToJson(
    SalaryDataWeekSalaryData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['title'] = entity.title;
  data['value'] = entity.value;
  data['comment'] = entity.comment;
  return data;
}

extension SalaryDataWeekSalaryDataExtension on SalaryDataWeekSalaryData {
  SalaryDataWeekSalaryData copyWith({
    String? title,
    int? value,
    String? comment,
  }) {
    return SalaryDataWeekSalaryData()
      ..title = title ?? this.title
      ..value = value ?? this.value
      ..comment = comment ?? this.comment;
  }
}

SalaryDataMonthSalaryData $SalaryDataMonthSalaryDataFromJson(
    Map<String, dynamic> json) {
  final SalaryDataMonthSalaryData salaryDataMonthSalaryData = SalaryDataMonthSalaryData();
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    salaryDataMonthSalaryData.title = title;
  }
  final int? value = jsonConvert.convert<int>(json['value']);
  if (value != null) {
    salaryDataMonthSalaryData.value = value;
  }
  final String? comment = jsonConvert.convert<String>(json['comment']);
  if (comment != null) {
    salaryDataMonthSalaryData.comment = comment;
  }
  return salaryDataMonthSalaryData;
}

Map<String, dynamic> $SalaryDataMonthSalaryDataToJson(
    SalaryDataMonthSalaryData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['title'] = entity.title;
  data['value'] = entity.value;
  data['comment'] = entity.comment;
  return data;
}

extension SalaryDataMonthSalaryDataExtension on SalaryDataMonthSalaryData {
  SalaryDataMonthSalaryData copyWith({
    String? title,
    int? value,
    String? comment,
  }) {
    return SalaryDataMonthSalaryData()
      ..title = title ?? this.title
      ..value = value ?? this.value
      ..comment = comment ?? this.comment;
  }
}
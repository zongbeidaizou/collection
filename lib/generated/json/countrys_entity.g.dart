import 'package:bounty_hunter/generated/json/base/json_convert_content.dart';
import 'package:bounty_hunter/models/countrys_entity.dart';

CountrysEntity $CountrysEntityFromJson(Map<String, dynamic> json) {
  final CountrysEntity countrysEntity = CountrysEntity();
  final bool? success = jsonConvert.convert<bool>(json['success']);
  if (success != null) {
    countrysEntity.success = success;
  }
  final String? errorMessage = jsonConvert.convert<String>(
      json['errorMessage']);
  if (errorMessage != null) {
    countrysEntity.errorMessage = errorMessage;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    countrysEntity.message = message;
  }
  final List<CountrysData>? data = (json['data'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<CountrysData>(e) as CountrysData).toList();
  if (data != null) {
    countrysEntity.data = data;
  }
  final List<dynamic>? other = (json['other'] as List<dynamic>?)?.map(
          (e) => e).toList();
  if (other != null) {
    countrysEntity.other = other;
  }
  final int? total = jsonConvert.convert<int>(json['total']);
  if (total != null) {
    countrysEntity.total = total;
  }
  final int? currentPage = jsonConvert.convert<int>(json['currentPage']);
  if (currentPage != null) {
    countrysEntity.currentPage = currentPage;
  }
  final int? perPage = jsonConvert.convert<int>(json['perPage']);
  if (perPage != null) {
    countrysEntity.perPage = perPage;
  }
  final bool? hasMorePages = jsonConvert.convert<bool>(json['hasMorePages']);
  if (hasMorePages != null) {
    countrysEntity.hasMorePages = hasMorePages;
  }
  return countrysEntity;
}

Map<String, dynamic> $CountrysEntityToJson(CountrysEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['success'] = entity.success;
  data['errorMessage'] = entity.errorMessage;
  data['message'] = entity.message;
  data['data'] = entity.data?.map((v) => v.toJson()).toList();
  data['other'] = entity.other;
  data['total'] = entity.total;
  data['currentPage'] = entity.currentPage;
  data['perPage'] = entity.perPage;
  data['hasMorePages'] = entity.hasMorePages;
  return data;
}

extension CountrysEntityExtension on CountrysEntity {
  CountrysEntity copyWith({
    bool? success,
    String? errorMessage,
    String? message,
    List<CountrysData>? data,
    List<dynamic>? other,
    int? total,
    int? currentPage,
    int? perPage,
    bool? hasMorePages,
  }) {
    return CountrysEntity()
      ..success = success ?? this.success
      ..errorMessage = errorMessage ?? this.errorMessage
      ..message = message ?? this.message
      ..data = data ?? this.data
      ..other = other ?? this.other
      ..total = total ?? this.total
      ..currentPage = currentPage ?? this.currentPage
      ..perPage = perPage ?? this.perPage
      ..hasMorePages = hasMorePages ?? this.hasMorePages;
  }
}

CountrysData $CountrysDataFromJson(Map<String, dynamic> json) {
  final CountrysData countrysData = CountrysData();
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    countrysData.code = code;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    countrysData.name = name;
  }
  return countrysData;
}

Map<String, dynamic> $CountrysDataToJson(CountrysData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['name'] = entity.name;
  return data;
}

extension CountrysDataExtension on CountrysData {
  CountrysData copyWith({
    String? code,
    String? name,
  }) {
    return CountrysData()
      ..code = code ?? this.code
      ..name = name ?? this.name;
  }
}
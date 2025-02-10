import 'package:bounty_hunter/generated/json/base/json_convert_content.dart';
import 'package:bounty_hunter/models/admin_entity.dart';

AdminEntity $AdminEntityFromJson(Map<String, dynamic> json) {
  final AdminEntity adminEntity = AdminEntity();
  final List<AdminData>? data = (json['data'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<AdminData>(e) as AdminData).toList();
  if (data != null) {
    adminEntity.data = data;
  }
  final bool? success = jsonConvert.convert<bool>(json['success']);
  if (success != null) {
    adminEntity.success = success;
  }
  final String? errorMessage = jsonConvert.convert<String>(
      json['errorMessage']);
  if (errorMessage != null) {
    adminEntity.errorMessage = errorMessage;
  }
  final int? total = jsonConvert.convert<int>(json['total']);
  if (total != null) {
    adminEntity.total = total;
  }
  return adminEntity;
}

Map<String, dynamic> $AdminEntityToJson(AdminEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['data'] = entity.data?.map((v) => v.toJson()).toList();
  data['success'] = entity.success;
  data['errorMessage'] = entity.errorMessage;
  data['total'] = entity.total;
  return data;
}

extension AdminEntityExtension on AdminEntity {
  AdminEntity copyWith({
    List<AdminData>? data,
    bool? success,
    String? errorMessage,
    int? total,
  }) {
    return AdminEntity()
      ..data = data ?? this.data
      ..success = success ?? this.success
      ..errorMessage = errorMessage ?? this.errorMessage
      ..total = total ?? this.total;
  }
}

AdminData $AdminDataFromJson(Map<String, dynamic> json) {
  final AdminData adminData = AdminData();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    adminData.id = id;
  }
  final String? aName = jsonConvert.convert<String>(json['a_name']);
  if (aName != null) {
    adminData.aName = aName;
  }
  return adminData;
}

Map<String, dynamic> $AdminDataToJson(AdminData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['a_name'] = entity.aName;
  return data;
}

extension AdminDataExtension on AdminData {
  AdminData copyWith({
    int? id,
    String? aName,
  }) {
    return AdminData()
      ..id = id ?? this.id
      ..aName = aName ?? this.aName;
  }
}
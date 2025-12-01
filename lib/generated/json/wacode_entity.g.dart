import 'package:bounty_hunter/generated/json/base/json_convert_content.dart';
import 'package:bounty_hunter/models/wacode_entity.dart';

WacodeEntity $WacodeEntityFromJson(Map<String, dynamic> json) {
  final WacodeEntity wacodeEntity = WacodeEntity();
  final bool? success = jsonConvert.convert<bool>(json['success']);
  if (success != null) {
    wacodeEntity.success = success;
  }
  final String? errorMessage = jsonConvert.convert<String>(
      json['errorMessage']);
  if (errorMessage != null) {
    wacodeEntity.errorMessage = errorMessage;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    wacodeEntity.message = message;
  }
  final WacodeData? data = jsonConvert.convert<WacodeData>(json['data']);
  if (data != null) {
    wacodeEntity.data = data;
  }
  return wacodeEntity;
}

Map<String, dynamic> $WacodeEntityToJson(WacodeEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['success'] = entity.success;
  data['errorMessage'] = entity.errorMessage;
  data['message'] = entity.message;
  data['data'] = entity.data?.toJson();
  return data;
}

extension WacodeEntityExtension on WacodeEntity {
  WacodeEntity copyWith({
    bool? success,
    String? errorMessage,
    String? message,
    WacodeData? data,
  }) {
    return WacodeEntity()
      ..success = success ?? this.success
      ..errorMessage = errorMessage ?? this.errorMessage
      ..message = message ?? this.message
      ..data = data ?? this.data;
  }
}

WacodeData $WacodeDataFromJson(Map<String, dynamic> json) {
  final WacodeData wacodeData = WacodeData();
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    wacodeData.code = code;
  }
  return wacodeData;
}

Map<String, dynamic> $WacodeDataToJson(WacodeData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  return data;
}

extension WacodeDataExtension on WacodeData {
  WacodeData copyWith({
    String? code,
  }) {
    return WacodeData()
      ..code = code ?? this.code;
  }
}
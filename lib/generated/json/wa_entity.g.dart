import 'package:bounty_hunter/generated/json/base/json_convert_content.dart';
import 'package:bounty_hunter/models/wa_entity.dart';

WaEntity $WaEntityFromJson(Map<String, dynamic> json) {
  final WaEntity waEntity = WaEntity();
  final bool? success = jsonConvert.convert<bool>(json['success']);
  if (success != null) {
    waEntity.success = success;
  }
  final String? errorMessage = jsonConvert.convert<String>(
      json['errorMessage']);
  if (errorMessage != null) {
    waEntity.errorMessage = errorMessage;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    waEntity.message = message;
  }
  final WaData? data = jsonConvert.convert<WaData>(json['data']);
  if (data != null) {
    waEntity.data = data;
  }
  return waEntity;
}

Map<String, dynamic> $WaEntityToJson(WaEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['success'] = entity.success;
  data['errorMessage'] = entity.errorMessage;
  data['message'] = entity.message;
  data['data'] = entity.data?.toJson();
  return data;
}

extension WaEntityExtension on WaEntity {
  WaEntity copyWith({
    bool? success,
    String? errorMessage,
    String? message,
    WaData? data,
  }) {
    return WaEntity()
      ..success = success ?? this.success
      ..errorMessage = errorMessage ?? this.errorMessage
      ..message = message ?? this.message
      ..data = data ?? this.data;
  }
}

WaData $WaDataFromJson(Map<String, dynamic> json) {
  final WaData waData = WaData();
  final String? wa = jsonConvert.convert<String>(json['wa']);
  if (wa != null) {
    waData.wa = wa;
  }
  final String? activationId = jsonConvert.convert<String>(
      json['activation_id']);
  if (activationId != null) {
    waData.activationId = activationId;
  }
  final String? tip = jsonConvert.convert<String>(json['tip']);
  if (tip != null) {
    waData.tip = tip;
  }
  final String? tip2 = jsonConvert.convert<String>(json['tip2']);
  if (tip2 != null) {
    waData.tip2 = tip2;
  }
  return waData;
}

Map<String, dynamic> $WaDataToJson(WaData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['wa'] = entity.wa;
  data['activation_id'] = entity.activationId;
  data['tip'] = entity.tip;
  data['tip2'] = entity.tip2;
  return data;
}

extension WaDataExtension on WaData {
  WaData copyWith({
    String? wa,
    String? activationId,
    String? tip,
    String? tip2,
  }) {
    return WaData()
      ..wa = wa ?? this.wa
      ..activationId = activationId ?? this.activationId
      ..tip = tip ?? this.tip
      ..tip2 = tip2 ?? this.tip2;
  }
}
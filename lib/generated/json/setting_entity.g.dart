import 'package:bounty_hunter/generated/json/base/json_convert_content.dart';
import 'package:bounty_hunter/models/setting_entity.dart';

SettingEntity $SettingEntityFromJson(Map<String, dynamic> json) {
  final SettingEntity settingEntity = SettingEntity();
  final bool? success = jsonConvert.convert<bool>(json['success']);
  if (success != null) {
    settingEntity.success = success;
  }
  final SettingData? data = jsonConvert.convert<SettingData>(json['data']);
  if (data != null) {
    settingEntity.data = data;
  }
  final List<dynamic>? other = (json['other'] as List<dynamic>?)?.map(
          (e) => e).toList();
  if (other != null) {
    settingEntity.other = other;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    settingEntity.message = message;
  }
  return settingEntity;
}

Map<String, dynamic> $SettingEntityToJson(SettingEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['success'] = entity.success;
  data['data'] = entity.data?.toJson();
  data['other'] = entity.other;
  data['message'] = entity.message;
  return data;
}

extension SettingEntityExtension on SettingEntity {
  SettingEntity copyWith({
    bool? success,
    SettingData? data,
    List<dynamic>? other,
    String? message,
  }) {
    return SettingEntity()
      ..success = success ?? this.success
      ..data = data ?? this.data
      ..other = other ?? this.other
      ..message = message ?? this.message;
  }
}

SettingData $SettingDataFromJson(Map<String, dynamic> json) {
  final SettingData settingData = SettingData();
  final List<SettingDataProducts>? products = (json['products'] as List<
      dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<SettingDataProducts>(e) as SettingDataProducts)
      .toList();
  if (products != null) {
    settingData.products = products;
  }
  return settingData;
}

Map<String, dynamic> $SettingDataToJson(SettingData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['products'] = entity.products?.map((v) => v.toJson()).toList();
  return data;
}

extension SettingDataExtension on SettingData {
  SettingData copyWith({
    List<SettingDataProducts>? products,
  }) {
    return SettingData()
      ..products = products ?? this.products;
  }
}

SettingDataProducts $SettingDataProductsFromJson(Map<String, dynamic> json) {
  final SettingDataProducts settingDataProducts = SettingDataProducts();
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    settingDataProducts.title = title;
  }
  final String? value = jsonConvert.convert<String>(json['value']);
  if (value != null) {
    settingDataProducts.value = value;
  }
  final String? logo = jsonConvert.convert<String>(json['logo']);
  if (logo != null) {
    settingDataProducts.logo = logo;
  }
  return settingDataProducts;
}

Map<String, dynamic> $SettingDataProductsToJson(SettingDataProducts entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['title'] = entity.title;
  data['value'] = entity.value;
  data['logo'] = entity.logo;
  return data;
}

extension SettingDataProductsExtension on SettingDataProducts {
  SettingDataProducts copyWith({
    String? title,
    String? value,
    String? logo,
  }) {
    return SettingDataProducts()
      ..title = title ?? this.title
      ..value = value ?? this.value
      ..logo = logo ?? this.logo;
  }
}
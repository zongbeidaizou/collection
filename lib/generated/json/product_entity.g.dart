import 'package:bounty_hunter/generated/json/base/json_convert_content.dart';
import 'package:bounty_hunter/models/product_entity.dart';

ProductEntity $ProductEntityFromJson(Map<String, dynamic> json) {
  final ProductEntity productEntity = ProductEntity();
  final List<ProductData>? data = (json['data'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<ProductData>(e) as ProductData).toList();
  if (data != null) {
    productEntity.data = data;
  }
  final bool? success = jsonConvert.convert<bool>(json['success']);
  if (success != null) {
    productEntity.success = success;
  }
  final String? errorMessage = jsonConvert.convert<String>(
      json['errorMessage']);
  if (errorMessage != null) {
    productEntity.errorMessage = errorMessage;
  }
  final int? total = jsonConvert.convert<int>(json['total']);
  if (total != null) {
    productEntity.total = total;
  }
  return productEntity;
}

Map<String, dynamic> $ProductEntityToJson(ProductEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['data'] = entity.data?.map((v) => v.toJson()).toList();
  data['success'] = entity.success;
  data['errorMessage'] = entity.errorMessage;
  data['total'] = entity.total;
  return data;
}

extension ProductEntityExtension on ProductEntity {
  ProductEntity copyWith({
    List<ProductData>? data,
    bool? success,
    String? errorMessage,
    int? total,
  }) {
    return ProductEntity()
      ..data = data ?? this.data
      ..success = success ?? this.success
      ..errorMessage = errorMessage ?? this.errorMessage
      ..total = total ?? this.total;
  }
}

ProductData $ProductDataFromJson(Map<String, dynamic> json) {
  final ProductData productData = ProductData();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    productData.id = id;
  }
  final String? bName = jsonConvert.convert<String>(json['b_name']);
  if (bName != null) {
    productData.bName = bName;
  }
  return productData;
}

Map<String, dynamic> $ProductDataToJson(ProductData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['b_name'] = entity.bName;
  return data;
}

extension ProductDataExtension on ProductData {
  ProductData copyWith({
    int? id,
    String? bName,
  }) {
    return ProductData()
      ..id = id ?? this.id
      ..bName = bName ?? this.bName;
  }
}
import 'package:bounty_hunter/generated/json/base/json_field.dart';
import 'package:bounty_hunter/generated/json/product_entity.g.dart';
import 'dart:convert';
export 'package:bounty_hunter/generated/json/product_entity.g.dart';

@JsonSerializable()
class ProductEntity {
	List<ProductData>? data = [];
	bool? success = false;
	String? errorMessage = '';
	int? total = 0;

	ProductEntity();

	factory ProductEntity.fromJson(Map<String, dynamic> json) => $ProductEntityFromJson(json);

	Map<String, dynamic> toJson() => $ProductEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ProductData {
	int? id = 0;
	@JSONField(name: "b_name")
	String? bName = '';

	ProductData();

	factory ProductData.fromJson(Map<String, dynamic> json) => $ProductDataFromJson(json);

	Map<String, dynamic> toJson() => $ProductDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}
import 'package:bounty_hunter/generated/json/base/json_field.dart';
import 'package:bounty_hunter/generated/json/message_template_entity.g.dart';
import 'dart:convert';
export 'package:bounty_hunter/generated/json/message_template_entity.g.dart';

@JsonSerializable()
class MessageTemplateEntity {
	bool? success = false;
	String? errorMessage = '';
	String? message = '';
	List<MessageTemplateData>? data = [];
	List<dynamic>? other = [];
	int? total = 0;
	int? currentPage = 0;
	int? perPage = 0;
	bool? hasMorePages = false;

	MessageTemplateEntity();

	factory MessageTemplateEntity.fromJson(Map<String, dynamic> json) => $MessageTemplateEntityFromJson(json);

	Map<String, dynamic> toJson() => $MessageTemplateEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class MessageTemplateData {
	int? id = 0;
	String? title = '';
	String? message = '';
	int? type = 0;
	@JSONField(name: 'available_days')
	int? availableDays = 0;
	int? category = 0;
	@JSONField(name: 'admin_id')
	int? adminId = 0;
	int? status = 0;
	@JSONField(name: 'created_at')
	String? createdAt = '';

	MessageTemplateData();

	factory MessageTemplateData.fromJson(Map<String, dynamic> json) => $MessageTemplateDataFromJson(json);

	Map<String, dynamic> toJson() => $MessageTemplateDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}
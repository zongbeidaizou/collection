import 'package:bounty_hunter/generated/json/base/json_convert_content.dart';
import 'package:bounty_hunter/models/message_template_entity.dart';

MessageTemplateEntity $MessageTemplateEntityFromJson(
    Map<String, dynamic> json) {
  final MessageTemplateEntity messageTemplateEntity = MessageTemplateEntity();
  final bool? success = jsonConvert.convert<bool>(json['success']);
  if (success != null) {
    messageTemplateEntity.success = success;
  }
  final String? errorMessage = jsonConvert.convert<String>(
      json['errorMessage']);
  if (errorMessage != null) {
    messageTemplateEntity.errorMessage = errorMessage;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    messageTemplateEntity.message = message;
  }
  final List<MessageTemplateData>? data = (json['data'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<MessageTemplateData>(e) as MessageTemplateData)
      .toList();
  if (data != null) {
    messageTemplateEntity.data = data;
  }
  final List<dynamic>? other = (json['other'] as List<dynamic>?)?.map(
          (e) => e).toList();
  if (other != null) {
    messageTemplateEntity.other = other;
  }
  final int? total = jsonConvert.convert<int>(json['total']);
  if (total != null) {
    messageTemplateEntity.total = total;
  }
  final int? currentPage = jsonConvert.convert<int>(json['currentPage']);
  if (currentPage != null) {
    messageTemplateEntity.currentPage = currentPage;
  }
  final int? perPage = jsonConvert.convert<int>(json['perPage']);
  if (perPage != null) {
    messageTemplateEntity.perPage = perPage;
  }
  final bool? hasMorePages = jsonConvert.convert<bool>(json['hasMorePages']);
  if (hasMorePages != null) {
    messageTemplateEntity.hasMorePages = hasMorePages;
  }
  return messageTemplateEntity;
}

Map<String, dynamic> $MessageTemplateEntityToJson(
    MessageTemplateEntity entity) {
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

extension MessageTemplateEntityExtension on MessageTemplateEntity {
  MessageTemplateEntity copyWith({
    bool? success,
    String? errorMessage,
    String? message,
    List<MessageTemplateData>? data,
    List<dynamic>? other,
    int? total,
    int? currentPage,
    int? perPage,
    bool? hasMorePages,
  }) {
    return MessageTemplateEntity()
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

MessageTemplateData $MessageTemplateDataFromJson(Map<String, dynamic> json) {
  final MessageTemplateData messageTemplateData = MessageTemplateData();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    messageTemplateData.id = id;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    messageTemplateData.title = title;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    messageTemplateData.message = message;
  }
  final int? type = jsonConvert.convert<int>(json['type']);
  if (type != null) {
    messageTemplateData.type = type;
  }
  final int? availableDays = jsonConvert.convert<int>(json['available_days']);
  if (availableDays != null) {
    messageTemplateData.availableDays = availableDays;
  }
  final int? category = jsonConvert.convert<int>(json['category']);
  if (category != null) {
    messageTemplateData.category = category;
  }
  final int? adminId = jsonConvert.convert<int>(json['admin_id']);
  if (adminId != null) {
    messageTemplateData.adminId = adminId;
  }
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    messageTemplateData.status = status;
  }
  final String? createdAt = jsonConvert.convert<String>(json['created_at']);
  if (createdAt != null) {
    messageTemplateData.createdAt = createdAt;
  }
  return messageTemplateData;
}

Map<String, dynamic> $MessageTemplateDataToJson(MessageTemplateData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['title'] = entity.title;
  data['message'] = entity.message;
  data['type'] = entity.type;
  data['available_days'] = entity.availableDays;
  data['category'] = entity.category;
  data['admin_id'] = entity.adminId;
  data['status'] = entity.status;
  data['created_at'] = entity.createdAt;
  return data;
}

extension MessageTemplateDataExtension on MessageTemplateData {
  MessageTemplateData copyWith({
    int? id,
    String? title,
    String? message,
    int? type,
    int? availableDays,
    int? category,
    int? adminId,
    int? status,
    String? createdAt,
  }) {
    return MessageTemplateData()
      ..id = id ?? this.id
      ..title = title ?? this.title
      ..message = message ?? this.message
      ..type = type ?? this.type
      ..availableDays = availableDays ?? this.availableDays
      ..category = category ?? this.category
      ..adminId = adminId ?? this.adminId
      ..status = status ?? this.status
      ..createdAt = createdAt ?? this.createdAt;
  }
}
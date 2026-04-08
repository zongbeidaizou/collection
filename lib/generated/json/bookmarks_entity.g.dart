import 'package:bounty_hunter/generated/json/base/json_convert_content.dart';
import 'package:bounty_hunter/models/bookmarks_entity.dart';

BookmarksEntity $BookmarksEntityFromJson(Map<String, dynamic> json) {
  final BookmarksEntity bookmarksEntity = BookmarksEntity();
  final bool? success = jsonConvert.convert<bool>(json['success']);
  if (success != null) {
    bookmarksEntity.success = success;
  }
  final String? errorMessage = jsonConvert.convert<String>(
      json['errorMessage']);
  if (errorMessage != null) {
    bookmarksEntity.errorMessage = errorMessage;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    bookmarksEntity.message = message;
  }
  final List<BookmarksData>? data = (json['data'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<BookmarksData>(e) as BookmarksData)
      .toList();
  if (data != null) {
    bookmarksEntity.data = data;
  }
  final List<dynamic>? other = (json['other'] as List<dynamic>?)?.map(
          (e) => e).toList();
  if (other != null) {
    bookmarksEntity.other = other;
  }
  final int? total = jsonConvert.convert<int>(json['total']);
  if (total != null) {
    bookmarksEntity.total = total;
  }
  final int? currentPage = jsonConvert.convert<int>(json['currentPage']);
  if (currentPage != null) {
    bookmarksEntity.currentPage = currentPage;
  }
  final int? perPage = jsonConvert.convert<int>(json['perPage']);
  if (perPage != null) {
    bookmarksEntity.perPage = perPage;
  }
  final bool? hasMorePages = jsonConvert.convert<bool>(json['hasMorePages']);
  if (hasMorePages != null) {
    bookmarksEntity.hasMorePages = hasMorePages;
  }
  return bookmarksEntity;
}

Map<String, dynamic> $BookmarksEntityToJson(BookmarksEntity entity) {
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

extension BookmarksEntityExtension on BookmarksEntity {
  BookmarksEntity copyWith({
    bool? success,
    String? errorMessage,
    String? message,
    List<BookmarksData>? data,
    List<dynamic>? other,
    int? total,
    int? currentPage,
    int? perPage,
    bool? hasMorePages,
  }) {
    return BookmarksEntity()
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

BookmarksData $BookmarksDataFromJson(Map<String, dynamic> json) {
  final BookmarksData bookmarksData = BookmarksData();
  final int? aAdminId = jsonConvert.convert<int>(json['a_admin_id']);
  if (aAdminId != null) {
    bookmarksData.aAdminId = aAdminId;
  }
  final String? bPhone = jsonConvert.convert<String>(json['b_phone']);
  if (bPhone != null) {
    bookmarksData.bPhone = bPhone;
  }
  final int? cReceiveCount = jsonConvert.convert<int>(json['c_receive_count']);
  if (cReceiveCount != null) {
    bookmarksData.cReceiveCount = cReceiveCount;
  }
  final String? createdAt = jsonConvert.convert<String>(json['created_at']);
  if (createdAt != null) {
    bookmarksData.createdAt = createdAt;
  }
  final String? updatedAt = jsonConvert.convert<String>(json['updated_at']);
  if (updatedAt != null) {
    bookmarksData.updatedAt = updatedAt;
  }
  return bookmarksData;
}

Map<String, dynamic> $BookmarksDataToJson(BookmarksData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['a_admin_id'] = entity.aAdminId;
  data['b_phone'] = entity.bPhone;
  data['c_receive_count'] = entity.cReceiveCount;
  data['created_at'] = entity.createdAt;
  data['updated_at'] = entity.updatedAt;
  return data;
}

extension BookmarksDataExtension on BookmarksData {
  BookmarksData copyWith({
    int? aAdminId,
    String? bPhone,
    int? cReceiveCount,
    String? createdAt,
    String? updatedAt,
  }) {
    return BookmarksData()
      ..aAdminId = aAdminId ?? this.aAdminId
      ..bPhone = bPhone ?? this.bPhone
      ..cReceiveCount = cReceiveCount ?? this.cReceiveCount
      ..createdAt = createdAt ?? this.createdAt
      ..updatedAt = updatedAt ?? this.updatedAt;
  }
}
import 'package:bounty_hunter/generated/json/base/json_field.dart';
import 'package:bounty_hunter/generated/json/bookmarks_entity.g.dart';
import 'dart:convert';
export 'package:bounty_hunter/generated/json/bookmarks_entity.g.dart';

@JsonSerializable()
class BookmarksEntity {
	bool? success = false;
	String? errorMessage = '';
	String? message = '';
	List<BookmarksData>? data = [];
	List<dynamic>? other = [];
	int? total = 0;
	int? currentPage = 0;
	int? perPage = 0;
	bool? hasMorePages = false;

	BookmarksEntity();

	factory BookmarksEntity.fromJson(Map<String, dynamic> json) => $BookmarksEntityFromJson(json);

	Map<String, dynamic> toJson() => $BookmarksEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class BookmarksData {
	@JSONField(name: 'a_admin_id')
	int? aAdminId = 0;
	@JSONField(name: 'b_phone')
	String? bPhone = '';
	@JSONField(name: 'c_receive_count')
	int? cReceiveCount = 0;
	@JSONField(name: 'created_at')
	String? createdAt = '';
	@JSONField(name: 'updated_at')
	String? updatedAt = '';

	BookmarksData();

	factory BookmarksData.fromJson(Map<String, dynamic> json) => $BookmarksDataFromJson(json);

	Map<String, dynamic> toJson() => $BookmarksDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}
import 'package:bounty_hunter/generated/json/base/json_field.dart';
import 'package:bounty_hunter/generated/json/authoriz_store_entity.g.dart';
import 'dart:convert';
export 'package:bounty_hunter/generated/json/authoriz_store_entity.g.dart';

@JsonSerializable()
class AuthorizStoreEntity {
	AuthorizStorePassport? passport;

	AuthorizStoreEntity();

	factory AuthorizStoreEntity.fromJson(Map<String, dynamic> json) => $AuthorizStoreEntityFromJson(json);

	Map<String, dynamic> toJson() => $AuthorizStoreEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class AuthorizStorePassport {
	@JSONField(name: "token_type")
	String? tokenType = '';
	@JSONField(name: "expires_in")
	int? expiresIn = 0;
	@JSONField(name: "access_token")
	String? accessToken = '';
	@JSONField(name: "refresh_token")
	String? refreshToken = '';

	AuthorizStorePassport();

	factory AuthorizStorePassport.fromJson(Map<String, dynamic> json) => $AuthorizStorePassportFromJson(json);

	Map<String, dynamic> toJson() => $AuthorizStorePassportToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}
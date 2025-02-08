import 'package:bounty_hunter/generated/json/base/json_convert_content.dart';
import 'package:bounty_hunter/models/authoriz_store_entity.dart';

AuthorizStoreEntity $AuthorizStoreEntityFromJson(Map<String, dynamic> json) {
  final AuthorizStoreEntity authorizStoreEntity = AuthorizStoreEntity();
  final AuthorizStorePassport? passport = jsonConvert.convert<
      AuthorizStorePassport>(json['passport']);
  if (passport != null) {
    authorizStoreEntity.passport = passport;
  }
  return authorizStoreEntity;
}

Map<String, dynamic> $AuthorizStoreEntityToJson(AuthorizStoreEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['passport'] = entity.passport?.toJson();
  return data;
}

extension AuthorizStoreEntityExtension on AuthorizStoreEntity {
  AuthorizStoreEntity copyWith({
    AuthorizStorePassport? passport,
  }) {
    return AuthorizStoreEntity()
      ..passport = passport ?? this.passport;
  }
}

AuthorizStorePassport $AuthorizStorePassportFromJson(
    Map<String, dynamic> json) {
  final AuthorizStorePassport authorizStorePassport = AuthorizStorePassport();
  final String? tokenType = jsonConvert.convert<String>(json['token_type']);
  if (tokenType != null) {
    authorizStorePassport.tokenType = tokenType;
  }
  final int? expiresIn = jsonConvert.convert<int>(json['expires_in']);
  if (expiresIn != null) {
    authorizStorePassport.expiresIn = expiresIn;
  }
  final String? accessToken = jsonConvert.convert<String>(json['access_token']);
  if (accessToken != null) {
    authorizStorePassport.accessToken = accessToken;
  }
  final String? refreshToken = jsonConvert.convert<String>(
      json['refresh_token']);
  if (refreshToken != null) {
    authorizStorePassport.refreshToken = refreshToken;
  }
  return authorizStorePassport;
}

Map<String, dynamic> $AuthorizStorePassportToJson(
    AuthorizStorePassport entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['token_type'] = entity.tokenType;
  data['expires_in'] = entity.expiresIn;
  data['access_token'] = entity.accessToken;
  data['refresh_token'] = entity.refreshToken;
  return data;
}

extension AuthorizStorePassportExtension on AuthorizStorePassport {
  AuthorizStorePassport copyWith({
    String? tokenType,
    int? expiresIn,
    String? accessToken,
    String? refreshToken,
  }) {
    return AuthorizStorePassport()
      ..tokenType = tokenType ?? this.tokenType
      ..expiresIn = expiresIn ?? this.expiresIn
      ..accessToken = accessToken ?? this.accessToken
      ..refreshToken = refreshToken ?? this.refreshToken;
  }
}
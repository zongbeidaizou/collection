import 'package:bounty_hunter/generated/json/base/json_convert_content.dart';
import 'package:bounty_hunter/shop/models/user_entity.dart';

UserEntity $UserEntityFromJson(Map<String, dynamic> json) {
  final UserEntity userEntity = UserEntity();
  final String? avatarUrl = jsonConvert.convert<String>(json['avatar_url']);
  if (avatarUrl != null) {
    userEntity.avatarUrl = avatarUrl;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    userEntity.name = name;
  }
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    userEntity.id = id;
  }
  final String? blog = jsonConvert.convert<String>(json['blog']);
  if (blog != null) {
    userEntity.blog = blog;
  }
  return userEntity;
}

Map<String, dynamic> $UserEntityToJson(UserEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['avatar_url'] = entity.avatarUrl;
  data['name'] = entity.name;
  data['id'] = entity.id;
  data['blog'] = entity.blog;
  return data;
}

extension UserEntityExtension on UserEntity {
  UserEntity copyWith({
    String? avatarUrl,
    String? name,
    int? id,
    String? blog,
  }) {
    return UserEntity()
      ..avatarUrl = avatarUrl ?? this.avatarUrl
      ..name = name ?? this.name
      ..id = id ?? this.id
      ..blog = blog ?? this.blog;
  }
}
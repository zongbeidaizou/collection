import 'package:bounty_hunter/generated/json/base/json_field.dart';
import 'package:bounty_hunter/generated/json/user_entity.g.dart';

@JsonSerializable()
class UserEntity {

	UserEntity();

	factory UserEntity.fromJson(Map<String, dynamic> json) => $UserEntityFromJson(json);

	Map<String, dynamic> toJson() => $UserEntityToJson(this);

	@JSONField(name: 'avatar_url')
	String? avatarUrl;
	String? name;
	int? id;
	String? blog;
}

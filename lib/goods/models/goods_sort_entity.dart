import 'package:bounty_hunter/generated/json/base/json_field.dart';
import 'package:bounty_hunter/generated/json/goods_sort_entity.g.dart';


@JsonSerializable()
class GoodsSortEntity {

	GoodsSortEntity();

	factory GoodsSortEntity.fromJson(Map<String, dynamic> json) => $GoodsSortEntityFromJson(json);

	Map<String, dynamic> toJson() => $GoodsSortEntityToJson(this);

	late String id;
	late String name;
}

import 'package:bounty_hunter/generated/json/base/json_convert_content.dart';
import 'package:bounty_hunter/models/help_entity.dart';

HelpEntity $HelpEntityFromJson(Map<String, dynamic> json) {
  final HelpEntity helpEntity = HelpEntity();
  final bool? success = jsonConvert.convert<bool>(json['success']);
  if (success != null) {
    helpEntity.success = success;
  }
  final String? errorMessage = jsonConvert.convert<String>(
      json['errorMessage']);
  if (errorMessage != null) {
    helpEntity.errorMessage = errorMessage;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    helpEntity.message = message;
  }
  final List<HelpData>? data = (json['data'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<HelpData>(e) as HelpData).toList();
  if (data != null) {
    helpEntity.data = data;
  }
  final HelpOther? other = jsonConvert.convert<HelpOther>(json['other']);
  if (other != null) {
    helpEntity.other = other;
  }
  final int? total = jsonConvert.convert<int>(json['total']);
  if (total != null) {
    helpEntity.total = total;
  }
  final int? currentPage = jsonConvert.convert<int>(json['currentPage']);
  if (currentPage != null) {
    helpEntity.currentPage = currentPage;
  }
  final int? perPage = jsonConvert.convert<int>(json['perPage']);
  if (perPage != null) {
    helpEntity.perPage = perPage;
  }
  final bool? hasMorePages = jsonConvert.convert<bool>(json['hasMorePages']);
  if (hasMorePages != null) {
    helpEntity.hasMorePages = hasMorePages;
  }
  return helpEntity;
}

Map<String, dynamic> $HelpEntityToJson(HelpEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['success'] = entity.success;
  data['errorMessage'] = entity.errorMessage;
  data['message'] = entity.message;
  data['data'] = entity.data?.map((v) => v.toJson()).toList();
  data['other'] = entity.other?.toJson();
  data['total'] = entity.total;
  data['currentPage'] = entity.currentPage;
  data['perPage'] = entity.perPage;
  data['hasMorePages'] = entity.hasMorePages;
  return data;
}

extension HelpEntityExtension on HelpEntity {
  HelpEntity copyWith({
    bool? success,
    String? errorMessage,
    String? message,
    List<HelpData>? data,
    HelpOther? other,
    int? total,
    int? currentPage,
    int? perPage,
    bool? hasMorePages,
  }) {
    return HelpEntity()
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

HelpData $HelpDataFromJson(Map<String, dynamic> json) {
  final HelpData helpData = HelpData();
  final String? tab = jsonConvert.convert<String>(json['tab']);
  if (tab != null) {
    helpData.tab = tab;
  }
  final List<HelpDataItems>? items = (json['items'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<HelpDataItems>(e) as HelpDataItems)
      .toList();
  if (items != null) {
    helpData.items = items;
  }
  return helpData;
}

Map<String, dynamic> $HelpDataToJson(HelpData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['tab'] = entity.tab;
  data['items'] = entity.items?.map((v) => v.toJson()).toList();
  return data;
}

extension HelpDataExtension on HelpData {
  HelpData copyWith({
    String? tab,
    List<HelpDataItems>? items,
  }) {
    return HelpData()
      ..tab = tab ?? this.tab
      ..items = items ?? this.items;
  }
}

HelpDataItems $HelpDataItemsFromJson(Map<String, dynamic> json) {
  final HelpDataItems helpDataItems = HelpDataItems();
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    helpDataItems.title = title;
  }
  final String? image = jsonConvert.convert<String>(json['image']);
  if (image != null) {
    helpDataItems.image = image;
  }
  final String? instruction = jsonConvert.convert<String>(json['instruction']);
  if (instruction != null) {
    helpDataItems.instruction = instruction;
  }
  final String? fit = jsonConvert.convert<String>(json['fit']);
  if (fit != null) {
    helpDataItems.fit = fit;
  }
  final List<HelpDataItemsSteps>? steps = (json['steps'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<HelpDataItemsSteps>(e) as HelpDataItemsSteps)
      .toList();
  if (steps != null) {
    helpDataItems.steps = steps;
  }
  return helpDataItems;
}

Map<String, dynamic> $HelpDataItemsToJson(HelpDataItems entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['title'] = entity.title;
  data['image'] = entity.image;
  data['instruction'] = entity.instruction;
  data['fit'] = entity.fit;
  data['steps'] = entity.steps?.map((v) => v.toJson()).toList();
  return data;
}

extension HelpDataItemsExtension on HelpDataItems {
  HelpDataItems copyWith({
    String? title,
    String? image,
    String? instruction,
    String? fit,
    List<HelpDataItemsSteps>? steps,
  }) {
    return HelpDataItems()
      ..title = title ?? this.title
      ..image = image ?? this.image
      ..instruction = instruction ?? this.instruction
      ..fit = fit ?? this.fit
      ..steps = steps ?? this.steps;
  }
}

HelpDataItemsSteps $HelpDataItemsStepsFromJson(Map<String, dynamic> json) {
  final HelpDataItemsSteps helpDataItemsSteps = HelpDataItemsSteps();
  final int? no = jsonConvert.convert<int>(json['no']);
  if (no != null) {
    helpDataItemsSteps.no = no;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    helpDataItemsSteps.title = title;
  }
  final String? description = jsonConvert.convert<String>(json['description']);
  if (description != null) {
    helpDataItemsSteps.description = description;
  }
  final List<HelpDataItemsStepsIcons>? icons = (json['icons'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<HelpDataItemsStepsIcons>(
          e) as HelpDataItemsStepsIcons)
      .toList();
  if (icons != null) {
    helpDataItemsSteps.icons = icons;
  }
  return helpDataItemsSteps;
}

Map<String, dynamic> $HelpDataItemsStepsToJson(HelpDataItemsSteps entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['no'] = entity.no;
  data['title'] = entity.title;
  data['description'] = entity.description;
  data['icons'] = entity.icons?.map((v) => v.toJson()).toList();
  return data;
}

extension HelpDataItemsStepsExtension on HelpDataItemsSteps {
  HelpDataItemsSteps copyWith({
    int? no,
    String? title,
    String? description,
    List<HelpDataItemsStepsIcons>? icons,
  }) {
    return HelpDataItemsSteps()
      ..no = no ?? this.no
      ..title = title ?? this.title
      ..description = description ?? this.description
      ..icons = icons ?? this.icons;
  }
}

HelpDataItemsStepsIcons $HelpDataItemsStepsIconsFromJson(
    Map<String, dynamic> json) {
  final HelpDataItemsStepsIcons helpDataItemsStepsIcons = HelpDataItemsStepsIcons();
  final String? icon = jsonConvert.convert<String>(json['icon']);
  if (icon != null) {
    helpDataItemsStepsIcons.icon = icon;
  }
  final String? text = jsonConvert.convert<String>(json['text']);
  if (text != null) {
    helpDataItemsStepsIcons.text = text;
  }
  return helpDataItemsStepsIcons;
}

Map<String, dynamic> $HelpDataItemsStepsIconsToJson(
    HelpDataItemsStepsIcons entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['icon'] = entity.icon;
  data['text'] = entity.text;
  return data;
}

extension HelpDataItemsStepsIconsExtension on HelpDataItemsStepsIcons {
  HelpDataItemsStepsIcons copyWith({
    String? icon,
    String? text,
  }) {
    return HelpDataItemsStepsIcons()
      ..icon = icon ?? this.icon
      ..text = text ?? this.text;
  }
}

HelpOther $HelpOtherFromJson(Map<String, dynamic> json) {
  final HelpOther helpOther = HelpOther();
  final String? h5 = jsonConvert.convert<String>(json['h5']);
  if (h5 != null) {
    helpOther.h5 = h5;
  }
  final String? foo = jsonConvert.convert<String>(json['foo']);
  if (foo != null) {
    helpOther.foo = foo;
  }
  final String? bar = jsonConvert.convert<String>(json['bar']);
  if (bar != null) {
    helpOther.bar = bar;
  }
  return helpOther;
}

Map<String, dynamic> $HelpOtherToJson(HelpOther entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['h5'] = entity.h5;
  data['foo'] = entity.foo;
  data['bar'] = entity.bar;
  return data;
}

extension HelpOtherExtension on HelpOther {
  HelpOther copyWith({
    String? h5,
    String? foo,
    String? bar,
  }) {
    return HelpOther()
      ..h5 = h5 ?? this.h5
      ..foo = foo ?? this.foo
      ..bar = bar ?? this.bar;
  }
}
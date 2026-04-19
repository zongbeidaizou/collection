import 'package:bounty_hunter/generated/json/base/json_convert_content.dart';
import 'package:bounty_hunter/models/shop_entity.dart';
import 'package:bounty_hunter/models/collection_order_entity.dart';


ShopEntity $ShopEntityFromJson(Map<String, dynamic> json) {
  final ShopEntity shopEntity = ShopEntity();
  final bool? success = jsonConvert.convert<bool>(json['success']);
  if (success != null) {
    shopEntity.success = success;
  }
  final ShopData? data = jsonConvert.convert<ShopData>(json['data']);
  if (data != null) {
    shopEntity.data = data;
  }
  final CollectionOrderOther? other = jsonConvert.convert<CollectionOrderOther>(
      json['other']);
  if (other != null) {
    shopEntity.other = other;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    shopEntity.message = message;
  }
  return shopEntity;
}

Map<String, dynamic> $ShopEntityToJson(ShopEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['success'] = entity.success;
  data['data'] = entity.data?.toJson();
  data['other'] = entity.other?.toJson();
  data['message'] = entity.message;
  return data;
}

extension ShopEntityExtension on ShopEntity {
  ShopEntity copyWith({
    bool? success,
    ShopData? data,
    CollectionOrderOther? other,
    String? message,
  }) {
    return ShopEntity()
      ..success = success ?? this.success
      ..data = data ?? this.data
      ..other = other ?? this.other
      ..message = message ?? this.message;
  }
}

ShopData $ShopDataFromJson(Map<String, dynamic> json) {
  final ShopData shopData = ShopData();
  final String? webUrl = jsonConvert.convert<String>(json['web_url']);
  if (webUrl != null) {
    shopData.webUrl = webUrl;
  }
  final bool? showMonthData = jsonConvert.convert<bool>(
      json['show_month_data']);
  if (showMonthData != null) {
    shopData.showMonthData = showMonthData;
  }
  final List<ShopDataMonthData>? monthData = (json['month_data'] as List<
      dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<ShopDataMonthData>(e) as ShopDataMonthData)
      .toList();
  if (monthData != null) {
    shopData.monthData = monthData;
  }
  final bool? showMonthRepayData = jsonConvert.convert<bool>(
      json['show_month_repay_data']);
  if (showMonthRepayData != null) {
    shopData.showMonthRepayData = showMonthRepayData;
  }
  final List<
      ShopDataMonthData>? monthRepayData = (json['month_repay_data'] as List<
      dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<ShopDataMonthData>(e) as ShopDataMonthData)
      .toList();
  if (monthRepayData != null) {
    shopData.monthRepayData = monthRepayData;
  }
  final bool? showMonthRegBonusData = jsonConvert.convert<bool>(
      json['show_month_reg_bonus_data']);
  if (showMonthRegBonusData != null) {
    shopData.showMonthRegBonusData = showMonthRegBonusData;
  }
  final List<
      ShopDataMonthData>? monthRegBonusData = (json['month_reg_bonus_data'] as List<
      dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<ShopDataMonthData>(e) as ShopDataMonthData)
      .toList();
  if (monthRegBonusData != null) {
    shopData.monthRegBonusData = monthRegBonusData;
  }
  final bool? showMonthApplyBonusData = jsonConvert.convert<bool>(
      json['show_month_apply_bonus_data']);
  if (showMonthApplyBonusData != null) {
    shopData.showMonthApplyBonusData = showMonthApplyBonusData;
  }
  final List<
      ShopDataMonthData>? monthApplyBonusData = (json['month_apply_bonus_data'] as List<
      dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<ShopDataMonthData>(e) as ShopDataMonthData)
      .toList();
  if (monthApplyBonusData != null) {
    shopData.monthApplyBonusData = monthApplyBonusData;
  }
  final bool? showWeekCaseData = jsonConvert.convert<bool>(
      json['show_week_case_data']);
  if (showWeekCaseData != null) {
    shopData.showWeekCaseData = showWeekCaseData;
  }
  final List<
      ShopDataWeekCaseData>? weekCaseData = (json['week_case_data'] as List<
      dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<ShopDataWeekCaseData>(e) as ShopDataWeekCaseData)
      .toList();
  if (weekCaseData != null) {
    shopData.weekCaseData = weekCaseData;
  }
  final bool? showWeekBonusData = jsonConvert.convert<bool>(
      json['show_week_bonus_data']);
  if (showWeekBonusData != null) {
    shopData.showWeekBonusData = showWeekBonusData;
  }
  final List<
      ShopDataWeekBonusData>? weekBonusData = (json['week_bonus_data'] as List<
      dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<ShopDataWeekBonusData>(e) as ShopDataWeekBonusData)
      .toList();
  if (weekBonusData != null) {
    shopData.weekBonusData = weekBonusData;
  }
  final bool? showMonthCaseData = jsonConvert.convert<bool>(
      json['show_month_case_data']);
  if (showMonthCaseData != null) {
    shopData.showMonthCaseData = showMonthCaseData;
  }
  final List<
      ShopDataMonthCaseData>? monthCaseData = (json['month_case_data'] as List<
      dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<ShopDataMonthCaseData>(e) as ShopDataMonthCaseData)
      .toList();
  if (monthCaseData != null) {
    shopData.monthCaseData = monthCaseData;
  }
  final bool? showMonthBonusData = jsonConvert.convert<bool>(
      json['show_month_bonus_data']);
  if (showMonthBonusData != null) {
    shopData.showMonthBonusData = showMonthBonusData;
  }
  final List<
      ShopDataMonthBonusData>? monthBonusData = (json['month_bonus_data'] as List<
      dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<ShopDataMonthBonusData>(e) as ShopDataMonthBonusData)
      .toList();
  if (monthBonusData != null) {
    shopData.monthBonusData = monthBonusData;
  }
  final bool? showMonthAdditionData = jsonConvert.convert<bool>(
      json['show_month_addition_data']);
  if (showMonthAdditionData != null) {
    shopData.showMonthAdditionData = showMonthAdditionData;
  }
  final List<
      ShopDataMonthAdditionData>? monthAdditionData = (json['month_addition_data'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<ShopDataMonthAdditionData>(
          e) as ShopDataMonthAdditionData).toList();
  if (monthAdditionData != null) {
    shopData.monthAdditionData = monthAdditionData;
  }
  final bool? showWeekRegisterData = jsonConvert.convert<bool>(
      json['show_week_register_data']);
  if (showWeekRegisterData != null) {
    shopData.showWeekRegisterData = showWeekRegisterData;
  }
  final List<
      ShopDataWeekCaseData>? weekRegisterData = (json['week_register_data'] as List<
      dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<ShopDataWeekCaseData>(e) as ShopDataWeekCaseData)
      .toList();
  if (weekRegisterData != null) {
    shopData.weekRegisterData = weekRegisterData;
  }
  final bool? showWeekApplyData = jsonConvert.convert<bool>(
      json['show_week_apply_data']);
  if (showWeekApplyData != null) {
    shopData.showWeekApplyData = showWeekApplyData;
  }
  final List<
      ShopDataWeekCaseData>? weekApplyData = (json['week_apply_data'] as List<
      dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<ShopDataWeekCaseData>(e) as ShopDataWeekCaseData)
      .toList();
  if (weekApplyData != null) {
    shopData.weekApplyData = weekApplyData;
  }
  final List<String>? notificationData = (json['notification_data'] as List<
      dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (notificationData != null) {
    shopData.notificationData = notificationData;
  }
  final String? notificationShowDate = jsonConvert.convert<String>(
      json['notification_show_date']);
  if (notificationShowDate != null) {
    shopData.notificationShowDate = notificationShowDate;
  }
  final List<ShopDataTrends>? trends = (json['trends'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<ShopDataTrends>(e) as ShopDataTrends)
      .toList();
  if (trends != null) {
    shopData.trends = trends;
  }
  final String? manualUpdateAt = jsonConvert.convert<String>(
      json['manual_update_at']);
  if (manualUpdateAt != null) {
    shopData.manualUpdateAt = manualUpdateAt;
  }
  final String? salaryUpdateAt = jsonConvert.convert<String>(
      json['salary_update_at']);
  if (salaryUpdateAt != null) {
    shopData.salaryUpdateAt = salaryUpdateAt;
  }
  final String? dailyUpdateAt = jsonConvert.convert<String>(
      json['daily_update_at']);
  if (dailyUpdateAt != null) {
    shopData.dailyUpdateAt = dailyUpdateAt;
  }
  final String? templateUpdateAt = jsonConvert.convert<String>(
      json['template_update_at']);
  if (templateUpdateAt != null) {
    shopData.templateUpdateAt = templateUpdateAt;
  }
  final String? settomgUpdateAt = jsonConvert.convert<String>(
      json['settomg_update_at']);
  if (settomgUpdateAt != null) {
    shopData.settomgUpdateAt = settomgUpdateAt;
  }
  final bool? showWeekCouponData = jsonConvert.convert<bool>(
      json['show_week_coupon_data']);
  if (showWeekCouponData != null) {
    shopData.showWeekCouponData = showWeekCouponData;
  }
  final List<
      ShopDataWeekCaseData>? weekCouponData = (json['week_coupon_data'] as List<
      dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<ShopDataWeekCaseData>(e) as ShopDataWeekCaseData)
      .toList();
  if (weekCouponData != null) {
    shopData.weekCouponData = weekCouponData;
  }
  final bool? showWeekExtendData = jsonConvert.convert<bool>(
      json['show_week_extend_data']);
  if (showWeekExtendData != null) {
    shopData.showWeekExtendData = showWeekExtendData;
  }
  final List<
      ShopDataWeekCaseData>? weekExtendData = (json['week_extend_data'] as List<
      dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<ShopDataWeekCaseData>(e) as ShopDataWeekCaseData)
      .toList();
  if (weekExtendData != null) {
    shopData.weekExtendData = weekExtendData;
  }
  final bool? showWeekRetainData = jsonConvert.convert<bool>(
      json['show_week_retain_data']);
  if (showWeekRetainData != null) {
    shopData.showWeekRetainData = showWeekRetainData;
  }
  final List<
      ShopDataWeekCaseData>? weekRetainData = (json['week_retain_data'] as List<
      dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<ShopDataWeekCaseData>(e) as ShopDataWeekCaseData)
      .toList();
  if (weekRetainData != null) {
    shopData.weekRetainData = weekRetainData;
  }
  final bool? showWeekReceiveData = jsonConvert.convert<bool>(
      json['show_week_receive_data']);
  if (showWeekReceiveData != null) {
    shopData.showWeekReceiveData = showWeekReceiveData;
  }
  final List<
      ShopDataWeekCaseData>? weekReceiveData = (json['week_receive_data'] as List<
      dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<ShopDataWeekCaseData>(e) as ShopDataWeekCaseData)
      .toList();
  if (weekReceiveData != null) {
    shopData.weekReceiveData = weekReceiveData;
  }
  return shopData;
}

Map<String, dynamic> $ShopDataToJson(ShopData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['web_url'] = entity.webUrl;
  data['show_month_data'] = entity.showMonthData;
  data['month_data'] = entity.monthData?.map((v) => v.toJson()).toList();
  data['show_month_repay_data'] = entity.showMonthRepayData;
  data['month_repay_data'] =
      entity.monthRepayData?.map((v) => v.toJson()).toList();
  data['show_month_reg_bonus_data'] = entity.showMonthRegBonusData;
  data['month_reg_bonus_data'] =
      entity.monthRegBonusData?.map((v) => v.toJson()).toList();
  data['show_month_apply_bonus_data'] = entity.showMonthApplyBonusData;
  data['month_apply_bonus_data'] =
      entity.monthApplyBonusData?.map((v) => v.toJson()).toList();
  data['show_week_case_data'] = entity.showWeekCaseData;
  data['week_case_data'] = entity.weekCaseData?.map((v) => v.toJson()).toList();
  data['show_week_bonus_data'] = entity.showWeekBonusData;
  data['week_bonus_data'] =
      entity.weekBonusData?.map((v) => v.toJson()).toList();
  data['show_month_case_data'] = entity.showMonthCaseData;
  data['month_case_data'] =
      entity.monthCaseData?.map((v) => v.toJson()).toList();
  data['show_month_bonus_data'] = entity.showMonthBonusData;
  data['month_bonus_data'] =
      entity.monthBonusData?.map((v) => v.toJson()).toList();
  data['show_month_addition_data'] = entity.showMonthAdditionData;
  data['month_addition_data'] =
      entity.monthAdditionData?.map((v) => v.toJson()).toList();
  data['show_week_register_data'] = entity.showWeekRegisterData;
  data['week_register_data'] =
      entity.weekRegisterData?.map((v) => v.toJson()).toList();
  data['show_week_apply_data'] = entity.showWeekApplyData;
  data['week_apply_data'] =
      entity.weekApplyData?.map((v) => v.toJson()).toList();
  data['notification_data'] = entity.notificationData;
  data['notification_show_date'] = entity.notificationShowDate;
  data['trends'] = entity.trends?.map((v) => v.toJson()).toList();
  data['manual_update_at'] = entity.manualUpdateAt;
  data['salary_update_at'] = entity.salaryUpdateAt;
  data['daily_update_at'] = entity.dailyUpdateAt;
  data['template_update_at'] = entity.templateUpdateAt;
  data['settomg_update_at'] = entity.settomgUpdateAt;
  data['show_week_coupon_data'] = entity.showWeekCouponData;
  data['week_coupon_data'] =
      entity.weekCouponData?.map((v) => v.toJson()).toList();
  data['show_week_extend_data'] = entity.showWeekExtendData;
  data['week_extend_data'] =
      entity.weekExtendData?.map((v) => v.toJson()).toList();
  data['show_week_retain_data'] = entity.showWeekRetainData;
  data['week_retain_data'] =
      entity.weekRetainData?.map((v) => v.toJson()).toList();
  data['show_week_receive_data'] = entity.showWeekReceiveData;
  data['week_receive_data'] =
      entity.weekReceiveData?.map((v) => v.toJson()).toList();
  return data;
}

extension ShopDataExtension on ShopData {
  ShopData copyWith({
    String? webUrl,
    bool? showMonthData,
    List<ShopDataMonthData>? monthData,
    bool? showMonthRepayData,
    List<ShopDataMonthData>? monthRepayData,
    bool? showMonthRegBonusData,
    List<ShopDataMonthData>? monthRegBonusData,
    bool? showMonthApplyBonusData,
    List<ShopDataMonthData>? monthApplyBonusData,
    bool? showWeekCaseData,
    List<ShopDataWeekCaseData>? weekCaseData,
    bool? showWeekBonusData,
    List<ShopDataWeekBonusData>? weekBonusData,
    bool? showMonthCaseData,
    List<ShopDataMonthCaseData>? monthCaseData,
    bool? showMonthBonusData,
    List<ShopDataMonthBonusData>? monthBonusData,
    bool? showMonthAdditionData,
    List<ShopDataMonthAdditionData>? monthAdditionData,
    bool? showWeekRegisterData,
    List<ShopDataWeekCaseData>? weekRegisterData,
    bool? showWeekApplyData,
    List<ShopDataWeekCaseData>? weekApplyData,
    List<String>? notificationData,
    String? notificationShowDate,
    List<ShopDataTrends>? trends,
    String? manualUpdateAt,
    String? salaryUpdateAt,
    String? dailyUpdateAt,
    String? templateUpdateAt,
    String? settomgUpdateAt,
    bool? showWeekCouponData,
    List<ShopDataWeekCaseData>? weekCouponData,
    bool? showWeekExtendData,
    List<ShopDataWeekCaseData>? weekExtendData,
    bool? showWeekRetainData,
    List<ShopDataWeekCaseData>? weekRetainData,
    bool? showWeekReceiveData,
    List<ShopDataWeekCaseData>? weekReceiveData,
  }) {
    return ShopData()
      ..webUrl = webUrl ?? this.webUrl
      ..showMonthData = showMonthData ?? this.showMonthData
      ..monthData = monthData ?? this.monthData
      ..showMonthRepayData = showMonthRepayData ?? this.showMonthRepayData
      ..monthRepayData = monthRepayData ?? this.monthRepayData
      ..showMonthRegBonusData = showMonthRegBonusData ??
          this.showMonthRegBonusData
      ..monthRegBonusData = monthRegBonusData ?? this.monthRegBonusData
      ..showMonthApplyBonusData = showMonthApplyBonusData ??
          this.showMonthApplyBonusData
      ..monthApplyBonusData = monthApplyBonusData ?? this.monthApplyBonusData
      ..showWeekCaseData = showWeekCaseData ?? this.showWeekCaseData
      ..weekCaseData = weekCaseData ?? this.weekCaseData
      ..showWeekBonusData = showWeekBonusData ?? this.showWeekBonusData
      ..weekBonusData = weekBonusData ?? this.weekBonusData
      ..showMonthCaseData = showMonthCaseData ?? this.showMonthCaseData
      ..monthCaseData = monthCaseData ?? this.monthCaseData
      ..showMonthBonusData = showMonthBonusData ?? this.showMonthBonusData
      ..monthBonusData = monthBonusData ?? this.monthBonusData
      ..showMonthAdditionData = showMonthAdditionData ??
          this.showMonthAdditionData
      ..monthAdditionData = monthAdditionData ?? this.monthAdditionData
      ..showWeekRegisterData = showWeekRegisterData ?? this.showWeekRegisterData
      ..weekRegisterData = weekRegisterData ?? this.weekRegisterData
      ..showWeekApplyData = showWeekApplyData ?? this.showWeekApplyData
      ..weekApplyData = weekApplyData ?? this.weekApplyData
      ..notificationData = notificationData ?? this.notificationData
      ..notificationShowDate = notificationShowDate ?? this.notificationShowDate
      ..trends = trends ?? this.trends
      ..manualUpdateAt = manualUpdateAt ?? this.manualUpdateAt
      ..salaryUpdateAt = salaryUpdateAt ?? this.salaryUpdateAt
      ..dailyUpdateAt = dailyUpdateAt ?? this.dailyUpdateAt
      ..templateUpdateAt = templateUpdateAt ?? this.templateUpdateAt
      ..settomgUpdateAt = settomgUpdateAt ?? this.settomgUpdateAt
      ..showWeekCouponData = showWeekCouponData ?? this.showWeekCouponData
      ..weekCouponData = weekCouponData ?? this.weekCouponData
      ..showWeekExtendData = showWeekExtendData ?? this.showWeekExtendData
      ..weekExtendData = weekExtendData ?? this.weekExtendData
      ..showWeekRetainData = showWeekRetainData ?? this.showWeekRetainData
      ..weekRetainData = weekRetainData ?? this.weekRetainData
      ..showWeekReceiveData = showWeekReceiveData ?? this.showWeekReceiveData
      ..weekReceiveData = weekReceiveData ?? this.weekReceiveData;
  }
}

ShopDataMonthData $ShopDataMonthDataFromJson(Map<String, dynamic> json) {
  final ShopDataMonthData shopDataMonthData = ShopDataMonthData();
  final String? avatar = jsonConvert.convert<String>(json['avatar']);
  if (avatar != null) {
    shopDataMonthData.avatar = avatar;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    shopDataMonthData.name = name;
  }
  final int? value = jsonConvert.convert<int>(json['value']);
  if (value != null) {
    shopDataMonthData.value = value;
  }
  final int? addition = jsonConvert.convert<int>(json['addition']);
  if (addition != null) {
    shopDataMonthData.addition = addition;
  }
  final int? addition2 = jsonConvert.convert<int>(json['addition2']);
  if (addition2 != null) {
    shopDataMonthData.addition2 = addition2;
  }
  return shopDataMonthData;
}

Map<String, dynamic> $ShopDataMonthDataToJson(ShopDataMonthData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['avatar'] = entity.avatar;
  data['name'] = entity.name;
  data['value'] = entity.value;
  data['addition'] = entity.addition;
  data['addition2'] = entity.addition2;
  return data;
}

extension ShopDataMonthDataExtension on ShopDataMonthData {
  ShopDataMonthData copyWith({
    String? avatar,
    String? name,
    int? value,
    int? addition,
    int? addition2,
  }) {
    return ShopDataMonthData()
      ..avatar = avatar ?? this.avatar
      ..name = name ?? this.name
      ..value = value ?? this.value
      ..addition = addition ?? this.addition
      ..addition2 = addition2 ?? this.addition2;
  }
}

ShopDataMonthRepayData $ShopDataMonthRepayDataFromJson(
    Map<String, dynamic> json) {
  final ShopDataMonthRepayData shopDataMonthRepayData = ShopDataMonthRepayData();
  final String? avatar = jsonConvert.convert<String>(json['avatar']);
  if (avatar != null) {
    shopDataMonthRepayData.avatar = avatar;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    shopDataMonthRepayData.name = name;
  }
  final int? value = jsonConvert.convert<int>(json['value']);
  if (value != null) {
    shopDataMonthRepayData.value = value;
  }
  final int? addition = jsonConvert.convert<int>(json['addition']);
  if (addition != null) {
    shopDataMonthRepayData.addition = addition;
  }
  final int? addition2 = jsonConvert.convert<int>(json['addition2']);
  if (addition2 != null) {
    shopDataMonthRepayData.addition2 = addition2;
  }
  return shopDataMonthRepayData;
}

Map<String, dynamic> $ShopDataMonthRepayDataToJson(
    ShopDataMonthRepayData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['avatar'] = entity.avatar;
  data['name'] = entity.name;
  data['value'] = entity.value;
  data['addition'] = entity.addition;
  data['addition2'] = entity.addition2;
  return data;
}

extension ShopDataMonthRepayDataExtension on ShopDataMonthRepayData {
  ShopDataMonthRepayData copyWith({
    String? avatar,
    String? name,
    int? value,
    int? addition,
    int? addition2,
  }) {
    return ShopDataMonthRepayData()
      ..avatar = avatar ?? this.avatar
      ..name = name ?? this.name
      ..value = value ?? this.value
      ..addition = addition ?? this.addition
      ..addition2 = addition2 ?? this.addition2;
  }
}

ShopDataMonthRegBonusData $ShopDataMonthRegBonusDataFromJson(
    Map<String, dynamic> json) {
  final ShopDataMonthRegBonusData shopDataMonthRegBonusData = ShopDataMonthRegBonusData();
  final String? avatar = jsonConvert.convert<String>(json['avatar']);
  if (avatar != null) {
    shopDataMonthRegBonusData.avatar = avatar;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    shopDataMonthRegBonusData.name = name;
  }
  final int? value = jsonConvert.convert<int>(json['value']);
  if (value != null) {
    shopDataMonthRegBonusData.value = value;
  }
  final int? addition = jsonConvert.convert<int>(json['addition']);
  if (addition != null) {
    shopDataMonthRegBonusData.addition = addition;
  }
  final int? addition2 = jsonConvert.convert<int>(json['addition2']);
  if (addition2 != null) {
    shopDataMonthRegBonusData.addition2 = addition2;
  }
  return shopDataMonthRegBonusData;
}

Map<String, dynamic> $ShopDataMonthRegBonusDataToJson(
    ShopDataMonthRegBonusData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['avatar'] = entity.avatar;
  data['name'] = entity.name;
  data['value'] = entity.value;
  data['addition'] = entity.addition;
  data['addition2'] = entity.addition2;
  return data;
}

extension ShopDataMonthRegBonusDataExtension on ShopDataMonthRegBonusData {
  ShopDataMonthRegBonusData copyWith({
    String? avatar,
    String? name,
    int? value,
    int? addition,
    int? addition2,
  }) {
    return ShopDataMonthRegBonusData()
      ..avatar = avatar ?? this.avatar
      ..name = name ?? this.name
      ..value = value ?? this.value
      ..addition = addition ?? this.addition
      ..addition2 = addition2 ?? this.addition2;
  }
}

ShopDataMonthApplyBonusData $ShopDataMonthApplyBonusDataFromJson(
    Map<String, dynamic> json) {
  final ShopDataMonthApplyBonusData shopDataMonthApplyBonusData = ShopDataMonthApplyBonusData();
  final String? avatar = jsonConvert.convert<String>(json['avatar']);
  if (avatar != null) {
    shopDataMonthApplyBonusData.avatar = avatar;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    shopDataMonthApplyBonusData.name = name;
  }
  final int? value = jsonConvert.convert<int>(json['value']);
  if (value != null) {
    shopDataMonthApplyBonusData.value = value;
  }
  final int? addition = jsonConvert.convert<int>(json['addition']);
  if (addition != null) {
    shopDataMonthApplyBonusData.addition = addition;
  }
  final int? addition2 = jsonConvert.convert<int>(json['addition2']);
  if (addition2 != null) {
    shopDataMonthApplyBonusData.addition2 = addition2;
  }
  return shopDataMonthApplyBonusData;
}

Map<String, dynamic> $ShopDataMonthApplyBonusDataToJson(
    ShopDataMonthApplyBonusData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['avatar'] = entity.avatar;
  data['name'] = entity.name;
  data['value'] = entity.value;
  data['addition'] = entity.addition;
  data['addition2'] = entity.addition2;
  return data;
}

extension ShopDataMonthApplyBonusDataExtension on ShopDataMonthApplyBonusData {
  ShopDataMonthApplyBonusData copyWith({
    String? avatar,
    String? name,
    int? value,
    int? addition,
    int? addition2,
  }) {
    return ShopDataMonthApplyBonusData()
      ..avatar = avatar ?? this.avatar
      ..name = name ?? this.name
      ..value = value ?? this.value
      ..addition = addition ?? this.addition
      ..addition2 = addition2 ?? this.addition2;
  }
}

ShopDataWeekCaseData $ShopDataWeekCaseDataFromJson(Map<String, dynamic> json) {
  final ShopDataWeekCaseData shopDataWeekCaseData = ShopDataWeekCaseData();
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    shopDataWeekCaseData.name = name;
  }
  final int? value = jsonConvert.convert<int>(json['value']);
  if (value != null) {
    shopDataWeekCaseData.value = value;
  }
  final int? addition = jsonConvert.convert<int>(json['addition']);
  if (addition != null) {
    shopDataWeekCaseData.addition = addition;
  }
  final int? addition2 = jsonConvert.convert<int>(json['addition2']);
  if (addition2 != null) {
    shopDataWeekCaseData.addition2 = addition2;
  }
  return shopDataWeekCaseData;
}

Map<String, dynamic> $ShopDataWeekCaseDataToJson(ShopDataWeekCaseData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['name'] = entity.name;
  data['value'] = entity.value;
  data['addition'] = entity.addition;
  data['addition2'] = entity.addition2;
  return data;
}

extension ShopDataWeekCaseDataExtension on ShopDataWeekCaseData {
  ShopDataWeekCaseData copyWith({
    String? name,
    int? value,
    int? addition,
    int? addition2,
  }) {
    return ShopDataWeekCaseData()
      ..name = name ?? this.name
      ..value = value ?? this.value
      ..addition = addition ?? this.addition
      ..addition2 = addition2 ?? this.addition2;
  }
}

ShopDataWeekBonusData $ShopDataWeekBonusDataFromJson(
    Map<String, dynamic> json) {
  final ShopDataWeekBonusData shopDataWeekBonusData = ShopDataWeekBonusData();
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    shopDataWeekBonusData.name = name;
  }
  final int? value = jsonConvert.convert<int>(json['value']);
  if (value != null) {
    shopDataWeekBonusData.value = value;
  }
  final List<int>? gradeValues = (json['gradeValues'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<int>(e) as int).toList();
  if (gradeValues != null) {
    shopDataWeekBonusData.gradeValues = gradeValues;
  }
  final int? addition = jsonConvert.convert<int>(json['addition']);
  if (addition != null) {
    shopDataWeekBonusData.addition = addition;
  }
  return shopDataWeekBonusData;
}

Map<String, dynamic> $ShopDataWeekBonusDataToJson(
    ShopDataWeekBonusData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['name'] = entity.name;
  data['value'] = entity.value;
  data['gradeValues'] = entity.gradeValues;
  data['addition'] = entity.addition;
  return data;
}

extension ShopDataWeekBonusDataExtension on ShopDataWeekBonusData {
  ShopDataWeekBonusData copyWith({
    String? name,
    int? value,
    List<int>? gradeValues,
    int? addition,
  }) {
    return ShopDataWeekBonusData()
      ..name = name ?? this.name
      ..value = value ?? this.value
      ..gradeValues = gradeValues ?? this.gradeValues
      ..addition = addition ?? this.addition;
  }
}

ShopDataMonthCaseData $ShopDataMonthCaseDataFromJson(
    Map<String, dynamic> json) {
  final ShopDataMonthCaseData shopDataMonthCaseData = ShopDataMonthCaseData();
  final String? date = jsonConvert.convert<String>(json['date']);
  if (date != null) {
    shopDataMonthCaseData.date = date;
  }
  final int? value = jsonConvert.convert<int>(json['value']);
  if (value != null) {
    shopDataMonthCaseData.value = value;
  }
  return shopDataMonthCaseData;
}

Map<String, dynamic> $ShopDataMonthCaseDataToJson(
    ShopDataMonthCaseData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['date'] = entity.date;
  data['value'] = entity.value;
  return data;
}

extension ShopDataMonthCaseDataExtension on ShopDataMonthCaseData {
  ShopDataMonthCaseData copyWith({
    String? date,
    int? value,
  }) {
    return ShopDataMonthCaseData()
      ..date = date ?? this.date
      ..value = value ?? this.value;
  }
}

ShopDataMonthBonusData $ShopDataMonthBonusDataFromJson(
    Map<String, dynamic> json) {
  final ShopDataMonthBonusData shopDataMonthBonusData = ShopDataMonthBonusData();
  final String? date = jsonConvert.convert<String>(json['date']);
  if (date != null) {
    shopDataMonthBonusData.date = date;
  }
  final int? value = jsonConvert.convert<int>(json['value']);
  if (value != null) {
    shopDataMonthBonusData.value = value;
  }
  return shopDataMonthBonusData;
}

Map<String, dynamic> $ShopDataMonthBonusDataToJson(
    ShopDataMonthBonusData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['date'] = entity.date;
  data['value'] = entity.value;
  return data;
}

extension ShopDataMonthBonusDataExtension on ShopDataMonthBonusData {
  ShopDataMonthBonusData copyWith({
    String? date,
    int? value,
  }) {
    return ShopDataMonthBonusData()
      ..date = date ?? this.date
      ..value = value ?? this.value;
  }
}

ShopDataMonthAdditionData $ShopDataMonthAdditionDataFromJson(
    Map<String, dynamic> json) {
  final ShopDataMonthAdditionData shopDataMonthAdditionData = ShopDataMonthAdditionData();
  final String? level = jsonConvert.convert<String>(json['level']);
  if (level != null) {
    shopDataMonthAdditionData.level = level;
  }
  final int? days = jsonConvert.convert<int>(json['days']);
  if (days != null) {
    shopDataMonthAdditionData.days = days;
  }
  final int? bonus = jsonConvert.convert<int>(json['bonus']);
  if (bonus != null) {
    shopDataMonthAdditionData.bonus = bonus;
  }
  final int? completeDays = jsonConvert.convert<int>(json['complete_days']);
  if (completeDays != null) {
    shopDataMonthAdditionData.completeDays = completeDays;
  }
  return shopDataMonthAdditionData;
}

Map<String, dynamic> $ShopDataMonthAdditionDataToJson(
    ShopDataMonthAdditionData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['level'] = entity.level;
  data['days'] = entity.days;
  data['bonus'] = entity.bonus;
  data['complete_days'] = entity.completeDays;
  return data;
}

extension ShopDataMonthAdditionDataExtension on ShopDataMonthAdditionData {
  ShopDataMonthAdditionData copyWith({
    String? level,
    int? days,
    int? bonus,
    int? completeDays,
  }) {
    return ShopDataMonthAdditionData()
      ..level = level ?? this.level
      ..days = days ?? this.days
      ..bonus = bonus ?? this.bonus
      ..completeDays = completeDays ?? this.completeDays;
  }
}

ShopDataWeekRegisterData $ShopDataWeekRegisterDataFromJson(
    Map<String, dynamic> json) {
  final ShopDataWeekRegisterData shopDataWeekRegisterData = ShopDataWeekRegisterData();
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    shopDataWeekRegisterData.name = name;
  }
  final int? value = jsonConvert.convert<int>(json['value']);
  if (value != null) {
    shopDataWeekRegisterData.value = value;
  }
  final int? addition = jsonConvert.convert<int>(json['addition']);
  if (addition != null) {
    shopDataWeekRegisterData.addition = addition;
  }
  return shopDataWeekRegisterData;
}

Map<String, dynamic> $ShopDataWeekRegisterDataToJson(
    ShopDataWeekRegisterData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['name'] = entity.name;
  data['value'] = entity.value;
  data['addition'] = entity.addition;
  return data;
}

extension ShopDataWeekRegisterDataExtension on ShopDataWeekRegisterData {
  ShopDataWeekRegisterData copyWith({
    String? name,
    int? value,
    int? addition,
  }) {
    return ShopDataWeekRegisterData()
      ..name = name ?? this.name
      ..value = value ?? this.value
      ..addition = addition ?? this.addition;
  }
}

ShopDataWeekApplyData $ShopDataWeekApplyDataFromJson(
    Map<String, dynamic> json) {
  final ShopDataWeekApplyData shopDataWeekApplyData = ShopDataWeekApplyData();
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    shopDataWeekApplyData.name = name;
  }
  final int? value = jsonConvert.convert<int>(json['value']);
  if (value != null) {
    shopDataWeekApplyData.value = value;
  }
  final int? addition = jsonConvert.convert<int>(json['addition']);
  if (addition != null) {
    shopDataWeekApplyData.addition = addition;
  }
  return shopDataWeekApplyData;
}

Map<String, dynamic> $ShopDataWeekApplyDataToJson(
    ShopDataWeekApplyData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['name'] = entity.name;
  data['value'] = entity.value;
  data['addition'] = entity.addition;
  return data;
}

extension ShopDataWeekApplyDataExtension on ShopDataWeekApplyData {
  ShopDataWeekApplyData copyWith({
    String? name,
    int? value,
    int? addition,
  }) {
    return ShopDataWeekApplyData()
      ..name = name ?? this.name
      ..value = value ?? this.value
      ..addition = addition ?? this.addition;
  }
}

ShopDataTrends $ShopDataTrendsFromJson(Map<String, dynamic> json) {
  final ShopDataTrends shopDataTrends = ShopDataTrends();
  final int? bHour = jsonConvert.convert<int>(json['b_hour']);
  if (bHour != null) {
    shopDataTrends.bHour = bHour;
  }
  final int? eRepaymentCount = jsonConvert.convert<int>(
      json['e_repayment_count']);
  if (eRepaymentCount != null) {
    shopDataTrends.eRepaymentCount = eRepaymentCount;
  }
  final int? cActionCount = jsonConvert.convert<int>(json['c_action_count']);
  if (cActionCount != null) {
    shopDataTrends.cActionCount = cActionCount;
  }
  return shopDataTrends;
}

Map<String, dynamic> $ShopDataTrendsToJson(ShopDataTrends entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['b_hour'] = entity.bHour;
  data['e_repayment_count'] = entity.eRepaymentCount;
  data['c_action_count'] = entity.cActionCount;
  return data;
}

extension ShopDataTrendsExtension on ShopDataTrends {
  ShopDataTrends copyWith({
    int? bHour,
    int? eRepaymentCount,
    int? cActionCount,
  }) {
    return ShopDataTrends()
      ..bHour = bHour ?? this.bHour
      ..eRepaymentCount = eRepaymentCount ?? this.eRepaymentCount
      ..cActionCount = cActionCount ?? this.cActionCount;
  }
}

ShopOther $ShopOtherFromJson(Map<String, dynamic> json) {
  final ShopOther shopOther = ShopOther();
  final ShopOtherProgress? progress = jsonConvert.convert<ShopOtherProgress>(
      json['progress']);
  if (progress != null) {
    shopOther.progress = progress;
  }
  final ShopOtherProfile? profile = jsonConvert.convert<ShopOtherProfile>(
      json['profile']);
  if (profile != null) {
    shopOther.profile = profile;
  }
  final List<
      ShopOtherMonthAdditionData>? monthAdditionData = (json['monthAdditionData'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<ShopOtherMonthAdditionData>(
          e) as ShopOtherMonthAdditionData).toList();
  if (monthAdditionData != null) {
    shopOther.monthAdditionData = monthAdditionData;
  }
  final List<
      ShopOtherAdditionBonus>? additionBonus = (json['additionBonus'] as List<
      dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<ShopOtherAdditionBonus>(e) as ShopOtherAdditionBonus)
      .toList();
  if (additionBonus != null) {
    shopOther.additionBonus = additionBonus;
  }
  final List<ShopOtherFines>? fines = (json['fines'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<ShopOtherFines>(e) as ShopOtherFines)
      .toList();
  if (fines != null) {
    shopOther.fines = fines;
  }
  final String? latestVersion = jsonConvert.convert<String>(
      json['latestVersion']);
  if (latestVersion != null) {
    shopOther.latestVersion = latestVersion;
  }
  return shopOther;
}

Map<String, dynamic> $ShopOtherToJson(ShopOther entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['progress'] = entity.progress?.toJson();
  data['profile'] = entity.profile?.toJson();
  data['monthAdditionData'] =
      entity.monthAdditionData?.map((v) => v.toJson()).toList();
  data['additionBonus'] = entity.additionBonus?.map((v) => v.toJson()).toList();
  data['fines'] = entity.fines?.map((v) => v.toJson()).toList();
  data['latestVersion'] = entity.latestVersion;
  return data;
}

extension ShopOtherExtension on ShopOther {
  ShopOther copyWith({
    ShopOtherProgress? progress,
    ShopOtherProfile? profile,
    List<ShopOtherMonthAdditionData>? monthAdditionData,
    List<ShopOtherAdditionBonus>? additionBonus,
    List<ShopOtherFines>? fines,
    String? latestVersion,
  }) {
    return ShopOther()
      ..progress = progress ?? this.progress
      ..profile = profile ?? this.profile
      ..monthAdditionData = monthAdditionData ?? this.monthAdditionData
      ..additionBonus = additionBonus ?? this.additionBonus
      ..fines = fines ?? this.fines
      ..latestVersion = latestVersion ?? this.latestVersion;
  }
}

ShopOtherProgress $ShopOtherProgressFromJson(Map<String, dynamic> json) {
  final ShopOtherProgress shopOtherProgress = ShopOtherProgress();
  final List<int>? points = (json['points'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<int>(e) as int).toList();
  if (points != null) {
    shopOtherProgress.points = points;
  }
  final List<int>? counts = (json['counts'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<int>(e) as int).toList();
  if (counts != null) {
    shopOtherProgress.counts = counts;
  }
  final List<String>? grades = (json['grades'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (grades != null) {
    shopOtherProgress.grades = grades;
  }
  final List<String>? commissionRates = (json['commissionRates'] as List<
      dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (commissionRates != null) {
    shopOtherProgress.commissionRates = commissionRates;
  }
  final String? currentGrade = jsonConvert.convert<String>(
      json['currentGrade']);
  if (currentGrade != null) {
    shopOtherProgress.currentGrade = currentGrade;
  }
  final String? currentRate = jsonConvert.convert<String>(json['currentRate']);
  if (currentRate != null) {
    shopOtherProgress.currentRate = currentRate;
  }
  final String? nextGrade = jsonConvert.convert<String>(json['nextGrade']);
  if (nextGrade != null) {
    shopOtherProgress.nextGrade = nextGrade;
  }
  final String? nextRate = jsonConvert.convert<String>(json['nextRate']);
  if (nextRate != null) {
    shopOtherProgress.nextRate = nextRate;
  }
  final int? more = jsonConvert.convert<int>(json['more']);
  if (more != null) {
    shopOtherProgress.more = more;
  }
  final double? currentPoint = jsonConvert.convert<double>(
      json['currentPoint']);
  if (currentPoint != null) {
    shopOtherProgress.currentPoint = currentPoint;
  }
  final int? nextAdditionBonus = jsonConvert.convert<int>(
      json['nextAdditionBonus']);
  if (nextAdditionBonus != null) {
    shopOtherProgress.nextAdditionBonus = nextAdditionBonus;
  }
  return shopOtherProgress;
}

Map<String, dynamic> $ShopOtherProgressToJson(ShopOtherProgress entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['points'] = entity.points;
  data['counts'] = entity.counts;
  data['grades'] = entity.grades;
  data['commissionRates'] = entity.commissionRates;
  data['currentGrade'] = entity.currentGrade;
  data['currentRate'] = entity.currentRate;
  data['nextGrade'] = entity.nextGrade;
  data['nextRate'] = entity.nextRate;
  data['more'] = entity.more;
  data['currentPoint'] = entity.currentPoint;
  data['nextAdditionBonus'] = entity.nextAdditionBonus;
  return data;
}

extension ShopOtherProgressExtension on ShopOtherProgress {
  ShopOtherProgress copyWith({
    List<int>? points,
    List<int>? counts,
    List<String>? grades,
    List<String>? commissionRates,
    String? currentGrade,
    String? currentRate,
    String? nextGrade,
    String? nextRate,
    int? more,
    double? currentPoint,
    int? nextAdditionBonus,
  }) {
    return ShopOtherProgress()
      ..points = points ?? this.points
      ..counts = counts ?? this.counts
      ..grades = grades ?? this.grades
      ..commissionRates = commissionRates ?? this.commissionRates
      ..currentGrade = currentGrade ?? this.currentGrade
      ..currentRate = currentRate ?? this.currentRate
      ..nextGrade = nextGrade ?? this.nextGrade
      ..nextRate = nextRate ?? this.nextRate
      ..more = more ?? this.more
      ..currentPoint = currentPoint ?? this.currentPoint
      ..nextAdditionBonus = nextAdditionBonus ?? this.nextAdditionBonus;
  }
}

ShopOtherProfile $ShopOtherProfileFromJson(Map<String, dynamic> json) {
  final ShopOtherProfile shopOtherProfile = ShopOtherProfile();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    shopOtherProfile.id = id;
  }
  final String? aName = jsonConvert.convert<String>(json['a_name']);
  if (aName != null) {
    shopOtherProfile.aName = aName;
  }
  final int? bAdminId = jsonConvert.convert<int>(json['b_admin_id']);
  if (bAdminId != null) {
    shopOtherProfile.bAdminId = bAdminId;
  }
  final int? cCollectionAgencyId = jsonConvert.convert<int>(
      json['c_collection_agency_id']);
  if (cCollectionAgencyId != null) {
    shopOtherProfile.cCollectionAgencyId = cCollectionAgencyId;
  }
  final int? dCollectionGroupId = jsonConvert.convert<int>(
      json['d_collection_group_id']);
  if (dCollectionGroupId != null) {
    shopOtherProfile.dCollectionGroupId = dCollectionGroupId;
  }
  final String? eCollectionStages = jsonConvert.convert<String>(
      json['e_collection_stages']);
  if (eCollectionStages != null) {
    shopOtherProfile.eCollectionStages = eCollectionStages;
  }
  final int? fStatus = jsonConvert.convert<int>(json['f_status']);
  if (fStatus != null) {
    shopOtherProfile.fStatus = fStatus;
  }
  final String? gComment = jsonConvert.convert<String>(json['g_comment']);
  if (gComment != null) {
    shopOtherProfile.gComment = gComment;
  }
  final int? hCollectionIngOrderCount = jsonConvert.convert<int>(
      json['h_collection_ing_order_count']);
  if (hCollectionIngOrderCount != null) {
    shopOtherProfile.hCollectionIngOrderCount = hCollectionIngOrderCount;
  }
  final int? iTodayCurrentKpiLevel = jsonConvert.convert<int>(
      json['i_today_current_kpi_level']);
  if (iTodayCurrentKpiLevel != null) {
    shopOtherProfile.iTodayCurrentKpiLevel = iTodayCurrentKpiLevel;
  }
  final int? jTodayInitAmount = jsonConvert.convert<int>(
      json['j_today_init_amount']);
  if (jTodayInitAmount != null) {
    shopOtherProfile.jTodayInitAmount = jTodayInitAmount;
  }
  final int? kCurrentNewCount = jsonConvert.convert<int>(
      json['k_current_new_count']);
  if (kCurrentNewCount != null) {
    shopOtherProfile.kCurrentNewCount = kCurrentNewCount;
  }
  final int? lCurrentNegotiatingCount = jsonConvert.convert<int>(
      json['l_current_negotiating_count']);
  if (lCurrentNegotiatingCount != null) {
    shopOtherProfile.lCurrentNegotiatingCount = lCurrentNegotiatingCount;
  }
  final int? mCurrrentPromisedCount = jsonConvert.convert<int>(
      json['m_currrent_promised_count']);
  if (mCurrrentPromisedCount != null) {
    shopOtherProfile.mCurrrentPromisedCount = mCurrrentPromisedCount;
  }
  final int? nCurrentBrokenCount = jsonConvert.convert<int>(
      json['n_current_broken_count']);
  if (nCurrentBrokenCount != null) {
    shopOtherProfile.nCurrentBrokenCount = nCurrentBrokenCount;
  }
  final int? oCurrentRefusedCount = jsonConvert.convert<int>(
      json['o_current_refused_count']);
  if (oCurrentRefusedCount != null) {
    shopOtherProfile.oCurrentRefusedCount = oCurrentRefusedCount;
  }
  final int? pTodayCurrentRepayCount = jsonConvert.convert<int>(
      json['p_today_current_repay_count']);
  if (pTodayCurrentRepayCount != null) {
    shopOtherProfile.pTodayCurrentRepayCount = pTodayCurrentRepayCount;
  }
  final int? rTodayCurrentRepayAmount = jsonConvert.convert<int>(
      json['r_today_current_repay_amount']);
  if (rTodayCurrentRepayAmount != null) {
    shopOtherProfile.rTodayCurrentRepayAmount = rTodayCurrentRepayAmount;
  }
  final int? tTodayLv1Commission = jsonConvert.convert<int>(
      json['t_today_lv1_commission']);
  if (tTodayLv1Commission != null) {
    shopOtherProfile.tTodayLv1Commission = tTodayLv1Commission;
  }
  final int? uTodayLv2Commission = jsonConvert.convert<int>(
      json['u_today_lv2_commission']);
  if (uTodayLv2Commission != null) {
    shopOtherProfile.uTodayLv2Commission = uTodayLv2Commission;
  }
  final int? vTodayLv3Commission = jsonConvert.convert<int>(
      json['v_today_lv3_commission']);
  if (vTodayLv3Commission != null) {
    shopOtherProfile.vTodayLv3Commission = vTodayLv3Commission;
  }
  final int? wTodayLv4Commission = jsonConvert.convert<int>(
      json['w_today_lv4_commission']);
  if (wTodayLv4Commission != null) {
    shopOtherProfile.wTodayLv4Commission = wTodayLv4Commission;
  }
  final int? xTodayInitCount = jsonConvert.convert<int>(
      json['x_today_init_count']);
  if (xTodayInitCount != null) {
    shopOtherProfile.xTodayInitCount = xTodayInitCount;
  }
  final String? yFirstLogAt = jsonConvert.convert<String>(
      json['y_first_log_at']);
  if (yFirstLogAt != null) {
    shopOtherProfile.yFirstLogAt = yFirstLogAt;
  }
  final String? zLastLogAt = jsonConvert.convert<String>(json['z_last_log_at']);
  if (zLastLogAt != null) {
    shopOtherProfile.zLastLogAt = zLastLogAt;
  }
  final int? aAWeekLv1Commission = jsonConvert.convert<int>(
      json['a_a_week_lv1_commission']);
  if (aAWeekLv1Commission != null) {
    shopOtherProfile.aAWeekLv1Commission = aAWeekLv1Commission;
  }
  final int? aBWeekLv2Commission = jsonConvert.convert<int>(
      json['a_b_week_lv2_commission']);
  if (aBWeekLv2Commission != null) {
    shopOtherProfile.aBWeekLv2Commission = aBWeekLv2Commission;
  }
  final int? aCWeekLv3Commission = jsonConvert.convert<int>(
      json['a_c_week_lv3_commission']);
  if (aCWeekLv3Commission != null) {
    shopOtherProfile.aCWeekLv3Commission = aCWeekLv3Commission;
  }
  final int? aDWeekLv4Commission = jsonConvert.convert<int>(
      json['a_d_week_lv4_commission']);
  if (aDWeekLv4Commission != null) {
    shopOtherProfile.aDWeekLv4Commission = aDWeekLv4Commission;
  }
  final int? aETodayCommissionRate = jsonConvert.convert<int>(
      json['a_e_today_commission_rate']);
  if (aETodayCommissionRate != null) {
    shopOtherProfile.aETodayCommissionRate = aETodayCommissionRate;
  }
  final String? aFLastCallAt = jsonConvert.convert<String>(
      json['a_f_last_call_at']);
  if (aFLastCallAt != null) {
    shopOtherProfile.aFLastCallAt = aFLastCallAt;
  }
  final int? aGCollectionCommissionNewCount = jsonConvert.convert<int>(
      json['a_g_collection_commission_new_count']);
  if (aGCollectionCommissionNewCount != null) {
    shopOtherProfile.aGCollectionCommissionNewCount =
        aGCollectionCommissionNewCount;
  }
  final int? aHCollectionNotificationCount = jsonConvert.convert<int>(
      json['a_h_collection_notification_count']);
  if (aHCollectionNotificationCount != null) {
    shopOtherProfile.aHCollectionNotificationCount =
        aHCollectionNotificationCount;
  }
  final int? aIWeekRepayCount = jsonConvert.convert<int>(
      json['a_i_week_repay_count']);
  if (aIWeekRepayCount != null) {
    shopOtherProfile.aIWeekRepayCount = aIWeekRepayCount;
  }
  final int? aJWeekCommission = jsonConvert.convert<int>(
      json['a_j_week_commission']);
  if (aJWeekCommission != null) {
    shopOtherProfile.aJWeekCommission = aJWeekCommission;
  }
  final int? aKMonthRepayCount = jsonConvert.convert<int>(
      json['a_k_month_repay_count']);
  if (aKMonthRepayCount != null) {
    shopOtherProfile.aKMonthRepayCount = aKMonthRepayCount;
  }
  final int? aLMonthCommission = jsonConvert.convert<int>(
      json['a_l_month_commission']);
  if (aLMonthCommission != null) {
    shopOtherProfile.aLMonthCommission = aLMonthCommission;
  }
  final int? aMTodayCommission = jsonConvert.convert<int>(
      json['a_m_today_commission']);
  if (aMTodayCommission != null) {
    shopOtherProfile.aMTodayCommission = aMTodayCommission;
  }
  final int? aNMonthLv1Days = jsonConvert.convert<int>(
      json['a_n_month_lv1_days']);
  if (aNMonthLv1Days != null) {
    shopOtherProfile.aNMonthLv1Days = aNMonthLv1Days;
  }
  final int? aOMonthLv2Days = jsonConvert.convert<int>(
      json['a_o_month_lv2_days']);
  if (aOMonthLv2Days != null) {
    shopOtherProfile.aOMonthLv2Days = aOMonthLv2Days;
  }
  final int? aPMonthLv3Days = jsonConvert.convert<int>(
      json['a_p_month_lv3_days']);
  if (aPMonthLv3Days != null) {
    shopOtherProfile.aPMonthLv3Days = aPMonthLv3Days;
  }
  final int? aQMonthLv4Days = jsonConvert.convert<int>(
      json['a_q_month_lv4_days']);
  if (aQMonthLv4Days != null) {
    shopOtherProfile.aQMonthLv4Days = aQMonthLv4Days;
  }
  final int? aRTodayPartCount = jsonConvert.convert<int>(
      json['a_r_today_part_count']);
  if (aRTodayPartCount != null) {
    shopOtherProfile.aRTodayPartCount = aRTodayPartCount;
  }
  final int? aSTodayPartAmount = jsonConvert.convert<int>(
      json['a_s_today_part_amount']);
  if (aSTodayPartAmount != null) {
    shopOtherProfile.aSTodayPartAmount = aSTodayPartAmount;
  }
  final int? aTTodaySmsCount = jsonConvert.convert<int>(
      json['a_t_today_sms_count']);
  if (aTTodaySmsCount != null) {
    shopOtherProfile.aTTodaySmsCount = aTTodaySmsCount;
  }
  final int? aUTodayCallCount = jsonConvert.convert<int>(
      json['a_u_today_call_count']);
  if (aUTodayCallCount != null) {
    shopOtherProfile.aUTodayCallCount = aUTodayCallCount;
  }
  final int? aVTodayLogCount = jsonConvert.convert<int>(
      json['a_v_today_log_count']);
  if (aVTodayLogCount != null) {
    shopOtherProfile.aVTodayLogCount = aVTodayLogCount;
  }
  final int? aWWeekSmsCount = jsonConvert.convert<int>(
      json['a_w_week_sms_count']);
  if (aWWeekSmsCount != null) {
    shopOtherProfile.aWWeekSmsCount = aWWeekSmsCount;
  }
  final int? aXWeekCallCount = jsonConvert.convert<int>(
      json['a_x_week_call_count']);
  if (aXWeekCallCount != null) {
    shopOtherProfile.aXWeekCallCount = aXWeekCallCount;
  }
  final int? aYWeekLogCount = jsonConvert.convert<int>(
      json['a_y_week_log_count']);
  if (aYWeekLogCount != null) {
    shopOtherProfile.aYWeekLogCount = aYWeekLogCount;
  }
  final String? bAAvatar = jsonConvert.convert<String>(json['b_a_avatar']);
  if (bAAvatar != null) {
    shopOtherProfile.bAAvatar = bAAvatar;
  }
  final int? aZTodayNoLogCount = jsonConvert.convert<int>(
      json['a_z_today_no_log_count']);
  if (aZTodayNoLogCount != null) {
    shopOtherProfile.aZTodayNoLogCount = aZTodayNoLogCount;
  }
  final int? cATodayNoCallCount = jsonConvert.convert<int>(
      json['c_a_today_no_call_count']);
  if (cATodayNoCallCount != null) {
    shopOtherProfile.cATodayNoCallCount = cATodayNoCallCount;
  }
  final String? cBLastCall = jsonConvert.convert<String>(json['c_b_last_call']);
  if (cBLastCall != null) {
    shopOtherProfile.cBLastCall = cBLastCall;
  }
  final dynamic cCReviewingCount = json['c_c_reviewing_count'];
  if (cCReviewingCount != null) {
    shopOtherProfile.cCReviewingCount = cCReviewingCount;
  }
  final int? cDTodayAdditionCount = jsonConvert.convert<int>(
      json['c_d_today_addition_count']);
  if (cDTodayAdditionCount != null) {
    shopOtherProfile.cDTodayAdditionCount = cDTodayAdditionCount;
  }
  final int? cETodayDeleteCount = jsonConvert.convert<int>(
      json['c_e_today_delete_count']);
  if (cETodayDeleteCount != null) {
    shopOtherProfile.cETodayDeleteCount = cETodayDeleteCount;
  }
  final int? cFWeekRegCnt = jsonConvert.convert<int>(json['c_f_week_reg_cnt']);
  if (cFWeekRegCnt != null) {
    shopOtherProfile.cFWeekRegCnt = cFWeekRegCnt;
  }
  final int? cGWeekApplyCnt = jsonConvert.convert<int>(
      json['c_g_week_apply_cnt']);
  if (cGWeekApplyCnt != null) {
    shopOtherProfile.cGWeekApplyCnt = cGWeekApplyCnt;
  }
  final int? cHWeekWaiveLeftCnt = jsonConvert.convert<int>(
      json['c_h_week_waive_left_cnt']);
  if (cHWeekWaiveLeftCnt != null) {
    shopOtherProfile.cHWeekWaiveLeftCnt = cHWeekWaiveLeftCnt;
  }
  final int? cIWeekBlockLeftCnt = jsonConvert.convert<int>(
      json['c_i_week_block_left_cnt']);
  if (cIWeekBlockLeftCnt != null) {
    shopOtherProfile.cIWeekBlockLeftCnt = cIWeekBlockLeftCnt;
  }
  final String? updatedAt = jsonConvert.convert<String>(json['updated_at']);
  if (updatedAt != null) {
    shopOtherProfile.updatedAt = updatedAt;
  }
  final int? cJWeekWaLeftCnt = jsonConvert.convert<int>(
      json['c_j_week_wa_left_cnt']);
  if (cJWeekWaLeftCnt != null) {
    shopOtherProfile.cJWeekWaLeftCnt = cJWeekWaLeftCnt;
  }
  final int? cKDayWaLeftCnt = jsonConvert.convert<int>(
      json['c_k_day_wa_left_cnt']);
  if (cKDayWaLeftCnt != null) {
    shopOtherProfile.cKDayWaLeftCnt = cKDayWaLeftCnt;
  }
  final int? cLWeekCouponLeftCnt = jsonConvert.convert<int>(
      json['c_l_week_coupon_left_cnt']);
  if (cLWeekCouponLeftCnt != null) {
    shopOtherProfile.cLWeekCouponLeftCnt = cLWeekCouponLeftCnt;
  }
  final int? cMWeekExtendLeftCnt = jsonConvert.convert<int>(
      json['c_m_week_extend_left_cnt']);
  if (cMWeekExtendLeftCnt != null) {
    shopOtherProfile.cMWeekExtendLeftCnt = cMWeekExtendLeftCnt;
  }
  final int? cNWeekExtendCnt = jsonConvert.convert<int>(
      json['c_n_week_extend_cnt']);
  if (cNWeekExtendCnt != null) {
    shopOtherProfile.cNWeekExtendCnt = cNWeekExtendCnt;
  }
  final int? cOMonthExtendCnt = jsonConvert.convert<int>(
      json['c_o_month_extend_cnt']);
  if (cOMonthExtendCnt != null) {
    shopOtherProfile.cOMonthExtendCnt = cOMonthExtendCnt;
  }
  final int? cPWeekRetainLeftCnt = jsonConvert.convert<int>(
      json['c_p_week_retain_left_cnt']);
  if (cPWeekRetainLeftCnt != null) {
    shopOtherProfile.cPWeekRetainLeftCnt = cPWeekRetainLeftCnt;
  }
  final int? cQWeekReceiveLeftCnt = jsonConvert.convert<int>(
      json['c_q_week_receive_left_cnt']);
  if (cQWeekReceiveLeftCnt != null) {
    shopOtherProfile.cQWeekReceiveLeftCnt = cQWeekReceiveLeftCnt;
  }
  final int? cRTodayMarketingCnt = jsonConvert.convert<int>(
      json['c_r_today_marketing_cnt']);
  if (cRTodayMarketingCnt != null) {
    shopOtherProfile.cRTodayMarketingCnt = cRTodayMarketingCnt;
  }
  final int? cSWeekRegBonus = jsonConvert.convert<int>(
      json['c_s_week_reg_bonus']);
  if (cSWeekRegBonus != null) {
    shopOtherProfile.cSWeekRegBonus = cSWeekRegBonus;
  }
  final int? cTWeekApplyBonus = jsonConvert.convert<int>(
      json['c_t_week_apply_bonus']);
  if (cTWeekApplyBonus != null) {
    shopOtherProfile.cTWeekApplyBonus = cTWeekApplyBonus;
  }
  final int? cUMonthRegBonus = jsonConvert.convert<int>(
      json['c_u_month_reg_bonus']);
  if (cUMonthRegBonus != null) {
    shopOtherProfile.cUMonthRegBonus = cUMonthRegBonus;
  }
  final int? cVMonthApplyBonus = jsonConvert.convert<int>(
      json['c_v_month_apply_bonus']);
  if (cVMonthApplyBonus != null) {
    shopOtherProfile.cVMonthApplyBonus = cVMonthApplyBonus;
  }
  final int? cWMonthRegCnt = jsonConvert.convert<int>(
      json['c_w_month_reg_cnt']);
  if (cWMonthRegCnt != null) {
    shopOtherProfile.cWMonthRegCnt = cWMonthRegCnt;
  }
  final int? cXMonthApplyCnt = jsonConvert.convert<int>(
      json['c_x_month_apply_cnt']);
  if (cXMonthApplyCnt != null) {
    shopOtherProfile.cXMonthApplyCnt = cXMonthApplyCnt;
  }
  final int? cYTodayReceiveCount = jsonConvert.convert<int>(
      json['c_y_today_receive_count']);
  if (cYTodayReceiveCount != null) {
    shopOtherProfile.cYTodayReceiveCount = cYTodayReceiveCount;
  }
  final int? cZTodayRetainCount = jsonConvert.convert<int>(
      json['c_z_today_retain_count']);
  if (cZTodayRetainCount != null) {
    shopOtherProfile.cZTodayRetainCount = cZTodayRetainCount;
  }
  final int? dATodaySystemCount = jsonConvert.convert<int>(
      json['d_a_today_system_count']);
  if (dATodaySystemCount != null) {
    shopOtherProfile.dATodaySystemCount = dATodaySystemCount;
  }
  final int? dBTodayOutCount = jsonConvert.convert<int>(
      json['d_b_today_out_count']);
  if (dBTodayOutCount != null) {
    shopOtherProfile.dBTodayOutCount = dBTodayOutCount;
  }
  final int? dCTodayMarketingCount = jsonConvert.convert<int>(
      json['d_c_today_marketing_count']);
  if (dCTodayMarketingCount != null) {
    shopOtherProfile.dCTodayMarketingCount = dCTodayMarketingCount;
  }
  final int? dDOtherBonus = jsonConvert.convert<int>(json['d_d_other_bonus']);
  if (dDOtherBonus != null) {
    shopOtherProfile.dDOtherBonus = dDOtherBonus;
  }
  final int? dEWeekAirtimeBonus = jsonConvert.convert<int>(
      json['d_e_week_airtime_bonus']);
  if (dEWeekAirtimeBonus != null) {
    shopOtherProfile.dEWeekAirtimeBonus = dEWeekAirtimeBonus;
  }
  final int? dFWeekAirtimeCnt = jsonConvert.convert<int>(
      json['d_f_week_airtime_cnt']);
  if (dFWeekAirtimeCnt != null) {
    shopOtherProfile.dFWeekAirtimeCnt = dFWeekAirtimeCnt;
  }
  final int? dGMonthAirtimeBonus = jsonConvert.convert<int>(
      json['d_g_month_airtime_bonus']);
  if (dGMonthAirtimeBonus != null) {
    shopOtherProfile.dGMonthAirtimeBonus = dGMonthAirtimeBonus;
  }
  final int? dHMonthAirtimeCnt = jsonConvert.convert<int>(
      json['d_h_month_airtime_cnt']);
  if (dHMonthAirtimeCnt != null) {
    shopOtherProfile.dHMonthAirtimeCnt = dHMonthAirtimeCnt;
  }
  final int? dIWeekAirtime2Bonus = jsonConvert.convert<int>(
      json['d_i_week_airtime2_bonus']);
  if (dIWeekAirtime2Bonus != null) {
    shopOtherProfile.dIWeekAirtime2Bonus = dIWeekAirtime2Bonus;
  }
  final int? dJWeekAirtime2Cnt = jsonConvert.convert<int>(
      json['d_j_week_airtime2_cnt']);
  if (dJWeekAirtime2Cnt != null) {
    shopOtherProfile.dJWeekAirtime2Cnt = dJWeekAirtime2Cnt;
  }
  final int? dKMonthAirtime2Bonus = jsonConvert.convert<int>(
      json['d_k_month_airtime2_bonus']);
  if (dKMonthAirtime2Bonus != null) {
    shopOtherProfile.dKMonthAirtime2Bonus = dKMonthAirtime2Bonus;
  }
  final int? dLMonthAirtime2Cnt = jsonConvert.convert<int>(
      json['d_l_month_airtime2_cnt']);
  if (dLMonthAirtime2Cnt != null) {
    shopOtherProfile.dLMonthAirtime2Cnt = dLMonthAirtime2Cnt;
  }
  final int? dMDayAirtimeBonus = jsonConvert.convert<int>(
      json['d_m_day_airtime_bonus']);
  if (dMDayAirtimeBonus != null) {
    shopOtherProfile.dMDayAirtimeBonus = dMDayAirtimeBonus;
  }
  final int? dNDayAirtime2Bonus = jsonConvert.convert<int>(
      json['d_n_day_airtime2_bonus']);
  if (dNDayAirtime2Bonus != null) {
    shopOtherProfile.dNDayAirtime2Bonus = dNDayAirtime2Bonus;
  }
  return shopOtherProfile;
}

Map<String, dynamic> $ShopOtherProfileToJson(ShopOtherProfile entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['a_name'] = entity.aName;
  data['b_admin_id'] = entity.bAdminId;
  data['c_collection_agency_id'] = entity.cCollectionAgencyId;
  data['d_collection_group_id'] = entity.dCollectionGroupId;
  data['e_collection_stages'] = entity.eCollectionStages;
  data['f_status'] = entity.fStatus;
  data['g_comment'] = entity.gComment;
  data['h_collection_ing_order_count'] = entity.hCollectionIngOrderCount;
  data['i_today_current_kpi_level'] = entity.iTodayCurrentKpiLevel;
  data['j_today_init_amount'] = entity.jTodayInitAmount;
  data['k_current_new_count'] = entity.kCurrentNewCount;
  data['l_current_negotiating_count'] = entity.lCurrentNegotiatingCount;
  data['m_currrent_promised_count'] = entity.mCurrrentPromisedCount;
  data['n_current_broken_count'] = entity.nCurrentBrokenCount;
  data['o_current_refused_count'] = entity.oCurrentRefusedCount;
  data['p_today_current_repay_count'] = entity.pTodayCurrentRepayCount;
  data['r_today_current_repay_amount'] = entity.rTodayCurrentRepayAmount;
  data['t_today_lv1_commission'] = entity.tTodayLv1Commission;
  data['u_today_lv2_commission'] = entity.uTodayLv2Commission;
  data['v_today_lv3_commission'] = entity.vTodayLv3Commission;
  data['w_today_lv4_commission'] = entity.wTodayLv4Commission;
  data['x_today_init_count'] = entity.xTodayInitCount;
  data['y_first_log_at'] = entity.yFirstLogAt;
  data['z_last_log_at'] = entity.zLastLogAt;
  data['a_a_week_lv1_commission'] = entity.aAWeekLv1Commission;
  data['a_b_week_lv2_commission'] = entity.aBWeekLv2Commission;
  data['a_c_week_lv3_commission'] = entity.aCWeekLv3Commission;
  data['a_d_week_lv4_commission'] = entity.aDWeekLv4Commission;
  data['a_e_today_commission_rate'] = entity.aETodayCommissionRate;
  data['a_f_last_call_at'] = entity.aFLastCallAt;
  data['a_g_collection_commission_new_count'] =
      entity.aGCollectionCommissionNewCount;
  data['a_h_collection_notification_count'] =
      entity.aHCollectionNotificationCount;
  data['a_i_week_repay_count'] = entity.aIWeekRepayCount;
  data['a_j_week_commission'] = entity.aJWeekCommission;
  data['a_k_month_repay_count'] = entity.aKMonthRepayCount;
  data['a_l_month_commission'] = entity.aLMonthCommission;
  data['a_m_today_commission'] = entity.aMTodayCommission;
  data['a_n_month_lv1_days'] = entity.aNMonthLv1Days;
  data['a_o_month_lv2_days'] = entity.aOMonthLv2Days;
  data['a_p_month_lv3_days'] = entity.aPMonthLv3Days;
  data['a_q_month_lv4_days'] = entity.aQMonthLv4Days;
  data['a_r_today_part_count'] = entity.aRTodayPartCount;
  data['a_s_today_part_amount'] = entity.aSTodayPartAmount;
  data['a_t_today_sms_count'] = entity.aTTodaySmsCount;
  data['a_u_today_call_count'] = entity.aUTodayCallCount;
  data['a_v_today_log_count'] = entity.aVTodayLogCount;
  data['a_w_week_sms_count'] = entity.aWWeekSmsCount;
  data['a_x_week_call_count'] = entity.aXWeekCallCount;
  data['a_y_week_log_count'] = entity.aYWeekLogCount;
  data['b_a_avatar'] = entity.bAAvatar;
  data['a_z_today_no_log_count'] = entity.aZTodayNoLogCount;
  data['c_a_today_no_call_count'] = entity.cATodayNoCallCount;
  data['c_b_last_call'] = entity.cBLastCall;
  data['c_c_reviewing_count'] = entity.cCReviewingCount;
  data['c_d_today_addition_count'] = entity.cDTodayAdditionCount;
  data['c_e_today_delete_count'] = entity.cETodayDeleteCount;
  data['c_f_week_reg_cnt'] = entity.cFWeekRegCnt;
  data['c_g_week_apply_cnt'] = entity.cGWeekApplyCnt;
  data['c_h_week_waive_left_cnt'] = entity.cHWeekWaiveLeftCnt;
  data['c_i_week_block_left_cnt'] = entity.cIWeekBlockLeftCnt;
  data['updated_at'] = entity.updatedAt;
  data['c_j_week_wa_left_cnt'] = entity.cJWeekWaLeftCnt;
  data['c_k_day_wa_left_cnt'] = entity.cKDayWaLeftCnt;
  data['c_l_week_coupon_left_cnt'] = entity.cLWeekCouponLeftCnt;
  data['c_m_week_extend_left_cnt'] = entity.cMWeekExtendLeftCnt;
  data['c_n_week_extend_cnt'] = entity.cNWeekExtendCnt;
  data['c_o_month_extend_cnt'] = entity.cOMonthExtendCnt;
  data['c_p_week_retain_left_cnt'] = entity.cPWeekRetainLeftCnt;
  data['c_q_week_receive_left_cnt'] = entity.cQWeekReceiveLeftCnt;
  data['c_r_today_marketing_cnt'] = entity.cRTodayMarketingCnt;
  data['c_s_week_reg_bonus'] = entity.cSWeekRegBonus;
  data['c_t_week_apply_bonus'] = entity.cTWeekApplyBonus;
  data['c_u_month_reg_bonus'] = entity.cUMonthRegBonus;
  data['c_v_month_apply_bonus'] = entity.cVMonthApplyBonus;
  data['c_w_month_reg_cnt'] = entity.cWMonthRegCnt;
  data['c_x_month_apply_cnt'] = entity.cXMonthApplyCnt;
  data['c_y_today_receive_count'] = entity.cYTodayReceiveCount;
  data['c_z_today_retain_count'] = entity.cZTodayRetainCount;
  data['d_a_today_system_count'] = entity.dATodaySystemCount;
  data['d_b_today_out_count'] = entity.dBTodayOutCount;
  data['d_c_today_marketing_count'] = entity.dCTodayMarketingCount;
  data['d_d_other_bonus'] = entity.dDOtherBonus;
  data['d_e_week_airtime_bonus'] = entity.dEWeekAirtimeBonus;
  data['d_f_week_airtime_cnt'] = entity.dFWeekAirtimeCnt;
  data['d_g_month_airtime_bonus'] = entity.dGMonthAirtimeBonus;
  data['d_h_month_airtime_cnt'] = entity.dHMonthAirtimeCnt;
  data['d_i_week_airtime2_bonus'] = entity.dIWeekAirtime2Bonus;
  data['d_j_week_airtime2_cnt'] = entity.dJWeekAirtime2Cnt;
  data['d_k_month_airtime2_bonus'] = entity.dKMonthAirtime2Bonus;
  data['d_l_month_airtime2_cnt'] = entity.dLMonthAirtime2Cnt;
  data['d_m_day_airtime_bonus'] = entity.dMDayAirtimeBonus;
  data['d_n_day_airtime2_bonus'] = entity.dNDayAirtime2Bonus;
  return data;
}

extension ShopOtherProfileExtension on ShopOtherProfile {
  ShopOtherProfile copyWith({
    int? id,
    String? aName,
    int? bAdminId,
    int? cCollectionAgencyId,
    int? dCollectionGroupId,
    String? eCollectionStages,
    int? fStatus,
    String? gComment,
    int? hCollectionIngOrderCount,
    int? iTodayCurrentKpiLevel,
    int? jTodayInitAmount,
    int? kCurrentNewCount,
    int? lCurrentNegotiatingCount,
    int? mCurrrentPromisedCount,
    int? nCurrentBrokenCount,
    int? oCurrentRefusedCount,
    int? pTodayCurrentRepayCount,
    int? rTodayCurrentRepayAmount,
    int? tTodayLv1Commission,
    int? uTodayLv2Commission,
    int? vTodayLv3Commission,
    int? wTodayLv4Commission,
    int? xTodayInitCount,
    String? yFirstLogAt,
    String? zLastLogAt,
    int? aAWeekLv1Commission,
    int? aBWeekLv2Commission,
    int? aCWeekLv3Commission,
    int? aDWeekLv4Commission,
    int? aETodayCommissionRate,
    String? aFLastCallAt,
    int? aGCollectionCommissionNewCount,
    int? aHCollectionNotificationCount,
    int? aIWeekRepayCount,
    int? aJWeekCommission,
    int? aKMonthRepayCount,
    int? aLMonthCommission,
    int? aMTodayCommission,
    int? aNMonthLv1Days,
    int? aOMonthLv2Days,
    int? aPMonthLv3Days,
    int? aQMonthLv4Days,
    int? aRTodayPartCount,
    int? aSTodayPartAmount,
    int? aTTodaySmsCount,
    int? aUTodayCallCount,
    int? aVTodayLogCount,
    int? aWWeekSmsCount,
    int? aXWeekCallCount,
    int? aYWeekLogCount,
    String? bAAvatar,
    int? aZTodayNoLogCount,
    int? cATodayNoCallCount,
    String? cBLastCall,
    dynamic cCReviewingCount,
    int? cDTodayAdditionCount,
    int? cETodayDeleteCount,
    int? cFWeekRegCnt,
    int? cGWeekApplyCnt,
    int? cHWeekWaiveLeftCnt,
    int? cIWeekBlockLeftCnt,
    String? updatedAt,
    int? cJWeekWaLeftCnt,
    int? cKDayWaLeftCnt,
    int? cLWeekCouponLeftCnt,
    int? cMWeekExtendLeftCnt,
    int? cNWeekExtendCnt,
    int? cOMonthExtendCnt,
    int? cPWeekRetainLeftCnt,
    int? cQWeekReceiveLeftCnt,
    int? cRTodayMarketingCnt,
    int? cSWeekRegBonus,
    int? cTWeekApplyBonus,
    int? cUMonthRegBonus,
    int? cVMonthApplyBonus,
    int? cWMonthRegCnt,
    int? cXMonthApplyCnt,
    int? cYTodayReceiveCount,
    int? cZTodayRetainCount,
    int? dATodaySystemCount,
    int? dBTodayOutCount,
    int? dCTodayMarketingCount,
    int? dDOtherBonus,
    int? dEWeekAirtimeBonus,
    int? dFWeekAirtimeCnt,
    int? dGMonthAirtimeBonus,
    int? dHMonthAirtimeCnt,
    int? dIWeekAirtime2Bonus,
    int? dJWeekAirtime2Cnt,
    int? dKMonthAirtime2Bonus,
    int? dLMonthAirtime2Cnt,
    int? dMDayAirtimeBonus,
    int? dNDayAirtime2Bonus,
  }) {
    return ShopOtherProfile()
      ..id = id ?? this.id
      ..aName = aName ?? this.aName
      ..bAdminId = bAdminId ?? this.bAdminId
      ..cCollectionAgencyId = cCollectionAgencyId ?? this.cCollectionAgencyId
      ..dCollectionGroupId = dCollectionGroupId ?? this.dCollectionGroupId
      ..eCollectionStages = eCollectionStages ?? this.eCollectionStages
      ..fStatus = fStatus ?? this.fStatus
      ..gComment = gComment ?? this.gComment
      ..hCollectionIngOrderCount = hCollectionIngOrderCount ??
          this.hCollectionIngOrderCount
      ..iTodayCurrentKpiLevel = iTodayCurrentKpiLevel ??
          this.iTodayCurrentKpiLevel
      ..jTodayInitAmount = jTodayInitAmount ?? this.jTodayInitAmount
      ..kCurrentNewCount = kCurrentNewCount ?? this.kCurrentNewCount
      ..lCurrentNegotiatingCount = lCurrentNegotiatingCount ??
          this.lCurrentNegotiatingCount
      ..mCurrrentPromisedCount = mCurrrentPromisedCount ??
          this.mCurrrentPromisedCount
      ..nCurrentBrokenCount = nCurrentBrokenCount ?? this.nCurrentBrokenCount
      ..oCurrentRefusedCount = oCurrentRefusedCount ?? this.oCurrentRefusedCount
      ..pTodayCurrentRepayCount = pTodayCurrentRepayCount ??
          this.pTodayCurrentRepayCount
      ..rTodayCurrentRepayAmount = rTodayCurrentRepayAmount ??
          this.rTodayCurrentRepayAmount
      ..tTodayLv1Commission = tTodayLv1Commission ?? this.tTodayLv1Commission
      ..uTodayLv2Commission = uTodayLv2Commission ?? this.uTodayLv2Commission
      ..vTodayLv3Commission = vTodayLv3Commission ?? this.vTodayLv3Commission
      ..wTodayLv4Commission = wTodayLv4Commission ?? this.wTodayLv4Commission
      ..xTodayInitCount = xTodayInitCount ?? this.xTodayInitCount
      ..yFirstLogAt = yFirstLogAt ?? this.yFirstLogAt
      ..zLastLogAt = zLastLogAt ?? this.zLastLogAt
      ..aAWeekLv1Commission = aAWeekLv1Commission ?? this.aAWeekLv1Commission
      ..aBWeekLv2Commission = aBWeekLv2Commission ?? this.aBWeekLv2Commission
      ..aCWeekLv3Commission = aCWeekLv3Commission ?? this.aCWeekLv3Commission
      ..aDWeekLv4Commission = aDWeekLv4Commission ?? this.aDWeekLv4Commission
      ..aETodayCommissionRate = aETodayCommissionRate ??
          this.aETodayCommissionRate
      ..aFLastCallAt = aFLastCallAt ?? this.aFLastCallAt
      ..aGCollectionCommissionNewCount = aGCollectionCommissionNewCount ??
          this.aGCollectionCommissionNewCount
      ..aHCollectionNotificationCount = aHCollectionNotificationCount ??
          this.aHCollectionNotificationCount
      ..aIWeekRepayCount = aIWeekRepayCount ?? this.aIWeekRepayCount
      ..aJWeekCommission = aJWeekCommission ?? this.aJWeekCommission
      ..aKMonthRepayCount = aKMonthRepayCount ?? this.aKMonthRepayCount
      ..aLMonthCommission = aLMonthCommission ?? this.aLMonthCommission
      ..aMTodayCommission = aMTodayCommission ?? this.aMTodayCommission
      ..aNMonthLv1Days = aNMonthLv1Days ?? this.aNMonthLv1Days
      ..aOMonthLv2Days = aOMonthLv2Days ?? this.aOMonthLv2Days
      ..aPMonthLv3Days = aPMonthLv3Days ?? this.aPMonthLv3Days
      ..aQMonthLv4Days = aQMonthLv4Days ?? this.aQMonthLv4Days
      ..aRTodayPartCount = aRTodayPartCount ?? this.aRTodayPartCount
      ..aSTodayPartAmount = aSTodayPartAmount ?? this.aSTodayPartAmount
      ..aTTodaySmsCount = aTTodaySmsCount ?? this.aTTodaySmsCount
      ..aUTodayCallCount = aUTodayCallCount ?? this.aUTodayCallCount
      ..aVTodayLogCount = aVTodayLogCount ?? this.aVTodayLogCount
      ..aWWeekSmsCount = aWWeekSmsCount ?? this.aWWeekSmsCount
      ..aXWeekCallCount = aXWeekCallCount ?? this.aXWeekCallCount
      ..aYWeekLogCount = aYWeekLogCount ?? this.aYWeekLogCount
      ..bAAvatar = bAAvatar ?? this.bAAvatar
      ..aZTodayNoLogCount = aZTodayNoLogCount ?? this.aZTodayNoLogCount
      ..cATodayNoCallCount = cATodayNoCallCount ?? this.cATodayNoCallCount
      ..cBLastCall = cBLastCall ?? this.cBLastCall
      ..cCReviewingCount = cCReviewingCount ?? this.cCReviewingCount
      ..cDTodayAdditionCount = cDTodayAdditionCount ?? this.cDTodayAdditionCount
      ..cETodayDeleteCount = cETodayDeleteCount ?? this.cETodayDeleteCount
      ..cFWeekRegCnt = cFWeekRegCnt ?? this.cFWeekRegCnt
      ..cGWeekApplyCnt = cGWeekApplyCnt ?? this.cGWeekApplyCnt
      ..cHWeekWaiveLeftCnt = cHWeekWaiveLeftCnt ?? this.cHWeekWaiveLeftCnt
      ..cIWeekBlockLeftCnt = cIWeekBlockLeftCnt ?? this.cIWeekBlockLeftCnt
      ..updatedAt = updatedAt ?? this.updatedAt
      ..cJWeekWaLeftCnt = cJWeekWaLeftCnt ?? this.cJWeekWaLeftCnt
      ..cKDayWaLeftCnt = cKDayWaLeftCnt ?? this.cKDayWaLeftCnt
      ..cLWeekCouponLeftCnt = cLWeekCouponLeftCnt ?? this.cLWeekCouponLeftCnt
      ..cMWeekExtendLeftCnt = cMWeekExtendLeftCnt ?? this.cMWeekExtendLeftCnt
      ..cNWeekExtendCnt = cNWeekExtendCnt ?? this.cNWeekExtendCnt
      ..cOMonthExtendCnt = cOMonthExtendCnt ?? this.cOMonthExtendCnt
      ..cPWeekRetainLeftCnt = cPWeekRetainLeftCnt ?? this.cPWeekRetainLeftCnt
      ..cQWeekReceiveLeftCnt = cQWeekReceiveLeftCnt ?? this.cQWeekReceiveLeftCnt
      ..cRTodayMarketingCnt = cRTodayMarketingCnt ?? this.cRTodayMarketingCnt
      ..cSWeekRegBonus = cSWeekRegBonus ?? this.cSWeekRegBonus
      ..cTWeekApplyBonus = cTWeekApplyBonus ?? this.cTWeekApplyBonus
      ..cUMonthRegBonus = cUMonthRegBonus ?? this.cUMonthRegBonus
      ..cVMonthApplyBonus = cVMonthApplyBonus ?? this.cVMonthApplyBonus
      ..cWMonthRegCnt = cWMonthRegCnt ?? this.cWMonthRegCnt
      ..cXMonthApplyCnt = cXMonthApplyCnt ?? this.cXMonthApplyCnt
      ..cYTodayReceiveCount = cYTodayReceiveCount ?? this.cYTodayReceiveCount
      ..cZTodayRetainCount = cZTodayRetainCount ?? this.cZTodayRetainCount
      ..dATodaySystemCount = dATodaySystemCount ?? this.dATodaySystemCount
      ..dBTodayOutCount = dBTodayOutCount ?? this.dBTodayOutCount
      ..dCTodayMarketingCount = dCTodayMarketingCount ??
          this.dCTodayMarketingCount
      ..dDOtherBonus = dDOtherBonus ?? this.dDOtherBonus
      ..dEWeekAirtimeBonus = dEWeekAirtimeBonus ?? this.dEWeekAirtimeBonus
      ..dFWeekAirtimeCnt = dFWeekAirtimeCnt ?? this.dFWeekAirtimeCnt
      ..dGMonthAirtimeBonus = dGMonthAirtimeBonus ?? this.dGMonthAirtimeBonus
      ..dHMonthAirtimeCnt = dHMonthAirtimeCnt ?? this.dHMonthAirtimeCnt
      ..dIWeekAirtime2Bonus = dIWeekAirtime2Bonus ?? this.dIWeekAirtime2Bonus
      ..dJWeekAirtime2Cnt = dJWeekAirtime2Cnt ?? this.dJWeekAirtime2Cnt
      ..dKMonthAirtime2Bonus = dKMonthAirtime2Bonus ?? this.dKMonthAirtime2Bonus
      ..dLMonthAirtime2Cnt = dLMonthAirtime2Cnt ?? this.dLMonthAirtime2Cnt
      ..dMDayAirtimeBonus = dMDayAirtimeBonus ?? this.dMDayAirtimeBonus
      ..dNDayAirtime2Bonus = dNDayAirtime2Bonus ?? this.dNDayAirtime2Bonus;
  }
}

ShopOtherMonthAdditionData $ShopOtherMonthAdditionDataFromJson(
    Map<String, dynamic> json) {
  final ShopOtherMonthAdditionData shopOtherMonthAdditionData = ShopOtherMonthAdditionData();
  final String? level = jsonConvert.convert<String>(json['level']);
  if (level != null) {
    shopOtherMonthAdditionData.level = level;
  }
  final int? days = jsonConvert.convert<int>(json['days']);
  if (days != null) {
    shopOtherMonthAdditionData.days = days;
  }
  final int? bonus = jsonConvert.convert<int>(json['bonus']);
  if (bonus != null) {
    shopOtherMonthAdditionData.bonus = bonus;
  }
  final int? completeDays = jsonConvert.convert<int>(json['complete_days']);
  if (completeDays != null) {
    shopOtherMonthAdditionData.completeDays = completeDays;
  }
  return shopOtherMonthAdditionData;
}

Map<String, dynamic> $ShopOtherMonthAdditionDataToJson(
    ShopOtherMonthAdditionData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['level'] = entity.level;
  data['days'] = entity.days;
  data['bonus'] = entity.bonus;
  data['complete_days'] = entity.completeDays;
  return data;
}

extension ShopOtherMonthAdditionDataExtension on ShopOtherMonthAdditionData {
  ShopOtherMonthAdditionData copyWith({
    String? level,
    int? days,
    int? bonus,
    int? completeDays,
  }) {
    return ShopOtherMonthAdditionData()
      ..level = level ?? this.level
      ..days = days ?? this.days
      ..bonus = bonus ?? this.bonus
      ..completeDays = completeDays ?? this.completeDays;
  }
}

ShopOtherAdditionBonus $ShopOtherAdditionBonusFromJson(
    Map<String, dynamic> json) {
  final ShopOtherAdditionBonus shopOtherAdditionBonus = ShopOtherAdditionBonus();
  final List<int>? overdueDays = (json['overdue_days'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<int>(e) as int).toList();
  if (overdueDays != null) {
    shopOtherAdditionBonus.overdueDays = overdueDays;
  }
  final int? rate = jsonConvert.convert<int>(json['rate']);
  if (rate != null) {
    shopOtherAdditionBonus.rate = rate;
  }
  return shopOtherAdditionBonus;
}

Map<String, dynamic> $ShopOtherAdditionBonusToJson(
    ShopOtherAdditionBonus entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['overdue_days'] = entity.overdueDays;
  data['rate'] = entity.rate;
  return data;
}

extension ShopOtherAdditionBonusExtension on ShopOtherAdditionBonus {
  ShopOtherAdditionBonus copyWith({
    List<int>? overdueDays,
    int? rate,
  }) {
    return ShopOtherAdditionBonus()
      ..overdueDays = overdueDays ?? this.overdueDays
      ..rate = rate ?? this.rate;
  }
}

ShopOtherFines $ShopOtherFinesFromJson(Map<String, dynamic> json) {
  final ShopOtherFines shopOtherFines = ShopOtherFines();
  final List<int>? borrowCount = (json['borrow_count'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<int>(e) as int).toList();
  if (borrowCount != null) {
    shopOtherFines.borrowCount = borrowCount;
  }
  final List<int>? fines = (json['fines'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<int>(e) as int).toList();
  if (fines != null) {
    shopOtherFines.fines = fines;
  }
  return shopOtherFines;
}

Map<String, dynamic> $ShopOtherFinesToJson(ShopOtherFines entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['borrow_count'] = entity.borrowCount;
  data['fines'] = entity.fines;
  return data;
}

extension ShopOtherFinesExtension on ShopOtherFines {
  ShopOtherFines copyWith({
    List<int>? borrowCount,
    List<int>? fines,
  }) {
    return ShopOtherFines()
      ..borrowCount = borrowCount ?? this.borrowCount
      ..fines = fines ?? this.fines;
  }
}
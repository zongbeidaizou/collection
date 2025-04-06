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
  final ShopDataOther? other = jsonConvert.convert<ShopDataOther>(
      json['other']);
  if (other != null) {
    shopData.other = other;
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
  return shopData;
}

Map<String, dynamic> $ShopDataToJson(ShopData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['web_url'] = entity.webUrl;
  data['other'] = entity.other?.toJson();
  data['show_month_data'] = entity.showMonthData;
  data['month_data'] = entity.monthData?.map((v) => v.toJson()).toList();
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
  return data;
}

extension ShopDataExtension on ShopData {
  ShopData copyWith({
    String? webUrl,
    ShopDataOther? other,
    bool? showMonthData,
    List<ShopDataMonthData>? monthData,
    bool? showWeekCaseData,
    List<ShopDataWeekCaseData>? weekCaseData,
    bool? showWeekBonusData,
    List<ShopDataWeekBonusData>? weekBonusData,
    bool? showMonthCaseData,
    List<ShopDataMonthCaseData>? monthCaseData,
    bool? showMonthBonusData,
    List<ShopDataMonthBonusData>? monthBonusData,
  }) {
    return ShopData()
      ..webUrl = webUrl ?? this.webUrl
      ..other = other ?? this.other
      ..showMonthData = showMonthData ?? this.showMonthData
      ..monthData = monthData ?? this.monthData
      ..showWeekCaseData = showWeekCaseData ?? this.showWeekCaseData
      ..weekCaseData = weekCaseData ?? this.weekCaseData
      ..showWeekBonusData = showWeekBonusData ?? this.showWeekBonusData
      ..weekBonusData = weekBonusData ?? this.weekBonusData
      ..showMonthCaseData = showMonthCaseData ?? this.showMonthCaseData
      ..monthCaseData = monthCaseData ?? this.monthCaseData
      ..showMonthBonusData = showMonthBonusData ?? this.showMonthBonusData
      ..monthBonusData = monthBonusData ?? this.monthBonusData;
  }
}

ShopDataOther $ShopDataOtherFromJson(Map<String, dynamic> json) {
  final ShopDataOther shopDataOther = ShopDataOther();
  final ShopDataOtherProgress? progress = jsonConvert.convert<
      ShopDataOtherProgress>(json['progress']);
  if (progress != null) {
    shopDataOther.progress = progress;
  }
  final ShopDataOtherProfile? profile = jsonConvert.convert<
      ShopDataOtherProfile>(json['profile']);
  if (profile != null) {
    shopDataOther.profile = profile;
  }
  return shopDataOther;
}

Map<String, dynamic> $ShopDataOtherToJson(ShopDataOther entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['progress'] = entity.progress?.toJson();
  data['profile'] = entity.profile?.toJson();
  return data;
}

extension ShopDataOtherExtension on ShopDataOther {
  ShopDataOther copyWith({
    ShopDataOtherProgress? progress,
    ShopDataOtherProfile? profile,
  }) {
    return ShopDataOther()
      ..progress = progress ?? this.progress
      ..profile = profile ?? this.profile;
  }
}

ShopDataOtherProgress $ShopDataOtherProgressFromJson(
    Map<String, dynamic> json) {
  final ShopDataOtherProgress shopDataOtherProgress = ShopDataOtherProgress();
  final List<int>? points = (json['points'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<int>(e) as int).toList();
  if (points != null) {
    shopDataOtherProgress.points = points;
  }
  final List<
      ShopDataOtherProgressLevelProgress>? levelProgress = (json['levelProgress'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<ShopDataOtherProgressLevelProgress>(
          e) as ShopDataOtherProgressLevelProgress).toList();
  if (levelProgress != null) {
    shopDataOtherProgress.levelProgress = levelProgress;
  }
  final List<
      ShopDataOtherProgressAmountProgress>? amountProgress = (json['amountProgress'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<ShopDataOtherProgressAmountProgress>(
          e) as ShopDataOtherProgressAmountProgress).toList();
  if (amountProgress != null) {
    shopDataOtherProgress.amountProgress = amountProgress;
  }
  final List<int>? amountProgress2 = (json['amountProgress2'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<int>(e) as int)
      .toList();
  if (amountProgress2 != null) {
    shopDataOtherProgress.amountProgress2 = amountProgress2;
  }
  final int? currentLevel = jsonConvert.convert<int>(json['currentLevel']);
  if (currentLevel != null) {
    shopDataOtherProgress.currentLevel = currentLevel;
  }
  final int? nextAmount = jsonConvert.convert<int>(json['nextAmount']);
  if (nextAmount != null) {
    shopDataOtherProgress.nextAmount = nextAmount;
  }
  final int? nextLevel = jsonConvert.convert<int>(json['nextLevel']);
  if (nextLevel != null) {
    shopDataOtherProgress.nextLevel = nextLevel;
  }
  final int? currentKey = jsonConvert.convert<int>(json['currentKey']);
  if (currentKey != null) {
    shopDataOtherProgress.currentKey = currentKey;
  }
  return shopDataOtherProgress;
}

Map<String, dynamic> $ShopDataOtherProgressToJson(
    ShopDataOtherProgress entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['points'] = entity.points;
  data['levelProgress'] = entity.levelProgress?.map((v) => v.toJson()).toList();
  data['amountProgress'] =
      entity.amountProgress?.map((v) => v.toJson()).toList();
  data['amountProgress2'] = entity.amountProgress2;
  data['currentLevel'] = entity.currentLevel;
  data['nextAmount'] = entity.nextAmount;
  data['nextLevel'] = entity.nextLevel;
  data['currentKey'] = entity.currentKey;
  return data;
}

extension ShopDataOtherProgressExtension on ShopDataOtherProgress {
  ShopDataOtherProgress copyWith({
    List<int>? points,
    List<ShopDataOtherProgressLevelProgress>? levelProgress,
    List<ShopDataOtherProgressAmountProgress>? amountProgress,
    List<int>? amountProgress2,
    int? currentLevel,
    int? nextAmount,
    int? nextLevel,
    int? currentKey,
  }) {
    return ShopDataOtherProgress()
      ..points = points ?? this.points
      ..levelProgress = levelProgress ?? this.levelProgress
      ..amountProgress = amountProgress ?? this.amountProgress
      ..amountProgress2 = amountProgress2 ?? this.amountProgress2
      ..currentLevel = currentLevel ?? this.currentLevel
      ..nextAmount = nextAmount ?? this.nextAmount
      ..nextLevel = nextLevel ?? this.nextLevel
      ..currentKey = currentKey ?? this.currentKey;
  }
}

ShopDataOtherProgressLevelProgress $ShopDataOtherProgressLevelProgressFromJson(
    Map<String, dynamic> json) {
  final ShopDataOtherProgressLevelProgress shopDataOtherProgressLevelProgress = ShopDataOtherProgressLevelProgress();
  final String? level = jsonConvert.convert<String>(json['level']);
  if (level != null) {
    shopDataOtherProgressLevelProgress.level = level;
  }
  final int? type = jsonConvert.convert<int>(json['type']);
  if (type != null) {
    shopDataOtherProgressLevelProgress.type = type;
  }
  return shopDataOtherProgressLevelProgress;
}

Map<String, dynamic> $ShopDataOtherProgressLevelProgressToJson(
    ShopDataOtherProgressLevelProgress entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['level'] = entity.level;
  data['type'] = entity.type;
  return data;
}

extension ShopDataOtherProgressLevelProgressExtension on ShopDataOtherProgressLevelProgress {
  ShopDataOtherProgressLevelProgress copyWith({
    String? level,
    int? type,
  }) {
    return ShopDataOtherProgressLevelProgress()
      ..level = level ?? this.level
      ..type = type ?? this.type;
  }
}

ShopDataOtherProgressAmountProgress $ShopDataOtherProgressAmountProgressFromJson(
    Map<String, dynamic> json) {
  final ShopDataOtherProgressAmountProgress shopDataOtherProgressAmountProgress = ShopDataOtherProgressAmountProgress();
  final int? amount = jsonConvert.convert<int>(json['amount']);
  if (amount != null) {
    shopDataOtherProgressAmountProgress.amount = amount;
  }
  final int? type = jsonConvert.convert<int>(json['type']);
  if (type != null) {
    shopDataOtherProgressAmountProgress.type = type;
  }
  return shopDataOtherProgressAmountProgress;
}

Map<String, dynamic> $ShopDataOtherProgressAmountProgressToJson(
    ShopDataOtherProgressAmountProgress entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['amount'] = entity.amount;
  data['type'] = entity.type;
  return data;
}

extension ShopDataOtherProgressAmountProgressExtension on ShopDataOtherProgressAmountProgress {
  ShopDataOtherProgressAmountProgress copyWith({
    int? amount,
    int? type,
  }) {
    return ShopDataOtherProgressAmountProgress()
      ..amount = amount ?? this.amount
      ..type = type ?? this.type;
  }
}

ShopDataOtherProfile $ShopDataOtherProfileFromJson(Map<String, dynamic> json) {
  final ShopDataOtherProfile shopDataOtherProfile = ShopDataOtherProfile();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    shopDataOtherProfile.id = id;
  }
  final String? aName = jsonConvert.convert<String>(json['a_name']);
  if (aName != null) {
    shopDataOtherProfile.aName = aName;
  }
  final int? bAdminId = jsonConvert.convert<int>(json['b_admin_id']);
  if (bAdminId != null) {
    shopDataOtherProfile.bAdminId = bAdminId;
  }
  final int? cCollectionAgencyId = jsonConvert.convert<int>(
      json['c_collection_agency_id']);
  if (cCollectionAgencyId != null) {
    shopDataOtherProfile.cCollectionAgencyId = cCollectionAgencyId;
  }
  final int? dCollectionGroupId = jsonConvert.convert<int>(
      json['d_collection_group_id']);
  if (dCollectionGroupId != null) {
    shopDataOtherProfile.dCollectionGroupId = dCollectionGroupId;
  }
  final String? eCollectionStages = jsonConvert.convert<String>(
      json['e_collection_stages']);
  if (eCollectionStages != null) {
    shopDataOtherProfile.eCollectionStages = eCollectionStages;
  }
  final int? fStatus = jsonConvert.convert<int>(json['f_status']);
  if (fStatus != null) {
    shopDataOtherProfile.fStatus = fStatus;
  }
  final String? gComment = jsonConvert.convert<String>(json['g_comment']);
  if (gComment != null) {
    shopDataOtherProfile.gComment = gComment;
  }
  final int? hCollectionIngOrderCount = jsonConvert.convert<int>(
      json['h_collection_ing_order_count']);
  if (hCollectionIngOrderCount != null) {
    shopDataOtherProfile.hCollectionIngOrderCount = hCollectionIngOrderCount;
  }
  final int? iTodayCurrentKpiLevel = jsonConvert.convert<int>(
      json['i_today_current_kpi_level']);
  if (iTodayCurrentKpiLevel != null) {
    shopDataOtherProfile.iTodayCurrentKpiLevel = iTodayCurrentKpiLevel;
  }
  final int? jTodayInitAmount = jsonConvert.convert<int>(
      json['j_today_init_amount']);
  if (jTodayInitAmount != null) {
    shopDataOtherProfile.jTodayInitAmount = jTodayInitAmount;
  }
  final int? kCurrentNewCount = jsonConvert.convert<int>(
      json['k_current_new_count']);
  if (kCurrentNewCount != null) {
    shopDataOtherProfile.kCurrentNewCount = kCurrentNewCount;
  }
  final int? lCurrentNegotiatingCount = jsonConvert.convert<int>(
      json['l_current_negotiating_count']);
  if (lCurrentNegotiatingCount != null) {
    shopDataOtherProfile.lCurrentNegotiatingCount = lCurrentNegotiatingCount;
  }
  final int? mCurrrentPromisedCount = jsonConvert.convert<int>(
      json['m_currrent_promised_count']);
  if (mCurrrentPromisedCount != null) {
    shopDataOtherProfile.mCurrrentPromisedCount = mCurrrentPromisedCount;
  }
  final int? nCurrentBrokenCount = jsonConvert.convert<int>(
      json['n_current_broken_count']);
  if (nCurrentBrokenCount != null) {
    shopDataOtherProfile.nCurrentBrokenCount = nCurrentBrokenCount;
  }
  final int? oCurrentRefusedCount = jsonConvert.convert<int>(
      json['o_current_refused_count']);
  if (oCurrentRefusedCount != null) {
    shopDataOtherProfile.oCurrentRefusedCount = oCurrentRefusedCount;
  }
  final int? pTodayCurrentRepayCount = jsonConvert.convert<int>(
      json['p_today_current_repay_count']);
  if (pTodayCurrentRepayCount != null) {
    shopDataOtherProfile.pTodayCurrentRepayCount = pTodayCurrentRepayCount;
  }
  final int? rTodayCurrentRepayAmount = jsonConvert.convert<int>(
      json['r_today_current_repay_amount']);
  if (rTodayCurrentRepayAmount != null) {
    shopDataOtherProfile.rTodayCurrentRepayAmount = rTodayCurrentRepayAmount;
  }
  final int? tTodayLv1Commission = jsonConvert.convert<int>(
      json['t_today_lv1_commission']);
  if (tTodayLv1Commission != null) {
    shopDataOtherProfile.tTodayLv1Commission = tTodayLv1Commission;
  }
  final int? uTodayLv2Commission = jsonConvert.convert<int>(
      json['u_today_lv2_commission']);
  if (uTodayLv2Commission != null) {
    shopDataOtherProfile.uTodayLv2Commission = uTodayLv2Commission;
  }
  final int? vTodayLv3Commission = jsonConvert.convert<int>(
      json['v_today_lv3_commission']);
  if (vTodayLv3Commission != null) {
    shopDataOtherProfile.vTodayLv3Commission = vTodayLv3Commission;
  }
  final int? wTodayLv4Commission = jsonConvert.convert<int>(
      json['w_today_lv4_commission']);
  if (wTodayLv4Commission != null) {
    shopDataOtherProfile.wTodayLv4Commission = wTodayLv4Commission;
  }
  final int? xTodayInitCount = jsonConvert.convert<int>(
      json['x_today_init_count']);
  if (xTodayInitCount != null) {
    shopDataOtherProfile.xTodayInitCount = xTodayInitCount;
  }
  final dynamic yFirstLogAt = json['y_first_log_at'];
  if (yFirstLogAt != null) {
    shopDataOtherProfile.yFirstLogAt = yFirstLogAt;
  }
  final dynamic zLastLogAt = json['z_last_log_at'];
  if (zLastLogAt != null) {
    shopDataOtherProfile.zLastLogAt = zLastLogAt;
  }
  final dynamic aAMonthLv1Commission = json['a_a_month_lv1_commission'];
  if (aAMonthLv1Commission != null) {
    shopDataOtherProfile.aAMonthLv1Commission = aAMonthLv1Commission;
  }
  final int? aBMonthLv2Commission = jsonConvert.convert<int>(
      json['a_b_month_lv2_commission']);
  if (aBMonthLv2Commission != null) {
    shopDataOtherProfile.aBMonthLv2Commission = aBMonthLv2Commission;
  }
  final dynamic aCMonthLv3Commission = json['a_c_month_lv3_commission'];
  if (aCMonthLv3Commission != null) {
    shopDataOtherProfile.aCMonthLv3Commission = aCMonthLv3Commission;
  }
  final dynamic aDMonthLv4Commission = json['a_d_month_lv4_commission'];
  if (aDMonthLv4Commission != null) {
    shopDataOtherProfile.aDMonthLv4Commission = aDMonthLv4Commission;
  }
  final int? aETodayCommissionRate = jsonConvert.convert<int>(
      json['a_e_today_commission_rate']);
  if (aETodayCommissionRate != null) {
    shopDataOtherProfile.aETodayCommissionRate = aETodayCommissionRate;
  }
  final dynamic aFLastCallAt = json['a_f_last_call_at'];
  if (aFLastCallAt != null) {
    shopDataOtherProfile.aFLastCallAt = aFLastCallAt;
  }
  final int? aGCollectionCommissionNewCount = jsonConvert.convert<int>(
      json['a_g_collection_commission_new_count']);
  if (aGCollectionCommissionNewCount != null) {
    shopDataOtherProfile.aGCollectionCommissionNewCount =
        aGCollectionCommissionNewCount;
  }
  final dynamic aHCollectionNotificationCount = json['a_h_collection_notification_count'];
  if (aHCollectionNotificationCount != null) {
    shopDataOtherProfile.aHCollectionNotificationCount =
        aHCollectionNotificationCount;
  }
  final dynamic aIWeekRepayCount = json['a_i_week_repay_count'];
  if (aIWeekRepayCount != null) {
    shopDataOtherProfile.aIWeekRepayCount = aIWeekRepayCount;
  }
  final dynamic aJWeekRank = json['a_j_week_rank'];
  if (aJWeekRank != null) {
    shopDataOtherProfile.aJWeekRank = aJWeekRank;
  }
  final String? updatedAt = jsonConvert.convert<String>(json['updated_at']);
  if (updatedAt != null) {
    shopDataOtherProfile.updatedAt = updatedAt;
  }
  return shopDataOtherProfile;
}

Map<String, dynamic> $ShopDataOtherProfileToJson(ShopDataOtherProfile entity) {
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
  data['a_a_month_lv1_commission'] = entity.aAMonthLv1Commission;
  data['a_b_month_lv2_commission'] = entity.aBMonthLv2Commission;
  data['a_c_month_lv3_commission'] = entity.aCMonthLv3Commission;
  data['a_d_month_lv4_commission'] = entity.aDMonthLv4Commission;
  data['a_e_today_commission_rate'] = entity.aETodayCommissionRate;
  data['a_f_last_call_at'] = entity.aFLastCallAt;
  data['a_g_collection_commission_new_count'] =
      entity.aGCollectionCommissionNewCount;
  data['a_h_collection_notification_count'] =
      entity.aHCollectionNotificationCount;
  data['a_i_week_repay_count'] = entity.aIWeekRepayCount;
  data['a_j_week_rank'] = entity.aJWeekRank;
  data['updated_at'] = entity.updatedAt;
  return data;
}

extension ShopDataOtherProfileExtension on ShopDataOtherProfile {
  ShopDataOtherProfile copyWith({
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
    dynamic yFirstLogAt,
    dynamic zLastLogAt,
    dynamic aAMonthLv1Commission,
    int? aBMonthLv2Commission,
    dynamic aCMonthLv3Commission,
    dynamic aDMonthLv4Commission,
    int? aETodayCommissionRate,
    dynamic aFLastCallAt,
    int? aGCollectionCommissionNewCount,
    dynamic aHCollectionNotificationCount,
    dynamic aIWeekRepayCount,
    dynamic aJWeekRank,
    String? updatedAt,
  }) {
    return ShopDataOtherProfile()
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
      ..aAMonthLv1Commission = aAMonthLv1Commission ?? this.aAMonthLv1Commission
      ..aBMonthLv2Commission = aBMonthLv2Commission ?? this.aBMonthLv2Commission
      ..aCMonthLv3Commission = aCMonthLv3Commission ?? this.aCMonthLv3Commission
      ..aDMonthLv4Commission = aDMonthLv4Commission ?? this.aDMonthLv4Commission
      ..aETodayCommissionRate = aETodayCommissionRate ??
          this.aETodayCommissionRate
      ..aFLastCallAt = aFLastCallAt ?? this.aFLastCallAt
      ..aGCollectionCommissionNewCount = aGCollectionCommissionNewCount ??
          this.aGCollectionCommissionNewCount
      ..aHCollectionNotificationCount = aHCollectionNotificationCount ??
          this.aHCollectionNotificationCount
      ..aIWeekRepayCount = aIWeekRepayCount ?? this.aIWeekRepayCount
      ..aJWeekRank = aJWeekRank ?? this.aJWeekRank
      ..updatedAt = updatedAt ?? this.updatedAt;
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
  return shopDataMonthData;
}

Map<String, dynamic> $ShopDataMonthDataToJson(ShopDataMonthData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['avatar'] = entity.avatar;
  data['name'] = entity.name;
  data['value'] = entity.value;
  return data;
}

extension ShopDataMonthDataExtension on ShopDataMonthData {
  ShopDataMonthData copyWith({
    String? avatar,
    String? name,
    int? value,
  }) {
    return ShopDataMonthData()
      ..avatar = avatar ?? this.avatar
      ..name = name ?? this.name
      ..value = value ?? this.value;
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
  return shopDataWeekCaseData;
}

Map<String, dynamic> $ShopDataWeekCaseDataToJson(ShopDataWeekCaseData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['name'] = entity.name;
  data['value'] = entity.value;
  return data;
}

extension ShopDataWeekCaseDataExtension on ShopDataWeekCaseData {
  ShopDataWeekCaseData copyWith({
    String? name,
    int? value,
  }) {
    return ShopDataWeekCaseData()
      ..name = name ?? this.name
      ..value = value ?? this.value;
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
  return shopDataWeekBonusData;
}

Map<String, dynamic> $ShopDataWeekBonusDataToJson(
    ShopDataWeekBonusData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['name'] = entity.name;
  data['value'] = entity.value;
  return data;
}

extension ShopDataWeekBonusDataExtension on ShopDataWeekBonusData {
  ShopDataWeekBonusData copyWith({
    String? name,
    int? value,
  }) {
    return ShopDataWeekBonusData()
      ..name = name ?? this.name
      ..value = value ?? this.value;
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
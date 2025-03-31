import 'package:bounty_hunter/generated/json/base/json_convert_content.dart';
import 'package:bounty_hunter/models/collection_notification_entity.dart';
import 'package:bounty_hunter/models/collection_order_entity.dart';


CollectionNotificationEntity $CollectionNotificationEntityFromJson(
    Map<String, dynamic> json) {
  final CollectionNotificationEntity collectionNotificationEntity = CollectionNotificationEntity();
  final bool? success = jsonConvert.convert<bool>(json['success']);
  if (success != null) {
    collectionNotificationEntity.success = success;
  }
  final String? errorMessage = jsonConvert.convert<String>(
      json['errorMessage']);
  if (errorMessage != null) {
    collectionNotificationEntity.errorMessage = errorMessage;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    collectionNotificationEntity.message = message;
  }
  final List<CollectionNotificationData>? data = (json['data'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<CollectionNotificationData>(
          e) as CollectionNotificationData).toList();
  if (data != null) {
    collectionNotificationEntity.data = data;
  }
  final CollectionOrderOther? other = jsonConvert.convert<CollectionOrderOther>(
      json['other']);
  if (other != null) {
    collectionNotificationEntity.other = other;
  }
  final int? total = jsonConvert.convert<int>(json['total']);
  if (total != null) {
    collectionNotificationEntity.total = total;
  }
  final int? currentPage = jsonConvert.convert<int>(json['currentPage']);
  if (currentPage != null) {
    collectionNotificationEntity.currentPage = currentPage;
  }
  final int? perPage = jsonConvert.convert<int>(json['perPage']);
  if (perPage != null) {
    collectionNotificationEntity.perPage = perPage;
  }
  final bool? hasMorePages = jsonConvert.convert<bool>(json['hasMorePages']);
  if (hasMorePages != null) {
    collectionNotificationEntity.hasMorePages = hasMorePages;
  }
  return collectionNotificationEntity;
}

Map<String, dynamic> $CollectionNotificationEntityToJson(
    CollectionNotificationEntity entity) {
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

extension CollectionNotificationEntityExtension on CollectionNotificationEntity {
  CollectionNotificationEntity copyWith({
    bool? success,
    String? errorMessage,
    String? message,
    List<CollectionNotificationData>? data,
    CollectionOrderOther? other,
    int? total,
    int? currentPage,
    int? perPage,
    bool? hasMorePages,
  }) {
    return CollectionNotificationEntity()
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

CollectionNotificationData $CollectionNotificationDataFromJson(
    Map<String, dynamic> json) {
  final CollectionNotificationData collectionNotificationData = CollectionNotificationData();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    collectionNotificationData.id = id;
  }
  final int? aCollectionStageId = jsonConvert.convert<int>(
      json['a_collection_stage_id']);
  if (aCollectionStageId != null) {
    collectionNotificationData.aCollectionStageId = aCollectionStageId;
  }
  final int? bCollectionAgencyId = jsonConvert.convert<int>(
      json['b_collection_agency_id']);
  if (bCollectionAgencyId != null) {
    collectionNotificationData.bCollectionAgencyId = bCollectionAgencyId;
  }
  final int? cCollectionGroupId = jsonConvert.convert<int>(
      json['c_collection_group_id']);
  if (cCollectionGroupId != null) {
    collectionNotificationData.cCollectionGroupId = cCollectionGroupId;
  }
  final int? dCollectionAdminId = jsonConvert.convert<int>(
      json['d_collection_admin_id']);
  if (dCollectionAdminId != null) {
    collectionNotificationData.dCollectionAdminId = dCollectionAdminId;
  }
  final int? eReaded = jsonConvert.convert<int>(json['e_readed']);
  if (eReaded != null) {
    collectionNotificationData.eReaded = eReaded;
  }
  final String? fReadAt = jsonConvert.convert<String>(json['f_read_at']);
  if (fReadAt != null) {
    collectionNotificationData.fReadAt = fReadAt;
  }
  final int? gCat = jsonConvert.convert<int>(json['g_cat']);
  if (gCat != null) {
    collectionNotificationData.gCat = gCat;
  }
  final String? hContent = jsonConvert.convert<String>(json['h_content']);
  if (hContent != null) {
    collectionNotificationData.hContent = hContent;
  }
  final int? iCollectionStageId = jsonConvert.convert<int>(
      json['i_collection_stage_id']);
  if (iCollectionStageId != null) {
    collectionNotificationData.iCollectionStageId = iCollectionStageId;
  }
  final int? gCollectionAgencyId = jsonConvert.convert<int>(
      json['g_collection_agency_id']);
  if (gCollectionAgencyId != null) {
    collectionNotificationData.gCollectionAgencyId = gCollectionAgencyId;
  }
  final int? kCollectionGroupId = jsonConvert.convert<int>(
      json['k_collection_group_id']);
  if (kCollectionGroupId != null) {
    collectionNotificationData.kCollectionGroupId = kCollectionGroupId;
  }
  final int? lCollectionAdminId = jsonConvert.convert<int>(
      json['l_collection_admin_id']);
  if (lCollectionAdminId != null) {
    collectionNotificationData.lCollectionAdminId = lCollectionAdminId;
  }
  final String? createdAt = jsonConvert.convert<String>(json['created_at']);
  if (createdAt != null) {
    collectionNotificationData.createdAt = createdAt;
  }
  return collectionNotificationData;
}

Map<String, dynamic> $CollectionNotificationDataToJson(
    CollectionNotificationData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['a_collection_stage_id'] = entity.aCollectionStageId;
  data['b_collection_agency_id'] = entity.bCollectionAgencyId;
  data['c_collection_group_id'] = entity.cCollectionGroupId;
  data['d_collection_admin_id'] = entity.dCollectionAdminId;
  data['e_readed'] = entity.eReaded;
  data['f_read_at'] = entity.fReadAt;
  data['g_cat'] = entity.gCat;
  data['h_content'] = entity.hContent;
  data['i_collection_stage_id'] = entity.iCollectionStageId;
  data['g_collection_agency_id'] = entity.gCollectionAgencyId;
  data['k_collection_group_id'] = entity.kCollectionGroupId;
  data['l_collection_admin_id'] = entity.lCollectionAdminId;
  data['created_at'] = entity.createdAt;
  return data;
}

extension CollectionNotificationDataExtension on CollectionNotificationData {
  CollectionNotificationData copyWith({
    int? id,
    int? aCollectionStageId,
    int? bCollectionAgencyId,
    int? cCollectionGroupId,
    int? dCollectionAdminId,
    int? eReaded,
    String? fReadAt,
    int? gCat,
    String? hContent,
    int? iCollectionStageId,
    int? gCollectionAgencyId,
    int? kCollectionGroupId,
    int? lCollectionAdminId,
    String? createdAt,
  }) {
    return CollectionNotificationData()
      ..id = id ?? this.id
      ..aCollectionStageId = aCollectionStageId ?? this.aCollectionStageId
      ..bCollectionAgencyId = bCollectionAgencyId ?? this.bCollectionAgencyId
      ..cCollectionGroupId = cCollectionGroupId ?? this.cCollectionGroupId
      ..dCollectionAdminId = dCollectionAdminId ?? this.dCollectionAdminId
      ..eReaded = eReaded ?? this.eReaded
      ..fReadAt = fReadAt ?? this.fReadAt
      ..gCat = gCat ?? this.gCat
      ..hContent = hContent ?? this.hContent
      ..iCollectionStageId = iCollectionStageId ?? this.iCollectionStageId
      ..gCollectionAgencyId = gCollectionAgencyId ?? this.gCollectionAgencyId
      ..kCollectionGroupId = kCollectionGroupId ?? this.kCollectionGroupId
      ..lCollectionAdminId = lCollectionAdminId ?? this.lCollectionAdminId
      ..createdAt = createdAt ?? this.createdAt;
  }
}

CollectionNotificationOther $CollectionNotificationOtherFromJson(
    Map<String, dynamic> json) {
  final CollectionNotificationOther collectionNotificationOther = CollectionNotificationOther();
  final CollectionNotificationOtherProgress? progress = jsonConvert.convert<
      CollectionNotificationOtherProgress>(json['progress']);
  if (progress != null) {
    collectionNotificationOther.progress = progress;
  }
  final CollectionNotificationOtherProfile? profile = jsonConvert.convert<
      CollectionNotificationOtherProfile>(json['profile']);
  if (profile != null) {
    collectionNotificationOther.profile = profile;
  }
  return collectionNotificationOther;
}

Map<String, dynamic> $CollectionNotificationOtherToJson(
    CollectionNotificationOther entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['progress'] = entity.progress?.toJson();
  data['profile'] = entity.profile?.toJson();
  return data;
}

extension CollectionNotificationOtherExtension on CollectionNotificationOther {
  CollectionNotificationOther copyWith({
    CollectionNotificationOtherProgress? progress,
    CollectionNotificationOtherProfile? profile,
  }) {
    return CollectionNotificationOther()
      ..progress = progress ?? this.progress
      ..profile = profile ?? this.profile;
  }
}

CollectionNotificationOtherProgress $CollectionNotificationOtherProgressFromJson(
    Map<String, dynamic> json) {
  final CollectionNotificationOtherProgress collectionNotificationOtherProgress = CollectionNotificationOtherProgress();
  final List<int>? points = (json['points'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<int>(e) as int).toList();
  if (points != null) {
    collectionNotificationOtherProgress.points = points;
  }
  final List<
      CollectionNotificationOtherProgressLevelProgress>? levelProgress = (json['levelProgress'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<
          CollectionNotificationOtherProgressLevelProgress>(
          e) as CollectionNotificationOtherProgressLevelProgress).toList();
  if (levelProgress != null) {
    collectionNotificationOtherProgress.levelProgress = levelProgress;
  }
  final List<
      CollectionNotificationOtherProgressAmountProgress>? amountProgress = (json['amountProgress'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<
          CollectionNotificationOtherProgressAmountProgress>(
          e) as CollectionNotificationOtherProgressAmountProgress).toList();
  if (amountProgress != null) {
    collectionNotificationOtherProgress.amountProgress = amountProgress;
  }
  final List<int>? amountProgress2 = (json['amountProgress2'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<int>(e) as int)
      .toList();
  if (amountProgress2 != null) {
    collectionNotificationOtherProgress.amountProgress2 = amountProgress2;
  }
  final int? currentLevel = jsonConvert.convert<int>(json['currentLevel']);
  if (currentLevel != null) {
    collectionNotificationOtherProgress.currentLevel = currentLevel;
  }
  final int? nextAmount = jsonConvert.convert<int>(json['nextAmount']);
  if (nextAmount != null) {
    collectionNotificationOtherProgress.nextAmount = nextAmount;
  }
  final int? nextLevel = jsonConvert.convert<int>(json['nextLevel']);
  if (nextLevel != null) {
    collectionNotificationOtherProgress.nextLevel = nextLevel;
  }
  final int? currentKey = jsonConvert.convert<int>(json['currentKey']);
  if (currentKey != null) {
    collectionNotificationOtherProgress.currentKey = currentKey;
  }
  return collectionNotificationOtherProgress;
}

Map<String, dynamic> $CollectionNotificationOtherProgressToJson(
    CollectionNotificationOtherProgress entity) {
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

extension CollectionNotificationOtherProgressExtension on CollectionNotificationOtherProgress {
  CollectionNotificationOtherProgress copyWith({
    List<int>? points,
    List<CollectionNotificationOtherProgressLevelProgress>? levelProgress,
    List<CollectionNotificationOtherProgressAmountProgress>? amountProgress,
    List<int>? amountProgress2,
    int? currentLevel,
    int? nextAmount,
    int? nextLevel,
    int? currentKey,
  }) {
    return CollectionNotificationOtherProgress()
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

CollectionNotificationOtherProgressLevelProgress $CollectionNotificationOtherProgressLevelProgressFromJson(
    Map<String, dynamic> json) {
  final CollectionNotificationOtherProgressLevelProgress collectionNotificationOtherProgressLevelProgress = CollectionNotificationOtherProgressLevelProgress();
  final String? level = jsonConvert.convert<String>(json['level']);
  if (level != null) {
    collectionNotificationOtherProgressLevelProgress.level = level;
  }
  final int? type = jsonConvert.convert<int>(json['type']);
  if (type != null) {
    collectionNotificationOtherProgressLevelProgress.type = type;
  }
  return collectionNotificationOtherProgressLevelProgress;
}

Map<String, dynamic> $CollectionNotificationOtherProgressLevelProgressToJson(
    CollectionNotificationOtherProgressLevelProgress entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['level'] = entity.level;
  data['type'] = entity.type;
  return data;
}

extension CollectionNotificationOtherProgressLevelProgressExtension on CollectionNotificationOtherProgressLevelProgress {
  CollectionNotificationOtherProgressLevelProgress copyWith({
    String? level,
    int? type,
  }) {
    return CollectionNotificationOtherProgressLevelProgress()
      ..level = level ?? this.level
      ..type = type ?? this.type;
  }
}

CollectionNotificationOtherProgressAmountProgress $CollectionNotificationOtherProgressAmountProgressFromJson(
    Map<String, dynamic> json) {
  final CollectionNotificationOtherProgressAmountProgress collectionNotificationOtherProgressAmountProgress = CollectionNotificationOtherProgressAmountProgress();
  final int? amount = jsonConvert.convert<int>(json['amount']);
  if (amount != null) {
    collectionNotificationOtherProgressAmountProgress.amount = amount;
  }
  final int? type = jsonConvert.convert<int>(json['type']);
  if (type != null) {
    collectionNotificationOtherProgressAmountProgress.type = type;
  }
  return collectionNotificationOtherProgressAmountProgress;
}

Map<String, dynamic> $CollectionNotificationOtherProgressAmountProgressToJson(
    CollectionNotificationOtherProgressAmountProgress entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['amount'] = entity.amount;
  data['type'] = entity.type;
  return data;
}

extension CollectionNotificationOtherProgressAmountProgressExtension on CollectionNotificationOtherProgressAmountProgress {
  CollectionNotificationOtherProgressAmountProgress copyWith({
    int? amount,
    int? type,
  }) {
    return CollectionNotificationOtherProgressAmountProgress()
      ..amount = amount ?? this.amount
      ..type = type ?? this.type;
  }
}

CollectionNotificationOtherProfile $CollectionNotificationOtherProfileFromJson(
    Map<String, dynamic> json) {
  final CollectionNotificationOtherProfile collectionNotificationOtherProfile = CollectionNotificationOtherProfile();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    collectionNotificationOtherProfile.id = id;
  }
  final String? aName = jsonConvert.convert<String>(json['a_name']);
  if (aName != null) {
    collectionNotificationOtherProfile.aName = aName;
  }
  final int? bAdminId = jsonConvert.convert<int>(json['b_admin_id']);
  if (bAdminId != null) {
    collectionNotificationOtherProfile.bAdminId = bAdminId;
  }
  final int? cCollectionAgencyId = jsonConvert.convert<int>(
      json['c_collection_agency_id']);
  if (cCollectionAgencyId != null) {
    collectionNotificationOtherProfile.cCollectionAgencyId =
        cCollectionAgencyId;
  }
  final int? dCollectionGroupId = jsonConvert.convert<int>(
      json['d_collection_group_id']);
  if (dCollectionGroupId != null) {
    collectionNotificationOtherProfile.dCollectionGroupId = dCollectionGroupId;
  }
  final String? eCollectionStages = jsonConvert.convert<String>(
      json['e_collection_stages']);
  if (eCollectionStages != null) {
    collectionNotificationOtherProfile.eCollectionStages = eCollectionStages;
  }
  final int? fStatus = jsonConvert.convert<int>(json['f_status']);
  if (fStatus != null) {
    collectionNotificationOtherProfile.fStatus = fStatus;
  }
  final String? gComment = jsonConvert.convert<String>(json['g_comment']);
  if (gComment != null) {
    collectionNotificationOtherProfile.gComment = gComment;
  }
  final int? hCollectionIngOrderCount = jsonConvert.convert<int>(
      json['h_collection_ing_order_count']);
  if (hCollectionIngOrderCount != null) {
    collectionNotificationOtherProfile.hCollectionIngOrderCount =
        hCollectionIngOrderCount;
  }
  final int? iTodayCurrentKpiLevel = jsonConvert.convert<int>(
      json['i_today_current_kpi_level']);
  if (iTodayCurrentKpiLevel != null) {
    collectionNotificationOtherProfile.iTodayCurrentKpiLevel =
        iTodayCurrentKpiLevel;
  }
  final int? jTodayInitAmount = jsonConvert.convert<int>(
      json['j_today_init_amount']);
  if (jTodayInitAmount != null) {
    collectionNotificationOtherProfile.jTodayInitAmount = jTodayInitAmount;
  }
  final int? kCurrentNewCount = jsonConvert.convert<int>(
      json['k_current_new_count']);
  if (kCurrentNewCount != null) {
    collectionNotificationOtherProfile.kCurrentNewCount = kCurrentNewCount;
  }
  final int? lCurrentNegotiatingCount = jsonConvert.convert<int>(
      json['l_current_negotiating_count']);
  if (lCurrentNegotiatingCount != null) {
    collectionNotificationOtherProfile.lCurrentNegotiatingCount =
        lCurrentNegotiatingCount;
  }
  final int? mCurrrentPromisedCount = jsonConvert.convert<int>(
      json['m_currrent_promised_count']);
  if (mCurrrentPromisedCount != null) {
    collectionNotificationOtherProfile.mCurrrentPromisedCount =
        mCurrrentPromisedCount;
  }
  final int? nCurrentBrokenCount = jsonConvert.convert<int>(
      json['n_current_broken_count']);
  if (nCurrentBrokenCount != null) {
    collectionNotificationOtherProfile.nCurrentBrokenCount =
        nCurrentBrokenCount;
  }
  final int? oCurrentRefusedCount = jsonConvert.convert<int>(
      json['o_current_refused_count']);
  if (oCurrentRefusedCount != null) {
    collectionNotificationOtherProfile.oCurrentRefusedCount =
        oCurrentRefusedCount;
  }
  final int? pTodayCurrentRepayCount = jsonConvert.convert<int>(
      json['p_today_current_repay_count']);
  if (pTodayCurrentRepayCount != null) {
    collectionNotificationOtherProfile.pTodayCurrentRepayCount =
        pTodayCurrentRepayCount;
  }
  final int? rTodayCurrentRepayAmount = jsonConvert.convert<int>(
      json['r_today_current_repay_amount']);
  if (rTodayCurrentRepayAmount != null) {
    collectionNotificationOtherProfile.rTodayCurrentRepayAmount =
        rTodayCurrentRepayAmount;
  }
  final int? tTodayLv1Commission = jsonConvert.convert<int>(
      json['t_today_lv1_commission']);
  if (tTodayLv1Commission != null) {
    collectionNotificationOtherProfile.tTodayLv1Commission =
        tTodayLv1Commission;
  }
  final int? uTodayLv2Commission = jsonConvert.convert<int>(
      json['u_today_lv2_commission']);
  if (uTodayLv2Commission != null) {
    collectionNotificationOtherProfile.uTodayLv2Commission =
        uTodayLv2Commission;
  }
  final int? vTodayLv3Commission = jsonConvert.convert<int>(
      json['v_today_lv3_commission']);
  if (vTodayLv3Commission != null) {
    collectionNotificationOtherProfile.vTodayLv3Commission =
        vTodayLv3Commission;
  }
  final int? wTodayLv4Commission = jsonConvert.convert<int>(
      json['w_today_lv4_commission']);
  if (wTodayLv4Commission != null) {
    collectionNotificationOtherProfile.wTodayLv4Commission =
        wTodayLv4Commission;
  }
  final int? xTodayInitCount = jsonConvert.convert<int>(
      json['x_today_init_count']);
  if (xTodayInitCount != null) {
    collectionNotificationOtherProfile.xTodayInitCount = xTodayInitCount;
  }
  final String? yFirstLogAt = jsonConvert.convert<String>(
      json['y_first_log_at']);
  if (yFirstLogAt != null) {
    collectionNotificationOtherProfile.yFirstLogAt = yFirstLogAt;
  }
  final String? zLastLogAt = jsonConvert.convert<String>(json['z_last_log_at']);
  if (zLastLogAt != null) {
    collectionNotificationOtherProfile.zLastLogAt = zLastLogAt;
  }
  final int? aAMonthLv1Commission = jsonConvert.convert<int>(
      json['a_a_month_lv1_commission']);
  if (aAMonthLv1Commission != null) {
    collectionNotificationOtherProfile.aAMonthLv1Commission =
        aAMonthLv1Commission;
  }
  final int? aBMonthLv2Commission = jsonConvert.convert<int>(
      json['a_b_month_lv2_commission']);
  if (aBMonthLv2Commission != null) {
    collectionNotificationOtherProfile.aBMonthLv2Commission =
        aBMonthLv2Commission;
  }
  final int? aCMonthLv3Commission = jsonConvert.convert<int>(
      json['a_c_month_lv3_commission']);
  if (aCMonthLv3Commission != null) {
    collectionNotificationOtherProfile.aCMonthLv3Commission =
        aCMonthLv3Commission;
  }
  final int? aDMonthLv4Commission = jsonConvert.convert<int>(
      json['a_d_month_lv4_commission']);
  if (aDMonthLv4Commission != null) {
    collectionNotificationOtherProfile.aDMonthLv4Commission =
        aDMonthLv4Commission;
  }
  final double? aETodayCommissionRate = jsonConvert.convert<double>(
      json['a_e_today_commission_rate']);
  if (aETodayCommissionRate != null) {
    collectionNotificationOtherProfile.aETodayCommissionRate =
        aETodayCommissionRate;
  }
  final String? aFLastCallAt = jsonConvert.convert<String>(
      json['a_f_last_call_at']);
  if (aFLastCallAt != null) {
    collectionNotificationOtherProfile.aFLastCallAt = aFLastCallAt;
  }
  final int? aGCollectionCommissionNewCount = jsonConvert.convert<int>(
      json['a_g_collection_commission_new_count']);
  if (aGCollectionCommissionNewCount != null) {
    collectionNotificationOtherProfile.aGCollectionCommissionNewCount =
        aGCollectionCommissionNewCount;
  }
  final int? aHCollectionNotificationCount = jsonConvert.convert<int>(
      json['a_h_collection_notification_count']);
  if (aHCollectionNotificationCount != null) {
    collectionNotificationOtherProfile.aHCollectionNotificationCount =
        aHCollectionNotificationCount;
  }
  final dynamic aIWeekRepayCount = json['a_i_week_repay_count'];
  if (aIWeekRepayCount != null) {
    collectionNotificationOtherProfile.aIWeekRepayCount = aIWeekRepayCount;
  }
  final dynamic aJWeekRank = json['a_j_week_rank'];
  if (aJWeekRank != null) {
    collectionNotificationOtherProfile.aJWeekRank = aJWeekRank;
  }
  final String? updatedAt = jsonConvert.convert<String>(json['updated_at']);
  if (updatedAt != null) {
    collectionNotificationOtherProfile.updatedAt = updatedAt;
  }
  return collectionNotificationOtherProfile;
}

Map<String, dynamic> $CollectionNotificationOtherProfileToJson(
    CollectionNotificationOtherProfile entity) {
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

extension CollectionNotificationOtherProfileExtension on CollectionNotificationOtherProfile {
  CollectionNotificationOtherProfile copyWith({
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
    int? aAMonthLv1Commission,
    int? aBMonthLv2Commission,
    int? aCMonthLv3Commission,
    int? aDMonthLv4Commission,
    double? aETodayCommissionRate,
    String? aFLastCallAt,
    int? aGCollectionCommissionNewCount,
    int? aHCollectionNotificationCount,
    dynamic aIWeekRepayCount,
    dynamic aJWeekRank,
    String? updatedAt,
  }) {
    return CollectionNotificationOtherProfile()
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
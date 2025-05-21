import 'package:bounty_hunter/generated/json/base/json_convert_content.dart';
import 'package:bounty_hunter/models/b_f_review_borrow_entity.dart';
import 'package:bounty_hunter/models/collection_order_entity.dart';


BFReviewBorrowEntity $BFReviewBorrowEntityFromJson(Map<String, dynamic> json) {
  final BFReviewBorrowEntity bFReviewBorrowEntity = BFReviewBorrowEntity();
  final bool? success = jsonConvert.convert<bool>(json['success']);
  if (success != null) {
    bFReviewBorrowEntity.success = success;
  }
  final String? errorMessage = jsonConvert.convert<String>(
      json['errorMessage']);
  if (errorMessage != null) {
    bFReviewBorrowEntity.errorMessage = errorMessage;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    bFReviewBorrowEntity.message = message;
  }
  final List<BFReviewBorrowData>? data = (json['data'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<BFReviewBorrowData>(e) as BFReviewBorrowData)
      .toList();
  if (data != null) {
    bFReviewBorrowEntity.data = data;
  }
  final CollectionOrderOther? other = jsonConvert.convert<CollectionOrderOther>(
      json['other']);
  if (other != null) {
    bFReviewBorrowEntity.other = other;
  }
  final int? total = jsonConvert.convert<int>(json['total']);
  if (total != null) {
    bFReviewBorrowEntity.total = total;
  }
  final int? currentPage = jsonConvert.convert<int>(json['currentPage']);
  if (currentPage != null) {
    bFReviewBorrowEntity.currentPage = currentPage;
  }
  final int? perPage = jsonConvert.convert<int>(json['perPage']);
  if (perPage != null) {
    bFReviewBorrowEntity.perPage = perPage;
  }
  final bool? hasMorePages = jsonConvert.convert<bool>(json['hasMorePages']);
  if (hasMorePages != null) {
    bFReviewBorrowEntity.hasMorePages = hasMorePages;
  }
  return bFReviewBorrowEntity;
}

Map<String, dynamic> $BFReviewBorrowEntityToJson(BFReviewBorrowEntity entity) {
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

extension BFReviewBorrowEntityExtension on BFReviewBorrowEntity {
  BFReviewBorrowEntity copyWith({
    bool? success,
    String? errorMessage,
    String? message,
    List<BFReviewBorrowData>? data,
    CollectionOrderOther? other,
    int? total,
    int? currentPage,
    int? perPage,
    bool? hasMorePages,
  }) {
    return BFReviewBorrowEntity()
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

BFReviewBorrowData $BFReviewBorrowDataFromJson(Map<String, dynamic> json) {
  final BFReviewBorrowData bFReviewBorrowData = BFReviewBorrowData();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    bFReviewBorrowData.id = id;
  }
  final int? aBorrowId = jsonConvert.convert<int>(json['a_borrow_id']);
  if (aBorrowId != null) {
    bFReviewBorrowData.aBorrowId = aBorrowId;
  }
  final int? bAdminId = jsonConvert.convert<int>(json['b_admin_id']);
  if (bAdminId != null) {
    bFReviewBorrowData.bAdminId = bAdminId;
  }
  final int? cResult = jsonConvert.convert<int>(json['c_result']);
  if (cResult != null) {
    bFReviewBorrowData.cResult = cResult;
  }
  final int? dIdNumberResult = jsonConvert.convert<int>(
      json['d_id_number_result']);
  if (dIdNumberResult != null) {
    bFReviewBorrowData.dIdNumberResult = dIdNumberResult;
  }
  final int? eContactPersionResult = jsonConvert.convert<int>(
      json['e_contact_persion_result']);
  if (eContactPersionResult != null) {
    bFReviewBorrowData.eContactPersionResult = eContactPersionResult;
  }
  final int? fJobResult = jsonConvert.convert<int>(json['f_job_result']);
  if (fJobResult != null) {
    bFReviewBorrowData.fJobResult = fJobResult;
  }
  final int? gContactResult = jsonConvert.convert<int>(
      json['g_contact_result']);
  if (gContactResult != null) {
    bFReviewBorrowData.gContactResult = gContactResult;
  }
  final int? hSmsResult = jsonConvert.convert<int>(json['h_sms_result']);
  if (hSmsResult != null) {
    bFReviewBorrowData.hSmsResult = hSmsResult;
  }
  final int? iRiskResult = jsonConvert.convert<int>(json['i_risk_result']);
  if (iRiskResult != null) {
    bFReviewBorrowData.iRiskResult = iRiskResult;
  }
  final int? jAppResult = jsonConvert.convert<int>(json['j_app_result']);
  if (jAppResult != null) {
    bFReviewBorrowData.jAppResult = jAppResult;
  }
  final int? kHistoryResult = jsonConvert.convert<int>(
      json['k_history_result']);
  if (kHistoryResult != null) {
    bFReviewBorrowData.kHistoryResult = kHistoryResult;
  }
  final int? lFlowCount = jsonConvert.convert<int>(json['l_flow_count']);
  if (lFlowCount != null) {
    bFReviewBorrowData.lFlowCount = lFlowCount;
  }
  final int? mReviewGroupId = jsonConvert.convert<int>(
      json['m_review_group_id']);
  if (mReviewGroupId != null) {
    bFReviewBorrowData.mReviewGroupId = mReviewGroupId;
  }
  final int? nBorrowTimesType = jsonConvert.convert<int>(
      json['n_borrow_times_type']);
  if (nBorrowTimesType != null) {
    bFReviewBorrowData.nBorrowTimesType = nBorrowTimesType;
  }
  final int? oDeviceResult = jsonConvert.convert<int>(json['o_device_result']);
  if (oDeviceResult != null) {
    bFReviewBorrowData.oDeviceResult = oDeviceResult;
  }
  final int? pBankResult = jsonConvert.convert<int>(json['p_bank_result']);
  if (pBankResult != null) {
    bFReviewBorrowData.pBankResult = pBankResult;
  }
  final String? qComment = jsonConvert.convert<String>(json['q_comment']);
  if (qComment != null) {
    bFReviewBorrowData.qComment = qComment;
  }
  final int? rLivenessResult = jsonConvert.convert<int>(
      json['r_liveness_result']);
  if (rLivenessResult != null) {
    bFReviewBorrowData.rLivenessResult = rLivenessResult;
  }
  final int? sOcrResult = jsonConvert.convert<int>(json['s_ocr_result']);
  if (sOcrResult != null) {
    bFReviewBorrowData.sOcrResult = sOcrResult;
  }
  final int? tMarkPhoneCount = jsonConvert.convert<int>(
      json['t_mark_phone_count']);
  if (tMarkPhoneCount != null) {
    bFReviewBorrowData.tMarkPhoneCount = tMarkPhoneCount;
  }
  final int? uMarkRealPhoneCount = jsonConvert.convert<int>(
      json['u_mark_real_phone_count']);
  if (uMarkRealPhoneCount != null) {
    bFReviewBorrowData.uMarkRealPhoneCount = uMarkRealPhoneCount;
  }
  final int? vMarkFakePhoneCount = jsonConvert.convert<int>(
      json['v_mark_fake_phone_count']);
  if (vMarkFakePhoneCount != null) {
    bFReviewBorrowData.vMarkFakePhoneCount = vMarkFakePhoneCount;
  }
  final int? wIsBorrower = jsonConvert.convert<int>(json['w_is_borrower']);
  if (wIsBorrower != null) {
    bFReviewBorrowData.wIsBorrower = wIsBorrower;
  }
  final String? xSn = jsonConvert.convert<String>(json['x_sn']);
  if (xSn != null) {
    bFReviewBorrowData.xSn = xSn;
  }
  final String? yPhone = jsonConvert.convert<String>(json['y_phone']);
  if (yPhone != null) {
    bFReviewBorrowData.yPhone = yPhone;
  }
  final int? zBorrowCount = jsonConvert.convert<int>(json['z_borrow_count']);
  if (zBorrowCount != null) {
    bFReviewBorrowData.zBorrowCount = zBorrowCount;
  }
  final String? aAName = jsonConvert.convert<String>(json['a_a_name']);
  if (aAName != null) {
    bFReviewBorrowData.aAName = aAName;
  }
  final int? aBNotKnowCount = jsonConvert.convert<int>(
      json['a_b_not_know_count']);
  if (aBNotKnowCount != null) {
    bFReviewBorrowData.aBNotKnowCount = aBNotKnowCount;
  }
  final String? createdAt = jsonConvert.convert<String>(json['created_at']);
  if (createdAt != null) {
    bFReviewBorrowData.createdAt = createdAt;
  }
  final String? aCAvatar = jsonConvert.convert<String>(json['a_c_avatar']);
  if (aCAvatar != null) {
    bFReviewBorrowData.aCAvatar = aCAvatar;
  }
  return bFReviewBorrowData;
}

Map<String, dynamic> $BFReviewBorrowDataToJson(BFReviewBorrowData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['a_borrow_id'] = entity.aBorrowId;
  data['b_admin_id'] = entity.bAdminId;
  data['c_result'] = entity.cResult;
  data['d_id_number_result'] = entity.dIdNumberResult;
  data['e_contact_persion_result'] = entity.eContactPersionResult;
  data['f_job_result'] = entity.fJobResult;
  data['g_contact_result'] = entity.gContactResult;
  data['h_sms_result'] = entity.hSmsResult;
  data['i_risk_result'] = entity.iRiskResult;
  data['j_app_result'] = entity.jAppResult;
  data['k_history_result'] = entity.kHistoryResult;
  data['l_flow_count'] = entity.lFlowCount;
  data['m_review_group_id'] = entity.mReviewGroupId;
  data['n_borrow_times_type'] = entity.nBorrowTimesType;
  data['o_device_result'] = entity.oDeviceResult;
  data['p_bank_result'] = entity.pBankResult;
  data['q_comment'] = entity.qComment;
  data['r_liveness_result'] = entity.rLivenessResult;
  data['s_ocr_result'] = entity.sOcrResult;
  data['t_mark_phone_count'] = entity.tMarkPhoneCount;
  data['u_mark_real_phone_count'] = entity.uMarkRealPhoneCount;
  data['v_mark_fake_phone_count'] = entity.vMarkFakePhoneCount;
  data['w_is_borrower'] = entity.wIsBorrower;
  data['x_sn'] = entity.xSn;
  data['y_phone'] = entity.yPhone;
  data['z_borrow_count'] = entity.zBorrowCount;
  data['a_a_name'] = entity.aAName;
  data['a_b_not_know_count'] = entity.aBNotKnowCount;
  data['created_at'] = entity.createdAt;
  data['a_c_avatar'] = entity.aCAvatar;
  return data;
}

extension BFReviewBorrowDataExtension on BFReviewBorrowData {
  BFReviewBorrowData copyWith({
    int? id,
    int? aBorrowId,
    int? bAdminId,
    int? cResult,
    int? dIdNumberResult,
    int? eContactPersionResult,
    int? fJobResult,
    int? gContactResult,
    int? hSmsResult,
    int? iRiskResult,
    int? jAppResult,
    int? kHistoryResult,
    int? lFlowCount,
    int? mReviewGroupId,
    int? nBorrowTimesType,
    int? oDeviceResult,
    int? pBankResult,
    String? qComment,
    int? rLivenessResult,
    int? sOcrResult,
    int? tMarkPhoneCount,
    int? uMarkRealPhoneCount,
    int? vMarkFakePhoneCount,
    int? wIsBorrower,
    String? xSn,
    String? yPhone,
    int? zBorrowCount,
    String? aAName,
    int? aBNotKnowCount,
    String? createdAt,
    String? aCAvatar,
  }) {
    return BFReviewBorrowData()
      ..id = id ?? this.id
      ..aBorrowId = aBorrowId ?? this.aBorrowId
      ..bAdminId = bAdminId ?? this.bAdminId
      ..cResult = cResult ?? this.cResult
      ..dIdNumberResult = dIdNumberResult ?? this.dIdNumberResult
      ..eContactPersionResult = eContactPersionResult ??
          this.eContactPersionResult
      ..fJobResult = fJobResult ?? this.fJobResult
      ..gContactResult = gContactResult ?? this.gContactResult
      ..hSmsResult = hSmsResult ?? this.hSmsResult
      ..iRiskResult = iRiskResult ?? this.iRiskResult
      ..jAppResult = jAppResult ?? this.jAppResult
      ..kHistoryResult = kHistoryResult ?? this.kHistoryResult
      ..lFlowCount = lFlowCount ?? this.lFlowCount
      ..mReviewGroupId = mReviewGroupId ?? this.mReviewGroupId
      ..nBorrowTimesType = nBorrowTimesType ?? this.nBorrowTimesType
      ..oDeviceResult = oDeviceResult ?? this.oDeviceResult
      ..pBankResult = pBankResult ?? this.pBankResult
      ..qComment = qComment ?? this.qComment
      ..rLivenessResult = rLivenessResult ?? this.rLivenessResult
      ..sOcrResult = sOcrResult ?? this.sOcrResult
      ..tMarkPhoneCount = tMarkPhoneCount ?? this.tMarkPhoneCount
      ..uMarkRealPhoneCount = uMarkRealPhoneCount ?? this.uMarkRealPhoneCount
      ..vMarkFakePhoneCount = vMarkFakePhoneCount ?? this.vMarkFakePhoneCount
      ..wIsBorrower = wIsBorrower ?? this.wIsBorrower
      ..xSn = xSn ?? this.xSn
      ..yPhone = yPhone ?? this.yPhone
      ..zBorrowCount = zBorrowCount ?? this.zBorrowCount
      ..aAName = aAName ?? this.aAName
      ..aBNotKnowCount = aBNotKnowCount ?? this.aBNotKnowCount
      ..createdAt = createdAt ?? this.createdAt
      ..aCAvatar = aCAvatar ?? this.aCAvatar;
  }
}
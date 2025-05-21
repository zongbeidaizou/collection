import 'package:bounty_hunter/generated/json/base/json_field.dart';
import 'package:bounty_hunter/generated/json/b_f_review_borrow_entity.g.dart';
import 'dart:convert';
export 'package:bounty_hunter/generated/json/b_f_review_borrow_entity.g.dart';
import 'package:bounty_hunter/models/collection_order_entity.dart';

@JsonSerializable()
class BFReviewBorrowEntity {
	bool? success = false;
	String? errorMessage = '';
	String? message = '';
	List<BFReviewBorrowData>? data = [];
	CollectionOrderOther? other;
	int? total = 0;
	int? currentPage = 0;
	int? perPage = 0;
	bool? hasMorePages = false;

	BFReviewBorrowEntity();

	factory BFReviewBorrowEntity.fromJson(Map<String, dynamic> json) => $BFReviewBorrowEntityFromJson(json);

	Map<String, dynamic> toJson() => $BFReviewBorrowEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class BFReviewBorrowData {
	int? id = 0;
	@JSONField(name: 'a_borrow_id')
	int? aBorrowId = 0;
	@JSONField(name: 'b_admin_id')
	int? bAdminId = 0;
	@JSONField(name: 'c_result')
	int? cResult = 0;
	@JSONField(name: 'd_id_number_result')
	int? dIdNumberResult = 0;
	@JSONField(name: 'e_contact_persion_result')
	int? eContactPersionResult = 0;
	@JSONField(name: 'f_job_result')
	int? fJobResult = 0;
	@JSONField(name: 'g_contact_result')
	int? gContactResult = 0;
	@JSONField(name: 'h_sms_result')
	int? hSmsResult = 0;
	@JSONField(name: 'i_risk_result')
	int? iRiskResult = 0;
	@JSONField(name: 'j_app_result')
	int? jAppResult = 0;
	@JSONField(name: 'k_history_result')
	int? kHistoryResult = 0;
	@JSONField(name: 'l_flow_count')
	int? lFlowCount = 0;
	@JSONField(name: 'm_review_group_id')
	int? mReviewGroupId = 0;
	@JSONField(name: 'n_borrow_times_type')
	int? nBorrowTimesType = 0;
	@JSONField(name: 'o_device_result')
	int? oDeviceResult = 0;
	@JSONField(name: 'p_bank_result')
	int? pBankResult = 0;
	@JSONField(name: 'q_comment')
	String? qComment = '';
	@JSONField(name: 'r_liveness_result')
	int? rLivenessResult = 0;
	@JSONField(name: 's_ocr_result')
	int? sOcrResult = 0;
	@JSONField(name: 't_mark_phone_count')
	int? tMarkPhoneCount = 0;
	@JSONField(name: 'u_mark_real_phone_count')
	int? uMarkRealPhoneCount = 0;
	@JSONField(name: 'v_mark_fake_phone_count')
	int? vMarkFakePhoneCount = 0;
	@JSONField(name: 'w_is_borrower')
	int? wIsBorrower = 0;
	@JSONField(name: 'x_sn')
	String? xSn = '';
	@JSONField(name: 'y_phone')
	String? yPhone = '';
	@JSONField(name: 'z_borrow_count')
	int? zBorrowCount = 0;
	@JSONField(name: 'a_a_name')
	String? aAName = '';
	@JSONField(name: 'a_b_not_know_count')
	int? aBNotKnowCount = 0;
	@JSONField(name: 'created_at')
	String? createdAt = '';
	@JSONField(name: 'a_c_avatar')
	String? aCAvatar = '';

	BFReviewBorrowData();

	factory BFReviewBorrowData.fromJson(Map<String, dynamic> json) => $BFReviewBorrowDataFromJson(json);

	Map<String, dynamic> toJson() => $BFReviewBorrowDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}
import 'package:bounty_hunter/generated/json/base/json_field.dart';
import 'package:bounty_hunter/generated/json/collection_log_entity.g.dart';
import 'dart:convert';
export 'package:bounty_hunter/generated/json/collection_log_entity.g.dart';

@JsonSerializable()
class CollectionLogEntity {
	bool? success = false;
	String? errorMessage = '';
	String? message = '';
	List<CollectionLogData>? data = [];
	CollectionLogOther? other;
	int? total = 0;
	int? currentPage = 0;
	int? perPage = 0;
	bool? hasMorePages = false;

	CollectionLogEntity();

	factory CollectionLogEntity.fromJson(Map<String, dynamic> json) => $CollectionLogEntityFromJson(json);

	Map<String, dynamic> toJson() => $CollectionLogEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class CollectionLogData {
	int? id = 0;
	@JSONField(name: "n_borrow_id")
	int? nBorrowId = 0;
	@JSONField(name: "o_period_id")
	int? oPeriodId = 0;
	@JSONField(name: "a_parent_id")
	int? aParentId = 0;
	@JSONField(name: "p_collection_order_id")
	int? pCollectionOrderId = 0;
	@JSONField(name: "b_collection_stage_id")
	int? bCollectionStageId = 0;
	@JSONField(name: "c_collection_agency_id")
	int? cCollectionAgencyId = 0;
	@JSONField(name: "d_collection_group_id")
	int? dCollectionGroupId = 0;
	@JSONField(name: "e_collection_admin_id")
	int? eCollectionAdminId = 0;
	@JSONField(name: "f_cat")
	int? fCat = 0;
	@JSONField(name: "g_type")
	int? gType = 0;
	@JSONField(name: "h_phone")
	String? hPhone = '';
	@JSONField(name: "i_target")
	int? iTarget = 0;
	@JSONField(name: "j_content")
	String? jContent = '';
	@JSONField(name: "k_promise_time")
	String? kPromiseTime = '';
	@JSONField(name: "l_stage_day_index")
	int? lStageDayIndex = 0;
	@JSONField(name: "m_overdue_days")
	int? mOverdueDays = 0;
	@JSONField(name: "created_at")
	String? createdAt = '';

	CollectionLogData();

	factory CollectionLogData.fromJson(Map<String, dynamic> json) => $CollectionLogDataFromJson(json);

	Map<String, dynamic> toJson() => $CollectionLogDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class CollectionLogOther {
	@JSONField(name: "repay_info")
	CollectionLogOtherRepayInfo? repayInfo;
	@JSONField(name: "contact_info")
	List<CollectionLogOtherContactInfo>? contactInfo = [];
	@JSONField(name: "sms_history")
	List<CollectionLogOtherSmsHistory>? smsHistory = [];

	CollectionLogOther();

	factory CollectionLogOther.fromJson(Map<String, dynamic> json) => $CollectionLogOtherFromJson(json);

	Map<String, dynamic> toJson() => $CollectionLogOtherToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class CollectionLogOtherRepayInfo {
	String? phone = '';
	String? name = '';
	@JSONField(name: "loan_amount")
	int? loanAmount = 0;
	@JSONField(name: "repay_amount")
	int? repayAmount = 0;
	@JSONField(name: "expect_repay_time")
	String? expectRepayTime = '';
	@JSONField(name: "borrow_days")
	int? borrowDays = 0;
	@JSONField(name: "up_amount")
	int? upAmount = 0;
	@JSONField(name: "bankcard_bank")
	String? bankcardBank = '';
	@JSONField(name: "overdue_days")
	int? overdueDays = 0;
	@JSONField(name: "product_name")
	String? productName = '';
	@JSONField(name: "recieve_bank")
	String? recieveBank = '';
	@JSONField(name: "recieve_bank_no")
	String? recieveBankNo = '';
	@JSONField(name: "account_number")
	String? accountNumber = '';
	String? bank = '';
	@JSONField(name: "account_name")
	String? accountName = '';
	String? email = '';
	String? whatsapp = '';

	CollectionLogOtherRepayInfo();

	factory CollectionLogOtherRepayInfo.fromJson(Map<String, dynamic> json) => $CollectionLogOtherRepayInfoFromJson(json);

	Map<String, dynamic> toJson() => $CollectionLogOtherRepayInfoToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class CollectionLogOtherContactInfo {
	String? name = '';
	String? relationship = '';
	String? phoneNumber = '';
	List<CollectionLogOtherContactInfoCallRecords>? callRecords = [];

	CollectionLogOtherContactInfo();

	factory CollectionLogOtherContactInfo.fromJson(Map<String, dynamic> json) => $CollectionLogOtherContactInfoFromJson(json);

	Map<String, dynamic> toJson() => $CollectionLogOtherContactInfoToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class CollectionLogOtherContactInfoCallRecords {
	String? time = '';
	int? duration = 0;
	@JSONField(name: "admin_id")
	int? adminId = 0;

	CollectionLogOtherContactInfoCallRecords();

	factory CollectionLogOtherContactInfoCallRecords.fromJson(Map<String, dynamic> json) => $CollectionLogOtherContactInfoCallRecordsFromJson(json);

	Map<String, dynamic> toJson() => $CollectionLogOtherContactInfoCallRecordsToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class CollectionLogOtherSmsHistory {
	@JSONField(name: "c_admin_id")
	int? cAdminId = 0;
	@JSONField(name: "f_to")
	String? fTo = '';
	@JSONField(name: "g_text")
	String? gText = '';
	@JSONField(name: "k_send_status")
	int? kSendStatus = 0;
	@JSONField(name: "created_at")
	String? createdAt = '';

	CollectionLogOtherSmsHistory();

	factory CollectionLogOtherSmsHistory.fromJson(Map<String, dynamic> json) => $CollectionLogOtherSmsHistoryFromJson(json);

	Map<String, dynamic> toJson() => $CollectionLogOtherSmsHistoryToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}
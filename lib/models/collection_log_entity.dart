import 'package:bounty_hunter/generated/json/base/json_field.dart';
import 'package:bounty_hunter/generated/json/collection_log_entity.g.dart';
import 'dart:convert';

import 'package:bounty_hunter/models/s_g_contact_entity.dart';
export 'package:bounty_hunter/generated/json/collection_log_entity.g.dart';
import 'package:bounty_hunter/models/collection_order_entity.dart';

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
	@JSONField(name: "n_sms_template_id")
	int? nSmsTemplateId = 0;
	@JSONField(name: "o_contact_id")
	int? oContactId = 0;
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
	String? avatar = '';
	CollectionLogOtherTrack? track;
	CollectionLogOtherPeriod? period;
	@JSONField(name: "repay_info")
	CollectionLogOtherRepayInfo? repayInfo;
	@JSONField(name: "contact_info")
	List<CollectionLogOtherContactInfo>? contactInfo = [];
	@JSONField(name: "contact_info2")
	SGContactEntity? contactInfo2 ;
	@JSONField(name: "sms_history")
	List<CollectionLogOtherSmsHistory>? smsHistory = [];
	@JSONField(name: "h_j_sms_template_newest_updated_at")
	String? hJSmsTemplateNewestUpdatedAt = '';
	@JSONField(name: "h_j_sms_template")
	List<CollectionLogOtherHJSmsTemplate>? hJSmsTemplate = [];
  CollectionOrderOther? other;

	CollectionLogOther();

	factory CollectionLogOther.fromJson(Map<String, dynamic> json) => $CollectionLogOtherFromJson(json);

	Map<String, dynamic> toJson() => $CollectionLogOtherToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class CollectionLogOtherTrack {
	@JSONField(name: "apply_time")
	String? applyTime = '';
	@JSONField(name: "borrow_amount")
	int? borrowAmount = 0;
	@JSONField(name: "loan_time")
	String? loanTime = '';
	@JSONField(name: "loan_bank")
	String? loanBank = '';
	@JSONField(name: "loan_amount")
	int? loanAmount = 0;
	@JSONField(name: "loan_active_time")
	String? loanActiveTime = '';

	CollectionLogOtherTrack();

	factory CollectionLogOtherTrack.fromJson(Map<String, dynamic> json) => $CollectionLogOtherTrackFromJson(json);

	Map<String, dynamic> toJson() => $CollectionLogOtherTrackToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class CollectionLogOtherPeriod {
	int? id = 0;
	@JSONField(name: "a_borrow_id")
	int? aBorrowId = 0;
	@JSONField(name: "f_expect_repay_total_amount")
	int? fExpectRepayTotalAmount = 0;
	@JSONField(name: "p_paid_interest")
	int? pPaidInterest = 0;
	@JSONField(name: "q_paid_service_fee")
	int? qPaidServiceFee = 0;
	@JSONField(name: "s_paid_overdue_amount")
	int? sPaidOverdueAmount = 0;
	@JSONField(name: "o_paid_borrow_amount")
	int? oPaidBorrowAmount = 0;
	@JSONField(name: "g_expect_borrow_amount")
	int? gExpectBorrowAmount = 0;
	@JSONField(name: "h_expect_interest")
	int? hExpectInterest = 0;
	@JSONField(name: "n_paid_amount")
	int? nPaidAmount = 0;
	@JSONField(name: "i_expect_service_fee")
	int? iExpectServiceFee = 0;
	@JSONField(name: "j_expect_violate_fee")
	int? jExpectViolateFee = 0;
	@JSONField(name: "k_expect_overdue_amount")
	int? kExpectOverdueAmount = 0;
	@JSONField(name: "l_overdue_days")
	int? lOverdueDays = 0;
	@JSONField(name: "t_deduction_times")
	int? tDeductionTimes = 0;
	@JSONField(name: "u_deduction_total_amount")
	int? uDeductionTotalAmount = 0;
	@JSONField(name: "a_h_part_times")
	int? aHPartTimes = 0;
	@JSONField(name: "a_u_current_deduction_fee")
	int? aUCurrentDeductionFee = 0;
	@JSONField(name: "a_z_left_amount")
	int? aZLeftAmount = 0;
	@JSONField(name: "a_p_expect_repay_time")
	String? aPExpectRepayTime = '';

	CollectionLogOtherPeriod();

	factory CollectionLogOtherPeriod.fromJson(Map<String, dynamic> json) => $CollectionLogOtherPeriodFromJson(json);

	Map<String, dynamic> toJson() => $CollectionLogOtherPeriodToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class CollectionLogOtherRepayInfo {
	@JSONField(name: "expect_repay_amount")
	String? expectRepayAmount = '';
	@JSONField(name: "expect_repay_time")
	String? expectRepayTime = '';
	@JSONField(name: "overdue_days")
	String? overdueDays = '';
	String? mobile = '';
	String? phone = '';
	String? bvn = '';
	String? name = '';
	@JSONField(name: "borrow_amount")
	String? borrowAmount = '';
	@JSONField(name: "loan_amount")
	String? loanAmount = '';
	@JSONField(name: "borrow_days")
	String? borrowDays = '';
	@JSONField(name: "app_name")
	String? appName = '';
	@JSONField(name: "product_name")
	String? productName = '';
	@JSONField(name: "loan_time")
	String? loanTime = '';
	@JSONField(name: "receive_bank")
	String? receiveBank = '';
	@JSONField(name: "receive_bank_no")
	String? receiveBankNo = '';
	@JSONField(name: "account_name")
	String? accountName = '';
	@JSONField(name: "account_no")
	String? accountNo = '';
	@JSONField(name: "account_bank")
	String? accountBank = '';
	@JSONField(name: "before_credit_amount")
	String? beforeCreditAmount = '';
	@JSONField(name: "after_credit_amount")
	String? afterCreditAmount = '';
	@JSONField(name: "change_credit_amount")
	String? changeCreditAmount = '';
	@JSONField(name: "before_credit_fraction")
	String? beforeCreditFraction = '';
	@JSONField(name: "after_credit_fraction")
	String? afterCreditFraction = '';
	@JSONField(name: "change_credit_fraction")
	String? changeCreditFraction = '';

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
	int? id = 0;
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
	int? id = 0;

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
	int? id = 0;

	CollectionLogOtherSmsHistory();

	factory CollectionLogOtherSmsHistory.fromJson(Map<String, dynamic> json) => $CollectionLogOtherSmsHistoryFromJson(json);

	Map<String, dynamic> toJson() => $CollectionLogOtherSmsHistoryToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class CollectionLogOtherHJSmsTemplate {
	int? id = 0;
	@JSONField(name: "d_template")
	String? dTemplate = '';
	@JSONField(name: "c_type")
	int? cType = 0;
	@JSONField(name: "s_name")
	String? sName = '';
	@JSONField(name: "e_days")
	String? eDays = '';

	CollectionLogOtherHJSmsTemplate();

	factory CollectionLogOtherHJSmsTemplate.fromJson(Map<String, dynamic> json) => $CollectionLogOtherHJSmsTemplateFromJson(json);

	Map<String, dynamic> toJson() => $CollectionLogOtherHJSmsTemplateToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}
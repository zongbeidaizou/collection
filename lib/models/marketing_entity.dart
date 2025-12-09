import 'package:bounty_hunter/generated/json/base/json_field.dart';
import 'package:bounty_hunter/generated/json/marketing_entity.g.dart';
import 'dart:convert';
export 'package:bounty_hunter/generated/json/marketing_entity.g.dart';

@JsonSerializable()
class MarketingEntity {
	bool? success = false;
	String? errorMessage = '';
	String? message = '';
	List<MarketingData>? data = [];
	MarketingOther? other;
	int? total = 0;
	int? currentPage = 0;
	int? perPage = 0;
	bool? hasMorePages = false;

	MarketingEntity();

	factory MarketingEntity.fromJson(Map<String, dynamic> json) => $MarketingEntityFromJson(json);

	Map<String, dynamic> toJson() => $MarketingEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class MarketingData {
	int? id = 0;
	@JSONField(name: 'a_phone')
	String? aPhone = '';
	@JSONField(name: 'd_admin_id')
	int? dAdminId = 0;
	@JSONField(name: 'e_status')
	int? eStatus = 0;
	@JSONField(name: 'q_end_at')
	String? qEndAt = '';
	@JSONField(name: 'u_status')
	int? uStatus = 0;
	@JSONField(name: 'a_a_a_a_a_s_l_telemarketing_detail_logs')
	List<MarketingDataAAAAASLTelemarketingDetailLogs>? aAAAASLTelemarketingDetailLogs = [];

	MarketingData();

	factory MarketingData.fromJson(Map<String, dynamic> json) => $MarketingDataFromJson(json);

	Map<String, dynamic> toJson() => $MarketingDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class MarketingDataAAAAASLTelemarketingDetailLogs {
	int? id = 0;
	@JSONField(name: 'a_telemarketing_detail_id')
	int? aTelemarketingDetailId = 0;
	@JSONField(name: 'd_admin_id')
	int? dAdminId = 0;
	@JSONField(name: 'e_status')
	int? eStatus = 0;
	@JSONField(name: 'g_viewed_time')
	String? gViewedTime = '';
	@JSONField(name: 'h_download_time')
	String? hDownloadTime = '';
	@JSONField(name: 'i_register_time')
	String? iRegisterTime = '';
	@JSONField(name: 'j_sms_cnt')
	int? jSmsCnt = 0;
	@JSONField(name: 'k_wa_cnt')
	int? kWaCnt = 0;
	@JSONField(name: 'l_phone_cnt')
	int? lPhoneCnt = 0;
	@JSONField(name: 'q_end_at')
	String? qEndAt = '';
	@JSONField(name: 'r_last_phone_at')
	String? rLastPhoneAt = '';
	@JSONField(name: 's_last_sms_at')
	String? sLastSmsAt = '';
	@JSONField(name: 't_last_wa_at')
	String? tLastWaAt = '';
	@JSONField(name: 'u_status')
	int? uStatus = 0;
	@JSONField(name: 'v_wa_status')
	int? vWaStatus = 0;
	@JSONField(name: 'w_phone_status')
	int? wPhoneStatus = 0;
	@JSONField(name: 'x_apply_at')
	String? xApplyAt = '';
	@JSONField(name: 'created_at')
	String? createdAt = '';

	MarketingDataAAAAASLTelemarketingDetailLogs();

	factory MarketingDataAAAAASLTelemarketingDetailLogs.fromJson(Map<String, dynamic> json) => $MarketingDataAAAAASLTelemarketingDetailLogsFromJson(json);

	Map<String, dynamic> toJson() => $MarketingDataAAAAASLTelemarketingDetailLogsToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class MarketingOther {
	String? url = '';
	String? app = '';
	List<MarketingOtherTemplates2>? templates2 = [];

	MarketingOther();

	factory MarketingOther.fromJson(Map<String, dynamic> json) => $MarketingOtherFromJson(json);

	Map<String, dynamic> toJson() => $MarketingOtherToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class MarketingOtherTemplates2 {
	int? id = 0;
	int? category = 0;
	@JSONField(name: 'available_days')
	int? availableDays = 0;
	String? message = '';
	String? title = '';

	MarketingOtherTemplates2();

	factory MarketingOtherTemplates2.fromJson(Map<String, dynamic> json) => $MarketingOtherTemplates2FromJson(json);

	Map<String, dynamic> toJson() => $MarketingOtherTemplates2ToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}
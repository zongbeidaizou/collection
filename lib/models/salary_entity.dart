import 'package:bounty_hunter/generated/json/base/json_field.dart';
import 'package:bounty_hunter/generated/json/salary_entity.g.dart';
import 'dart:convert';
export 'package:bounty_hunter/generated/json/salary_entity.g.dart';

@JsonSerializable()
class SalaryEntity {
	bool? success = false;
	SalaryData? data;
	List<dynamic>? other = [];
	String? message = '';

	SalaryEntity();

	factory SalaryEntity.fromJson(Map<String, dynamic> json) => $SalaryEntityFromJson(json);

	Map<String, dynamic> toJson() => $SalaryEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class SalaryData {
	@JSONField(name: 'show_month_basic_salary')
	bool? showMonthBasicSalary = false;
	@JSONField(name: 'month_basic_salary_value')
	int? monthBasicSalaryValue = 0;
	@JSONField(name: 'month_basic_salary_comment')
	String? monthBasicSalaryComment = '';
	@JSONField(name: 'show_week_salary')
	bool? showWeekSalary = false;
	@JSONField(name: 'week_salary_comment')
	String? weekSalaryComment = '';
	@JSONField(name: 'week_salary_total')
	int? weekSalaryTotal = 0;
	@JSONField(name: 'week_salary_data')
	List<SalaryDataWeekSalaryData>? weekSalaryData = [];
	@JSONField(name: 'show_month_salary')
	bool? showMonthSalary = false;
	@JSONField(name: 'month_salary_comment')
	String? monthSalaryComment = '';
	@JSONField(name: 'month_salary_total')
	int? monthSalaryTotal = 0;
	@JSONField(name: 'month_salary_data')
	List<SalaryDataMonthSalaryData>? monthSalaryData = [];
	@JSONField(name: 'show_week_bonus_rank_rule')
	bool? showWeekBonusRankRule = false;
	@JSONField(name: 'week_bonus_rank_rule_title')
	String? weekBonusRankRuleTitle = '';
	@JSONField(name: 'week_bonus_rank_rule_comment')
	String? weekBonusRankRuleComment = '';
	@JSONField(name: 'week_bonus_rank_rule_data')
	List<SalaryDataWeekBonusRankRuleData>? weekBonusRankRuleData = [];
	@JSONField(name: 'show_week_repayment_rank_rule')
	bool? showWeekRepaymentRankRule = false;
	@JSONField(name: 'week_repayment_rank_rule_title')
	String? weekRepaymentRankRuleTitle = '';
	@JSONField(name: 'week_repayment_rank_rule_comment')
	String? weekRepaymentRankRuleComment = '';
	@JSONField(name: 'week_repayment_rank_rule_data')
	List<SalaryDataWeekRepaymentRankRuleData>? weekRepaymentRankRuleData = [];
	@JSONField(name: 'show_week_register_rank_rule')
	bool? showWeekRegisterRankRule = false;
	@JSONField(name: 'week_register_rank_rule_title')
	String? weekRegisterRankRuleTitle = '';
	@JSONField(name: 'week_register_rank_rule_comment')
	String? weekRegisterRankRuleComment = '';
	@JSONField(name: 'week_register_rank_rule_data')
	List<SalaryDataWeekRegisterRankRuleData>? weekRegisterRankRuleData = [];
	@JSONField(name: 'show_week_apply_rank_rule')
	bool? showWeekApplyRankRule = false;
	@JSONField(name: 'week_apply_rank_rule_title')
	String? weekApplyRankRuleTitle = '';
	@JSONField(name: 'week_apply_rank_rule_comment')
	String? weekApplyRankRuleComment = '';
	@JSONField(name: 'week_apply_rank_rule_data')
	List<SalaryDataWeekApplyRankRuleData>? weekApplyRankRuleData = [];
	@JSONField(name: 'show_month_bonus_rank_rule')
	bool? showMonthBonusRankRule = false;
	@JSONField(name: 'month_bonus_rank_rule_title')
	String? monthBonusRankRuleTitle = '';
	@JSONField(name: 'month_bonus_rank_rule_comment')
	String? monthBonusRankRuleComment = '';
	@JSONField(name: 'month_bonus_rank_rule_data')
	List<SalaryDataMonthBonusRankRuleData>? monthBonusRankRuleData = [];
	@JSONField(name: 'show_month_repayment_rank_rule')
	bool? showMonthRepaymentRankRule = false;
	@JSONField(name: 'month_repayment_rank_rule_title')
	String? monthRepaymentRankRuleTitle = '';
	@JSONField(name: 'month_repayment_rank_rule_comment')
	String? monthRepaymentRankRuleComment = '';
	@JSONField(name: 'month_repayment_rank_rule_data')
	List<SalaryDataMonthRepaymentRankRuleData>? monthRepaymentRankRuleData = [];
	@JSONField(name: 'show_month_register_rank_rule')
	bool? showMonthRegisterRankRule = false;
	@JSONField(name: 'month_register_rank_rule_title')
	String? monthRegisterRankRuleTitle = '';
	@JSONField(name: 'month_register_rank_rule_comment')
	String? monthRegisterRankRuleComment = '';
	@JSONField(name: 'month_register_rank_rule_data')
	List<SalaryDataMonthRegisterRankRuleData>? monthRegisterRankRuleData = [];
	@JSONField(name: 'show_month_apply_rank_rule')
	bool? showMonthApplyRankRule = false;
	@JSONField(name: 'month_apply_rank_rule_title')
	String? monthApplyRankRuleTitle = '';
	@JSONField(name: 'month_apply_rank_rule_comment')
	String? monthApplyRankRuleComment = '';
	@JSONField(name: 'month_apply_rank_rule_data')
	List<SalaryDataMonthApplyRankRuleData>? monthApplyRankRuleData = [];
	@JSONField(name: 'show_feedback_bonus')
	bool? showFeedbackBonus = false;
	@JSONField(name: 'feedback_bonus_title')
	String? feedbackBonusTitle = '';
	@JSONField(name: 'feedback_bonus_comment')
	String? feedbackBonusComment = '';
	@JSONField(name: 'feedback_bonus_data')
	List<SalaryDataFeedbackBonusData>? feedbackBonusData = [];
	@JSONField(name: 'show_fine')
	bool? showFine = false;
	@JSONField(name: 'fine_title')
	String? fineTitle = '';
	@JSONField(name: 'fine_comment')
	String? fineComment = '';
	@JSONField(name: 'fine_data')
	List<SalaryDataFineData>? fineData = [];

	SalaryData();

	factory SalaryData.fromJson(Map<String, dynamic> json) => $SalaryDataFromJson(json);

	Map<String, dynamic> toJson() => $SalaryDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class SalaryDataWeekSalaryData {
	String? title = '';
	int? value = 0;
	String? comment = '';

	SalaryDataWeekSalaryData();

	factory SalaryDataWeekSalaryData.fromJson(Map<String, dynamic> json) => $SalaryDataWeekSalaryDataFromJson(json);

	Map<String, dynamic> toJson() => $SalaryDataWeekSalaryDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class SalaryDataMonthSalaryData {
	String? title = '';
	int? value = 0;
	String? comment = '';

	SalaryDataMonthSalaryData();

	factory SalaryDataMonthSalaryData.fromJson(Map<String, dynamic> json) => $SalaryDataMonthSalaryDataFromJson(json);

	Map<String, dynamic> toJson() => $SalaryDataMonthSalaryDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class SalaryDataWeekBonusRankRuleData {
	String? title = '';
	String? value1 = '';
	String? value2 = '';
	String? comment = '';

	SalaryDataWeekBonusRankRuleData();

	factory SalaryDataWeekBonusRankRuleData.fromJson(Map<String, dynamic> json) => $SalaryDataWeekBonusRankRuleDataFromJson(json);

	Map<String, dynamic> toJson() => $SalaryDataWeekBonusRankRuleDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class SalaryDataWeekRepaymentRankRuleData {
	String? title = '';
	String? value1 = '';
	String? value2 = '';
	String? comment = '';

	SalaryDataWeekRepaymentRankRuleData();

	factory SalaryDataWeekRepaymentRankRuleData.fromJson(Map<String, dynamic> json) => $SalaryDataWeekRepaymentRankRuleDataFromJson(json);

	Map<String, dynamic> toJson() => $SalaryDataWeekRepaymentRankRuleDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class SalaryDataWeekRegisterRankRuleData {
	String? title = '';
	String? value1 = '';
	String? value2 = '';
	String? value3 = '';
	String? comment = '';

	SalaryDataWeekRegisterRankRuleData();

	factory SalaryDataWeekRegisterRankRuleData.fromJson(Map<String, dynamic> json) => $SalaryDataWeekRegisterRankRuleDataFromJson(json);

	Map<String, dynamic> toJson() => $SalaryDataWeekRegisterRankRuleDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class SalaryDataWeekApplyRankRuleData {
	String? title = '';
	String? value1 = '';
	String? value2 = '';
	String? value3 = '';
	String? comment = '';

	SalaryDataWeekApplyRankRuleData();

	factory SalaryDataWeekApplyRankRuleData.fromJson(Map<String, dynamic> json) => $SalaryDataWeekApplyRankRuleDataFromJson(json);

	Map<String, dynamic> toJson() => $SalaryDataWeekApplyRankRuleDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class SalaryDataMonthBonusRankRuleData {
	String? title = '';
	String? value = '';
	String? comment = '';

	SalaryDataMonthBonusRankRuleData();

	factory SalaryDataMonthBonusRankRuleData.fromJson(Map<String, dynamic> json) => $SalaryDataMonthBonusRankRuleDataFromJson(json);

	Map<String, dynamic> toJson() => $SalaryDataMonthBonusRankRuleDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class SalaryDataMonthRepaymentRankRuleData {
	String? title = '';
	String? value = '';
	String? comment = '';

	SalaryDataMonthRepaymentRankRuleData();

	factory SalaryDataMonthRepaymentRankRuleData.fromJson(Map<String, dynamic> json) => $SalaryDataMonthRepaymentRankRuleDataFromJson(json);

	Map<String, dynamic> toJson() => $SalaryDataMonthRepaymentRankRuleDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class SalaryDataMonthRegisterRankRuleData {
	String? title = '';
	String? value = '';
	String? comment = '';

	SalaryDataMonthRegisterRankRuleData();

	factory SalaryDataMonthRegisterRankRuleData.fromJson(Map<String, dynamic> json) => $SalaryDataMonthRegisterRankRuleDataFromJson(json);

	Map<String, dynamic> toJson() => $SalaryDataMonthRegisterRankRuleDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class SalaryDataMonthApplyRankRuleData {
	String? title = '';
	String? value = '';
	String? comment = '';

	SalaryDataMonthApplyRankRuleData();

	factory SalaryDataMonthApplyRankRuleData.fromJson(Map<String, dynamic> json) => $SalaryDataMonthApplyRankRuleDataFromJson(json);

	Map<String, dynamic> toJson() => $SalaryDataMonthApplyRankRuleDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class SalaryDataFeedbackBonusData {
	String? title = '';
	String? value = '';
	String? comment = '';

	SalaryDataFeedbackBonusData();

	factory SalaryDataFeedbackBonusData.fromJson(Map<String, dynamic> json) => $SalaryDataFeedbackBonusDataFromJson(json);

	Map<String, dynamic> toJson() => $SalaryDataFeedbackBonusDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class SalaryDataFineData {
	String? title = '';
	String? value1 = '';
	String? value2 = '';
	String? value3 = '';
	String? comment = '';

	SalaryDataFineData();

	factory SalaryDataFineData.fromJson(Map<String, dynamic> json) => $SalaryDataFineDataFromJson(json);

	Map<String, dynamic> toJson() => $SalaryDataFineDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}
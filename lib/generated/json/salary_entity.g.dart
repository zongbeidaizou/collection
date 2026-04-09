import 'package:bounty_hunter/generated/json/base/json_convert_content.dart';
import 'package:bounty_hunter/models/salary_entity.dart';

SalaryEntity $SalaryEntityFromJson(Map<String, dynamic> json) {
  final SalaryEntity salaryEntity = SalaryEntity();
  final bool? success = jsonConvert.convert<bool>(json['success']);
  if (success != null) {
    salaryEntity.success = success;
  }
  final SalaryData? data = jsonConvert.convert<SalaryData>(json['data']);
  if (data != null) {
    salaryEntity.data = data;
  }
  final List<dynamic>? other = (json['other'] as List<dynamic>?)?.map(
          (e) => e).toList();
  if (other != null) {
    salaryEntity.other = other;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    salaryEntity.message = message;
  }
  return salaryEntity;
}

Map<String, dynamic> $SalaryEntityToJson(SalaryEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['success'] = entity.success;
  data['data'] = entity.data?.toJson();
  data['other'] = entity.other;
  data['message'] = entity.message;
  return data;
}

extension SalaryEntityExtension on SalaryEntity {
  SalaryEntity copyWith({
    bool? success,
    SalaryData? data,
    List<dynamic>? other,
    String? message,
  }) {
    return SalaryEntity()
      ..success = success ?? this.success
      ..data = data ?? this.data
      ..other = other ?? this.other
      ..message = message ?? this.message;
  }
}

SalaryData $SalaryDataFromJson(Map<String, dynamic> json) {
  final SalaryData salaryData = SalaryData();
  final bool? showMonthBasicSalary = jsonConvert.convert<bool>(
      json['show_month_basic_salary']);
  if (showMonthBasicSalary != null) {
    salaryData.showMonthBasicSalary = showMonthBasicSalary;
  }
  final int? monthBasicSalaryValue = jsonConvert.convert<int>(
      json['month_basic_salary_value']);
  if (monthBasicSalaryValue != null) {
    salaryData.monthBasicSalaryValue = monthBasicSalaryValue;
  }
  final String? monthBasicSalaryComment = jsonConvert.convert<String>(
      json['month_basic_salary_comment']);
  if (monthBasicSalaryComment != null) {
    salaryData.monthBasicSalaryComment = monthBasicSalaryComment;
  }
  final bool? showWeekSalary = jsonConvert.convert<bool>(
      json['show_week_salary']);
  if (showWeekSalary != null) {
    salaryData.showWeekSalary = showWeekSalary;
  }
  final String? weekSalaryComment = jsonConvert.convert<String>(
      json['week_salary_comment']);
  if (weekSalaryComment != null) {
    salaryData.weekSalaryComment = weekSalaryComment;
  }
  final int? weekSalaryTotal = jsonConvert.convert<int>(
      json['week_salary_total']);
  if (weekSalaryTotal != null) {
    salaryData.weekSalaryTotal = weekSalaryTotal;
  }
  final List<
      SalaryDataWeekSalaryData>? weekSalaryData = (json['week_salary_data'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<SalaryDataWeekSalaryData>(
          e) as SalaryDataWeekSalaryData).toList();
  if (weekSalaryData != null) {
    salaryData.weekSalaryData = weekSalaryData;
  }
  final bool? showMonthSalary = jsonConvert.convert<bool>(
      json['show_month_salary']);
  if (showMonthSalary != null) {
    salaryData.showMonthSalary = showMonthSalary;
  }
  final String? monthSalaryComment = jsonConvert.convert<String>(
      json['month_salary_comment']);
  if (monthSalaryComment != null) {
    salaryData.monthSalaryComment = monthSalaryComment;
  }
  final int? monthSalaryTotal = jsonConvert.convert<int>(
      json['month_salary_total']);
  if (monthSalaryTotal != null) {
    salaryData.monthSalaryTotal = monthSalaryTotal;
  }
  final List<
      SalaryDataMonthSalaryData>? monthSalaryData = (json['month_salary_data'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<SalaryDataMonthSalaryData>(
          e) as SalaryDataMonthSalaryData).toList();
  if (monthSalaryData != null) {
    salaryData.monthSalaryData = monthSalaryData;
  }
  final bool? showWeekBonusRankRule = jsonConvert.convert<bool>(
      json['show_week_bonus_rank_rule']);
  if (showWeekBonusRankRule != null) {
    salaryData.showWeekBonusRankRule = showWeekBonusRankRule;
  }
  final String? weekBonusRankRuleTitle = jsonConvert.convert<String>(
      json['week_bonus_rank_rule_title']);
  if (weekBonusRankRuleTitle != null) {
    salaryData.weekBonusRankRuleTitle = weekBonusRankRuleTitle;
  }
  final String? weekBonusRankRuleComment = jsonConvert.convert<String>(
      json['week_bonus_rank_rule_comment']);
  if (weekBonusRankRuleComment != null) {
    salaryData.weekBonusRankRuleComment = weekBonusRankRuleComment;
  }
  final List<
      SalaryDataWeekBonusRankRuleData>? weekBonusRankRuleData = (json['week_bonus_rank_rule_data'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<SalaryDataWeekBonusRankRuleData>(
          e) as SalaryDataWeekBonusRankRuleData).toList();
  if (weekBonusRankRuleData != null) {
    salaryData.weekBonusRankRuleData = weekBonusRankRuleData;
  }
  final bool? showWeekRepaymentRankRule = jsonConvert.convert<bool>(
      json['show_week_repayment_rank_rule']);
  if (showWeekRepaymentRankRule != null) {
    salaryData.showWeekRepaymentRankRule = showWeekRepaymentRankRule;
  }
  final String? weekRepaymentRankRuleTitle = jsonConvert.convert<String>(
      json['week_repayment_rank_rule_title']);
  if (weekRepaymentRankRuleTitle != null) {
    salaryData.weekRepaymentRankRuleTitle = weekRepaymentRankRuleTitle;
  }
  final String? weekRepaymentRankRuleComment = jsonConvert.convert<String>(
      json['week_repayment_rank_rule_comment']);
  if (weekRepaymentRankRuleComment != null) {
    salaryData.weekRepaymentRankRuleComment = weekRepaymentRankRuleComment;
  }
  final List<
      SalaryDataWeekRepaymentRankRuleData>? weekRepaymentRankRuleData = (json['week_repayment_rank_rule_data'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<SalaryDataWeekRepaymentRankRuleData>(
          e) as SalaryDataWeekRepaymentRankRuleData).toList();
  if (weekRepaymentRankRuleData != null) {
    salaryData.weekRepaymentRankRuleData = weekRepaymentRankRuleData;
  }
  final bool? showWeekRegisterRankRule = jsonConvert.convert<bool>(
      json['show_week_register_rank_rule']);
  if (showWeekRegisterRankRule != null) {
    salaryData.showWeekRegisterRankRule = showWeekRegisterRankRule;
  }
  final String? weekRegisterRankRuleTitle = jsonConvert.convert<String>(
      json['week_register_rank_rule_title']);
  if (weekRegisterRankRuleTitle != null) {
    salaryData.weekRegisterRankRuleTitle = weekRegisterRankRuleTitle;
  }
  final String? weekRegisterRankRuleComment = jsonConvert.convert<String>(
      json['week_register_rank_rule_comment']);
  if (weekRegisterRankRuleComment != null) {
    salaryData.weekRegisterRankRuleComment = weekRegisterRankRuleComment;
  }
  final List<
      SalaryDataWeekRegisterRankRuleData>? weekRegisterRankRuleData = (json['week_register_rank_rule_data'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<SalaryDataWeekRegisterRankRuleData>(
          e) as SalaryDataWeekRegisterRankRuleData).toList();
  if (weekRegisterRankRuleData != null) {
    salaryData.weekRegisterRankRuleData = weekRegisterRankRuleData;
  }
  final bool? showWeekApplyRankRule = jsonConvert.convert<bool>(
      json['show_week_apply_rank_rule']);
  if (showWeekApplyRankRule != null) {
    salaryData.showWeekApplyRankRule = showWeekApplyRankRule;
  }
  final String? weekApplyRankRuleTitle = jsonConvert.convert<String>(
      json['week_apply_rank_rule_title']);
  if (weekApplyRankRuleTitle != null) {
    salaryData.weekApplyRankRuleTitle = weekApplyRankRuleTitle;
  }
  final String? weekApplyRankRuleComment = jsonConvert.convert<String>(
      json['week_apply_rank_rule_comment']);
  if (weekApplyRankRuleComment != null) {
    salaryData.weekApplyRankRuleComment = weekApplyRankRuleComment;
  }
  final List<
      SalaryDataWeekApplyRankRuleData>? weekApplyRankRuleData = (json['week_apply_rank_rule_data'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<SalaryDataWeekApplyRankRuleData>(
          e) as SalaryDataWeekApplyRankRuleData).toList();
  if (weekApplyRankRuleData != null) {
    salaryData.weekApplyRankRuleData = weekApplyRankRuleData;
  }
  final bool? showMonthBonusRankRule = jsonConvert.convert<bool>(
      json['show_month_bonus_rank_rule']);
  if (showMonthBonusRankRule != null) {
    salaryData.showMonthBonusRankRule = showMonthBonusRankRule;
  }
  final String? monthBonusRankRuleTitle = jsonConvert.convert<String>(
      json['month_bonus_rank_rule_title']);
  if (monthBonusRankRuleTitle != null) {
    salaryData.monthBonusRankRuleTitle = monthBonusRankRuleTitle;
  }
  final String? monthBonusRankRuleComment = jsonConvert.convert<String>(
      json['month_bonus_rank_rule_comment']);
  if (monthBonusRankRuleComment != null) {
    salaryData.monthBonusRankRuleComment = monthBonusRankRuleComment;
  }
  final List<
      SalaryDataMonthBonusRankRuleData>? monthBonusRankRuleData = (json['month_bonus_rank_rule_data'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<SalaryDataMonthBonusRankRuleData>(
          e) as SalaryDataMonthBonusRankRuleData).toList();
  if (monthBonusRankRuleData != null) {
    salaryData.monthBonusRankRuleData = monthBonusRankRuleData;
  }
  final bool? showMonthRepaymentRankRule = jsonConvert.convert<bool>(
      json['show_month_repayment_rank_rule']);
  if (showMonthRepaymentRankRule != null) {
    salaryData.showMonthRepaymentRankRule = showMonthRepaymentRankRule;
  }
  final String? monthRepaymentRankRuleTitle = jsonConvert.convert<String>(
      json['month_repayment_rank_rule_title']);
  if (monthRepaymentRankRuleTitle != null) {
    salaryData.monthRepaymentRankRuleTitle = monthRepaymentRankRuleTitle;
  }
  final String? monthRepaymentRankRuleComment = jsonConvert.convert<String>(
      json['month_repayment_rank_rule_comment']);
  if (monthRepaymentRankRuleComment != null) {
    salaryData.monthRepaymentRankRuleComment = monthRepaymentRankRuleComment;
  }
  final List<
      SalaryDataMonthRepaymentRankRuleData>? monthRepaymentRankRuleData = (json['month_repayment_rank_rule_data'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<SalaryDataMonthRepaymentRankRuleData>(
          e) as SalaryDataMonthRepaymentRankRuleData).toList();
  if (monthRepaymentRankRuleData != null) {
    salaryData.monthRepaymentRankRuleData = monthRepaymentRankRuleData;
  }
  final bool? showMonthRegisterRankRule = jsonConvert.convert<bool>(
      json['show_month_register_rank_rule']);
  if (showMonthRegisterRankRule != null) {
    salaryData.showMonthRegisterRankRule = showMonthRegisterRankRule;
  }
  final String? monthRegisterRankRuleTitle = jsonConvert.convert<String>(
      json['month_register_rank_rule_title']);
  if (monthRegisterRankRuleTitle != null) {
    salaryData.monthRegisterRankRuleTitle = monthRegisterRankRuleTitle;
  }
  final String? monthRegisterRankRuleComment = jsonConvert.convert<String>(
      json['month_register_rank_rule_comment']);
  if (monthRegisterRankRuleComment != null) {
    salaryData.monthRegisterRankRuleComment = monthRegisterRankRuleComment;
  }
  final List<
      SalaryDataMonthRegisterRankRuleData>? monthRegisterRankRuleData = (json['month_register_rank_rule_data'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<SalaryDataMonthRegisterRankRuleData>(
          e) as SalaryDataMonthRegisterRankRuleData).toList();
  if (monthRegisterRankRuleData != null) {
    salaryData.monthRegisterRankRuleData = monthRegisterRankRuleData;
  }
  final bool? showMonthApplyRankRule = jsonConvert.convert<bool>(
      json['show_month_apply_rank_rule']);
  if (showMonthApplyRankRule != null) {
    salaryData.showMonthApplyRankRule = showMonthApplyRankRule;
  }
  final String? monthApplyRankRuleTitle = jsonConvert.convert<String>(
      json['month_apply_rank_rule_title']);
  if (monthApplyRankRuleTitle != null) {
    salaryData.monthApplyRankRuleTitle = monthApplyRankRuleTitle;
  }
  final String? monthApplyRankRuleComment = jsonConvert.convert<String>(
      json['month_apply_rank_rule_comment']);
  if (monthApplyRankRuleComment != null) {
    salaryData.monthApplyRankRuleComment = monthApplyRankRuleComment;
  }
  final List<
      SalaryDataMonthApplyRankRuleData>? monthApplyRankRuleData = (json['month_apply_rank_rule_data'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<SalaryDataMonthApplyRankRuleData>(
          e) as SalaryDataMonthApplyRankRuleData).toList();
  if (monthApplyRankRuleData != null) {
    salaryData.monthApplyRankRuleData = monthApplyRankRuleData;
  }
  final bool? showFeedbackBonus = jsonConvert.convert<bool>(
      json['show_feedback_bonus']);
  if (showFeedbackBonus != null) {
    salaryData.showFeedbackBonus = showFeedbackBonus;
  }
  final String? feedbackBonusTitle = jsonConvert.convert<String>(
      json['feedback_bonus_title']);
  if (feedbackBonusTitle != null) {
    salaryData.feedbackBonusTitle = feedbackBonusTitle;
  }
  final String? feedbackBonusComment = jsonConvert.convert<String>(
      json['feedback_bonus_comment']);
  if (feedbackBonusComment != null) {
    salaryData.feedbackBonusComment = feedbackBonusComment;
  }
  final List<
      SalaryDataFeedbackBonusData>? feedbackBonusData = (json['feedback_bonus_data'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<SalaryDataFeedbackBonusData>(
          e) as SalaryDataFeedbackBonusData).toList();
  if (feedbackBonusData != null) {
    salaryData.feedbackBonusData = feedbackBonusData;
  }
  final bool? showFine = jsonConvert.convert<bool>(json['show_fine']);
  if (showFine != null) {
    salaryData.showFine = showFine;
  }
  final String? fineTitle = jsonConvert.convert<String>(json['fine_title']);
  if (fineTitle != null) {
    salaryData.fineTitle = fineTitle;
  }
  final String? fineComment = jsonConvert.convert<String>(json['fine_comment']);
  if (fineComment != null) {
    salaryData.fineComment = fineComment;
  }
  final List<SalaryDataFineData>? fineData = (json['fine_data'] as List<
      dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<SalaryDataFineData>(e) as SalaryDataFineData)
      .toList();
  if (fineData != null) {
    salaryData.fineData = fineData;
  }
  return salaryData;
}

Map<String, dynamic> $SalaryDataToJson(SalaryData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['show_month_basic_salary'] = entity.showMonthBasicSalary;
  data['month_basic_salary_value'] = entity.monthBasicSalaryValue;
  data['month_basic_salary_comment'] = entity.monthBasicSalaryComment;
  data['show_week_salary'] = entity.showWeekSalary;
  data['week_salary_comment'] = entity.weekSalaryComment;
  data['week_salary_total'] = entity.weekSalaryTotal;
  data['week_salary_data'] =
      entity.weekSalaryData?.map((v) => v.toJson()).toList();
  data['show_month_salary'] = entity.showMonthSalary;
  data['month_salary_comment'] = entity.monthSalaryComment;
  data['month_salary_total'] = entity.monthSalaryTotal;
  data['month_salary_data'] =
      entity.monthSalaryData?.map((v) => v.toJson()).toList();
  data['show_week_bonus_rank_rule'] = entity.showWeekBonusRankRule;
  data['week_bonus_rank_rule_title'] = entity.weekBonusRankRuleTitle;
  data['week_bonus_rank_rule_comment'] = entity.weekBonusRankRuleComment;
  data['week_bonus_rank_rule_data'] =
      entity.weekBonusRankRuleData?.map((v) => v.toJson()).toList();
  data['show_week_repayment_rank_rule'] = entity.showWeekRepaymentRankRule;
  data['week_repayment_rank_rule_title'] = entity.weekRepaymentRankRuleTitle;
  data['week_repayment_rank_rule_comment'] =
      entity.weekRepaymentRankRuleComment;
  data['week_repayment_rank_rule_data'] =
      entity.weekRepaymentRankRuleData?.map((v) => v.toJson()).toList();
  data['show_week_register_rank_rule'] = entity.showWeekRegisterRankRule;
  data['week_register_rank_rule_title'] = entity.weekRegisterRankRuleTitle;
  data['week_register_rank_rule_comment'] = entity.weekRegisterRankRuleComment;
  data['week_register_rank_rule_data'] =
      entity.weekRegisterRankRuleData?.map((v) => v.toJson()).toList();
  data['show_week_apply_rank_rule'] = entity.showWeekApplyRankRule;
  data['week_apply_rank_rule_title'] = entity.weekApplyRankRuleTitle;
  data['week_apply_rank_rule_comment'] = entity.weekApplyRankRuleComment;
  data['week_apply_rank_rule_data'] =
      entity.weekApplyRankRuleData?.map((v) => v.toJson()).toList();
  data['show_month_bonus_rank_rule'] = entity.showMonthBonusRankRule;
  data['month_bonus_rank_rule_title'] = entity.monthBonusRankRuleTitle;
  data['month_bonus_rank_rule_comment'] = entity.monthBonusRankRuleComment;
  data['month_bonus_rank_rule_data'] =
      entity.monthBonusRankRuleData?.map((v) => v.toJson()).toList();
  data['show_month_repayment_rank_rule'] = entity.showMonthRepaymentRankRule;
  data['month_repayment_rank_rule_title'] = entity.monthRepaymentRankRuleTitle;
  data['month_repayment_rank_rule_comment'] =
      entity.monthRepaymentRankRuleComment;
  data['month_repayment_rank_rule_data'] =
      entity.monthRepaymentRankRuleData?.map((v) => v.toJson()).toList();
  data['show_month_register_rank_rule'] = entity.showMonthRegisterRankRule;
  data['month_register_rank_rule_title'] = entity.monthRegisterRankRuleTitle;
  data['month_register_rank_rule_comment'] =
      entity.monthRegisterRankRuleComment;
  data['month_register_rank_rule_data'] =
      entity.monthRegisterRankRuleData?.map((v) => v.toJson()).toList();
  data['show_month_apply_rank_rule'] = entity.showMonthApplyRankRule;
  data['month_apply_rank_rule_title'] = entity.monthApplyRankRuleTitle;
  data['month_apply_rank_rule_comment'] = entity.monthApplyRankRuleComment;
  data['month_apply_rank_rule_data'] =
      entity.monthApplyRankRuleData?.map((v) => v.toJson()).toList();
  data['show_feedback_bonus'] = entity.showFeedbackBonus;
  data['feedback_bonus_title'] = entity.feedbackBonusTitle;
  data['feedback_bonus_comment'] = entity.feedbackBonusComment;
  data['feedback_bonus_data'] =
      entity.feedbackBonusData?.map((v) => v.toJson()).toList();
  data['show_fine'] = entity.showFine;
  data['fine_title'] = entity.fineTitle;
  data['fine_comment'] = entity.fineComment;
  data['fine_data'] = entity.fineData?.map((v) => v.toJson()).toList();
  return data;
}

extension SalaryDataExtension on SalaryData {
  SalaryData copyWith({
    bool? showMonthBasicSalary,
    int? monthBasicSalaryValue,
    String? monthBasicSalaryComment,
    bool? showWeekSalary,
    String? weekSalaryComment,
    int? weekSalaryTotal,
    List<SalaryDataWeekSalaryData>? weekSalaryData,
    bool? showMonthSalary,
    String? monthSalaryComment,
    int? monthSalaryTotal,
    List<SalaryDataMonthSalaryData>? monthSalaryData,
    bool? showWeekBonusRankRule,
    String? weekBonusRankRuleTitle,
    String? weekBonusRankRuleComment,
    List<SalaryDataWeekBonusRankRuleData>? weekBonusRankRuleData,
    bool? showWeekRepaymentRankRule,
    String? weekRepaymentRankRuleTitle,
    String? weekRepaymentRankRuleComment,
    List<SalaryDataWeekRepaymentRankRuleData>? weekRepaymentRankRuleData,
    bool? showWeekRegisterRankRule,
    String? weekRegisterRankRuleTitle,
    String? weekRegisterRankRuleComment,
    List<SalaryDataWeekRegisterRankRuleData>? weekRegisterRankRuleData,
    bool? showWeekApplyRankRule,
    String? weekApplyRankRuleTitle,
    String? weekApplyRankRuleComment,
    List<SalaryDataWeekApplyRankRuleData>? weekApplyRankRuleData,
    bool? showMonthBonusRankRule,
    String? monthBonusRankRuleTitle,
    String? monthBonusRankRuleComment,
    List<SalaryDataMonthBonusRankRuleData>? monthBonusRankRuleData,
    bool? showMonthRepaymentRankRule,
    String? monthRepaymentRankRuleTitle,
    String? monthRepaymentRankRuleComment,
    List<SalaryDataMonthRepaymentRankRuleData>? monthRepaymentRankRuleData,
    bool? showMonthRegisterRankRule,
    String? monthRegisterRankRuleTitle,
    String? monthRegisterRankRuleComment,
    List<SalaryDataMonthRegisterRankRuleData>? monthRegisterRankRuleData,
    bool? showMonthApplyRankRule,
    String? monthApplyRankRuleTitle,
    String? monthApplyRankRuleComment,
    List<SalaryDataMonthApplyRankRuleData>? monthApplyRankRuleData,
    bool? showFeedbackBonus,
    String? feedbackBonusTitle,
    String? feedbackBonusComment,
    List<SalaryDataFeedbackBonusData>? feedbackBonusData,
    bool? showFine,
    String? fineTitle,
    String? fineComment,
    List<SalaryDataFineData>? fineData,
  }) {
    return SalaryData()
      ..showMonthBasicSalary = showMonthBasicSalary ?? this.showMonthBasicSalary
      ..monthBasicSalaryValue = monthBasicSalaryValue ??
          this.monthBasicSalaryValue
      ..monthBasicSalaryComment = monthBasicSalaryComment ??
          this.monthBasicSalaryComment
      ..showWeekSalary = showWeekSalary ?? this.showWeekSalary
      ..weekSalaryComment = weekSalaryComment ?? this.weekSalaryComment
      ..weekSalaryTotal = weekSalaryTotal ?? this.weekSalaryTotal
      ..weekSalaryData = weekSalaryData ?? this.weekSalaryData
      ..showMonthSalary = showMonthSalary ?? this.showMonthSalary
      ..monthSalaryComment = monthSalaryComment ?? this.monthSalaryComment
      ..monthSalaryTotal = monthSalaryTotal ?? this.monthSalaryTotal
      ..monthSalaryData = monthSalaryData ?? this.monthSalaryData
      ..showWeekBonusRankRule = showWeekBonusRankRule ??
          this.showWeekBonusRankRule
      ..weekBonusRankRuleTitle = weekBonusRankRuleTitle ??
          this.weekBonusRankRuleTitle
      ..weekBonusRankRuleComment = weekBonusRankRuleComment ??
          this.weekBonusRankRuleComment
      ..weekBonusRankRuleData = weekBonusRankRuleData ??
          this.weekBonusRankRuleData
      ..showWeekRepaymentRankRule = showWeekRepaymentRankRule ??
          this.showWeekRepaymentRankRule
      ..weekRepaymentRankRuleTitle = weekRepaymentRankRuleTitle ??
          this.weekRepaymentRankRuleTitle
      ..weekRepaymentRankRuleComment = weekRepaymentRankRuleComment ??
          this.weekRepaymentRankRuleComment
      ..weekRepaymentRankRuleData = weekRepaymentRankRuleData ??
          this.weekRepaymentRankRuleData
      ..showWeekRegisterRankRule = showWeekRegisterRankRule ??
          this.showWeekRegisterRankRule
      ..weekRegisterRankRuleTitle = weekRegisterRankRuleTitle ??
          this.weekRegisterRankRuleTitle
      ..weekRegisterRankRuleComment = weekRegisterRankRuleComment ??
          this.weekRegisterRankRuleComment
      ..weekRegisterRankRuleData = weekRegisterRankRuleData ??
          this.weekRegisterRankRuleData
      ..showWeekApplyRankRule = showWeekApplyRankRule ??
          this.showWeekApplyRankRule
      ..weekApplyRankRuleTitle = weekApplyRankRuleTitle ??
          this.weekApplyRankRuleTitle
      ..weekApplyRankRuleComment = weekApplyRankRuleComment ??
          this.weekApplyRankRuleComment
      ..weekApplyRankRuleData = weekApplyRankRuleData ??
          this.weekApplyRankRuleData
      ..showMonthBonusRankRule = showMonthBonusRankRule ??
          this.showMonthBonusRankRule
      ..monthBonusRankRuleTitle = monthBonusRankRuleTitle ??
          this.monthBonusRankRuleTitle
      ..monthBonusRankRuleComment = monthBonusRankRuleComment ??
          this.monthBonusRankRuleComment
      ..monthBonusRankRuleData = monthBonusRankRuleData ??
          this.monthBonusRankRuleData
      ..showMonthRepaymentRankRule = showMonthRepaymentRankRule ??
          this.showMonthRepaymentRankRule
      ..monthRepaymentRankRuleTitle = monthRepaymentRankRuleTitle ??
          this.monthRepaymentRankRuleTitle
      ..monthRepaymentRankRuleComment = monthRepaymentRankRuleComment ??
          this.monthRepaymentRankRuleComment
      ..monthRepaymentRankRuleData = monthRepaymentRankRuleData ??
          this.monthRepaymentRankRuleData
      ..showMonthRegisterRankRule = showMonthRegisterRankRule ??
          this.showMonthRegisterRankRule
      ..monthRegisterRankRuleTitle = monthRegisterRankRuleTitle ??
          this.monthRegisterRankRuleTitle
      ..monthRegisterRankRuleComment = monthRegisterRankRuleComment ??
          this.monthRegisterRankRuleComment
      ..monthRegisterRankRuleData = monthRegisterRankRuleData ??
          this.monthRegisterRankRuleData
      ..showMonthApplyRankRule = showMonthApplyRankRule ??
          this.showMonthApplyRankRule
      ..monthApplyRankRuleTitle = monthApplyRankRuleTitle ??
          this.monthApplyRankRuleTitle
      ..monthApplyRankRuleComment = monthApplyRankRuleComment ??
          this.monthApplyRankRuleComment
      ..monthApplyRankRuleData = monthApplyRankRuleData ??
          this.monthApplyRankRuleData
      ..showFeedbackBonus = showFeedbackBonus ?? this.showFeedbackBonus
      ..feedbackBonusTitle = feedbackBonusTitle ?? this.feedbackBonusTitle
      ..feedbackBonusComment = feedbackBonusComment ?? this.feedbackBonusComment
      ..feedbackBonusData = feedbackBonusData ?? this.feedbackBonusData
      ..showFine = showFine ?? this.showFine
      ..fineTitle = fineTitle ?? this.fineTitle
      ..fineComment = fineComment ?? this.fineComment
      ..fineData = fineData ?? this.fineData;
  }
}

SalaryDataWeekSalaryData $SalaryDataWeekSalaryDataFromJson(
    Map<String, dynamic> json) {
  final SalaryDataWeekSalaryData salaryDataWeekSalaryData = SalaryDataWeekSalaryData();
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    salaryDataWeekSalaryData.title = title;
  }
  final int? value = jsonConvert.convert<int>(json['value']);
  if (value != null) {
    salaryDataWeekSalaryData.value = value;
  }
  final String? comment = jsonConvert.convert<String>(json['comment']);
  if (comment != null) {
    salaryDataWeekSalaryData.comment = comment;
  }
  return salaryDataWeekSalaryData;
}

Map<String, dynamic> $SalaryDataWeekSalaryDataToJson(
    SalaryDataWeekSalaryData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['title'] = entity.title;
  data['value'] = entity.value;
  data['comment'] = entity.comment;
  return data;
}

extension SalaryDataWeekSalaryDataExtension on SalaryDataWeekSalaryData {
  SalaryDataWeekSalaryData copyWith({
    String? title,
    int? value,
    String? comment,
  }) {
    return SalaryDataWeekSalaryData()
      ..title = title ?? this.title
      ..value = value ?? this.value
      ..comment = comment ?? this.comment;
  }
}

SalaryDataMonthSalaryData $SalaryDataMonthSalaryDataFromJson(
    Map<String, dynamic> json) {
  final SalaryDataMonthSalaryData salaryDataMonthSalaryData = SalaryDataMonthSalaryData();
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    salaryDataMonthSalaryData.title = title;
  }
  final int? value = jsonConvert.convert<int>(json['value']);
  if (value != null) {
    salaryDataMonthSalaryData.value = value;
  }
  final String? comment = jsonConvert.convert<String>(json['comment']);
  if (comment != null) {
    salaryDataMonthSalaryData.comment = comment;
  }
  return salaryDataMonthSalaryData;
}

Map<String, dynamic> $SalaryDataMonthSalaryDataToJson(
    SalaryDataMonthSalaryData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['title'] = entity.title;
  data['value'] = entity.value;
  data['comment'] = entity.comment;
  return data;
}

extension SalaryDataMonthSalaryDataExtension on SalaryDataMonthSalaryData {
  SalaryDataMonthSalaryData copyWith({
    String? title,
    int? value,
    String? comment,
  }) {
    return SalaryDataMonthSalaryData()
      ..title = title ?? this.title
      ..value = value ?? this.value
      ..comment = comment ?? this.comment;
  }
}

SalaryDataWeekBonusRankRuleData $SalaryDataWeekBonusRankRuleDataFromJson(
    Map<String, dynamic> json) {
  final SalaryDataWeekBonusRankRuleData salaryDataWeekBonusRankRuleData = SalaryDataWeekBonusRankRuleData();
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    salaryDataWeekBonusRankRuleData.title = title;
  }
  final String? value1 = jsonConvert.convert<String>(json['value1']);
  if (value1 != null) {
    salaryDataWeekBonusRankRuleData.value1 = value1;
  }
  final String? value2 = jsonConvert.convert<String>(json['value2']);
  if (value2 != null) {
    salaryDataWeekBonusRankRuleData.value2 = value2;
  }
  final String? comment = jsonConvert.convert<String>(json['comment']);
  if (comment != null) {
    salaryDataWeekBonusRankRuleData.comment = comment;
  }
  return salaryDataWeekBonusRankRuleData;
}

Map<String, dynamic> $SalaryDataWeekBonusRankRuleDataToJson(
    SalaryDataWeekBonusRankRuleData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['title'] = entity.title;
  data['value1'] = entity.value1;
  data['value2'] = entity.value2;
  data['comment'] = entity.comment;
  return data;
}

extension SalaryDataWeekBonusRankRuleDataExtension on SalaryDataWeekBonusRankRuleData {
  SalaryDataWeekBonusRankRuleData copyWith({
    String? title,
    String? value1,
    String? value2,
    String? comment,
  }) {
    return SalaryDataWeekBonusRankRuleData()
      ..title = title ?? this.title
      ..value1 = value1 ?? this.value1
      ..value2 = value2 ?? this.value2
      ..comment = comment ?? this.comment;
  }
}

SalaryDataWeekRepaymentRankRuleData $SalaryDataWeekRepaymentRankRuleDataFromJson(
    Map<String, dynamic> json) {
  final SalaryDataWeekRepaymentRankRuleData salaryDataWeekRepaymentRankRuleData = SalaryDataWeekRepaymentRankRuleData();
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    salaryDataWeekRepaymentRankRuleData.title = title;
  }
  final String? value1 = jsonConvert.convert<String>(json['value1']);
  if (value1 != null) {
    salaryDataWeekRepaymentRankRuleData.value1 = value1;
  }
  final String? value2 = jsonConvert.convert<String>(json['value2']);
  if (value2 != null) {
    salaryDataWeekRepaymentRankRuleData.value2 = value2;
  }
  final String? comment = jsonConvert.convert<String>(json['comment']);
  if (comment != null) {
    salaryDataWeekRepaymentRankRuleData.comment = comment;
  }
  return salaryDataWeekRepaymentRankRuleData;
}

Map<String, dynamic> $SalaryDataWeekRepaymentRankRuleDataToJson(
    SalaryDataWeekRepaymentRankRuleData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['title'] = entity.title;
  data['value1'] = entity.value1;
  data['value2'] = entity.value2;
  data['comment'] = entity.comment;
  return data;
}

extension SalaryDataWeekRepaymentRankRuleDataExtension on SalaryDataWeekRepaymentRankRuleData {
  SalaryDataWeekRepaymentRankRuleData copyWith({
    String? title,
    String? value1,
    String? value2,
    String? comment,
  }) {
    return SalaryDataWeekRepaymentRankRuleData()
      ..title = title ?? this.title
      ..value1 = value1 ?? this.value1
      ..value2 = value2 ?? this.value2
      ..comment = comment ?? this.comment;
  }
}

SalaryDataWeekRegisterRankRuleData $SalaryDataWeekRegisterRankRuleDataFromJson(
    Map<String, dynamic> json) {
  final SalaryDataWeekRegisterRankRuleData salaryDataWeekRegisterRankRuleData = SalaryDataWeekRegisterRankRuleData();
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    salaryDataWeekRegisterRankRuleData.title = title;
  }
  final String? value1 = jsonConvert.convert<String>(json['value1']);
  if (value1 != null) {
    salaryDataWeekRegisterRankRuleData.value1 = value1;
  }
  final String? value2 = jsonConvert.convert<String>(json['value2']);
  if (value2 != null) {
    salaryDataWeekRegisterRankRuleData.value2 = value2;
  }
  final String? value3 = jsonConvert.convert<String>(json['value3']);
  if (value3 != null) {
    salaryDataWeekRegisterRankRuleData.value3 = value3;
  }
  final String? comment = jsonConvert.convert<String>(json['comment']);
  if (comment != null) {
    salaryDataWeekRegisterRankRuleData.comment = comment;
  }
  return salaryDataWeekRegisterRankRuleData;
}

Map<String, dynamic> $SalaryDataWeekRegisterRankRuleDataToJson(
    SalaryDataWeekRegisterRankRuleData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['title'] = entity.title;
  data['value1'] = entity.value1;
  data['value2'] = entity.value2;
  data['value3'] = entity.value3;
  data['comment'] = entity.comment;
  return data;
}

extension SalaryDataWeekRegisterRankRuleDataExtension on SalaryDataWeekRegisterRankRuleData {
  SalaryDataWeekRegisterRankRuleData copyWith({
    String? title,
    String? value1,
    String? value2,
    String? value3,
    String? comment,
  }) {
    return SalaryDataWeekRegisterRankRuleData()
      ..title = title ?? this.title
      ..value1 = value1 ?? this.value1
      ..value2 = value2 ?? this.value2
      ..value3 = value3 ?? this.value3
      ..comment = comment ?? this.comment;
  }
}

SalaryDataWeekApplyRankRuleData $SalaryDataWeekApplyRankRuleDataFromJson(
    Map<String, dynamic> json) {
  final SalaryDataWeekApplyRankRuleData salaryDataWeekApplyRankRuleData = SalaryDataWeekApplyRankRuleData();
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    salaryDataWeekApplyRankRuleData.title = title;
  }
  final String? value1 = jsonConvert.convert<String>(json['value1']);
  if (value1 != null) {
    salaryDataWeekApplyRankRuleData.value1 = value1;
  }
  final String? value2 = jsonConvert.convert<String>(json['value2']);
  if (value2 != null) {
    salaryDataWeekApplyRankRuleData.value2 = value2;
  }
  final String? value3 = jsonConvert.convert<String>(json['value3']);
  if (value3 != null) {
    salaryDataWeekApplyRankRuleData.value3 = value3;
  }
  final String? comment = jsonConvert.convert<String>(json['comment']);
  if (comment != null) {
    salaryDataWeekApplyRankRuleData.comment = comment;
  }
  return salaryDataWeekApplyRankRuleData;
}

Map<String, dynamic> $SalaryDataWeekApplyRankRuleDataToJson(
    SalaryDataWeekApplyRankRuleData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['title'] = entity.title;
  data['value1'] = entity.value1;
  data['value2'] = entity.value2;
  data['value3'] = entity.value3;
  data['comment'] = entity.comment;
  return data;
}

extension SalaryDataWeekApplyRankRuleDataExtension on SalaryDataWeekApplyRankRuleData {
  SalaryDataWeekApplyRankRuleData copyWith({
    String? title,
    String? value1,
    String? value2,
    String? value3,
    String? comment,
  }) {
    return SalaryDataWeekApplyRankRuleData()
      ..title = title ?? this.title
      ..value1 = value1 ?? this.value1
      ..value2 = value2 ?? this.value2
      ..value3 = value3 ?? this.value3
      ..comment = comment ?? this.comment;
  }
}

SalaryDataMonthBonusRankRuleData $SalaryDataMonthBonusRankRuleDataFromJson(
    Map<String, dynamic> json) {
  final SalaryDataMonthBonusRankRuleData salaryDataMonthBonusRankRuleData = SalaryDataMonthBonusRankRuleData();
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    salaryDataMonthBonusRankRuleData.title = title;
  }
  final String? value = jsonConvert.convert<String>(json['value']);
  if (value != null) {
    salaryDataMonthBonusRankRuleData.value = value;
  }
  final String? comment = jsonConvert.convert<String>(json['comment']);
  if (comment != null) {
    salaryDataMonthBonusRankRuleData.comment = comment;
  }
  return salaryDataMonthBonusRankRuleData;
}

Map<String, dynamic> $SalaryDataMonthBonusRankRuleDataToJson(
    SalaryDataMonthBonusRankRuleData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['title'] = entity.title;
  data['value'] = entity.value;
  data['comment'] = entity.comment;
  return data;
}

extension SalaryDataMonthBonusRankRuleDataExtension on SalaryDataMonthBonusRankRuleData {
  SalaryDataMonthBonusRankRuleData copyWith({
    String? title,
    String? value,
    String? comment,
  }) {
    return SalaryDataMonthBonusRankRuleData()
      ..title = title ?? this.title
      ..value = value ?? this.value
      ..comment = comment ?? this.comment;
  }
}

SalaryDataMonthRepaymentRankRuleData $SalaryDataMonthRepaymentRankRuleDataFromJson(
    Map<String, dynamic> json) {
  final SalaryDataMonthRepaymentRankRuleData salaryDataMonthRepaymentRankRuleData = SalaryDataMonthRepaymentRankRuleData();
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    salaryDataMonthRepaymentRankRuleData.title = title;
  }
  final String? value = jsonConvert.convert<String>(json['value']);
  if (value != null) {
    salaryDataMonthRepaymentRankRuleData.value = value;
  }
  final String? comment = jsonConvert.convert<String>(json['comment']);
  if (comment != null) {
    salaryDataMonthRepaymentRankRuleData.comment = comment;
  }
  return salaryDataMonthRepaymentRankRuleData;
}

Map<String, dynamic> $SalaryDataMonthRepaymentRankRuleDataToJson(
    SalaryDataMonthRepaymentRankRuleData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['title'] = entity.title;
  data['value'] = entity.value;
  data['comment'] = entity.comment;
  return data;
}

extension SalaryDataMonthRepaymentRankRuleDataExtension on SalaryDataMonthRepaymentRankRuleData {
  SalaryDataMonthRepaymentRankRuleData copyWith({
    String? title,
    String? value,
    String? comment,
  }) {
    return SalaryDataMonthRepaymentRankRuleData()
      ..title = title ?? this.title
      ..value = value ?? this.value
      ..comment = comment ?? this.comment;
  }
}

SalaryDataMonthRegisterRankRuleData $SalaryDataMonthRegisterRankRuleDataFromJson(
    Map<String, dynamic> json) {
  final SalaryDataMonthRegisterRankRuleData salaryDataMonthRegisterRankRuleData = SalaryDataMonthRegisterRankRuleData();
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    salaryDataMonthRegisterRankRuleData.title = title;
  }
  final String? value = jsonConvert.convert<String>(json['value']);
  if (value != null) {
    salaryDataMonthRegisterRankRuleData.value = value;
  }
  final String? comment = jsonConvert.convert<String>(json['comment']);
  if (comment != null) {
    salaryDataMonthRegisterRankRuleData.comment = comment;
  }
  return salaryDataMonthRegisterRankRuleData;
}

Map<String, dynamic> $SalaryDataMonthRegisterRankRuleDataToJson(
    SalaryDataMonthRegisterRankRuleData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['title'] = entity.title;
  data['value'] = entity.value;
  data['comment'] = entity.comment;
  return data;
}

extension SalaryDataMonthRegisterRankRuleDataExtension on SalaryDataMonthRegisterRankRuleData {
  SalaryDataMonthRegisterRankRuleData copyWith({
    String? title,
    String? value,
    String? comment,
  }) {
    return SalaryDataMonthRegisterRankRuleData()
      ..title = title ?? this.title
      ..value = value ?? this.value
      ..comment = comment ?? this.comment;
  }
}

SalaryDataMonthApplyRankRuleData $SalaryDataMonthApplyRankRuleDataFromJson(
    Map<String, dynamic> json) {
  final SalaryDataMonthApplyRankRuleData salaryDataMonthApplyRankRuleData = SalaryDataMonthApplyRankRuleData();
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    salaryDataMonthApplyRankRuleData.title = title;
  }
  final String? value = jsonConvert.convert<String>(json['value']);
  if (value != null) {
    salaryDataMonthApplyRankRuleData.value = value;
  }
  final String? comment = jsonConvert.convert<String>(json['comment']);
  if (comment != null) {
    salaryDataMonthApplyRankRuleData.comment = comment;
  }
  return salaryDataMonthApplyRankRuleData;
}

Map<String, dynamic> $SalaryDataMonthApplyRankRuleDataToJson(
    SalaryDataMonthApplyRankRuleData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['title'] = entity.title;
  data['value'] = entity.value;
  data['comment'] = entity.comment;
  return data;
}

extension SalaryDataMonthApplyRankRuleDataExtension on SalaryDataMonthApplyRankRuleData {
  SalaryDataMonthApplyRankRuleData copyWith({
    String? title,
    String? value,
    String? comment,
  }) {
    return SalaryDataMonthApplyRankRuleData()
      ..title = title ?? this.title
      ..value = value ?? this.value
      ..comment = comment ?? this.comment;
  }
}

SalaryDataFeedbackBonusData $SalaryDataFeedbackBonusDataFromJson(
    Map<String, dynamic> json) {
  final SalaryDataFeedbackBonusData salaryDataFeedbackBonusData = SalaryDataFeedbackBonusData();
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    salaryDataFeedbackBonusData.title = title;
  }
  final String? value = jsonConvert.convert<String>(json['value']);
  if (value != null) {
    salaryDataFeedbackBonusData.value = value;
  }
  final String? comment = jsonConvert.convert<String>(json['comment']);
  if (comment != null) {
    salaryDataFeedbackBonusData.comment = comment;
  }
  return salaryDataFeedbackBonusData;
}

Map<String, dynamic> $SalaryDataFeedbackBonusDataToJson(
    SalaryDataFeedbackBonusData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['title'] = entity.title;
  data['value'] = entity.value;
  data['comment'] = entity.comment;
  return data;
}

extension SalaryDataFeedbackBonusDataExtension on SalaryDataFeedbackBonusData {
  SalaryDataFeedbackBonusData copyWith({
    String? title,
    String? value,
    String? comment,
  }) {
    return SalaryDataFeedbackBonusData()
      ..title = title ?? this.title
      ..value = value ?? this.value
      ..comment = comment ?? this.comment;
  }
}

SalaryDataFineData $SalaryDataFineDataFromJson(Map<String, dynamic> json) {
  final SalaryDataFineData salaryDataFineData = SalaryDataFineData();
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    salaryDataFineData.title = title;
  }
  final String? value1 = jsonConvert.convert<String>(json['value1']);
  if (value1 != null) {
    salaryDataFineData.value1 = value1;
  }
  final String? value2 = jsonConvert.convert<String>(json['value2']);
  if (value2 != null) {
    salaryDataFineData.value2 = value2;
  }
  final String? value3 = jsonConvert.convert<String>(json['value3']);
  if (value3 != null) {
    salaryDataFineData.value3 = value3;
  }
  final String? comment = jsonConvert.convert<String>(json['comment']);
  if (comment != null) {
    salaryDataFineData.comment = comment;
  }
  return salaryDataFineData;
}

Map<String, dynamic> $SalaryDataFineDataToJson(SalaryDataFineData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['title'] = entity.title;
  data['value1'] = entity.value1;
  data['value2'] = entity.value2;
  data['value3'] = entity.value3;
  data['comment'] = entity.comment;
  return data;
}

extension SalaryDataFineDataExtension on SalaryDataFineData {
  SalaryDataFineData copyWith({
    String? title,
    String? value1,
    String? value2,
    String? value3,
    String? comment,
  }) {
    return SalaryDataFineData()
      ..title = title ?? this.title
      ..value1 = value1 ?? this.value1
      ..value2 = value2 ?? this.value2
      ..value3 = value3 ?? this.value3
      ..comment = comment ?? this.comment;
  }
}
/// 模板分类
enum MessageTemplateCategory {
  marketing, // 营销
  review, // 审核
  collection, // 催收
}

/// 模板分类工具类
class MessageTemplateCategoryUtil {
  /// 获取分类显示名称
  static String getCategoryName(MessageTemplateCategory category) {
    switch (category) {
      case MessageTemplateCategory.marketing:
        return '营销';
      case MessageTemplateCategory.review:
        return '审核';
      case MessageTemplateCategory.collection:
        return '催收';
    }
  }

  /// 从字符串获取分类
  static MessageTemplateCategory? fromString(String? value) {
    switch (value) {
      case 'marketing':
        return MessageTemplateCategory.marketing;
      case 'review':
        return MessageTemplateCategory.review;
      case 'collection':
        return MessageTemplateCategory.collection;
      default:
        return null;
    }
  }

  /// 转换为字符串
  static String toValue(MessageTemplateCategory category) {
    switch (category) {
      case MessageTemplateCategory.marketing:
        return 'marketing';
      case MessageTemplateCategory.review:
        return 'review';
      case MessageTemplateCategory.collection:
        return 'collection';
    }
  }

  /// 获取所有分类列表
  static List<MessageTemplateCategory> getAllCategories() {
    return MessageTemplateCategory.values;
  }
}

/// 消息模板数据模型
class MessageTemplate {
  final int? id;
  final String title;
  final String message;
  final int availableDays;
  final MessageTemplateCategory category;

  MessageTemplate({
    this.id,
    required this.title,
    required this.message,
    required this.availableDays,
    required this.category,
  });

  /// 创建副本
  MessageTemplate copyWith({
    int? id,
    String? title,
    String? message,
    int? availableDays,
    MessageTemplateCategory? category,
  }) {
    return MessageTemplate(
      id: id ?? this.id,
      title: title ?? this.title,
      message: message ?? this.message,
      availableDays: availableDays ?? this.availableDays,
      category: category ?? this.category,
    );
  }

  /// 从JSON创建消息模板
  factory MessageTemplate.fromJson(Map<String, dynamic> json) {
    return MessageTemplate(
      id: json['id'] as int?,
      title: json['title'] as String? ?? '',
      message: json['message'] as String,
      availableDays: json['available_days'] as int,
      category:
          MessageTemplateCategoryUtil.fromString(json['category'] as String?) ??
              MessageTemplateCategory.marketing,
    );
  }

  /// 转换为JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'message': message,
      'available_days': availableDays,
      'category': MessageTemplateCategoryUtil.toValue(category),
    };
  }
}

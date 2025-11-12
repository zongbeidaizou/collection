/// 消息模板数据模型
class MessageTemplate {
  final int? id;
  final String title;
  final String message;
  final int availableDays;

  MessageTemplate({
    this.id,
    required this.title,
    required this.message,
    required this.availableDays,
  });

  /// 创建副本
  MessageTemplate copyWith({
    int? id,
    String? title,
    String? message,
    int? availableDays,
  }) {
    return MessageTemplate(
      id: id ?? this.id,
      title: title ?? this.title,
      message: message ?? this.message,
      availableDays: availableDays ?? this.availableDays,
    );
  }

  /// 从JSON创建消息模板
  factory MessageTemplate.fromJson(Map<String, dynamic> json) {
    return MessageTemplate(
      id: json['id'] as int?,
      title: json['title'] as String? ?? '',
      message: json['message'] as String,
      availableDays: json['available_days'] as int,
    );
  }

  /// 转换为JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'message': message,
      'available_days': availableDays,
    };
  }
}

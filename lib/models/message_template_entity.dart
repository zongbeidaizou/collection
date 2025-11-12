/// 消息模板数据模型
class MessageTemplate {
  final int? id;
  final String message;
  final int availableDays;

  MessageTemplate({
    this.id,
    required this.message,
    required this.availableDays,
  });

  /// 从JSON创建消息模板
  factory MessageTemplate.fromJson(Map<String, dynamic> json) {
    return MessageTemplate(
      id: json['id'] as int?,
      message: json['message'] as String,
      availableDays: json['available_days'] as int,
    );
  }

  /// 转换为JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'message': message,
      'available_days': availableDays,
    };
  }
}

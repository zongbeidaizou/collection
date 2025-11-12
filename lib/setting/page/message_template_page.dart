import 'package:flutter/material.dart';
import 'package:bounty_hunter/models/message_template_entity.dart';
import 'package:bounty_hunter/res/resources.dart';
import 'package:bounty_hunter/widgets/my_app_bar.dart';
import 'package:bounty_hunter/widgets/my_card.dart';

/// 消息模板页面
class MessageTemplatePage extends StatefulWidget {
  const MessageTemplatePage({super.key});

  @override
  State<MessageTemplatePage> createState() => _MessageTemplatePageState();
}

class _MessageTemplatePageState extends State<MessageTemplatePage> {
  final List<MessageTemplate> _templates = [];

  @override
  void initState() {
    super.initState();
    _loadTemplates();
  }

  /// 加载消息模板列表
  void _loadTemplates() {
    // TODO: 这里可以从本地存储或服务器加载数据
    // 目前使用示例数据
    setState(() {
      _templates.addAll([
        MessageTemplate(
          id: 1,
          message: '您好，您的订单已逾期，请及时处理。',
          availableDays: 30,
        ),
        MessageTemplate(
          id: 2,
          message: '提醒：您的还款日期即将到来，请提前准备。',
          availableDays: 15,
        ),
        MessageTemplate(
          id: 3,
          message: '感谢您的配合，如有疑问请联系客服。',
          availableDays: 7,
        ),
        MessageTemplate(
          id: 4,
          message: '您的账户有异常，请及时查看并处理。',
          availableDays: 60,
        ),
        MessageTemplate(
          id: 5,
          message: '恭喜您完成还款，期待下次合作。',
          availableDays: 90,
        ),
      ]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        centerTitle: 'Message Template',
      ),
      body: _templates.isEmpty
          ? Center(
              child: Text(
                'No message templates',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.only(
                  left: 16.0, right: 16.0, bottom: 16.0, top: 8.0),
              itemCount: _templates.length,
              itemBuilder: (context, index) {
                return Column(
                  children: <Widget>[
                    Gaps.vGap15,
                    _MessageTemplateItem(
                      template: _templates[index],
                    ),
                  ],
                );
              },
            ),
    );
  }
}

/// 消息模板列表项
class _MessageTemplateItem extends StatelessWidget {
  const _MessageTemplateItem({
    required this.template,
  });

  final MessageTemplate template;

  @override
  Widget build(BuildContext context) {
    return MyCard(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              template.message,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Gaps.vGap12,
            Gaps.line,
            Gaps.vGap12,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Available Days:',
                  style: TextStyles.textGray14,
                ),
                Text(
                  '${template.availableDays} days',
                  style: TextStyles.textBold14.copyWith(
                    color: Colours.app_main,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

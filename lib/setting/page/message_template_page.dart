import 'package:bounty_hunter/mvp/base_page.dart';
import 'package:bounty_hunter/setting/iview/message_template_page_iview.dart';
import 'package:bounty_hunter/setting/presenter/message_template_presenter.dart';
import 'package:flutter/material.dart';
import 'package:bounty_hunter/models/message_template_entity.dart';
import 'package:bounty_hunter/res/resources.dart';
import 'package:bounty_hunter/widgets/my_app_bar.dart';
import 'package:bounty_hunter/widgets/my_card.dart';
import 'add_message_template_page.dart';

/// 消息模板页面
class MessageTemplatePage extends StatefulWidget {
  const MessageTemplatePage({super.key});

  @override
  State<MessageTemplatePage> createState() => _MessageTemplatePageState();
}

class _MessageTemplatePageState extends State<MessageTemplatePage>
    with
        AutomaticKeepAliveClientMixin<MessageTemplatePage>,
        SingleTickerProviderStateMixin,
        BasePageMixin<MessageTemplatePage, MessageTemplatePresenter>
    implements MessageTemplatePageMvpView {
  final List<MessageTemplateData> _templates = [];
  late MessageTemplatePresenter _messageTemplatePresenter;
  final Map<int, String> _categoryMap = {
    0: 'Template for messages to borrowers',
    1: 'Template for messages to contacts',
    2: 'Template for marketing messages',
    3: 'Template for review messages',
  };

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _messageTemplatePresenter.index(1, true);
    });
  }

  /// 新增模板
  void _addTemplate() async {
    await Navigator.push<MessageTemplateData>(
      context,
      MaterialPageRoute(
        builder: (context) => const AddMessageTemplatePage(),
      ),
    );
  }

  /// 编辑模板
  void _editTemplate(MessageTemplateData template) async {
    await Navigator.push<MessageTemplateData>(
      context,
      MaterialPageRoute(
        builder: (context) => AddMessageTemplatePage(template: template),
      ),
    );
  }

  /// 删除模板
  void _deleteTemplate(MessageTemplateData template) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: Text(
              'Are you sure you want to delete template "${template.title}"?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                await _messageTemplatePresenter.delete(template.id!);
                setState(() {
                  _templates.removeWhere((t) => t.id == template.id);
                });
                Navigator.pop(context);
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: MyAppBar(
        centerTitle: 'Message Template',
        actionName: 'Add',
        onPressed: _addTemplate,
      ),
      body: _templates.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'No message templates',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
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
                      onEdit: () => _editTemplate(_templates[index]),
                      onDelete: () => _deleteTemplate(_templates[index]),
                      categoryMap: _categoryMap,
                    ),
                  ],
                );
              },
            ),
    );
  }

  @override
  MessageTemplatePresenter createPresenter() {
    // TODO: implement createPresenter
    _messageTemplatePresenter = MessageTemplatePresenter();
    return _messageTemplatePresenter;
  }

  @override
  void onRefresh() {
    // TODO: implement onRefresh
  }

  @override
  void setCurrentPage(int currentPage) {
    // TODO: implement setCurrentPage
  }

  @override
  void setData(List<MessageTemplateData> logs, {bool clear = false}) {
    // TODO: implement setLogs
    _templates.clear();
    _templates.addAll(logs);
    setState(() {});
  }

  @override
  void setPageSize(int pageSize) {
    // TODO: implement setPageSize
  }

  @override
  void setTemplates(List<String> templates, String url) {
    // TODO: implement setTemplates
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

/// 消息模板列表项
class _MessageTemplateItem extends StatelessWidget {
  const _MessageTemplateItem({
    required this.template,
    this.onEdit,
    this.onDelete,
    required this.categoryMap,
  });

  final MessageTemplateData template;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final Map<int, String> categoryMap;

  @override
  Widget build(BuildContext context) {
    final String originalMessage = template.message ?? '';
    final String previewMessage =
        originalMessage.isEmpty ? '' : replacePlaceholders(originalMessage);

    return MyCard(
      child: InkWell(
        onTap: onEdit,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        Text(
                          template.title ?? '',
                          style: TextStyles.textBold16,
                        ),
                        Gaps.hGap8,
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8.0,
                            vertical: 4.0,
                          ),
                          decoration: BoxDecoration(
                            color: Colours.app_main.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Text(
                            categoryMap[template.category ?? 0] ?? '',
                            style: TextStyles.textSize12.copyWith(
                              color: Colours.app_main,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'edit') {
                        onEdit?.call();
                      } else if (value == 'delete') {
                        onDelete?.call();
                      }
                    },
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<String>>[
                      const PopupMenuItem<String>(
                        value: 'edit',
                        child: Text('Edit'),
                      ),
                      const PopupMenuItem<String>(
                        value: 'delete',
                        child: Text('Delete'),
                      ),
                    ],
                  ),
                ],
              ),
              Gaps.vGap8,
              Text(
                originalMessage,
                style: Theme.of(context).textTheme.bodySmall,
                maxLines: 6,
                overflow: TextOverflow.ellipsis,
              ),
              if (previewMessage.isNotEmpty) ...[
                Gaps.vGap12,
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Colours.app_main.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(6.0),
                    border: Border.all(
                      color: Colours.app_main.withOpacity(0.2),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Preview (placeholders replaced):',
                        style: TextStyles.textGray12,
                      ),
                      Gaps.vGap4,
                      Text(
                        previewMessage,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colours.text,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
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
                    '${template.availableDays ?? 0} days',
                    style: TextStyles.textBold14.copyWith(
                      color: Colours.app_main,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

const Map<String, String> _placeholderExampleValues = {
  '@app_name@': 'Leading Loan',
  '@name@': 'John Doe',
  '@bvn@': '22261764186',
  '@mobile@': '7038875111',
  '@borrow_amount@': '₦100,000',
  '@expect_repay_amount@': '₦25,000',
  '@expect_repay_time@': 'Nov 26, 2025',
  '@overdue_days@': '10',
  '@url@': 'https://moimoi.xin',
  '@account_name@': 'John Doe',
  '@account_no@': '6698028745',
  '@account_bank@': 'Access Bank',
};

String replacePlaceholders(String message) {
  String preview = message;
  _placeholderExampleValues.forEach((key, value) {
    preview = preview.replaceAll(key, value);
  });
  return preview;
}

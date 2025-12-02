import 'package:bounty_hunter/mvp/base_page.dart';
import 'package:bounty_hunter/setting/iview/message_template_page_iview.dart';
import 'package:bounty_hunter/setting/presenter/message_template_presenter.dart';
import 'package:flutter/material.dart';
import 'package:bounty_hunter/models/message_template_entity.dart';
import 'package:bounty_hunter/res/resources.dart';
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
    26: 'Messages to borrowers',
    28: 'Messages to contacts',
    25: 'marketing messages',
    32: 'review messages',
  };
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _categoryMap.length, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _messageTemplatePresenter.index(1, true);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.black,
        ),
        title: const Text('Message Template'),
        actions: [
          TextButton(
            onPressed: _addTemplate,
            child: const Text('Add'),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          labelColor: Colours.app_main,
          unselectedLabelColor: Colours.text_gray,
          indicatorColor: Colours.app_main,
          tabs: _categoryMap.values.map((label) => Tab(text: label)).toList(),
        ),
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
          : TabBarView(
              controller: _tabController,
              children: _categoryMap.keys.map((categoryKey) {
                final List<MessageTemplateData> filtered =
                    _templates.where((t) => t.category == categoryKey).toList();
                if (filtered.isEmpty) {
                  return Center(
                    child: Text(
                      'No templates in this category',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.only(
                      left: 16.0, right: 16.0, bottom: 16.0, top: 8.0),
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    final template = filtered[index];
                    return Column(
                      children: <Widget>[
                        Gaps.vGap15,
                        _MessageTemplateItem(
                          template: template,
                          onEdit: () => _editTemplate(template),
                          onDelete: () => _deleteTemplate(template),
                          categoryMap: _categoryMap,
                        ),
                      ],
                    );
                  },
                );
              }).toList(),
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
      shadowColor: Colors.blueAccent,
      child: InkWell(
        onTap: onEdit,
        child: Padding(
          padding: const EdgeInsets.all(6.0),
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
              _buildMessageWithPlaceholders(
                context,
                originalMessage,
                maxLines: 6,
              ),
              if (previewMessage.isNotEmpty) ...[
                Gaps.vGap8,
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
                      _buildPreviewWithHighlightedValues(
                        context,
                        originalMessage,
                        previewMessage,
                      ),
                    ],
                  ),
                ),
              ],
              Gaps.vGap4,
              Gaps.line,
              Gaps.vGap4,
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

  /// 构建带有占位符高亮的消息文本
  Widget _buildMessageWithPlaceholders(
    BuildContext context,
    String message, {
    int maxLines = 6,
  }) {
    if (message.isEmpty) {
      return const SizedBox.shrink();
    }

    // 匹配占位符的正则表达式：@xxx@
    final RegExp placeholderPattern = RegExp(r'@\w+@');
    final List<TextSpan> spans = [];
    int lastIndex = 0;

    for (final Match match in placeholderPattern.allMatches(message)) {
      // 添加占位符之前的普通文本
      if (match.start > lastIndex) {
        spans.add(TextSpan(
          text: message.substring(lastIndex, match.start),
          style: Theme.of(context).textTheme.bodySmall,
        ));
      }

      // 添加占位符（红色加粗）
      spans.add(TextSpan(
        text: match.group(0),
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
      ));

      lastIndex = match.end;
    }

    // 添加剩余的普通文本
    if (lastIndex < message.length) {
      spans.add(TextSpan(
        text: message.substring(lastIndex),
        style: Theme.of(context).textTheme.bodySmall,
      ));
    }

    return RichText(
      text: TextSpan(children: spans),
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
    );
  }

  /// 构建预览文本，将被替换的占位符值用蓝色加粗显示
  Widget _buildPreviewWithHighlightedValues(
    BuildContext context,
    String originalMessage,
    String previewMessage,
  ) {
    if (previewMessage.isEmpty) {
      return const SizedBox.shrink();
    }

    // 匹配占位符的正则表达式：@xxx@
    final RegExp placeholderPattern = RegExp(r'@\w+@');
    final List<Match> placeholderMatches =
        placeholderPattern.allMatches(originalMessage).toList();

    // 如果没有占位符，直接返回普通文本
    if (placeholderMatches.isEmpty) {
      return Text(
        previewMessage,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colours.text,
            ),
      );
    }

    // 构建替换值列表（按顺序），并记录每个替换值在原始消息中的位置
    final List<MapEntry<String, int>> replacements = [];
    for (final Match match in placeholderMatches) {
      final String placeholder = match.group(0)!;
      final String? replacement = _placeholderExampleValues[placeholder];
      if (replacement != null && replacement.isNotEmpty) {
        replacements.add(MapEntry(replacement, match.start));
      }
    }

    if (replacements.isEmpty) {
      return Text(
        previewMessage,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colours.text,
            ),
      );
    }

    // 在预览消息中查找并标记替换值（按顺序）
    final List<TextSpan> spans = [];
    int lastIndex = 0;

    for (final MapEntry<String, int> replacement in replacements) {
      final String value = replacement.key;
      final int foundIndex = previewMessage.indexOf(value, lastIndex);

      if (foundIndex != -1) {
        // 添加替换值之前的普通文本
        if (foundIndex > lastIndex) {
          spans.add(TextSpan(
            text: previewMessage.substring(lastIndex, foundIndex),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colours.text,
                ),
          ));
        }

        // 添加替换值（蓝色加粗）
        spans.add(TextSpan(
          text: value,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
        ));

        lastIndex = foundIndex + value.length;
      }
    }

    // 添加剩余的普通文本
    if (lastIndex < previewMessage.length) {
      spans.add(TextSpan(
        text: previewMessage.substring(lastIndex),
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colours.text,
            ),
      ));
    }

    // 如果没有生成任何 spans，返回普通文本
    if (spans.isEmpty) {
      return Text(
        previewMessage,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colours.text,
            ),
      );
    }

    return RichText(
      text: TextSpan(children: spans),
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

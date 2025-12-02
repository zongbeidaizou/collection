import 'package:bounty_hunter/models/collection_notification_entity.dart';
import 'package:bounty_hunter/mvp/base_page.dart';
import 'package:bounty_hunter/setting/iview/message_template_page_iview.dart';
import 'package:bounty_hunter/setting/presenter/message_template_presenter.dart';
import 'package:bounty_hunter/setting/setting_router.dart';
import 'package:bounty_hunter/shop/iview/message_page_iview.dart';
import 'package:bounty_hunter/shop/presenter/message_presenter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bounty_hunter/models/message_template_entity.dart';
import 'package:bounty_hunter/res/resources.dart';
import 'package:bounty_hunter/widgets/my_app_bar.dart';
import 'package:bounty_hunter/widgets/my_button.dart';
import 'package:bounty_hunter/widgets/my_card.dart';
import 'package:bounty_hunter/routers/fluro_navigator.dart';

/// 占位符定义
class Placeholder {
  final String key;
  final String label;
  final String exampleValue;

  const Placeholder({
    required this.key,
    required this.label,
    required this.exampleValue,
  });
}

/// 预定义的占位符列表
final List<Placeholder> availablePlaceholders = [
  const Placeholder(
      key: '@app_name@', label: 'App Name', exampleValue: 'Leading Loan'),
  const Placeholder(key: '@name@', label: 'Cx name', exampleValue: 'John Doe'),
  const Placeholder(key: '@bvn@', label: 'Cx bvn', exampleValue: '22261764186'),
  const Placeholder(
      key: '@mobile@', label: 'Cx mobile', exampleValue: '7038875111'),
  const Placeholder(
      key: '@borrow_amount@', label: 'Borrow Amount', exampleValue: '₦100,000'),
  const Placeholder(
      key: '@expect_repay_amount@',
      label: 'Expect Repay Amount',
      exampleValue: '₦25,000'),
  const Placeholder(
      key: '@expect_repay_time@',
      label: 'Expect Repay Time',
      exampleValue: 'Nov 26, 2025'),
  const Placeholder(
      key: '@overdue_days@', label: 'Overdue Days', exampleValue: '10'),
  const Placeholder(
      key: '@url@', label: 'Download Link', exampleValue: 'https://moimoi.xin'),
  const Placeholder(
      key: '@account_name@', label: 'Account Name', exampleValue: 'John Doe'),
  const Placeholder(
      key: '@account_no@', label: 'Account No', exampleValue: '6698028745'),
  const Placeholder(
      key: '@account_bank@',
      label: 'Account Bank',
      exampleValue: 'Access Bank'),
];

/// 新增/编辑消息模板页面
class AddMessageTemplatePage extends StatefulWidget {
  const AddMessageTemplatePage({
    super.key,
    this.template,
  });

  /// 如果提供template，则为编辑模式；否则为新增模式
  final MessageTemplateData? template;

  @override
  State<AddMessageTemplatePage> createState() => _AddMessageTemplatePageState();
}

class _AddMessageTemplatePageState extends State<AddMessageTemplatePage>
    with
        AutomaticKeepAliveClientMixin<AddMessageTemplatePage>,
        SingleTickerProviderStateMixin,
        BasePageMixin<AddMessageTemplatePage, MessageTemplatePresenter>
    implements MessageTemplatePageMvpView {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _daysController = TextEditingController();
  final FocusNode _contentFocusNode = FocusNode();
  late MessageTemplateData? _template;
  int _selectedCategory = 0;
  final Map<int, String> _categoryMap = {
    26: 'Template for messages to borrowers',
    28: 'Template for messages to contacts',
    25: 'Template for marketing messages',
    32: 'Template for review messages',
  };
  late MessageTemplatePresenter _messageTemplatePresenter;

  @override
  void initState() {
    super.initState();
    // 从widget获取template
    _template = widget.template;
    // 如果是编辑模式，填充现有数据
    if (_template != null) {
      _titleController.text = _template!.title ?? '';
      _contentController.text = _template!.message ?? '';
      _daysController.text = _template!.availableDays.toString();
      _selectedCategory = _template!.category ?? 0;
    }
    // 监听内容变化，更新预览
    _contentController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _daysController.dispose();
    _contentFocusNode.dispose();
    super.dispose();
  }

  /// 插入占位符到内容中
  void _insertPlaceholder(Placeholder placeholder) {
    final String text = _contentController.text;
    final TextSelection selection = _contentController.selection;
    final String newText = text.replaceRange(
      selection.start,
      selection.end,
      placeholder.key,
    );
    _contentController.text = newText;
    // 设置光标位置到插入的占位符之后
    final int newPosition = selection.start + placeholder.key.length;
    _contentController.selection = TextSelection.collapsed(offset: newPosition);
    // 重新聚焦到内容输入框
    _contentFocusNode.requestFocus();
  }

  /// 显示占位符选择对话框
  void _showPlaceholderDialog() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.88,
          padding: EdgeInsets.only(
            top: 16,
            left: 16,
            right: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Select Placeholder',
                style: TextStyles.textBold18,
              ),
              Gaps.vGap8,
              Expanded(
                child: ListView.builder(
                  itemCount: availablePlaceholders.length,
                  itemBuilder: (context, index) {
                    final placeholder = availablePlaceholders[index];
                    return InkWell(
                      onTap: () {
                        _insertPlaceholder(placeholder);
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 8.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    placeholder.label,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  Gaps.vGap4,
                                  Text(
                                    '${placeholder.key} (Example: ${placeholder.exampleValue})',
                                    style: TextStyles.textGray12,
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              Icons.chevron_right,
                              color: Theme.of(context)
                                  .iconTheme
                                  .color
                                  ?.withOpacity(0.5),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// 替换占位符为示例值，用于预览
  String _getPreviewText() {
    String previewText = _contentController.text;
    for (final placeholder in availablePlaceholders) {
      previewText =
          previewText.replaceAll(placeholder.key, placeholder.exampleValue);
    }
    return previewText;
  }

  /// 构建预览文本，将被替换的占位符值用蓝色加粗显示
  Widget _buildPreviewWithHighlightedValues(
    BuildContext context,
    String originalMessage,
  ) {
    if (originalMessage.isEmpty) {
      return const SizedBox.shrink();
    }

    // 生成预览文本
    String previewMessage = originalMessage;
    for (final placeholder in availablePlaceholders) {
      previewMessage =
          previewMessage.replaceAll(placeholder.key, placeholder.exampleValue);
    }

    // 匹配占位符的正则表达式：@xxx@
    final RegExp placeholderPattern = RegExp(r'@\w+@');
    final List<Match> placeholderMatches =
        placeholderPattern.allMatches(originalMessage).toList();

    // 如果没有占位符，直接返回普通文本
    if (placeholderMatches.isEmpty) {
      return Text(
        previewMessage,
        style: Theme.of(context).textTheme.bodyMedium,
      );
    }

    // 构建替换值列表（按顺序），并记录每个替换值在原始消息中的位置
    final List<MapEntry<String, int>> replacements = [];
    for (final Match match in placeholderMatches) {
      final String placeholder = match.group(0)!;
      try {
        final Placeholder placeholderObj = availablePlaceholders.firstWhere(
          (p) => p.key == placeholder,
        );
        if (placeholderObj.exampleValue.isNotEmpty) {
          replacements.add(MapEntry(placeholderObj.exampleValue, match.start));
        }
      } catch (e) {
        // 如果找不到对应的占位符，跳过
        continue;
      }
    }

    if (replacements.isEmpty) {
      return Text(
        previewMessage,
        style: Theme.of(context).textTheme.bodyMedium,
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
            style: Theme.of(context).textTheme.bodyMedium,
          ));
        }

        // 添加替换值（蓝色加粗）
        spans.add(TextSpan(
          text: value,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
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
        style: Theme.of(context).textTheme.bodyMedium,
      ));
    }

    // 如果没有生成任何 spans，返回普通文本
    if (spans.isEmpty) {
      return Text(
        previewMessage,
        style: Theme.of(context).textTheme.bodyMedium,
      );
    }

    return RichText(
      text: TextSpan(children: spans),
    );
  }

  /// 保存模板
  void _saveTemplate() async {
    final String title = _titleController.text.trim();
    final String content = _contentController.text.trim();
    final String daysText = _daysController.text.trim();

    if (title.isEmpty) {
      _showErrorDialog('Please enter title');
      return;
    }

    if (content.isEmpty) {
      _showErrorDialog('Please enter content');
      return;
    }

    if (daysText.isEmpty) {
      _showErrorDialog('Please enter available days');
      return;
    }

    final int? days = int.tryParse(daysText);
    if (days == null) {
      _showErrorDialog('Available days must be a number greater than 0');
      return;
    }

    // 验证必须包含 @app_name@ 和 @name@
    if (!content.contains('@app_name@')) {
      _showErrorDialog('Content must include @app_name@ placeholder');
      return;
    }

    if (!content.contains('@name@')) {
      _showErrorDialog('Content must include @name@ placeholder');
      return;
    }

    // 验证 @url@ 前后必须有空格
    if (content.contains('@url@')) {
      final RegExp urlPattern = RegExp(r'@url@');
      final Iterable<Match> matches = urlPattern.allMatches(content);
      for (final Match match in matches) {
        final int startIndex = match.start;
        final int endIndex = match.end;

        // 检查前面是否有空格（或字符串开头）
        final bool hasSpaceBefore = startIndex == 0 ||
            content[startIndex - 1] == ' ' ||
            content[startIndex - 1] == '\n';

        // 检查后面是否有空格（或字符串结尾）
        final bool hasSpaceAfter = endIndex >= content.length ||
            content[endIndex] == ' ' ||
            content[endIndex] == '\n';

        if (!hasSpaceBefore || !hasSpaceAfter) {
          _showErrorDialog(
              '@url@ placeholder must have spaces before and after it');
          return;
        }
      }
    }

    if (widget.template != null) {
      await _messageTemplatePresenter.update(
          widget.template!.id!, title, content, days, _selectedCategory);
      NavigatorUtils.push(context, SettingRouter.messageTemplatePage,
          replace: true);
    } else {
      await _messageTemplatePresenter.store(
          title, content, days, _selectedCategory);
      NavigatorUtils.push(context, SettingRouter.messageTemplatePage,
          replace: true);
    }
  }

  /// 显示错误对话框
  void _showErrorDialog(String message) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Notice'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  /// 显示分类选择对话框
  void _showCategoryDialog() {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Category'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: _categoryMap.entries.map((entry) {
              return RadioListTile<int>(
                title: Text(entry.value),
                value: entry.key,
                groupValue: _selectedCategory,
                onChanged: (int? value) {
                  if (value != null) {
                    setState(() {
                      _selectedCategory = value;
                    });
                    Navigator.pop(context);
                  }
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        centerTitle: _template == null ? 'Add Template' : 'Edit Template',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // 分类选择
            MyCard(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Category',
                      style: TextStyles.textBold14,
                    ),
                    Gaps.vGap8,
                    InkWell(
                      onTap: _showCategoryDialog,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 16.0,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).dividerColor,
                          ),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              _categoryMap[_selectedCategory] ?? '',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Icon(
                              Icons.arrow_drop_down,
                              color: Theme.of(context).iconTheme.color,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Gaps.vGap8,
            // 标题输入
            MyCard(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Title',
                      style: TextStyles.textBold14,
                    ),
                    Gaps.vGap8,
                    TextField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                        hintText: 'Please enter title',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 8.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Gaps.vGap8,

            // 可用天数输入
            MyCard(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Available Days',
                      style: TextStyles.textBold14,
                    ),
                    Gaps.vGap8,
                    TextField(
                      controller: _daysController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: const InputDecoration(
                        hintText: 'Please enter available days',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 8.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Gaps.vGap8,

            // 内容输入
            MyCard(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Content',
                          style: TextStyles.textBold14,
                        ),
                        TextButton.icon(
                          onPressed: _showPlaceholderDialog,
                          icon: const Icon(Icons.tag, size: 18),
                          label: const Text('Select Placeholder'),
                        ),
                      ],
                    ),
                    Gaps.vGap8,
                    TextField(
                      controller: _contentController,
                      focusNode: _contentFocusNode,
                      maxLines: 5,
                      decoration: const InputDecoration(
                        hintText:
                            'Please enter content, you can use placeholders',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(12.0),
                      ),
                    ),
                    Gaps.vGap12,
                    // 预览区域
                    Container(
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: Theme.of(context).dividerColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4.0),
                        border: Border.all(
                          color:
                              Theme.of(context).dividerColor.withOpacity(0.3),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Preview:',
                            style: TextStyles.textGray14,
                          ),
                          Gaps.vGap8,
                          _contentController.text.isEmpty
                              ? Text(
                                  '(No content)',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                )
                              : _buildPreviewWithHighlightedValues(
                                  context, _contentController.text),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Gaps.vGap8,

            // 保存按钮
            MyButton(
              text: 'Save',
              onPressed: _saveTemplate,
            ),
            Gaps.vGap8,
          ],
        ),
      ),
    );
  }

  @override
  MessageTemplatePresenter createPresenter() {
    _messageTemplatePresenter = MessageTemplatePresenter();
    return _messageTemplatePresenter;
  }

  @override
  void onRefresh() {}

  @override
  void setCurrentPage(int currentPage) {}

  @override
  void setPageSize(int pageSize) {}

  @override
  bool get wantKeepAlive => false;

  @override
  void setData(List<MessageTemplateData> logs, {bool clear = false}) {}

  @override
  void setTemplates(List<String> templates, String url) {}
}

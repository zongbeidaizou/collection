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
  const Placeholder(key: '@name@', label: '姓名', exampleValue: '张三'),
  const Placeholder(key: '@age@', label: '年龄', exampleValue: '25'),
  const Placeholder(key: '@gender@', label: '性别', exampleValue: '男'),
  const Placeholder(key: '@phone@', label: '电话', exampleValue: '13800138000'),
  const Placeholder(
      key: '@email@', label: '邮箱', exampleValue: 'example@email.com'),
  const Placeholder(key: '@amount@', label: '金额', exampleValue: '1000'),
  const Placeholder(key: '@date@', label: '日期', exampleValue: '2024-01-01'),
  const Placeholder(key: '@orderId@', label: '订单号', exampleValue: 'ORD123456'),
];

/// 新增/编辑消息模板页面
class AddMessageTemplatePage extends StatefulWidget {
  const AddMessageTemplatePage({
    super.key,
    this.template,
  });

  /// 如果提供template，则为编辑模式；否则为新增模式
  final MessageTemplate? template;

  @override
  State<AddMessageTemplatePage> createState() => _AddMessageTemplatePageState();
}

class _AddMessageTemplatePageState extends State<AddMessageTemplatePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _daysController = TextEditingController();
  final FocusNode _contentFocusNode = FocusNode();
  late MessageTemplate? _template;
  MessageTemplateCategory _selectedCategory = MessageTemplateCategory.marketing;

  @override
  void initState() {
    super.initState();
    // 从widget获取template
    _template = widget.template;
    // 如果是编辑模式，填充现有数据
    if (_template != null) {
      _titleController.text = _template!.title;
      _contentController.text = _template!.message;
      _daysController.text = _template!.availableDays.toString();
      _selectedCategory = _template!.category;
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
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return Container(
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
                '选择占位符',
                style: TextStyles.textBold18,
              ),
              Gaps.vGap8,
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
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
                                    '${placeholder.key} (示例: ${placeholder.exampleValue})',
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

  /// 保存模板
  void _saveTemplate() {
    final String title = _titleController.text.trim();
    final String content = _contentController.text.trim();
    final String daysText = _daysController.text.trim();

    if (title.isEmpty) {
      _showErrorDialog('请输入标题');
      return;
    }

    if (content.isEmpty) {
      _showErrorDialog('请输入内容');
      return;
    }

    if (daysText.isEmpty) {
      _showErrorDialog('请输入可用天数');
      return;
    }

    final int? days = int.tryParse(daysText);
    if (days == null || days <= 0) {
      _showErrorDialog('可用天数必须是大于0的数字');
      return;
    }

    final MessageTemplate template = MessageTemplate(
      id: _template?.id,
      title: title,
      message: content,
      availableDays: days,
      category: _selectedCategory,
    );

    // 返回结果
    NavigatorUtils.goBackWithParams(context, template);
  }

  /// 显示错误对话框
  void _showErrorDialog(String message) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('提示'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('确定'),
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
          title: const Text('选择分类'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children:
                MessageTemplateCategoryUtil.getAllCategories().map((category) {
              return RadioListTile<MessageTemplateCategory>(
                title:
                    Text(MessageTemplateCategoryUtil.getCategoryName(category)),
                value: category,
                groupValue: _selectedCategory,
                onChanged: (MessageTemplateCategory? value) {
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
                      '分类',
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
                              MessageTemplateCategoryUtil.getCategoryName(
                                  _selectedCategory),
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
                      '标题',
                      style: TextStyles.textBold14,
                    ),
                    Gaps.vGap8,
                    TextField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                        hintText: '请输入标题',
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
                      '可用天数',
                      style: TextStyles.textBold14,
                    ),
                    Gaps.vGap8,
                    TextField(
                      controller: _daysController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: const InputDecoration(
                        hintText: '请输入可用天数',
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
                          '内容',
                          style: TextStyles.textBold14,
                        ),
                        TextButton.icon(
                          onPressed: _showPlaceholderDialog,
                          icon: const Icon(Icons.tag, size: 18),
                          label: const Text('选择占位符'),
                        ),
                      ],
                    ),
                    Gaps.vGap8,
                    TextField(
                      controller: _contentController,
                      focusNode: _contentFocusNode,
                      maxLines: 5,
                      decoration: const InputDecoration(
                        hintText: '请输入内容，可以使用占位符',
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
                            '预览效果:',
                            style: TextStyles.textGray14,
                          ),
                          Gaps.vGap8,
                          Text(
                            _contentController.text.isEmpty
                                ? '（暂无内容）'
                                : _getPreviewText(),
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
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
              text: '保存',
              onPressed: _saveTemplate,
            ),
            Gaps.vGap8,
          ],
        ),
      ),
    );
  }
}

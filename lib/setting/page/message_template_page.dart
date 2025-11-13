import 'package:bounty_hunter/models/marketing_entity.dart';
import 'package:bounty_hunter/mvp/base_page.dart';
import 'package:bounty_hunter/setting/iview/message_template_page_iview.dart';
import 'package:bounty_hunter/setting/presenter/message_template_presenter.dart';
import 'package:flutter/material.dart';
import 'package:bounty_hunter/models/message_template_entity.dart';
import 'package:bounty_hunter/res/resources.dart';
import 'package:bounty_hunter/widgets/my_app_bar.dart';
import 'package:bounty_hunter/widgets/my_button.dart';
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
  final List<MessageTemplate> _templates = [];
  late MessageTemplatePresenter _messageTemplatePresenter;

  @override
  void initState() {
    super.initState();
    _loadTemplates();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _messageTemplatePresenter.index(1, true);
    });
  }

  /// 加载消息模板列表
  void _loadTemplates() {
    // TODO: 这里可以从本地存储或服务器加载数据
    // 目前使用示例数据
    setState(() {
      _templates.addAll([
        MessageTemplate(
          id: 1,
          title: '逾期提醒',
          message: '您好，@name@，您的订单已逾期，请及时处理。',
          availableDays: 30,
          category: MessageTemplateCategory.collection,
        ),
        MessageTemplate(
          id: 2,
          title: '还款提醒',
          message: '提醒：@name@，您的还款日期即将到来，请提前准备。',
          availableDays: 15,
          category: MessageTemplateCategory.collection,
        ),
        MessageTemplate(
          id: 3,
          title: '感谢消息',
          message: '感谢@name@的配合，如有疑问请联系客服。',
          availableDays: 7,
          category: MessageTemplateCategory.marketing,
        ),
        MessageTemplate(
          id: 4,
          title: '账户异常',
          message: '@name@，您的账户有异常，请及时查看并处理。',
          availableDays: 60,
          category: MessageTemplateCategory.review,
        ),
        MessageTemplate(
          id: 5,
          title: '还款完成',
          message: '恭喜@name@完成还款，期待下次合作。',
          availableDays: 90,
          category: MessageTemplateCategory.marketing,
        ),
      ]);
    });
  }

  /// 新增模板
  void _addTemplate() async {
    final MessageTemplate? result = await Navigator.push<MessageTemplate>(
      context,
      MaterialPageRoute(
        builder: (context) => const AddMessageTemplatePage(),
      ),
    );
    if (result != null && mounted) {
      setState(() {
        // 生成新的ID
        final int newId = _templates.isEmpty
            ? 1
            : (_templates
                    .map((t) => t.id ?? 0)
                    .reduce((a, b) => a > b ? a : b) +
                1);
        _templates.add(result.copyWith(id: newId));
      });
    }
  }

  /// 编辑模板
  void _editTemplate(MessageTemplate template) async {
    final MessageTemplate? result = await Navigator.push<MessageTemplate>(
      context,
      MaterialPageRoute(
        builder: (context) => AddMessageTemplatePage(template: template),
      ),
    );
    if (result != null && mounted) {
      setState(() {
        final int index = _templates.indexWhere((t) => t.id == template.id);
        if (index != -1) {
          _templates[index] = result;
        }
      });
    }
  }

  /// 删除模板
  void _deleteTemplate(MessageTemplate template) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('确认删除'),
          content: Text('确定要删除模板"${template.title}"吗？'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('取消'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _templates.removeWhere((t) => t.id == template.id);
                });
                Navigator.pop(context);
              },
              child: const Text('删除'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        centerTitle: 'Message Template',
        actionName: '新增',
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
                  Gaps.vGap16,
                  MyButton(
                    text: '新增模板',
                    onPressed: _addTemplate,
                    minWidth: 120,
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
  void setData(List<MarketingData> logs, {bool clear = false}) {
    // TODO: implement setLogs
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
  });

  final MessageTemplate template;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
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
                          template.title,
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
                            MessageTemplateCategoryUtil.getCategoryName(
                                template.category),
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
                        child: Text('编辑'),
                      ),
                      const PopupMenuItem<String>(
                        value: 'delete',
                        child: Text('删除'),
                      ),
                    ],
                  ),
                ],
              ),
              Gaps.vGap8,
              Text(
                template.message,
                style: Theme.of(context).textTheme.bodyMedium,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
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
      ),
    );
  }
}

import 'package:bounty_hunter/models/salary_entity.dart';
import 'package:bounty_hunter/net/net.dart';
import 'package:bounty_hunter/widgets/my_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

class SalaryDetailPage extends StatefulWidget {
  const SalaryDetailPage({super.key});

  @override
  State<SalaryDetailPage> createState() => _SalaryDetailPageState();
}

class _SalaryDetailPageState extends State<SalaryDetailPage> {
  SalaryData? _salary;
  bool _loading = true;
  final TextEditingController _adminSearchController = TextEditingController();
  int? _selectedAdminId;
  List<SalaryDataAdmins> _adminList = <SalaryDataAdmins>[];
  List<SalaryDataAdmins> _filteredAdminList = <SalaryDataAdmins>[];
  OverlayEntry? _adminDropdownEntry;
  final LayerLink _adminLayerLink = LayerLink();
  final GlobalKey _adminFieldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _loadSalary();
  }

  @override
  void dispose() {
    _hideAdminDropdown();
    _adminSearchController.dispose();
    super.dispose();
  }

  Future<void> _loadSalary({int? adminId}) async {
    setState(() {
      _loading = true;
    });

    await DioUtils.instance.requestNetwork<SalaryEntity>(
      Method.get,
      HttpApi.salary,
      queryParameters: adminId != null ? {'admin_id': adminId} : null,
      onSuccess: (SalaryEntity? entity) async {
        if (!mounted) return;
        setState(() {
          _salary = entity?.data;
          _adminList = entity?.data?.admins ?? <SalaryDataAdmins>[];
          _filteredAdminList = List<SalaryDataAdmins>.from(_adminList);
          _loading = false;
        });
        if (_salary == null) {
          showToast('No salary data.');
        }
      },
      onError: (_, String msg) {
        if (!mounted) return;
        setState(() {
          _loading = false;
        });
        showToast(msg.isNotEmpty ? msg : 'Failed to load salary.');
      },
    );
  }

  void _hideAdminDropdown() {
    _adminDropdownEntry?.remove();
    _adminDropdownEntry = null;
  }

  void _filterAdmins(String keyword) {
    final String lower = keyword.trim().toLowerCase();
    setState(() {
      _filteredAdminList = lower.isEmpty
          ? List<SalaryDataAdmins>.from(_adminList)
          : _adminList
              .where((SalaryDataAdmins item) =>
                  (item.aName ?? '').toLowerCase().contains(lower))
              .toList();
    });
    _adminDropdownEntry?.markNeedsBuild();
  }

  Future<void> _selectAdmin(SalaryDataAdmins admin) async {
    _selectedAdminId = admin.id;
    _adminSearchController.text = admin.aName ?? '';
    _hideAdminDropdown();
    await _loadSalary(adminId: admin.id);
  }

  void _showAdminDropdown() {
    if (_adminDropdownEntry != null) {
      _adminDropdownEntry!.remove();
    }

    final BuildContext? fieldContext = _adminFieldKey.currentContext;
    if (fieldContext == null) return;

    final RenderBox box = fieldContext.findRenderObject() as RenderBox;
    final Size size = box.size;
    final Offset offset = box.localToGlobal(Offset.zero);

    _adminDropdownEntry = OverlayEntry(
      builder: (BuildContext context) {
        return Positioned(
          left: offset.dx,
          top: offset.dy + size.height + 4,
          width: size.width,
          child: Material(
            elevation: 6,
            borderRadius: BorderRadius.circular(12),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 280),
              child: _filteredAdminList.isEmpty
                  ? const Padding(
                      padding: EdgeInsets.all(12),
                      child: Text('No admins found.'),
                    )
                  : ListView.separated(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemBuilder: (BuildContext context, int index) {
                        final SalaryDataAdmins admin = _filteredAdminList[index];
                        return ListTile(
                          title: Text(admin.aName ?? '-'),
                          onTap: () => _selectAdmin(admin),
                        );
                      },
                      separatorBuilder: (_, __) => const Divider(height: 1),
                      itemCount: _filteredAdminList.length,
                    ),
            ),
          ),
        );
      },
    );

    Overlay.of(context).insert(_adminDropdownEntry!);
  }

  Widget _sectionTitle(String text, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 16,
            decoration: BoxDecoration(
              color: color ?? Colors.indigo,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionCard({
    required Widget child,
    Color? borderColor,
    Color? backgroundColor,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: backgroundColor ?? Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor ?? Colors.indigo.withOpacity(0.15)),
      ),
      child: child,
    );
  }

  Widget _dataRow(String title, int value, String comment) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.indigo.withOpacity(0.04),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.indigo.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  value.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.indigo,
                  ),
                ),
              ),
            ],
          ),
          if (comment.trim().isNotEmpty) ...<Widget>[
            const SizedBox(height: 6),
            Text(
              comment,
              style: TextStyle(color: Colors.grey[700], fontSize: 12),
            ),
          ],
        ],
      ),
    );
  }

  Widget _ruleRow({
    required String title,
    String? value,
    String? value1,
    String? value2,
    String? value3,
    String? comment,
  }) {
    final List<String> values = <String>[
      if ((value ?? '').trim().isNotEmpty) value!.trim(),
      if ((value1 ?? '').trim().isNotEmpty) value1!.trim(),
      if ((value2 ?? '').trim().isNotEmpty) value2!.trim(),
      if ((value3 ?? '').trim().isNotEmpty) value3!.trim(),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              if (values.isNotEmpty)
                Flexible(
                  child: Text(
                    values.join(' / '),
                    textAlign: TextAlign.right,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
            ],
          ),
          if ((comment ?? '').trim().isNotEmpty) ...<Widget>[
            const SizedBox(height: 3),
            Text(
              comment!.trim(),
              style: TextStyle(color: Colors.grey[700], fontSize: 12),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildRuleSection({
    required bool show,
    required String title,
    required String comment,
    required List<Widget> rows,
  }) {
    if (!show) return const SizedBox.shrink();
    return _sectionCard(
      borderColor: Colors.teal.withOpacity(0.2),
      backgroundColor: Colors.teal.withOpacity(0.03),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionTitle(title, color: Colors.teal),
          if (comment.trim().isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Text(
                comment,
                style: TextStyle(color: Colors.grey[700]),
              ),
            ),
          ...rows,
        ],
      ),
    );
  }

  Widget _buildContent() {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }

    final SalaryData? salary = _salary;
    if (salary == null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text('No salary data available.'),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _loadSalary,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => _loadSalary(adminId: _selectedAdminId),
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          _sectionCard(
            child: CompositedTransformTarget(
              link: _adminLayerLink,
              child: Container(
                key: _adminFieldKey,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.indigo.withOpacity(0.2)),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: _adminSearchController,
                  decoration: const InputDecoration(
                    labelText: 'Please select agent',
                    border: InputBorder.none,
                    suffixIcon: Icon(Icons.arrow_drop_down),
                  ),
                  onTap: _showAdminDropdown,
                  onChanged: _filterAdmins,
                ),
              ),
            ),
          ),
          if (salary.showMonthBasicSalary == true)
            _sectionCard(
              borderColor: Colors.deepPurple.withOpacity(0.2),
              backgroundColor: Colors.deepPurple.withOpacity(0.03),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _sectionTitle('Monthly Basic Salary', color: Colors.deepPurple),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '${salary.monthBasicSalaryValue ?? 0}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.deepPurple,
                      ),
                    ),
                  ),
                  if ((salary.monthBasicSalaryComment ?? '').trim().isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        salary.monthBasicSalaryComment ?? '',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ),
                ],
              ),
            ),
          if (salary.showWeekSalary == true)
            _sectionCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _sectionTitle('Weekly Salary'),
                  Text(
                    'Total: ${salary.weekSalaryTotal ?? 0}',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  if ((salary.weekSalaryComment ?? '').trim().isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        salary.weekSalaryComment ?? '',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ),
                  const SizedBox(height: 6),
                  ...((salary.weekSalaryData ?? <SalaryDataWeekSalaryData>[])
                      .map((SalaryDataWeekSalaryData e) =>
                          _dataRow(e.title ?? '-', e.value ?? 0, e.comment ?? ''))),
                ],
              ),
            ),
          if (salary.showMonthSalary == true)
            _sectionCard(
              borderColor: Colors.blueGrey.withOpacity(0.2),
              backgroundColor: Colors.blueGrey.withOpacity(0.03),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _sectionTitle('Monthly Salary', color: Colors.blueGrey),
                  Text(
                    'Total: ${salary.monthSalaryTotal ?? 0}',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  if ((salary.monthSalaryComment ?? '').trim().isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        salary.monthSalaryComment ?? '',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ),
                  const SizedBox(height: 6),
                  ...((salary.monthSalaryData ?? <SalaryDataMonthSalaryData>[])
                      .map((SalaryDataMonthSalaryData e) =>
                          _dataRow(e.title ?? '-', e.value ?? 0, e.comment ?? ''))),
                ],
              ),
            ),

          _buildRuleSection(
            show: salary.showWeekBonusRankRule == true,
            title: salary.weekBonusRankRuleTitle?.trim().isNotEmpty == true
                ? salary.weekBonusRankRuleTitle!
                : 'Weekly Bonus Rank Rule',
            comment: salary.weekBonusRankRuleComment ?? '',
            rows: (salary.weekBonusRankRuleData ?? <SalaryDataWeekBonusRankRuleData>[])
                .map((e) => _ruleRow(
                      title: e.title ?? '-',
                      value1: e.value1,
                      value2: e.value2,
                      comment: e.comment,
                    ))
                .toList(),
          ),
          _buildRuleSection(
            show: salary.showWeekRepaymentRankRule == true,
            title: salary.weekRepaymentRankRuleTitle?.trim().isNotEmpty == true
                ? salary.weekRepaymentRankRuleTitle!
                : 'Weekly Repayment Rank Rule',
            comment: salary.weekRepaymentRankRuleComment ?? '',
            rows: (salary.weekRepaymentRankRuleData ??
                    <SalaryDataWeekRepaymentRankRuleData>[])
                .map((e) => _ruleRow(
                      title: e.title ?? '-',
                      value1: e.value1,
                      value2: e.value2,
                      comment: e.comment,
                    ))
                .toList(),
          ),
          _buildRuleSection(
            show: salary.showWeekRegisterRankRule == true,
            title: salary.weekRegisterRankRuleTitle?.trim().isNotEmpty == true
                ? salary.weekRegisterRankRuleTitle!
                : 'Weekly Register Rank Rule',
            comment: salary.weekRegisterRankRuleComment ?? '',
            rows: (salary.weekRegisterRankRuleData ??
                    <SalaryDataWeekRegisterRankRuleData>[])
                .map((e) => _ruleRow(
                      title: e.title ?? '-',
                      value1: e.value1,
                      value2: e.value2,
                      value3: e.value3,
                      comment: e.comment,
                    ))
                .toList(),
          ),
          _buildRuleSection(
            show: salary.showWeekApplyRankRule == true,
            title: salary.weekApplyRankRuleTitle?.trim().isNotEmpty == true
                ? salary.weekApplyRankRuleTitle!
                : 'Weekly Apply Rank Rule',
            comment: salary.weekApplyRankRuleComment ?? '',
            rows: (salary.weekApplyRankRuleData ??
                    <SalaryDataWeekApplyRankRuleData>[])
                .map((e) => _ruleRow(
                      title: e.title ?? '-',
                      value1: e.value1,
                      value2: e.value2,
                      value3: e.value3,
                      comment: e.comment,
                    ))
                .toList(),
          ),
          _buildRuleSection(
            show: salary.showMonthBonusRankRule == true,
            title: salary.monthBonusRankRuleTitle?.trim().isNotEmpty == true
                ? salary.monthBonusRankRuleTitle!
                : 'Monthly Bonus Rank Rule',
            comment: salary.monthBonusRankRuleComment ?? '',
            rows: (salary.monthBonusRankRuleData ??
                    <SalaryDataMonthBonusRankRuleData>[])
                .map((e) => _ruleRow(
                      title: e.title ?? '-',
                      value: e.value,
                      comment: e.comment,
                    ))
                .toList(),
          ),
          _buildRuleSection(
            show: salary.showMonthRepaymentRankRule == true,
            title: salary.monthRepaymentRankRuleTitle?.trim().isNotEmpty == true
                ? salary.monthRepaymentRankRuleTitle!
                : 'Monthly Repayment Rank Rule',
            comment: salary.monthRepaymentRankRuleComment ?? '',
            rows: (salary.monthRepaymentRankRuleData ??
                    <SalaryDataMonthRepaymentRankRuleData>[])
                .map((e) => _ruleRow(
                      title: e.title ?? '-',
                      value: e.value,
                      comment: e.comment,
                    ))
                .toList(),
          ),
          _buildRuleSection(
            show: salary.showMonthRegisterRankRule == true,
            title: salary.monthRegisterRankRuleTitle?.trim().isNotEmpty == true
                ? salary.monthRegisterRankRuleTitle!
                : 'Monthly Register Rank Rule',
            comment: salary.monthRegisterRankRuleComment ?? '',
            rows: (salary.monthRegisterRankRuleData ??
                    <SalaryDataMonthRegisterRankRuleData>[])
                .map((e) => _ruleRow(
                      title: e.title ?? '-',
                      value: e.value,
                      comment: e.comment,
                    ))
                .toList(),
          ),
          _buildRuleSection(
            show: salary.showMonthApplyRankRule == true,
            title: salary.monthApplyRankRuleTitle?.trim().isNotEmpty == true
                ? salary.monthApplyRankRuleTitle!
                : 'Monthly Apply Rank Rule',
            comment: salary.monthApplyRankRuleComment ?? '',
            rows: (salary.monthApplyRankRuleData ??
                    <SalaryDataMonthApplyRankRuleData>[])
                .map((e) => _ruleRow(
                      title: e.title ?? '-',
                      value: e.value,
                      comment: e.comment,
                    ))
                .toList(),
          ),
          _buildRuleSection(
            show: salary.showFeedbackBonus == true,
            title: salary.feedbackBonusTitle?.trim().isNotEmpty == true
                ? salary.feedbackBonusTitle!
                : 'Feedback Bonus Rule',
            comment: salary.feedbackBonusComment ?? '',
            rows: (salary.feedbackBonusData ?? <SalaryDataFeedbackBonusData>[])
                .map((e) => _ruleRow(
                      title: e.title ?? '-',
                      value: e.value,
                      comment: e.comment,
                    ))
                .toList(),
          ),
          _buildRuleSection(
            show: salary.showFine == true,
            title: salary.fineTitle?.trim().isNotEmpty == true
                ? salary.fineTitle!
                : 'Fine Rule',
            comment: salary.fineComment ?? '',
            rows: (salary.fineData ?? <SalaryDataFineData>[])
                .map((e) => _ruleRow(
                      title: e.title ?? '-',
                      value1: e.value1,
                      value2: e.value2,
                      value3: e.value3,
                      comment: e.comment,
                    ))
                .toList(),
          ),

          if (salary.showMonthBasicSalary != true &&
              salary.showWeekSalary != true &&
              salary.showMonthSalary != true &&
              salary.showWeekBonusRankRule != true &&
              salary.showWeekRepaymentRankRule != true &&
              salary.showWeekRegisterRankRule != true &&
              salary.showWeekApplyRankRule != true &&
              salary.showMonthBonusRankRule != true &&
              salary.showMonthRepaymentRankRule != true &&
              salary.showMonthRegisterRankRule != true &&
              salary.showMonthApplyRankRule != true &&
              salary.showFeedbackBonus != true &&
              salary.showFine != true)
            const Padding(
              padding: EdgeInsets.only(top: 8),
              child: Text('No salary data available.'),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(centerTitle: 'Salary Details'),
      body: _buildContent(),
    );
  }
}

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

  @override
  void initState() {
    super.initState();
    _loadSalary();
  }

  Future<void> _loadSalary() async {
    setState(() {
      _loading = true;
    });

    await DioUtils.instance.requestNetwork<SalaryEntity>(
      Method.get,
      HttpApi.salary,
      onSuccess: (SalaryEntity? entity) async {
        if (!mounted) return;
        setState(() {
          _salary = entity?.data;
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

  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
      ),
    );
  }

  Widget _dataRow(String title, int value, String comment) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Text(
            value.toString(),
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
          if (comment.trim().isNotEmpty) ...<Widget>[
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                comment,
                textAlign: TextAlign.right,
                style: TextStyle(color: Colors.grey[700], fontSize: 12),
              ),
            ),
          ],
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
      onRefresh: _loadSalary,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          if (salary.showWeekSalary == true) ...<Widget>[
            _sectionTitle('Weekly Salary'),
            Text('Total: ${salary.weekSalaryTotal ?? 0}'),
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
            const SizedBox(height: 8),
          ],
          if (salary.showMonthSalary == true) ...<Widget>[
            _sectionTitle('Monthly Salary'),
            Text('Total: ${salary.monthSalaryTotal ?? 0}'),
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
          if (salary.showWeekSalary != true && salary.showMonthSalary != true)
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

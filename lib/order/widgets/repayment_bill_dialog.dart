import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:bounty_hunter/models/collection_log_entity.dart';
import 'package:bounty_hunter/util/other_utils.dart';
import 'package:bounty_hunter/res/colors.dart';
import 'package:bounty_hunter/res/dimens.dart';
import 'package:bounty_hunter/res/gaps.dart';
import 'package:bounty_hunter/widgets/my_card.dart';

class RepaymentBillDialog extends StatelessWidget {
  const RepaymentBillDialog({
    super.key,
    required this.avatar,
    required this.repayInfo,
    required this.period,
    this.track,
  });

  final String? avatar;
  final CollectionLogOtherRepayInfo? repayInfo;
  final CollectionLogOtherPeriod? period;
  final CollectionLogOtherTrack? track;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.95,
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.9,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 头部 - 账单标题和用户信息
            _buildHeader(context),

            // 账单内容
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 申请信息
                    _buildNigerianStyleSection(
                      'Application Details',
                      [
                        _buildNigerianStyleRow('Application Date',
                            _formatDateTime(track?.applyTime)),
                        _buildNigerianStyleRow('Disbursement Date',
                            _formatDateTime(repayInfo?.loanTime)),
                        _buildNigerianStyleRow('Disbursement Bank',
                            repayInfo?.receiveBank ?? 'N/A'),
                        _buildNigerianStyleRow(
                            'Account Number', repayInfo?.accountNo ?? 'N/A'),
                        _buildNigerianStyleRow('Disbursement Amt.',
                            Utils.formatPrice2(repayInfo?.loanAmount ?? 0),
                            isAmount: true),
                        _buildNigerianStyleRow(
                            'Transaction ID', repayInfo?.var10 ?? 'N/A'),
                      ],
                    ),

                    Gaps.vGap16,

                    // 还款信息
                    if (period != null) ...[
                      _buildNigerianStyleSection(
                        'Repayment Details',
                        [
                          _buildNigerianStyleRow(
                              'Due Date',
                              _formatDateTime(period?.aPExpectRepayTime,
                                  withTime: false)),
                          _buildNigerianStyleRow(
                              'Total Amount Due',
                              Utils.formatPrice2(
                                  period?.fExpectRepayTotalAmount != null
                                      ? period!.fExpectRepayTotalAmount! -
                                          period!.pPaidInterest! -
                                          period!.qPaidServiceFee! -
                                          period!.sPaidOverdueAmount! -
                                          period!.oPaidBorrowAmount! -
                                          period!.uDeductionTotalAmount!
                                      : 0),
                              isAmount: true),
                          _buildNigerianStyleRow(
                              'Interest Amount',
                              Utils.formatPrice2(
                                  (period!.hExpectInterest ?? 0) -
                                      (period!.pPaidInterest ?? 0)),
                              isAmount: true),
                          _buildNigerianStyleRow(
                              'Penalty Amount',
                              Utils.formatPrice2(
                                  period!.kExpectOverdueAmount ?? 0),
                              isAmount: true),
                          _buildNigerianStyleRow('Amount Paid',
                              Utils.formatPrice2(period?.nPaidAmount ?? 0),
                              isAmount: true),
                          _buildNigerianStyleRow(
                              'Amount Waived',
                              Utils.formatPrice2(
                                  period?.uDeductionTotalAmount ?? 0),
                              isAmount: true),
                        ],
                      ),
                    ],

                    Gaps.vGap16,

                    // 账单底部信息
                    _buildFooter(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 获取应用主题颜色
  Color _getAppPrimaryColor() {
    final appName = repayInfo?.appName?.toLowerCase() ?? '';
    if (appName.contains('kaka')) {
      return Colors.blue.shade700;
    } else if (appName.contains('leading')) {
      return Colors.green.shade700;
    } else if (appName.contains('moimoi')) {
      return Colors.orange.shade700;
    }
    // 默认颜色
    return Colors.green.shade700;
  }

  // 获取应用主题渐变色
  List<Color> _getAppGradientColors() {
    final appName = repayInfo?.appName?.toLowerCase() ?? '';
    if (appName.contains('kaka')) {
      return [Colors.blue.shade700, Colors.blue.shade500];
    } else if (appName.contains('leading')) {
      return [Colors.green.shade700, Colors.green.shade500];
    } else if (appName.contains('moimoi')) {
      return [Colors.orange.shade700, Colors.orange.shade500];
    }
    // 默认颜色
    return [Colors.green.shade700, Colors.green.shade500];
  }

  // 获取应用主题浅色
  Color _getAppLightColor() {
    final appName = repayInfo?.appName?.toLowerCase() ?? '';
    if (appName.contains('kaka')) {
      return Colors.blue.shade50;
    } else if (appName.contains('leading')) {
      return Colors.green.shade50;
    } else if (appName.contains('moimoi')) {
      return Colors.orange.shade50;
    }
    // 默认颜色
    return Colors.green.shade50;
  }

  // 获取应用主题边框色
  Color _getAppBorderColor() {
    final appName = repayInfo?.appName?.toLowerCase() ?? '';
    if (appName.contains('kaka')) {
      return Colors.blue.shade200;
    } else if (appName.contains('leading')) {
      return Colors.green.shade200;
    } else if (appName.contains('moimoi')) {
      return Colors.orange.shade200;
    }
    // 默认颜色
    return Colors.green.shade200;
  }

  // 头部设计
  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: _getAppGradientColors(),
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      child: Column(
        children: [
          // 头像和用户信息
          Row(
            children: [
              // 头像
              GestureDetector(
                onTap: () => _showAvatarDialog(context, avatar),
                child: CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.white,
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: avatar ?? '',
                      fit: BoxFit.cover,
                      width: 50,
                      height: 50,
                      placeholder: (context, url) => Image.asset(
                        'assets/images/order/icon_avatar.png',
                        fit: BoxFit.cover,
                      ),
                      errorWidget: (context, url, error) => Image.asset(
                        'assets/images/order/icon_avatar.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              Gaps.hGap16,
              // 用户信息
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      repayInfo?.name ?? 'Unknown Borrower',
                      style: const TextStyle(
                        fontSize: Dimens.font_sp18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Gaps.vGap4,
                    Text(
                      'Phone: ${repayInfo?.phone ?? 'N/A'}',
                      style: const TextStyle(
                        fontSize: Dimens.font_sp14,
                        color: Colors.white70,
                      ),
                    ),
                    if (repayInfo?.bvn != null && repayInfo!.bvn!.isNotEmpty)
                      Text(
                        'BVN: ${repayInfo!.bvn}',
                        style: const TextStyle(
                          fontSize: Dimens.font_sp14,
                          color: Colors.white70,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
          Gaps.vGap16,
          // 账单标题
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              (repayInfo?.appName ?? '') + ' LOAN REPAYMENT BILL',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: Dimens.font_sp16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 尼日利亚风格的信息区块
  Widget _buildNigerianStyleSection(String title, List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 标题栏
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
            decoration: BoxDecoration(
              color: _getAppLightColor(),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12.0),
                topRight: Radius.circular(12.0),
              ),
              border: Border(
                bottom: BorderSide(
                  color: _getAppBorderColor(),
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.receipt_long,
                  color: _getAppPrimaryColor(),
                  size: 20,
                ),
                Gaps.hGap8,
                Text(
                  title.toUpperCase(),
                  style: TextStyle(
                    fontSize: Dimens.font_sp14,
                    fontWeight: FontWeight.bold,
                    color: _getAppPrimaryColor(),
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
          // 内容
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Column(
              children: children,
            ),
          ),
        ],
      ),
    );
  }

  // 尼日利亚风格的信息行
  Widget _buildNigerianStyleRow(String label, String value,
      {bool isAmount = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 标签
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                fontSize: Dimens.font_sp10,
                color: Colors.grey.shade700,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          // 分隔符
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              ':',
              style: TextStyle(
                fontSize: Dimens.font_sp12,
                color: Colors.grey.shade500,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // 值
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(
                fontSize: Dimens.font_sp12,
                color: isAmount ? _getAppPrimaryColor() : Colors.grey.shade800,
                fontWeight: isAmount ? FontWeight.bold : FontWeight.w500,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }

  // 底部信息
  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: Colors.grey.shade200,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Text(
            'Generated on ${DateFormat('EEEE, MMMM dd, yyyy \'at\' HH:mm', 'en_US').format(DateTime.now())}',
            style: TextStyle(
              fontSize: Dimens.font_sp12,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
          Gaps.vGap8,
        ],
      ),
    );
  }

  // 格式化日期时间
  String _formatDateTime(String? dateTimeString, {bool withTime = true}) {
    if (dateTimeString == null || dateTimeString.isEmpty) {
      return 'N/A';
    }

    try {
      final DateTime dateTime = DateTime.parse(dateTimeString);
      return DateFormat('MMMM dd, yyyy ${withTime ? 'HH:mm' : ''}', 'en_US')
          .format(dateTime);
    } catch (e) {
      return dateTimeString;
    }
  }

  /// 显示头像放大对话框
  void _showAvatarDialog(BuildContext context, String? avatarUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.black54,
              child: Center(
                child: GestureDetector(
                  onTap: () {}, // 防止点击图片时关闭对话框
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.8,
                      maxHeight: MediaQuery.of(context).size.height * 0.8,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: CachedNetworkImage(
                        imageUrl: avatarUrl ?? '',
                        fit: BoxFit.contain,
                        placeholder: (context, url) => Container(
                          color: Colors.white,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: Colors.white,
                          child: Image.asset(
                            'assets/images/order/icon_avatar.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

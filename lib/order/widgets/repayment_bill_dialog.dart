import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:bounty_hunter/models/collection_log_entity.dart';
import 'package:bounty_hunter/util/other_utils.dart';
import 'package:bounty_hunter/res/dimens.dart';
import 'package:bounty_hunter/res/gaps.dart';
import 'package:oktoast/oktoast.dart';

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

  // 获取应用名称
  String _getAppName() {
    return repayInfo?.appName?.toLowerCase() ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final appName = _getAppName();

    // 根据不同的app返回完全不同的布局
    if (appName.contains('kaka')) {
      return _buildKakaBill(context);
    } else if (appName.contains('moimoi')) {
      return _buildMoimoiBill(context);
    } else {
      // Leading 或其他默认样式
      return _buildLeadingBill(context);
    }
  }

  // ==================== Leading Bill (原有尼日利亚风格) ====================
  Widget _buildLeadingBill(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildLeadingHeader(context),
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(6.0),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildNigerianStyleSection(
                          'Application Details',
                          [
                            _buildNigerianStyleRow('Application Date',
                                _formatDateTime(track?.applyTime)),
                            _buildNigerianStyleRow('Disbursement Date',
                                _formatDateTime(repayInfo?.loanTime)),
                            _buildNigerianStyleRow('Disbursement Bank',
                                repayInfo?.receiveBank ?? 'N/A'),
                            _buildNigerianStyleRow('Account Number',
                                repayInfo?.accountNo ?? 'N/A'),
                            _buildNigerianStyleRow('Disbursement Amt.',
                                Utils.formatPrice2(repayInfo?.loanAmount ?? 0),
                                isAmount: true),
                            _buildNigerianStyleRow(
                                'Transaction ID', repayInfo?.var10 ?? 'N/A'),
                          ],
                        ),
                        Gaps.vGap4,
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
                        Gaps.vGap4,
                        _buildFooter(),
                      ],
                    ),
                    _buildWatermark(repayInfo?.appName ?? ''),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Leading 头部
  Widget _buildLeadingHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green.shade700, Colors.green.shade500],
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
          // 关闭按钮
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
                tooltip: 'Close',
              ),
            ],
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () => _showAvatarDialog(context, avatar),
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white,
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: avatar ?? '',
                      fit: BoxFit.cover,
                      width: 100,
                      height: 100,
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      repayInfo?.name ?? 'Unknown Borrower',
                      style: const TextStyle(
                        fontSize: Dimens.font_sp14,
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
          Gaps.vGap4,
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              (repayInfo?.appName ?? '').toUpperCase() + ' LOAN REPAYMENT BILL',
              textAlign: TextAlign.center,
              style: const TextStyle(
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

  // 水印组件
  Widget _buildWatermark(String appName) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      bottom: 0,
      child: IgnorePointer(
        child: Stack(
          children: [
            Positioned(
              top: 50,
              left: -5,
              child: Transform.rotate(
                angle: -35 * 3.14159 / 180,
                child: Text(
                  appName.toUpperCase(),
                  style: TextStyle(
                    fontSize: 36,
                    color: Colors.green.shade700.withOpacity(0.2),
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 180,
              left: 1,
              child: Transform.rotate(
                angle: -35 * 3.14159 / 180,
                child: Text(
                  appName.toUpperCase() + "   " + appName.toUpperCase(),
                  style: TextStyle(
                    fontSize: 36,
                    color: Colors.green.shade700.withOpacity(0.2),
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 400,
              left: 100,
              child: Transform.rotate(
                angle: -35 * 3.14159 / 180,
                child: Text(
                  appName.toUpperCase(),
                  style: TextStyle(
                    fontSize: 36,
                    color: Colors.green.shade700.withOpacity(0.2),
                    fontWeight: FontWeight.w300,
                  ),
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
    return GestureDetector(
      onTap: () {
        showToast('The information has been uploaded.');
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(8.0),
          //添加背景图片

          border: Border.all(
            color: Colors.grey.shade200,
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Text(
              'Upload the customer\'s adverse credit information to FirstCentral.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            Image.asset(
              'assets/images/order/FirstCentral.png',
              fit: BoxFit.cover,
            )
          ],
        ),
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

  // ==================== Kaka Bill (横向卡片式布局) ====================
  Widget _buildKakaBill(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24.0),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blue.shade800, Colors.blue.shade600],
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    // 关闭按钮
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text(
                          'Kaka Loan Repayment Statement',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.white),
                          onPressed: () => Navigator.of(context).pop(),
                          tooltip: 'Close',
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => _showAvatarDialog(context, avatar),
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.white,
                            child: ClipOval(
                              child: CachedNetworkImage(
                                imageUrl: avatar ?? '',
                                fit: BoxFit.cover,
                                width: 100,
                                height: 100,
                                placeholder: (context, url) => Image.asset(
                                  'assets/images/order/icon_avatar.png',
                                  fit: BoxFit.cover,
                                ),
                                errorWidget: (context, url, error) =>
                                    Image.asset(
                                  'assets/images/order/icon_avatar.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                            child: Column(
                          children: [
                            _buildKakaRepayInfo(
                                'Due Date:',
                                _formatDateTime(period!.aPExpectRepayTime,
                                    withTime: false)),
                            _buildKakaRepayInfo(
                                'Interest:',
                                Utils.formatPrice2(
                                    (period!.hExpectInterest ?? 0) -
                                        (period!.pPaidInterest ?? 0))),
                            _buildKakaRepayInfo(
                                'Penalty:',
                                Utils.formatPrice2(
                                    period!.kExpectOverdueAmount ?? 0)),
                            _buildKakaRepayInfo('Amount Paid:',
                                Utils.formatPrice2(period!.nPaidAmount ?? 0)),
                            _buildKakaRepayInfo(
                                'Amount Waived:',
                                Utils.formatPrice2(
                                    period!.uDeductionTotalAmount ?? 0)),
                            _buildKakaRepayInfo(
                                'Amount Remaining:',
                                Utils.formatPrice2(
                                    period!.fExpectRepayTotalAmount! -
                                        period!.pPaidInterest! -
                                        period!.qPaidServiceFee! -
                                        period!.sPaidOverdueAmount! -
                                        period!.oPaidBorrowAmount! -
                                        period!.uDeductionTotalAmount!)),
                          ],
                        )),
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(color: Colors.white24, height: 1),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(6.0),
                  children: [
                    _buildKakaQuickInfo('Borrower Name', Icons.person,
                        repayInfo?.name ?? 'N/A'),
                    _buildKakaQuickInfo('Borrower Phone', Icons.phone,
                        repayInfo?.phone ?? 'N/A'),
                    _buildKakaQuickInfo('Borrower BVN', Icons.sim_card_sharp,
                        repayInfo?.bvn ?? 'N/A'),
                    _buildKakaQuickInfo(
                        'Disbursement Date',
                        Icons.access_time_outlined,
                        _formatDateTime(repayInfo?.loanTime)),
                    _buildKakaQuickInfo('Disbursement Bank',
                        Icons.account_balance, repayInfo?.receiveBank ?? 'N/A'),
                    _buildKakaQuickInfo('Disbursement Account Number',
                        Icons.add_card_outlined, repayInfo?.accountNo ?? 'N/A'),
                    _buildKakaQuickInfo(
                        'Disbursement Amount',
                        Icons.attach_money_outlined,
                        Utils.formatPrice2(repayInfo?.loanAmount ?? 0)),
                    _buildKakaQuickInfo('Transaction ID', Icons.description,
                        repayInfo?.var10 ?? 'N/A'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildKakaQuickInfo(String label, IconData icon, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: Colors.white.withOpacity(0.9)),
              const SizedBox(width: 8.0),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.white.withOpacity(0.7),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4.0),
          Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildKakaRepayInfo(String label, String value) {
    return Row(
      children: [
        const SizedBox(width: 8.0),
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            color: Colors.white.withOpacity(0.7),
            fontWeight: FontWeight.w500,
          ),
        ),
        const Expanded(child: SizedBox(width: 8.0)),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  // ==================== Moimoi Bill (正式表格式布局) ====================
  Widget _buildMoimoiBill(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          children: [
            // 正式商务头部
            _buildMoimoiHeader(context),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(3, 10, 3, 10),
                child: Column(
                  children: [
                    // 正式的表格布局
                    _buildMoimoiFormalTable('APPLICATION INFORMATION', [
                      _buildMoimoiFormalRow('Disbursement Date',
                          _formatDateTime(repayInfo?.loanTime)),
                      _buildMoimoiFormalRow(
                          'Disbursement Bank', repayInfo?.receiveBank ?? 'N/A'),
                      _buildMoimoiFormalRow(
                          'Account Number', repayInfo?.accountNo ?? 'N/A'),
                      _buildMoimoiFormalRow('Disbursement Amount',
                          Utils.formatPrice2(repayInfo?.loanAmount ?? 0),
                          isAmount: true),
                      _buildMoimoiFormalRow(
                          'Transaction ID', repayInfo?.var10 ?? 'N/A'),
                    ]),
                    const SizedBox(height: 20.0),
                    if (period != null)
                      _buildMoimoiFormalTable('REPAYMENT INFORMATION', [
                        _buildMoimoiFormalRow(
                            'Due Date',
                            _formatDateTime(period?.aPExpectRepayTime,
                                withTime: false)),
                        _buildMoimoiFormalRow(
                          'Total Amount Due',
                          Utils.formatPrice2(
                            period?.fExpectRepayTotalAmount != null
                                ? period!.fExpectRepayTotalAmount! -
                                    period!.pPaidInterest! -
                                    period!.qPaidServiceFee! -
                                    period!.sPaidOverdueAmount! -
                                    period!.oPaidBorrowAmount! -
                                    period!.uDeductionTotalAmount!
                                : 0,
                          ),
                          isAmount: true,
                          isHighlight: true,
                        ),
                        _buildMoimoiFormalRow(
                            'Interest Amount',
                            Utils.formatPrice2((period!.hExpectInterest ?? 0) -
                                (period!.pPaidInterest ?? 0)),
                            isAmount: true),
                        _buildMoimoiFormalRow(
                            'Penalty Amount',
                            Utils.formatPrice2(
                                period!.kExpectOverdueAmount ?? 0),
                            isAmount: true),
                        _buildMoimoiFormalRow('Amount Paid',
                            Utils.formatPrice2(period?.nPaidAmount ?? 0),
                            isAmount: true),
                        _buildMoimoiFormalRow(
                            'Amount Waived',
                            Utils.formatPrice2(
                                period?.uDeductionTotalAmount ?? 0),
                            isAmount: true),
                      ]),
                    const SizedBox(height: 20.0),
                    _buildMoimoiFooter(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMoimoiHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: Colors.orange.shade800,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8.0),
          topRight: Radius.circular(8.0),
        ),
      ),
      child: Column(
        children: [
          // 关闭按钮
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
                tooltip: 'Close',
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 6.0),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Text(
                        'OFFICIAL STATEMENT',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    Text(
                      (repayInfo?.appName ?? '').toUpperCase(),
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 2.0,
                      ),
                    ),
                    const SizedBox(height: 6.0),
                    Text(
                      'LOAN REPAYMENT STATEMENT',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white.withOpacity(0.9),
                        letterSpacing: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: GestureDetector(
                  onTap: () => _showAvatarDialog(context, avatar),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: CachedNetworkImage(
                      imageUrl: avatar ?? '',
                      fit: BoxFit.cover,
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
            ],
          ),
          const SizedBox(height: 20.0),
          Container(
            height: 1,
            color: Colors.white.withOpacity(0.3),
          ),
          const SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildMoimoiHeaderInfo('BORROWER', repayInfo?.name ?? 'N/A'),
              // _buildMoimoiHeaderInfo('PHONE', repayInfo?.phone ?? 'N/A'),
              if (repayInfo?.bvn != null && repayInfo!.bvn!.isNotEmpty)
                _buildMoimoiHeaderInfo('BVN', repayInfo!.bvn!),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMoimoiHeaderInfo(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: Colors.white.withOpacity(0.7),
            letterSpacing: 1.0,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildMoimoiFormalTable(String title, List<Widget> rows) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(color: Colors.orange.shade300, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
            decoration: BoxDecoration(
              color: Colors.orange.shade800,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(4.0),
                topRight: Radius.circular(4.0),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 4,
                  height: 20,
                  color: Colors.white,
                ),
                const SizedBox(width: 12.0),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Column(
              children: rows,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMoimoiFormalRow(String label, String value,
      {bool isAmount = false, bool isHighlight = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade200, width: 1),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 133,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade700,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.3,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20.0),
            width: 1,
            height: 20,
            color: Colors.grey.shade300,
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: TextStyle(
                fontSize: isHighlight ? 16 : 14,
                color: isAmount ? Colors.orange.shade800 : Colors.grey.shade800,
                fontWeight: (isAmount || isHighlight)
                    ? FontWeight.bold
                    : FontWeight.w500,
                letterSpacing: isHighlight ? 0.5 : 0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMoimoiFooter() {
    return GestureDetector(
      onTap: () {
        showToast('The information has been uploaded.');
      },
      child: Container(
        padding: const EdgeInsets.all(24.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4.0),
          border: Border.all(color: Colors.orange.shade300, width: 1.5),
        ),
        child: Column(
          children: [
            Text(
              "Upload customer's adverse credit information to FirstCentral.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                color: Colors.grey.shade700,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.3,
              ),
            ),
            const SizedBox(height: 16.0),
            Image.asset(
              'assets/images/order/FirstCentral.png',
              height: 60,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }

  /// 显示头像放大对话框
  void _showAvatarDialog(BuildContext context, String? avatarUrl) {
    showDialog<void>(
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

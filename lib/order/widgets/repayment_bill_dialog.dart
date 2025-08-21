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
        width: MediaQuery.of(context).size.width * 1,
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 1,
        ),
        child: Stack(
          children: [
            // 主要内容
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 头部 - 包含头像和标题
                Container(
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Colours.app_main.withOpacity(0.1),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16.0),
                      topRight: Radius.circular(16.0),
                    ),
                  ),
                  child: Row(
                    children: [
                      // 头像
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.transparent,
                        child: ClipOval(
                          child: CachedNetworkImage(
                            imageUrl: avatar ?? '',
                            fit: BoxFit.cover,
                            width: 60,
                            height: 60,
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
                              ),
                            ),
                            Gaps.vGap4,
                            Text(
                              'Phone: ${repayInfo?.phone ?? 'N/A'}',
                              style: TextStyle(
                                fontSize: Dimens.font_sp14,
                                color: Colors.grey[600],
                              ),
                            ),
                            if (repayInfo?.bvn != null &&
                                repayInfo!.bvn!.isNotEmpty)
                              Text(
                                'BVN: ${repayInfo!.bvn}',
                                style: TextStyle(
                                  fontSize: Dimens.font_sp14,
                                  color: Colors.grey[600],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // 还款账单内容
                Flexible(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 基本信息
                        _buildInfoSection(
                          'Basic Information',
                          [
                            _buildInfoRow('Product Name',
                                repayInfo?.productName ?? 'N/A'),
                            _buildInfoRow('Application Name',
                                repayInfo?.appName ?? 'N/A'),
                            _buildInfoRow('Loan Application Time',
                                _formatDateTime(repayInfo?.loanTime)),
                            _buildInfoRow('Loan Duration',
                                '${repayInfo?.borrowDays ?? 0} days'),
                          ],
                        ),

                        Gaps.vGap16,

                        // 借款信息
                        _buildInfoSection(
                          'Loan Details',
                          [
                            _buildInfoRow(
                                'Requested Amount',
                                Utils.formatPrice2(
                                    repayInfo?.borrowAmount ?? 0)),
                            _buildInfoRow('Disbursed Amount',
                                Utils.formatPrice2(repayInfo?.loanAmount ?? 0)),
                            if (track != null)
                              _buildInfoRow('Disbursement Bank',
                                  track!.loanBank ?? 'N/A'),
                            if (track != null)
                              _buildInfoRow('Disbursement Time',
                                  _formatDateTime(track!.loanTime)),
                          ],
                        ),

                        Gaps.vGap16,

                        // 还款信息
                        if (period != null)
                          _buildInfoSection(
                            'Repayment Schedule',
                            [
                              _buildInfoRow('Expected Repayment Date',
                                  _formatDateTime(period!.aPExpectRepayTime)),
                              _buildInfoRow(
                                  'Total Amount Due',
                                  Utils.formatPrice2(
                                      period!.fExpectRepayTotalAmount ?? 0)),
                              _buildInfoRow(
                                  'Principal Amount',
                                  Utils.formatPrice2(
                                      period!.gExpectBorrowAmount ?? 0)),
                              _buildInfoRow(
                                  'Interest Amount',
                                  Utils.formatPrice2(
                                      period!.hExpectInterest ?? 0)),
                              _buildInfoRow(
                                  'Service Fee',
                                  Utils.formatPrice2(
                                      period!.iExpectServiceFee ?? 0)),
                              _buildInfoRow(
                                  'Penalty Fee',
                                  Utils.formatPrice2(
                                      period!.jExpectViolateFee ?? 0)),
                              _buildInfoRow(
                                  'Late Payment Fee',
                                  Utils.formatPrice2(
                                      period!.kExpectOverdueAmount ?? 0)),
                            ],
                          ),

                        Gaps.vGap16,

                        // 已还信息
                        if (period != null)
                          _buildInfoSection(
                            'Payment History',
                            [
                              _buildInfoRow('Total Amount Paid',
                                  Utils.formatPrice2(period!.nPaidAmount ?? 0)),
                              _buildInfoRow(
                                  'Principal Paid',
                                  Utils.formatPrice2(
                                      period!.oPaidBorrowAmount ?? 0)),
                              _buildInfoRow(
                                  'Interest Paid',
                                  Utils.formatPrice2(
                                      period!.pPaidInterest ?? 0)),
                              _buildInfoRow(
                                  'Service Fee Paid',
                                  Utils.formatPrice2(
                                      period!.qPaidServiceFee ?? 0)),
                              _buildInfoRow(
                                  'Late Fee Paid',
                                  Utils.formatPrice2(
                                      period!.sPaidOverdueAmount ?? 0)),
                            ],
                          ),

                        Gaps.vGap16,

                        // 逾期信息
                        if (period != null)
                          _buildInfoSection(
                            'Overdue Information',
                            [
                              _buildInfoRow('Days Overdue',
                                  '${period!.lOverdueDays ?? 0} days'),
                              _buildInfoRow('Fee Waiver Count',
                                  '${period!.tDeductionTimes ?? 0} times'),
                              _buildInfoRow(
                                  'Total Fee Waived',
                                  Utils.formatPrice2(
                                      period!.uDeductionTotalAmount ?? 0)),
                            ],
                          ),

                        Gaps.vGap16,

                        // 账户信息
                        _buildInfoSection(
                          'Bank Account Details',
                          [
                            _buildInfoRow('Account Holder Name',
                                repayInfo?.accountName ?? 'N/A'),
                            _buildInfoRow('Account Number',
                                repayInfo?.accountNo ?? 'N/A'),
                            _buildInfoRow(
                                'Bank Name', repayInfo?.accountBank ?? 'N/A'),
                            _buildInfoRow('Receiving Bank',
                                repayInfo?.receiveBank ?? 'N/A'),
                            _buildInfoRow('Receiving Account',
                                repayInfo?.receiveBankNo ?? 'N/A'),
                          ],
                        ),

                        Gaps.vGap16,

                        // 剩余还款金额 - 突出显示
                        if (period != null)
                          Container(
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.red.withOpacity(0.1),
                                  Colors.orange.withOpacity(0.1),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(
                                  color: Colors.red.withOpacity(0.5)),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Outstanding Balance:',
                                      style: TextStyle(
                                        fontSize: Dimens.font_sp16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red,
                                      ),
                                    ),
                                    Text(
                                      Utils.formatPrice2((period!
                                                  .fExpectRepayTotalAmount ??
                                              0) -
                                          (period!.qPaidServiceFee ?? 0) -
                                          (period!.pPaidInterest ?? 0) -
                                          (period!.sPaidOverdueAmount ?? 0) -
                                          (period!.oPaidBorrowAmount ?? 0) -
                                          (period!.uDeductionTotalAmount ?? 0)),
                                      style: const TextStyle(
                                        fontSize: Dimens.font_sp18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                                Gaps.vGap8,
                                Container(
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    color: Colors.amber.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(Icons.warning_amber,
                                          color: Colors.orange, size: 16),
                                      Gaps.hGap8,
                                      Expanded(
                                        child: Text(
                                          'Please ensure timely payment to avoid additional charges',
                                          style: TextStyle(
                                            fontSize: Dimens.font_sp12,
                                            color: Colors.orange[800],
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                        Gaps.vGap16,

                        // 账单底部信息
                        Container(
                          padding: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Column(
                            children: [
                              Text(
                                'Generated on ${DateFormat('MMM dd, yyyy \'at\' HH:mm', 'en_US').format(DateTime.now())}',
                                style: TextStyle(
                                  fontSize: Dimens.font_sp12,
                                  color: Colors.grey[600],
                                ),
                              ),
                              Gaps.vGap4,
                              Text(
                                'This is an official loan repayment bill from Nigeria',
                                style: TextStyle(
                                  fontSize: Dimens.font_sp12,
                                  color: Colors.grey[600],
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // 底部按钮
                Container(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colours.app_main,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: const Text('Close Bill'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection(String title, List<Widget> children) {
    return MyCard(
      shadowColor: Colors.grey.withOpacity(0.2),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.info_outline, color: Colours.app_main, size: 18),
                Gaps.hGap8,
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: Dimens.font_sp16,
                    fontWeight: FontWeight.bold,
                    color: Colours.app_main,
                  ),
                ),
              ],
            ),
            Gaps.vGap8,
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
            child: Text(
              label,
              style: TextStyle(
                fontSize: Dimens.font_sp14,
                color: Colors.grey[700],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Gaps.hGap8,
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: Dimens.font_sp14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDateTime(String? dateTime) {
    if (dateTime == null || dateTime.isEmpty) {
      return 'N/A';
    }
    try {
      return DateFormat('MMM dd, yyyy \'at\' HH:mm', 'en_US')
          .format(DateTime.parse(dateTime));
    } catch (e) {
      return dateTime;
    }
  }
}

// 水印绘制器
class WatermarkPainter extends CustomPainter {
  final String text;
  final Color color;

  WatermarkPainter({required this.text, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );

    textPainter.layout();

    // 绘制旋转的水印文字
    for (int i = 0; i < 5; i++) {
      for (int j = 0; j < 3; j++) {
        canvas.save();
        canvas.translate(
          size.width * 0.2 * (i + 1),
          size.height * 0.3 * (j + 1),
        );
        canvas.rotate(-0.3); // 旋转角度
        textPainter.paint(canvas, Offset.zero);
        canvas.restore();
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

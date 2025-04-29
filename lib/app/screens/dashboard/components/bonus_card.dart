import 'package:flutter/material.dart';
import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:mlm_demo_frontend_flutter/app/core/custom_widget/custom_container.dart';
import 'package:mlm_demo_frontend_flutter/app/core/utils/app_colors.dart';

import '../../../core/utils/app_textstyle.dart';

class BonusCard extends StatelessWidget {
  final double? amount;
  final double? withdrawable;
  final double? networkAvg;
  final double? percentGrowth; // +ve for up, -ve for down
  final bool isLoading;

  const BonusCard({
    super.key,
    this.amount,
    this.withdrawable,
    this.networkAvg,
    this.percentGrowth,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      padding: const EdgeInsets.all(16),
      backgroundColor: AppColors.primaryColor,
      child: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // TITLE + GROWTH
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'TOTAL BONUSES',
                      style: AppTextstyle.text14.copyWith(
                        fontSize: FontSizeManager.getFontSize(context, 18),
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (percentGrowth != null)
                      Row(
                        children: [
                          Icon(
                            percentGrowth! >= 0
                                ? Icons.arrow_upward
                                : Icons.arrow_downward,
                            size: 16,
                            color: percentGrowth! >= 0
                                ? Colors.greenAccent
                                : Colors.redAccent,
                          ),
                          Text(
                            '${percentGrowth!.abs().toStringAsFixed(1)}%',
                            style: AppTextstyle.text14.copyWith(
                              fontSize:
                                  FontSizeManager.getFontSize(context, 12),
                              color: percentGrowth! >= 0
                                  ? Colors.greenAccent
                                  : Colors.redAccent,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      )
                  ],
                ),

                // GRAPH
                CustomPaint(
                  painter: _LineGraphPainter(),
                  size: const Size(double.infinity, 30),
                ),

                // MAIN AMOUNT
                AnimatedFlipCounter(
                  duration: const Duration(milliseconds: 800),
                  value: amount ?? 0,
                  fractionDigits: 0,
                  prefix: '\$',
                  textStyle: AppTextstyle.text14.copyWith(
                    fontSize: FontSizeManager.getFontSize(context, 24),
                    color: AppColors.whiteColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                // WITHDRAWABLE + NETWORK AVG
                if (withdrawable != null || networkAvg != null)
                  Column(
                    children: [
                      if (withdrawable != null)
                        Text(
                          'Withdrawable: \$${withdrawable!.toStringAsFixed(0)}',
                          style: AppTextstyle.text14.copyWith(
                            fontSize: FontSizeManager.getFontSize(context, 12),
                            color: AppColors.whiteColor.withOpacity(0.8),
                          ),
                        ),
                      if (networkAvg != null)
                        Text(
                          'Network Avg: \$${networkAvg!.toStringAsFixed(0)}',
                          style: AppTextstyle.text14.copyWith(
                            fontSize: FontSizeManager.getFontSize(context, 11),
                            color: Colors.white54,
                          ),
                        ),
                    ],
                  ),
              ],
            ),
    );
  }
}

// 🖌 Painter stays same
class _LineGraphPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = AppColors.secondaryColor
      ..strokeWidth = 8
      ..style = PaintingStyle.stroke;

    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.grey.withOpacity(0.3),
          Colors.transparent,
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, size.height * 0.8);
    path.quadraticBezierTo(size.width * 0.2, size.height * 0.6,
        size.width * 0.3, size.height * 0.65);
    path.quadraticBezierTo(size.width * 0.4, size.height * 0.75,
        size.width * 0.5, size.height * 0.5);
    path.quadraticBezierTo(size.width * 0.6, size.height * 0.3,
        size.width * 0.7, size.height * 0.4);
    path.quadraticBezierTo(
        size.width * 0.85, size.height * 0.6, size.width, size.height * 0.3);

    final fillPath = Path.from(path)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(path, linePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

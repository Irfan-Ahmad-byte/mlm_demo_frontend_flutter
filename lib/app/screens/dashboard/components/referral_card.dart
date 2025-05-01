import 'package:flutter/material.dart';
import 'package:mlm_demo_frontend_flutter/app/core/utils/app_colors.dart';
import 'package:mlm_demo_frontend_flutter/app/core/utils/app_spaces.dart';
import 'package:shimmer/shimmer.dart';
import 'package:animated_flip_counter/animated_flip_counter.dart';
import '../../../core/utils/app_textstyle.dart';

class ReferralCard extends StatelessWidget {
  final int? count;
  final bool isLoading;

  const ReferralCard({super.key, this.count, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170,
      child: isLoading
          ? Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child:
                  const CircleAvatar(radius: 60, backgroundColor: Colors.white),
            )
          : TweenAnimationBuilder<double>(
              duration: const Duration(seconds: 5),
              tween: Tween(begin: 0, end: (count ?? 0) / 1000.0),
              builder: (context, value, child) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    // Circle background + arc
                    CustomPaint(
                      size: const Size(160, 160),
                      painter: _CircleProgressPainter(value.clamp(0.0, 1.0)),
                    ),
                    // Inside container with background
                    Container(
                      width: 100,
                      height: 100,
                      decoration: const BoxDecoration(
                        color: AppColors.whiteColor,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'TOTAL\nREFERRALS',
                            textAlign: TextAlign.center,
                            style: AppTextstyle.text14.copyWith(
                              fontSize: FontSizeManager.getFontSize(context, 8),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          height6,
                          AnimatedFlipCounter(
                            duration: const Duration(milliseconds: 900),
                            value: count?.toDouble() ?? 0,
                            textStyle: AppTextstyle.text14.copyWith(
                              fontSize:
                                  FontSizeManager.getFontSize(context, 20),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
    );
  }
}

class _CircleProgressPainter extends CustomPainter {
  final double progress;

  _CircleProgressPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    const strokeWidth = 14.0;
    final rect = Offset.zero & size;
    final center = rect.center;
    final radius = (size.width - strokeWidth) / 2;

    final bgPaint = Paint()
      ..color = Colors.grey.shade200
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final fgPaint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFFD4AF37), Color(0xFFFBE27C)],
      ).createShader(rect)
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, bgPaint);

    final sweepAngle = progress * 2 * 3.1416;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -3.1416 / 2,
      sweepAngle,
      false,
      fgPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _CircleProgressPainter oldDelegate) =>
      oldDelegate.progress != progress;
}

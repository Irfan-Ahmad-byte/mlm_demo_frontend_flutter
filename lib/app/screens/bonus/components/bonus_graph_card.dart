import 'package:flutter/material.dart';
import 'package:mlm_demo_frontend_flutter/app/core/custom_widget/custom_container.dart';
import 'package:mlm_demo_frontend_flutter/app/core/utils/app_colors.dart';
import 'package:mlm_demo_frontend_flutter/app/core/utils/app_textstyle.dart';

import '../../../core/custom_widget/responsive_widget.dart';
import '../../../core/utils/app_spaces.dart';

class BonusGraphCard extends StatelessWidget {
  static bool isMobileOrCustomScreen(BuildContext context) {
    return ResponsiveWidget.isSmallScreen(context) ||
        ResponsiveWidget.isCustomScreen(context);
  }

  const BonusGraphCard({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      backgroundColor: AppColors.secondaryColor,
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      border: Border(
        right: BorderSide(
          color: AppColors.primaryColor,
          width: 10,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔹 Title
          Text(
            'BONUS TREND',
            style: AppTextstyle.text14.copyWith(
              fontSize: FontSizeManager.getFontSize(context, 12),
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),
          height4,

          // 📝 Subtext
          Text(
            'This chart shows your bonus earnings over the past week.',
            style: AppTextstyle.text14.copyWith(
              fontSize: FontSizeManager.getFontSize(context, 10),
              color: AppColors.shadowColor,
            ),
          ),

          // 📈 Graph
          SizedBox(
            height: isMobileOrCustomScreen(context) ? 70 : 100,
            child: CustomPaint(
              size: const Size(double.infinity, 100),
              painter: _BonusGraphPainter(),
            ),
          ),

          // 📍 Mini Stats
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Lowest: \$120',
                style: AppTextstyle.text14.copyWith(
                  fontSize: FontSizeManager.getFontSize(context, 12),
                  color: Colors.red.shade800,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Highest: \$320',
                style: AppTextstyle.text14.copyWith(
                  fontSize: FontSizeManager.getFontSize(context, 12),
                  color: Colors.greenAccent.shade200,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _BonusGraphPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint linePaint = Paint()
      ..color = Colors.white.withOpacity(0.8)
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;

    final Path path = Path();
    path.moveTo(0, size.height * 0.7);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.3,
        size.width * 0.5, size.height * 0.6);
    path.quadraticBezierTo(
        size.width * 0.75, size.height * 0.9, size.width, size.height * 0.4);

    canvas.drawPath(path, linePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

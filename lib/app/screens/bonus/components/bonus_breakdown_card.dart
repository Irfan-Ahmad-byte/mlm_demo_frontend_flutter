import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:mlm_demo_frontend_flutter/app/core/custom_widget/custom_container.dart';
import 'package:mlm_demo_frontend_flutter/app/core/utils/app_colors.dart';
import 'package:mlm_demo_frontend_flutter/app/core/utils/app_textstyle.dart';

import '../../../core/utils/app_spaces.dart';

class BonusBreakdownCard extends StatelessWidget {
  const BonusBreakdownCard({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> bonuses = [
      {
        'label': 'Direct Bonus',
        'description': 'Earned from your direct referrals',
        'amount': 1500.0,
        'goal': 2000.0,
        'icon': Icons.monetization_on,
        'color': Colors.green
      },
      {
        'label': 'Team Bonus',
        'description': 'Earned from your network performance',
        'amount': 700.0,
        'goal': 1500.0,
        'icon': Icons.people_alt,
        'color': Colors.blue
      },
      {
        'label': 'Level Bonus',
        'description': 'Earned from deeper level referrals',
        'amount': 350.0,
        'goal': 1000.0,
        'icon': Icons.stacked_line_chart,
        'color': Colors.orange
      },
    ];

    return CustomContainer(
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'BONUS BREAKDOWN',
            style: AppTextstyle.text14.copyWith(
              fontSize: FontSizeManager.getFontSize(context, 14),
              color: AppColors.secondaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          height20,
          ...bonuses.map((bonus) {
            double progress = (bonus['amount'] / bonus['goal']).clamp(0.0, 1.0);

            return Container(
              margin: const EdgeInsets.only(bottom: 14),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.95),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    color: bonus['color'].withOpacity(0.3), width: 0.8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top row
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: bonus['color'].withOpacity(0.12),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          bonus['icon'],
                          size: 18,
                          color: bonus['color'],
                        ),
                      ),
                      width10,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              bonus['label'],
                              style: AppTextstyle.text14.copyWith(
                                fontSize:
                                    FontSizeManager.getFontSize(context, 14),
                                color: AppColors.whiteColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              bonus['description'],
                              style: AppTextstyle.text14.copyWith(
                                fontSize:
                                    FontSizeManager.getFontSize(context, 11),
                                color: Colors.white38,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: bonus['color'].withOpacity(0.15),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: AnimatedFlipCounter(
                          duration: const Duration(milliseconds: 600),
                          value: bonus['amount'] as double,
                          prefix: '\$',
                          fractionDigits: 0,
                          textStyle: AppTextstyle.text14.copyWith(
                            fontSize: FontSizeManager.getFontSize(context, 14),
                            color: bonus['color'],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  height10,
                  LinearProgressIndicator(
                    value: progress,
                    color: bonus['color'],
                    backgroundColor: Colors.white12,
                    minHeight: 6,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height4,
                  Text(
                    '${(progress * 100).toStringAsFixed(1)}% of \$${bonus['goal'].toInt()} goal',
                    style: AppTextstyle.text14.copyWith(
                      fontSize: FontSizeManager.getFontSize(context, 11),
                      color: Colors.white54,
                    ),
                  )
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}

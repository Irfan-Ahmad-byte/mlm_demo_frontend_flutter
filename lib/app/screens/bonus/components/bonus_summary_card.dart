import 'package:flutter/material.dart';
import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mlm_demo_frontend_flutter/app/core/custom_widget/custom_container.dart';
import 'package:mlm_demo_frontend_flutter/app/core/custom_widget/responsive_widget.dart';
import 'package:mlm_demo_frontend_flutter/app/core/utils/app_colors.dart';
import 'package:mlm_demo_frontend_flutter/app/core/utils/app_textstyle.dart';

import '../../../core/utils/app_spaces.dart';

class BonusSummaryCard extends StatelessWidget {
  final double amount;
  final double monthlyIncrease;

  const BonusSummaryCard({
    super.key,
    required this.amount,
    required this.monthlyIncrease,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 20.h),
      border: Border(
        left: BorderSide(
          color: AppColors.secondaryColor,
          width: 10,
        ),
      ),
      width: double.infinity,
      child: Row(
        children: [
          // 💵 Optional Icon
          Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              color: AppColors.secondaryColor.withOpacity(0.5),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.monetization_on,
                color: Colors.green, size: 22),
          ),
          width10,
          // 💬 Text & Chip
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'TOTAL BONUSES',
                  style: AppTextstyle.text14.copyWith(
                    fontSize: FontSizeManager.getFontSize(context, 14),
                    color: AppColors.secondaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                height10,
                AnimatedFlipCounter(
                  duration: const Duration(milliseconds: 700),
                  value: amount,
                  prefix: '\$',
                  fractionDigits: 0,
                  textStyle: AppTextstyle.text14.copyWith(
                    fontSize: FontSizeManager.getFontSize(context, 28),
                    fontWeight: FontWeight.bold,
                    color: AppColors.whiteColor,
                  ),
                ),
                height10,
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '+\$${monthlyIncrease.toStringAsFixed(0)} this month',
                    style: AppTextstyle.text14.copyWith(
                      fontSize: FontSizeManager.getFontSize(context, 12),
                      color: Colors.green,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (ResponsiveWidget.isLargeScreen(context)) ...[
            width4,
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InviteUserButton(onPressed: () {}),
                height10,
                Text(
                  'Invite Users to earn more',
                  maxLines: 2,
                  overflow: TextOverflow.visible,
                  style: AppTextstyle.text14.copyWith(
                    fontSize: FontSizeManager.getFontSize(context, 10),
                    color: AppColors.whiteColor,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            )
          ]
        ],
      ),
    );
  }
}

class InviteUserButton extends StatelessWidget {
  final VoidCallback onPressed;

  const InviteUserButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.person_add_alt_1, size: 20, color: Colors.white),
      label: Text(
        'Invite Users',
        style: AppTextstyle.text14.copyWith(
          fontSize: FontSizeManager.getFontSize(context, 12),
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.secondaryColor,
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 6.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 4,
        shadowColor: AppColors.secondaryColor.withOpacity(0.4),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mlm_demo_frontend_flutter/app/core/custom_widget/custom_container.dart';
import 'package:mlm_demo_frontend_flutter/app/core/custom_widget/responsive_widget.dart';
import 'package:mlm_demo_frontend_flutter/app/core/utils/app_colors.dart';
import 'package:mlm_demo_frontend_flutter/app/core/utils/app_textstyle.dart';
import 'package:mlm_demo_frontend_flutter/app/screens/bonus/controller/bonus_controller.dart';
import '../../../core/utils/app_spaces.dart';

class BonusSummaryCard extends StatelessWidget {
  final controller = Get.put(BonusController());

  BonusSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isSmall = ResponsiveWidget.isSmallScreen(context);

    return CustomContainer(
      border: Border(
        left: BorderSide(
          color: AppColors.secondaryColor,
          width: 10,
        ),
      ),
      width: double.infinity,
      child: isSmall
          ? Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                height10,
                _buildTotalSection(context, isSmall),
                height10,
                DistributeBonusButton(
                  title: 'Distribute Bonuses',
                  onPressed: () {
                    controller.distributeReferralBonus();
                  },
                ),
                height6,
                DistributeBonusButton(
                  title: 'Pay All',
                  onPressed: () {
                    controller.bonusPayAll();
                  },
                ),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.center, // 🔥 key fix
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // 🧾 Left Side – Bonus Info
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    width10,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'TOTAL BONUS',
                          style: AppTextstyle.text14.copyWith(
                            fontSize: FontSizeManager.getFontSize(context, 14),
                            color: AppColors.secondaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        height4,
                        AnimatedFlipCounter(
                          duration: const Duration(milliseconds: 700),
                          value: 20,
                          prefix: '\$',
                          fractionDigits: 0,
                          textStyle: AppTextstyle.text14.copyWith(
                            fontSize: FontSizeManager.getFontSize(context, 28),
                            fontWeight: FontWeight.bold,
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ],
                    ),
                    width20,
                    // 🎖 Rank Badge
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        color: Colors.brown.shade800,
                        borderRadius: BorderRadius.circular(18.r),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Current Rank:',
                            style: AppTextstyle.text14.copyWith(
                              fontSize:
                                  FontSizeManager.getFontSize(context, 12),
                              color: Colors.orangeAccent,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'Bronze',
                            style: AppTextstyle.text14.copyWith(
                              fontSize:
                                  FontSizeManager.getFontSize(context, 12),
                              color: Colors.greenAccent,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                // 🟡 Buttons Side
                DistributeBonusButton(
                  title: 'Distribute Bonuses',
                  onPressed: () {
                    controller.distributeReferralBonus();
                  },
                ),
                width10,
                DistributeBonusButton(
                  title: 'Pay All',
                  onPressed: () {
                    controller.bonusPayAll();
                  },
                ),
              ],
            ),
    );
  }

  Widget _buildTotalSection(BuildContext context, bool isSmall) {
    return Column(
      crossAxisAlignment:
          isSmall ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      mainAxisAlignment:
          isSmall ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: [
        Text(
          'TOTAL BONUS',
          style: AppTextstyle.text14.copyWith(
            fontSize: FontSizeManager.getFontSize(context, 14),
            color: AppColors.secondaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        height10,
        AnimatedFlipCounter(
          duration: const Duration(milliseconds: 700),
          value: 20,
          prefix: '\$',
          fractionDigits: 0,
          textStyle: AppTextstyle.text14.copyWith(
            fontSize: FontSizeManager.getFontSize(context, 28),
            fontWeight: FontWeight.bold,
            color: AppColors.whiteColor,
          ),
        ),
      ],
    );
  }
}

class DistributeBonusButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;

  const DistributeBonusButton(
      {super.key, required this.onPressed, required this.title});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.payments_outlined, size: 20, color: Colors.white),
      label: Text(
        title,
        style: AppTextstyle.text14.copyWith(
          fontSize: FontSizeManager.getFontSize(context, 12),
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.secondaryColor,
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 4,
        shadowColor: AppColors.secondaryColor.withOpacity(0.4),
      ),
    );
  }
}

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
          width10,
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
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
                height10,
                DistributeBonusButton(onPressed: () {
                  controller.distributeReferralBonus();
                })
              ],
            ),
          ),
          if (ResponsiveWidget.isLargeScreen(context)) ...[
            width10,
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Current Rank: ',
                      style: AppTextstyle.text14.copyWith(
                        fontSize: FontSizeManager.getFontSize(context, 12),
                        color: Colors.orangeAccent,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Bronze',
                      style: AppTextstyle.text14.copyWith(
                        fontSize: FontSizeManager.getFontSize(context, 12),
                        color: Colors.greenAccent,
                        fontWeight: FontWeight.w700,
                      ),
                    )
                    // CustomRichText(
                    //   text1: 'Current Rank: ',
                    //   text2: 'Bronze',
                    //   maxLines: 2,
                    //   overflow: TextOverflow.ellipsis,
                    //   style1: AppTextstyle.text14.copyWith(
                    //     fontSize: FontSizeManager.getFontSize(context, 12),
                    //     color: Colors.orangeAccent,
                    //     fontWeight: FontWeight.w600,
                    //   ),
                    //   style2: AppTextstyle.text14.copyWith(
                    //     fontSize: FontSizeManager.getFontSize(context, 12),
                    //     color: Colors.greenAccent,
                    //     fontWeight: FontWeight.w700,
                    //   ),
                    // ),
                  ],
                )),
          ]
        ],
      ),
    );
  }
}

class DistributeBonusButton extends StatelessWidget {
  final VoidCallback onPressed;

  const DistributeBonusButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.payments_outlined, size: 20, color: Colors.white),
      label: Text(
        'Distribute Bonuses',
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

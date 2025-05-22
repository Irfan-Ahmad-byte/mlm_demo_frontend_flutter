import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mlm_demo_frontend_flutter/app/core/utils/app_colors.dart';
import 'package:mlm_demo_frontend_flutter/app/core/utils/app_textstyle.dart';
import 'package:mlm_demo_frontend_flutter/app/core/utils/app_spaces.dart';

class BonusCard extends StatelessWidget {
  final String level;
  final String type;
  final String date;
  final String amount;
  final Color statusColor;

  const BonusCard({
    super.key,
    required this.level,
    required this.type,
    required this.date,
    required this.amount,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.secondaryColor.withOpacity(0.1)),
        borderRadius: BorderRadius.circular(10.r),
        color: AppColors.primaryColor,
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(15.h),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.secondaryColor.withOpacity(0.12),
            ),
            child: const Icon(Icons.trending_up, color: Colors.blueAccent),
          ),
          width12,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  level,
                  style: AppTextstyle.text14.copyWith(
                    fontSize: FontSizeManager.getFontSize(context, 14),
                    fontWeight: FontWeight.bold,
                    color: AppColors.whiteColor,
                  ),
                ),
                Text(
                  type,
                  style: AppTextstyle.text14.copyWith(
                    fontSize: FontSizeManager.getFontSize(context, 12),
                    color: AppColors.whiteColor.withOpacity(0.8),
                  ),
                ),
                Text(
                  date,
                  style: AppTextstyle.text14.copyWith(
                    fontSize: FontSizeManager.getFontSize(context, 10),
                    color: AppColors.whiteColor.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ),
          width8,
          Text(
            amount,
            style: AppTextstyle.text14.copyWith(
              fontSize: FontSizeManager.getFontSize(context, 14),
              fontWeight: FontWeight.bold,
              color: statusColor,
            ),
          ),
        ],
      ),
    );
  }
}

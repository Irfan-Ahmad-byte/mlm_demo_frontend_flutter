import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mlm_demo_frontend_flutter/app/core/utils/app_colors.dart';
import 'package:mlm_demo_frontend_flutter/app/core/utils/app_textstyle.dart';

Future<void> showBonusDetailDialog(
    BuildContext context, Map<String, dynamic> bonus) {
  return showDialog(
    context: context,
    builder: (_) {
      return Dialog(
        backgroundColor: AppColors.primaryColor, // darker card
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 20.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔹 Title
              Center(
                child: Text(
                  '💼 Bonus Details',
                  style: AppTextstyle.text14.copyWith(
                    fontSize: FontSizeManager.getFontSize(context, 14),
                    color: AppColors.secondaryColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(height: 14.h),
              Divider(
                  thickness: 1,
                  color: AppColors.secondaryColor.withOpacity(0.2)),

              // 🧾 Details
              _buildRow(context, "Bonus ID", bonus["id"], AppColors.whiteColor),
              _buildRow(
                  context, "User ID", bonus["user_id"], AppColors.whiteColor),
              _buildRow(context, "Source User", bonus["source_user_id"],
                  AppColors.whiteColor),
              _buildRow(context, "Level", bonus["level"].toString(),
                  Colors.orangeAccent),
              _buildRow(context, "Amount", "\$${bonus["amount"]}",
                  Colors.greenAccent),
              _buildRow(
                  context, "Type", bonus["type"], AppColors.secondaryColor),
              _buildRow(
                  context,
                  "Status",
                  bonus["status"].toUpperCase(),
                  bonus["status"] == "paid"
                      ? Colors.greenAccent
                      : Colors.orange),
              _buildRow(context, "Created At", bonus["created_at"].toString(),
                  Colors.grey[400]!),

              SizedBox(height: 20.h),

              // ❌ Close Button
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    "CLOSE",
                    style: AppTextstyle.text14.copyWith(
                      fontSize: FontSizeManager.getFontSize(context, 12),
                      color: AppColors.secondaryColor,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

Widget _buildRow(
    BuildContext context, String title, String value, Color valueColor) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 5.h),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100.w,
          child: Text(
            "$title:",
            style: AppTextstyle.text14.copyWith(
              fontSize: FontSizeManager.getFontSize(context, 12),
              color: AppColors.whiteColor.withOpacity(0.8),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: AppTextstyle.text14.copyWith(
              fontSize: FontSizeManager.getFontSize(context, 12),
              color: valueColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    ),
  );
}

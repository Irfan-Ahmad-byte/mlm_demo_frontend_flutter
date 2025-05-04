import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mlm_demo_frontend_flutter/app/core/custom_widget/app_button.dart';

import '../utils/app_colors.dart';
import '../utils/app_textstyle.dart';
import 'responsive_widget.dart';

class ErrorDialog extends StatelessWidget {
  final String title, text;
  final VoidCallback onRetry;

  const ErrorDialog({
    super.key,
    required this.title,
    required this.text,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.close_outlined,
                color: AppColors.errorColor,
              )),
        ],
      ),
      backgroundColor: AppColors.bodyColor,
      title: Text(
        title, // Customizable text
        style: AppTextstyle.text14.copyWith(
            fontSize: FontSizeManager.getFontSize(context, 14),
            color: AppColors.errorColor,
            fontWeight: FontWeight.bold),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 120.w,
          ),
          Icon(Icons.error, color: AppColors.errorColor, size: 50),
          SizedBox(height: 20),
          ConstrainedBox(
            constraints: BoxConstraints(
                maxWidth: !ResponsiveWidget.isLargeScreen(context)
                    ? 200.w
                    : 100.w), // Limit text width
            child: Text(
              text,
              // Example: "An error occurred while processing your request. Please try again later."
              style: AppTextstyle.text14.copyWith(
                  fontSize: FontSizeManager.getFontSize(context, 12),
                  color: AppColors.primaryColor),
              textAlign: TextAlign.center,
              overflow: TextOverflow.visible, // Enable wrapping
            ),
          ),
          SizedBox(height: 20),
          AppButton(
            text: "Close",
            onPressed: () {
              Get.back();
            },
          ),
        ],
      ),
    );
  }
}

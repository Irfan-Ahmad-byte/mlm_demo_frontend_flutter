import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../utils/app_colors.dart';
import '../utils/app_textstyle.dart';
import 'custom_container.dart';

class CustomSnackBar {
  static OverlayEntry? _currentSnackBar;

  static void show({
    required String message,
    Color? backColor,
  }) {
    // Check if Overlay context is available
    final overlay =
        Get.overlayContext != null ? Overlay.of(Get.overlayContext!) : null;

    if (overlay == null) {
      Get.snackbar("Error", message); // Fallback if Overlay is not available
      return;
    }

    // Remove any existing Snackbar
    _removeCurrentSnackBar();

    // Create a new OverlayEntry for Snackbar
    _currentSnackBar = OverlayEntry(
      builder: (context) => Positioned(
        top: 100.h,
        right: 10.w,
        child: Material(
          color: Colors.transparent,
          child: CustomContainer(
            width: 200.w,
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
            backgroundColor: backColor ?? AppColors.secondaryColor,
            child: Text(
              message,
              maxLines: 2,
              style: AppTextstyle.text14.copyWith(
                fontSize: FontSizeManager.getFontSize(context, 13),
                color: AppColors.primaryDarkColor,
              ),
            ),
          ),
        ),
      ),
    );

    // Insert Snackbar into Overlay
    overlay.insert(_currentSnackBar!);

    // Automatically remove Snackbar after duration
    Future.delayed(const Duration(seconds: 2), _removeCurrentSnackBar);
  }

  static void _removeCurrentSnackBar() {
    _currentSnackBar?.remove();
    _currentSnackBar = null;
  }
}

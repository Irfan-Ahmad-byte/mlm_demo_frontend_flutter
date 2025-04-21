import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mlm_demo_frontend_flutter/app/core/utils/app_colors.dart';

import '../../services/initial_setting_service.dart';

class AppTextstyle {
  // Base TextStyle
  static final textStyle = TextStyle(
    color: AppColors.textColor,
    fontFamily: Get.find<InitialSettingServices>().settingmodel.fontFamily,
    fontStyle: FontStyle.normal,
  );

  // Common Font Sizes
  static final TextStyle text24 = textStyle.copyWith(fontSize: 24);
  static final TextStyle text14 = textStyle.copyWith(fontSize: 14);

  static final TextStyle text13 = textStyle.copyWith(fontSize: 13);
  static final TextStyle text12 = textStyle.copyWith(fontSize: 12);

  // Even Numbers Font Sizes
  static final TextStyle text162 = textStyle.copyWith(fontSize: 52);
  static final TextStyle text30 = textStyle.copyWith(fontSize: 30);
  static final TextStyle text34 = textStyle.copyWith(fontSize: 34);
  static final TextStyle text36 = textStyle.copyWith(fontSize: 36);
  static final TextStyle text38 = textStyle.copyWith(fontSize: 38);
  static final TextStyle text40 = textStyle.copyWith(fontSize: 40);
  static final TextStyle text45 = textStyle.copyWith(fontSize: 45);
  static final TextStyle text16 = textStyle.copyWith(fontSize: 16);
  static final TextStyle text10 = textStyle.copyWith(fontSize: 10);
  static final TextStyle text8 = textStyle.copyWith(fontSize: 8);
  static final TextStyle text6 = textStyle.copyWith(fontSize: 6);
  static final TextStyle text4 = textStyle.copyWith(fontSize: 4);
  static final TextStyle text3 = textStyle.copyWith(fontSize: 3);
  static final TextStyle text5 = textStyle.copyWith(fontSize: 5);

  static final TextStyle text118 = textStyle.copyWith(fontSize: 118);
  static final TextStyle text50 = textStyle.copyWith(fontSize: 50);
  static final TextStyle text72 = textStyle.copyWith(fontSize: 72);
  static final TextStyle text22 = textStyle.copyWith(fontSize: 22);
  static final TextStyle text20 = textStyle.copyWith(fontSize: 20);
  static final TextStyle text18 = textStyle.copyWith(fontSize: 18);
}

class FontSizeManager {
  // static double getFontSize(BuildContext context, double fontSize) {
  //   double screenWidth = MediaQuery.of(context).size.width;
  //   double devicePixelRatio = MediaQuery.of(context).devicePixelRatio;

  //   if (screenWidth <= 300) {
  //     // Ultra small screens (small phones)
  //     return fontSize * 0.85;
  //   } else if (screenWidth > 300 && screenWidth <= 480) {
  //     // Small mobile devices
  //     return fontSize * 0.95;
  //   } else if (screenWidth > 480 && screenWidth <= 768) {
  //     // Medium mobile devices
  //     return fontSize * 1.0;
  //   } else if (screenWidth > 768 && screenWidth <= 1024) {
  //     // Tablets & small laptops
  //     return fontSize * 1.1;
  //   } else if (screenWidth > 1024 && screenWidth <= 1366) {
  //     // Regular laptops & desktops
  //     return fontSize * 1.14 + (devicePixelRatio * 0.02);
  //   } else {
  //     // Ultra-wide screens
  //     return fontSize * 1.2 + (devicePixelRatio * 0.04);
  //   }
  // }
  static double getFontSize(BuildContext context, double fontSize) {
    double screenWidth = MediaQuery.of(context).size.width;
    double devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    double baseScale = 1.0;

    if (screenWidth <= 320) {
      // Ultra small screens
      baseScale = 0.92;
    } else if (screenWidth <= 480) {
      // Small mobiles
      baseScale = 1.0;
    } else if (screenWidth <= 768) {
      // Medium devices
      baseScale = 1.08;
    } else if (screenWidth <= 1024) {
      // Tablets
      baseScale = 1.16;
    } else if (screenWidth <= 1366) {
      // Laptops
      baseScale = 1.25;
    } else if (screenWidth <= 1920) {
      // HD / Mac large screens
      baseScale = 1.35;
    } else {
      // Ultra-wide and 4K screens
      baseScale = 1.45;
    }

    // Adjust using devicePixelRatio to fine-tune for high-res screens
    double adjustedFontSize = fontSize * baseScale + (devicePixelRatio * 0.3);
    return adjustedFontSize;
  }
}

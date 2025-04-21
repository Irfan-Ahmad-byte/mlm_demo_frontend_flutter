// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../services/initial_setting_service.dart';

class UI {
  /// Parse Hex color safely
  static Color parseColor(String hexCode, {double? opacity}) {
    try {
      return Color(int.parse(hexCode.replaceAll("#", "0xFF")))
          .withOpacity(opacity ?? 1);
    } catch (e) {
      return const Color(0xFFCCCCCC).withOpacity(opacity ?? 1);
    }
  }

  /// Get themed color directly from settings
  static Color get primaryColor => parseColor(
      InitialSettingServices.to.activeTheme.primaryColor ?? "#000000");
  static Color get accentColor => parseColor(
      InitialSettingServices.to.activeTheme.accentColor ?? "#007BFF");
  static Color get scaffoldColor => parseColor(
      InitialSettingServices.to.activeTheme.scaffoldColor ?? "#F8FAFC");
  static Color get textColor =>
      parseColor(InitialSettingServices.to.activeTheme.textColor ?? "#1F2937");
  static Color get hintColor =>
      parseColor(InitialSettingServices.to.activeTheme.hintColor ?? "#6B7280");

  // ---------- SNACKBARS ---------- //

  static void success(String message, {String title = 'Success'}) {
    if (!Get.isSnackbarOpen) {
      Get.showSnackbar(
        _baseSnackbar(
          title: title,
          message: message,
          icon: Icons.check_circle_outline,
          backgroundColor: primaryColor,
        ),
      );
    }
  }

  static void error(String message, {String title = 'Error'}) {
    if (!Get.isSnackbarOpen) {
      Get.showSnackbar(
        _baseSnackbar(
          title: title,
          message: message,
          icon: Icons.error_outline,
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  static void alert(String message, {String title = 'Alert'}) {
    if (!Get.isSnackbarOpen) {
      Get.showSnackbar(
        _baseSnackbar(
          title: title,
          message: message,
          icon: Icons.info_outline,
          backgroundColor: Colors.amber,
        ),
      );
    }
  }

  static void close() {
    if (Get.isSnackbarOpen) Get.closeCurrentSnackbar();
  }

  static GetSnackBar _baseSnackbar({
    required String title,
    required String message,
    required IconData icon,
    required Color backgroundColor,
    Duration duration = const Duration(seconds: 2),
  }) {
    return GetSnackBar(
      titleText: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 16,
        ),
      ),
      messageText: Text(
        message,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
        ),
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
      icon: Icon(icon, size: 28, color: Colors.white),
      backgroundColor: backgroundColor,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      duration: duration,
    );
  }
}

import 'package:flutter/material.dart';
import '../../services/initial_setting_service.dart';
import 'ui.dart';

class AppColors {
  static const Color whiteColor = Colors.white;
  static const Color errorColor = Color(0xFFEF4444); // Soft polite red
  static const Color transparentColor = Colors.transparent;
  static const Color blackColor = Colors.black;

  static Color get shadowColor => UI.parseColor("#000000");

  static Color get primaryColor => _getThemeColor(
        InitialSettingServices.to.activeTheme.primaryColor,
        fallback: "#1B1F3B", // Deep Royal Navy
      );

  static Color get primaryDarkColor => _getThemeColor(
        InitialSettingServices.to.activeTheme.primaryDarkColor,
        fallback: "#0F172A", // Midnight Dark Blue
      );

  static Color get secondaryColor => _getThemeColor(
        InitialSettingServices.to.activeTheme.accentColor,
        fallback: "#D4AF37", // Elegant Gold for highlights/buttons
      );

  static Color get secondaryDarkColor => _getThemeColor(
        InitialSettingServices.to.activeTheme.accentDarkColor,
        fallback: "#8B0000", // Rich Burgundy (optional deep accent)
      );

  static Color get scaffoldColor => _getThemeColor(
        InitialSettingServices.to.activeTheme.scaffoldColor,
        fallback: "#F8FAFC", // Porcelain Soft Background
      );

  static Color get headerColor => _getThemeColor(
        InitialSettingServices.to.activeTheme.headerColor,
        fallback: "#1B1F3B", // Same as primary (deep royal navy)
      );

  static Color get hintColor => _getThemeColor(
        InitialSettingServices.to.activeTheme.hintColor,
        fallback: "#64748B", // Muted trustworthy hint
      );

  static Color get containerColor => _getThemeColor(
        InitialSettingServices.to.activeTheme.containerColor,
        fallback: "#F9FAFB", // Porcelain White for Bonus Cards
      );

  static Color get textColor => _getThemeColor(
        InitialSettingServices.to.activeTheme.textColor,
        fallback: "#1F2937", // Dark Charcoal Text
      );

  static Color get bodyColor => UI.parseColor("#F8FAFC"); // Background

  static Color get darkOrange =>
      UI.parseColor("#D97706"); // Optional Rich Accent (Orange-Gold)

  static Color get lightGreen =>
      UI.parseColor("#10B981"); // Emerald Success Green

  static Color get greyColor =>
      UI.parseColor("#E5E7EB"); // Soft Light Grey for borders

  static Color get backColor =>
      UI.parseColor("#F9FAFB"); // Softest background (almost white)

  /// Internal theme color parser with fallback
  static Color _getThemeColor(String? color, {required String fallback}) {
    if (color == null || color.isEmpty) {
      return UI.parseColor(fallback);
    }
    return UI.parseColor(color);
  }
}

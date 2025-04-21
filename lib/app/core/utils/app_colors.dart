import 'package:flutter/material.dart';
import '../../services/initial_setting_service.dart';
import 'ui.dart';

class AppColors {
  static const Color whiteColor = Colors.white;
  static const Color errorColor = Colors.red;
  static const Color transparentColor = Colors.transparent;
  static const Color blackColor = Colors.black;

  static Color get shadowColor => UI.parseColor("#000000");

  static Color get primaryColor => _getThemeColor(
        InitialSettingServices.to.settingmodel.lightTheme?.primaryColor,
        fallback: "#8B5CF6",
      );

  static Color get secondaryColor => _getThemeColor(
        InitialSettingServices.to.settingmodel.lightTheme?.accentColor,
        fallback: "#2DD4BF",
      );

  static Color get hintColor => _getThemeColor(
        InitialSettingServices.to.settingmodel.lightTheme?.hintColor,
        fallback: "#CBD5E1",
      );

  static Color get textColor => _getThemeColor(
        InitialSettingServices.to.settingmodel.lightTheme?.textColor,
        fallback: "#1F2937",
      );

  static Color get bodyColor => UI.parseColor("#FEF4EC");

  static Color get darkOrange => UI.parseColor("#EF0E0E");
  static Color get lightGreen => UI.parseColor("#1DBF73");
  static Color get greyColor => UI.parseColor("#919191");
  static Color get backColor => UI.parseColor("#FEEFE4");

  /// Internal theme color parser with fallback
  static Color _getThemeColor(String? color, {required String fallback}) {
    if (color == null || color.isEmpty) {
      return UI.parseColor(fallback);
    }
    return UI.parseColor(color);
  }
}

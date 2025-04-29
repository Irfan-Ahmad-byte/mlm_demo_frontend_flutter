import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mlm_demo_frontend_flutter/app/core/utils/ui.dart';

import '../core/utils/app_constants.dart';
import '../initial_model/initial_settings_model.dart';

class InitialSettingServices extends GetxService {
  static InitialSettingServices get to => Get.find<InitialSettingServices>();

  late InitialSettingModel settingmodel;

  Future<InitialSettingServices> init() async {
    try {
      final response = await getJsonFile(kInitialSettingJson);
      print("InitialSetting JSON loaded: $response"); // 👈 DEBUG

      if (response != null) {
        settingmodel = InitialSettingModel.fromJson(response);
        print("Theme Loaded: ${settingmodel.defaultTheme}"); // 👈 DEBUG
      }
    } catch (e, stack) {
      print("🔥 Error loading initial settings: $e");
      print(stack);
    }

    return this;
  }

  static Future<dynamic> getJsonFile(String path) async {
    return rootBundle.loadString(path).then(convert.jsonDecode);
  }

  ThemeMode getThemeMode() {
    final mode = settingmodel.defaultTheme?.toLowerCase();
    if (mode == 'dark') return ThemeMode.dark;
    return ThemeMode.light;
  }

  ThemeData getLightTheme() {
    final t = settingmodel.lightTheme ?? LightTheme();

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor:
            UI.parseColor(t.primaryColor ?? "#1B1F3B"), // 🛡️ Royal Navy
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: UI.parseColor(t.primaryColor ?? "#1B1F3B"),
      ),
    );

    return ThemeData(
      fontFamily: fontFamily,
      brightness: Brightness.light,
      primaryColor: UI.parseColor(t.primaryColor ?? "#1B1F3B"), // 🛡️
      primaryColorDark: UI.parseColor(t.primaryDarkColor ?? "#0F172A"), // 🌌
      scaffoldBackgroundColor:
          UI.parseColor(t.scaffoldColor ?? "#F8FAFC"), // 🧺
      dividerColor: UI.parseColor(t.hintColor ?? "#E5E7EB"), // Subtle dividers
      focusColor: UI.parseColor(t.accentColor ?? "#D4AF37"), // Gold Accent
      hintColor: UI.parseColor(t.hintColor ?? "#64748B"), // Muted Trusty Hint
      checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: UI.parseColor(t.accentColor ?? "#D4AF37"), // Gold
        selectionColor: UI.parseColor(t.accentColor ?? "#D4AF37"),
        selectionHandleColor: UI.parseColor(t.accentColor ?? "#D4AF37"),
      ),
      colorScheme: ColorScheme.light(
        primary: UI.parseColor(t.primaryColor ?? "#1B1F3B"),
        secondary: UI.parseColor(t.accentColor ?? "#D4AF37"),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: UI.parseColor(t.primaryColor ?? "#1B1F3B"),
      ),
    );
  }

  ThemeData getDarkTheme() {
    final t = settingmodel.darkTheme ?? LightTheme();

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: UI.parseColor(t.primaryColor ?? "#0F172A"),
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: UI.parseColor(t.primaryColor ?? "#0F172A"),
      ),
    );

    return ThemeData.dark().copyWith(
      textTheme: Typography.material2021().black.apply(fontFamily: fontFamily),
      primaryColor: UI.parseColor(t.primaryColor ?? "#0F172A"),
      scaffoldBackgroundColor: UI.parseColor(t.scaffoldColor ?? "#0F172A"),
      hintColor: UI.parseColor(t.hintColor ?? "#64748B"),
      colorScheme: ColorScheme.dark(
        primary: UI.parseColor(t.primaryColor ?? "#0F172A"),
        secondary: UI.parseColor(t.accentColor ?? "#D4AF37"),
      ),
    );
  }

  LightTheme get activeTheme => getThemeMode() == ThemeMode.dark
      ? (settingmodel.darkTheme ?? LightTheme())
      : (settingmodel.lightTheme ?? LightTheme());

  String get appName => settingmodel.appName ?? 'GrowBro';
  String get appVersion => settingmodel.appVersion ?? '1.0.0';
  String get fontFamily => settingmodel.fontFamily ?? 'Inter';
}

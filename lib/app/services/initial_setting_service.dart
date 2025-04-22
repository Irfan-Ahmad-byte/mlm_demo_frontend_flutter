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
        statusBarColor: UI.parseColor(t.primaryColor ?? "#52a9b0"),
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: UI.parseColor(t.primaryColor ?? "#52a9b0"),
      ),
    );

    return ThemeData(
      fontFamily: fontFamily,
      brightness: Brightness.light,
      primaryColor: UI.parseColor(t.primaryColor ?? "#52a9b0"),
      primaryColorDark: UI.parseColor(t.primaryDarkColor ?? "#194d5c"),
      scaffoldBackgroundColor: UI.parseColor(t.scaffoldColor ?? "#ffffff"),
      dividerColor: UI.parseColor(t.hintColor ?? "#c0dde2"),
      focusColor: UI.parseColor(t.accentColor ?? "#aadfe4"),
      hintColor: UI.parseColor(t.hintColor ?? "#c0dde2"),
      checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: UI.parseColor(t.accentColor ?? "#aadfe4"),
        selectionColor: UI.parseColor(t.accentColor ?? "#aadfe4"),
        selectionHandleColor: UI.parseColor(t.accentColor ?? "#aadfe4"),
      ),
      colorScheme: ColorScheme.light(
        primary: UI.parseColor(t.primaryColor ?? "#52a9b0"),
        secondary: UI.parseColor(t.accentColor ?? "#aadfe4"),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: UI.parseColor(t.primaryColor ?? "#52a9b0"),
      ),
    );
  }

  ThemeData getDarkTheme() {
    final t = settingmodel.darkTheme ?? LightTheme();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: UI.parseColor(t.primaryColor ?? "#52a9b0"),
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: UI.parseColor(t.primaryColor ?? "#52a9b0"),
      ),
    );

    return ThemeData.dark().copyWith(
      textTheme: Typography.material2021().black.apply(fontFamily: fontFamily),
      primaryColor: UI.parseColor(t.primaryColor ?? "#52a9b0"),
      scaffoldBackgroundColor: UI.parseColor(t.scaffoldColor ?? "#102e46"),
      hintColor: UI.parseColor(t.hintColor ?? "#c0dde2"),
      colorScheme: ColorScheme.dark(
        primary: UI.parseColor(t.primaryColor ?? "#52a9b0"),
        secondary: UI.parseColor(t.accentColor ?? "#aadfe4"),
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

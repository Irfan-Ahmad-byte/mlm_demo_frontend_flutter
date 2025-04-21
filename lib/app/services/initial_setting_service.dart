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
    final response = await getJsonFile(kInitialSettingJson);
    if (response != null) {
      settingmodel = InitialSettingModel.fromJson(response);
    }
    return this;
  }

  static Future<dynamic> getJsonFile(String path) async {
    return rootBundle.loadString(path).then(convert.jsonDecode);
  }

  ThemeMode getThemeMode() {
    final mode = settingmodel.defaultTheme?.toLowerCase();
    if (mode == 'dark') {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.light.copyWith(
          systemNavigationBarColor: Colors.black,
        ),
      );
      return ThemeMode.dark;
    }
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(
        systemNavigationBarColor: Colors.white,
      ),
    );
    return ThemeMode.light;
  }

  ThemeData getLightTheme() {
    final t = settingmodel.lightTheme ?? LightTheme();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: UI.parseColor(t.primaryColor ?? "#8B5CF6"),
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: UI.parseColor(t.primaryColor ?? "#8B5CF6"),
      ),
    );

    return ThemeData(
      fontFamily: fontFamily,
      brightness: Brightness.light,
      primaryColor: UI.parseColor(t.primaryColor ?? "#8B5CF6"),
      primaryColorDark: UI.parseColor(t.primaryDarkColor ?? "#7C3AED"),
      scaffoldBackgroundColor: UI.parseColor(t.scaffoldColor ?? "#F8FAFC"),
      dividerColor: UI.parseColor(t.hintColor ?? "#CBD5E1"),
      focusColor: UI.parseColor(t.accentColor ?? "#2DD4BF"),
      hintColor: UI.parseColor(t.hintColor ?? "#94A3B8"),
      checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: UI.parseColor(t.accentColor ?? "#2DD4BF"),
        selectionColor: UI.parseColor(t.accentColor ?? "#2DD4BF"),
        selectionHandleColor: UI.parseColor(t.accentColor ?? "#2DD4BF"),
      ),
      colorScheme: ColorScheme.light(
        primary: UI.parseColor(t.primaryColor ?? "#8B5CF6"),
        secondary: UI.parseColor(t.accentColor ?? "#2DD4BF"),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: UI.parseColor(t.primaryColor ?? "#8B5CF6"),
      ),
    );
  }

  ThemeData getDarkTheme() {
    final t = settingmodel.darkTheme ?? LightTheme();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: UI.parseColor(t.primaryColor ?? "#8B5CF6"),
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: UI.parseColor(t.primaryColor ?? "#8B5CF6"),
      ),
    );
    return ThemeData.dark().copyWith(
      textTheme: Typography.material2021().black.apply(fontFamily: fontFamily),
      primaryColor: UI.parseColor(t.primaryColor ?? "#8B5CF6"),
      scaffoldBackgroundColor: UI.parseColor(t.scaffoldColor ?? "#0F172A"),
      hintColor: UI.parseColor(t.hintColor ?? "#94A3B8"),
      colorScheme: ColorScheme.dark(
        primary: UI.parseColor(t.primaryColor ?? "#8B5CF6"),
        secondary: UI.parseColor(t.accentColor ?? "#2DD4BF"),
      ),
    );
  }

  LightTheme get activeTheme => getThemeMode() == ThemeMode.dark
      ? (settingmodel.darkTheme ?? LightTheme())
      : (settingmodel.lightTheme ?? LightTheme());

  String get appName => settingmodel.appName ?? 'MLM Demo';
  String get appVersion => settingmodel.appVersion ?? '1.0.0';
  String get fontFamily => settingmodel.fontFamily ?? 'Inter';
}

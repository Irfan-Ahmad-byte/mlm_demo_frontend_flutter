import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mlm_demo_frontend_flutter/app/core/utils/app_constants.dart';
import 'app/routes/app_pages.dart';
import 'app/routes/app_routes.dart';
import 'app/services/initial_setting_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Get.putAsync(() => InitialSettingServices().init());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: SimpleBuilder(
        builder: (context) => GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: GetMaterialApp(
            title: kAppName,
            darkTheme: Get.find<InitialSettingServices>().getDarkTheme(),
            themeMode: Get.find<InitialSettingServices>().getThemeMode(),
            theme: Get.find<InitialSettingServices>().getLightTheme(),
            getPages: AppPages.pages,
            initialRoute: AppRoutes.initial,
            defaultTransition: Transition.fadeIn,
            debugShowCheckedModeBanner: false,
          ),
        ),
      ),
    );
  }
}

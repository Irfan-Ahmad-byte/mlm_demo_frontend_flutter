import 'package:get/get.dart';
import 'package:mlm_demo_frontend_flutter/app/routes/app_routes.dart';
import 'package:mlm_demo_frontend_flutter/app/screens/login/login_page.dart';

class AppPages extends AppRoutes {
  static final pages = [
    GetPage(name: AppRoutes.initial, page: () => LoginPage())
  ];
}

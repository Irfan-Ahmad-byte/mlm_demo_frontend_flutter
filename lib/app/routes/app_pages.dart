import 'package:get/get.dart';
import 'package:mlm_demo_frontend_flutter/app/routes/app_routes.dart';
import 'package:mlm_demo_frontend_flutter/app/screens/index/index_page.dart';
import 'package:mlm_demo_frontend_flutter/app/screens/login/bindings/login_binding.dart';
// import 'package:mlm_demo_frontend_flutter/app/screens/login/login_page.dart';

class AppPages extends AppRoutes {
  static final pages = [
    GetPage(
        name: AppRoutes.initial,
        page: () => IndexPage(),
        binding: LoginBinding()),
    GetPage(name: AppRoutes.index, page: () => IndexPage())
  ];
}

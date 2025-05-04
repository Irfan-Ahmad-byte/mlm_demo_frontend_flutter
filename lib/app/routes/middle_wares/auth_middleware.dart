import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mlm_demo_frontend_flutter/app/api/api_preference.dart';

import '../app_routes.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final token = ApiPreference.getApiToken;
    if (token != null && token.toString().isNotEmpty) {
      return RouteSettings(name: AppRoutes.index);
    }
    return null; // allow access
  }
}

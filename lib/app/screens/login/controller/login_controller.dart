import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../api/api_preference.dart';
import '../../../core/custom_widget/custom_snackbar.dart';
import '../../../core/custom_widget/loading.dart';
import '../../../core/utils/app_colors.dart';
import '../../../routes/app_routes.dart';
import '../repository/login_repository.dart';

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final obscure = true.obs;

  final LoginRepository loginRepository = LoginRepository();

  void setObscureText() {
    obscure.value = !obscure.value;
  }

  void loginUser(
      {required String email,
      required String password,
      VoidCallback? isClear}) async {
    if (email.isEmpty || password.isEmpty) {
      CustomSnackBar.show(
        message: "Email and password are required",
        backColor: AppColors.errorColor,
      );
      return;
    }

    try {
      CustomLoading.show();

      final Map<String, dynamic> body = {
        "grant_type": "password",
        "username": email,
        "password": password,
        "scope": "",
        "client_id": "string",
        "client_secret": "string",
      };

      final response = await loginRepository.loginUser(body: body);

      if (response != null && response['access_token'] != null) {
        print(response);
        // await AppPreferences.setApiToken(response['access_token']);
        Get.log("Login Token: ${response['access_token']}");
        await ApiPreference.setApiToken(response['access_token']);

        Get.offAllNamed(AppRoutes.index);
        isClear?.call();

        CustomSnackBar.show(
          message: "Login successful",
          backColor: AppColors.lightGreen,
        );
      } else {
        CustomSnackBar.show(
          message: response['detail'] ?? "Invalid credentials",
          backColor: AppColors.errorColor,
        );
      }
    } catch (e) {
      Get.log("Login failed: $e");
      CustomSnackBar.show(
        message: "Login failed, please try again",
        backColor: AppColors.errorColor,
      );
    } finally {
      CustomLoading.hide();
    }
  }
}

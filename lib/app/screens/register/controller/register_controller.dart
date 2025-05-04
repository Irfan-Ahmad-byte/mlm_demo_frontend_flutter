import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:mlm_demo_frontend_flutter/app/screens/register/repository/register_repository.dart';
import 'package:uuid/uuid.dart';

import '../../../core/custom_widget/custom_snackbar.dart';
import '../../../core/custom_widget/loading.dart';
import '../../../core/utils/app_colors.dart';
import '../../../routes/app_routes.dart';

class RegisterController extends GetxController {
  final RegisterRepository loginRepository = RegisterRepository();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final parentIdController = TextEditingController();

  final maskFormatter = MaskTextInputFormatter(
    mask: '########-####-####-####-############',
    filter: {"#": RegExp(r'[0-9a-fA-F]')},
    type: MaskAutoCompletionType.lazy,
  );

  @override
  void onInit() {
    super.onInit();

    // Generate UUID here and assign directly
    var uuid = Uuid();
    parentIdController.text = uuid.v4();
  }

  void registerUser() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final parentId = parentIdController.text.trim();

    if (email.isEmpty || password.isEmpty || parentId.isEmpty) {
      CustomSnackBar.show(
        message: "All fields are required.",
        backColor: AppColors.errorColor,
      );
      return;
    }

    try {
      CustomLoading.show();

      final body = {
        "email": email,
        "password": password,
        "parent_id": parentId,
      };

      final response = await loginRepository.registerUser(body: body);

      if (response != null && response['email'] != null) {
        Get.offAllNamed(AppRoutes.login);
        clearFields();
        CustomSnackBar.show(
          message: "Registration successful",
          backColor: AppColors.lightGreen,
        );
      } else {
        CustomSnackBar.show(
          message: response['detail'] ?? "Registration failed",
          backColor: AppColors.errorColor,
        );
      }
    } catch (e) {
      Get.log("Registration failed: $e");
      CustomSnackBar.show(
        message: "Registration failed, please try again",
        backColor: AppColors.errorColor,
      );
    } finally {
      CustomLoading.hide();
    }
  }

  void clearFields() {
    emailController.clear();
    passwordController.clear();
    parentIdController.clear();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    parentIdController.dispose();
    super.onClose();
  }
}

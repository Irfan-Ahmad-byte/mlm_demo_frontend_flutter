import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mlm_demo_frontend_flutter/app/core/assets/app_icons.dart';
import 'package:mlm_demo_frontend_flutter/app/routes/app_routes.dart';
import '../../../core/custom_widget/app_text_field.dart';
import '../../../core/custom_widget/app_button.dart';
import '../../../core/utils/app_colors.dart';

class LoginForm extends StatelessWidget {
  final loginFormKey = GlobalKey<FormState>();

  LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: AppColors.primaryDarkColor,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.w),
        constraints: BoxConstraints(maxWidth: 320.w),
        child: Form(
          key: loginFormKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                AppIcons.logo,
                width: 20.w,
                height: 64,
              ),
              SizedBox(height: 10.h),
              Text(
                'Log in',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.secondaryColor,
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                'Enter your credentials to\naccess your account',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textColor,
                ),
              ),
              SizedBox(height: 40.h),

              /// Email Field
              AppTextField(
                label: 'Email',
                hint: 'Enter your email',
                // controller: controller.emailController,
                keyboardType: TextInputType.emailAddress,
                icon: Icons.email,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.h),

              /// Password Field
              AppTextField(
                label: 'Password',
                hint: 'Enter your password',
                // controller: controller.passwordController,
                isPassword: true,
                icon: Icons.lock,
                validator: (value) {
                  if (value == null || value.length < 6) {
                    return 'Minimum 6 characters';
                  }
                  return null;
                },
              ),
              SizedBox(height: 40.h),

              /// Login Button
              AppButton(
                text: 'Log in',
                onPressed: () {
                  Get.offAllNamed(AppRoutes.index);
                  // if (loginFormKey.currentState!.validate()) {
                  //   controller.loginUser(
                  //     email: controller.emailController.text,
                  //     password: controller.passwordController.text,
                  //     isClear: () {
                  //       controller.emailController.clear();
                  //       controller.passwordController.clear();
                  //     },
                  //   );
                  // }
                },
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}

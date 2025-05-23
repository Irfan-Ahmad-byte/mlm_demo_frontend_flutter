import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mlm_demo_frontend_flutter/app/core/assets/app_icons.dart';
import 'package:mlm_demo_frontend_flutter/app/routes/app_routes.dart';
import '../../../core/assets/app_images.dart';
import '../../../core/custom_widget/app_text_field.dart';
import '../../../core/custom_widget/app_button.dart';
import '../../../core/custom_widget/responsive_widget.dart';
import '../../../core/utils/app_colors.dart';
import '../controller/login_controller.dart';

class LoginForm extends StatelessWidget {
  final loginFormKey = GlobalKey<FormState>();
  final LoginController controller;

  LoginForm({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 110.h),
        constraints: BoxConstraints(
          maxWidth:
              ResponsiveWidget.isSmallScreen(context) ? double.infinity : 320.w,
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(!ResponsiveWidget.isSmallScreen(context)
                ? AppImages.loginLong
                : AppImages.loginBack),
            fit: BoxFit.fill,
          ),
        ),
        child: Form(
          key: loginFormKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                AppIcons.logo,
                width: 20.w,
                height: 64.h,
                color: AppColors.secondaryColor,
              ),
              SizedBox(height: 30.h),
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
                  color: AppColors.greyColor,
                ),
              ),
              SizedBox(height: 20.h),

              /// Email Field
              AppTextField(
                label: 'Email',
                hint: 'Enter your email',
                controller: controller.emailController,
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
                controller: controller.passwordController,
                isPassword: true,
                showSuffixIcon: true,
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
                  if (loginFormKey.currentState!.validate()) {
                    controller.loginUser(
                      email: controller.emailController.text,
                      password: controller.passwordController.text,
                      isClear: () {
                        controller.emailController.clear();
                        controller.passwordController.clear();
                      },
                    );
                  }
                },
              ),
              SizedBox(height: 20.h),
              TextButton(
                onPressed: () {
                  Get.toNamed(AppRoutes.register);
                },
                child: Text(
                  'Don\'t have an account? Sign up',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.errorColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mlm_demo_frontend_flutter/app/core/assets/app_icons.dart';
import 'package:mlm_demo_frontend_flutter/app/screens/register/controller/register_controller.dart';
import '../../../core/assets/app_images.dart';
import '../../../core/custom_widget/app_text_field.dart';
import '../../../core/custom_widget/app_button.dart';
import '../../../core/custom_widget/responsive_widget.dart';
import '../../../core/utils/app_colors.dart';
import '../../../routes/app_routes.dart';

class RegisterForm extends StatelessWidget {
  final registerKey = GlobalKey<FormState>();
  final RegisterController controller;

  RegisterForm({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 44.h),
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
          key: registerKey,
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
                'Register',
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
              SizedBox(height: 40.h),

              /// Password Field
              AppTextField(
                label: 'Sponsor',
                hint: 'Enter Address',
                controller: controller.parentIdController,
                inputFormatters: [controller.maskFormatter],
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
              SizedBox(height: 10.h),

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
                text: 'Sign Up',
                onPressed: () {
                  print(controller.parentIdController.text);
                  if (registerKey.currentState!.validate()) {
                    controller.registerUser();
                  }
                },
              ),
              SizedBox(height: 20.h),
              TextButton(
                onPressed: () {
                  Get.toNamed(AppRoutes.login);
                },
                child: Text(
                  'Already have an account? Log in',
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

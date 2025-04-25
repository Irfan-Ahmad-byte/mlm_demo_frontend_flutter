import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mlm_demo_frontend_flutter/app/core/custom_widget/responsive_widget.dart';
import 'package:mlm_demo_frontend_flutter/app/screens/login/components/login_form.dart';
import '../../../core/assets/app_images.dart';
import '../controller/login_controller.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: ResponsiveWidget.isLargeScreen(context)
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        height: 450.h,
                        width: 180.w,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            scale: 1.0,
                            image: AssetImage(AppImages.mlmSide),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20.w),
                    Expanded(child: LoginForm()),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 40.h,
                        horizontal: 20.w,
                      ),
                      child: LoginForm(),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}

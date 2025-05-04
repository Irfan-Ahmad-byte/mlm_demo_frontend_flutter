import 'package:flutter/material.dart';
import 'package:mlm_demo_frontend_flutter/app/core/custom_widget/responsive_widget.dart';

import '../../core/utils/app_colors.dart';
import 'screen/register_screen.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Title(
      title: 'Register |GrowBrow',
      color: AppColors.textColor,
      child: Scaffold(
        body: SizedBox(
          height: size.height,
          width: size.width,
          child: const ResponsiveWidget(
            largescreen: RegisterScreen(),
            mediumscreen: RegisterScreen(),
            smallscreen: RegisterScreen(),
          ),
        ),
      ),
    );
  }
}

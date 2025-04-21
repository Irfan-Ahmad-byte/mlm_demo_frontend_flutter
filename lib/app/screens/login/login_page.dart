

import 'package:flutter/material.dart';
 
import '../../core/utils/app_colors.dart';
import 'screen/login_screen.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Title(
      title: 'Login | Earn Big Profits',
      color: AppColors.textColor,
      child: Scaffold(
        body: SizedBox(
          height: size.height,
          width: size.width,
          child: LoginScreen(),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mlm_demo_frontend_flutter/app/screens/dashboard/view/screen/dashboard_screen.dart';
import '../../../core/custom_widget/responsive_widget.dart';
import '../../../core/utils/app_colors.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Title(
      title: 'Dashboard |GrowBrow',
      color: AppColors.textColor,
      child: Scaffold(
        body: SizedBox(
          height: size.height,
          width: size.width,
          child:   ResponsiveWidget(
            largescreen: DashboardScreen(),
            mediumscreen: DashboardScreen(),
            smallscreen: DashboardScreen(),
          ),
        ),
      ),
    );
  }
}

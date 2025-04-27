import 'package:flutter/material.dart';
import 'package:mlm_demo_frontend_flutter/app/screens/teambonus/view/screen/teambonus_screen.dart';
import '../../../core/custom_widget/responsive_widget.dart';
import '../../../core/utils/app_colors.dart';

class TeambonusPage extends StatelessWidget {
  const TeambonusPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Title(
      title: 'TeamBonus |GrowBrow',
      color: AppColors.textColor,
      child: Scaffold(
        body: SizedBox(
          height: size.height,
          width: size.width,
          child: const ResponsiveWidget(
            largescreen: TeambonusScreen(),
            mediumscreen: TeambonusScreen(),
            smallscreen: TeambonusScreen(),
          ),
        ),
      ),
    );
  }
}

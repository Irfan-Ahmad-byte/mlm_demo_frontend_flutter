import 'package:flutter/material.dart';
import 'package:mlm_demo_frontend_flutter/app/screens/bonus/view/screen/bonus_screen.dart';
import '../../../core/custom_widget/responsive_widget.dart';
import '../../../core/utils/app_colors.dart';

class BonusPage extends StatelessWidget {
  const BonusPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Title(
      title: 'Bonus |GrowBrow',
      color: AppColors.textColor,
      child: Scaffold(
        body: SizedBox(
          height: size.height,
          width: size.width,
          child: ResponsiveWidget(
            largescreen: BonusScreen(),
            mediumscreen: BonusScreen(),
            smallscreen: BonusScreen(),
          ),
        ),
      ),
    );
  }
}

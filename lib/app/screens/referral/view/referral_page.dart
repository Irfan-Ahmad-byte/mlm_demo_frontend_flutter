import 'package:flutter/material.dart';
import 'package:mlm_demo_frontend_flutter/app/screens/referral/view/screen/referral_screen.dart';
import '../../../core/custom_widget/responsive_widget.dart';
import '../../../core/utils/app_colors.dart';

class ReferralPage extends StatelessWidget {
  const ReferralPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Title(
      title: 'Referal |GrowBrow',
      color: AppColors.textColor,
      child: Scaffold(
        body: SizedBox(
          height: size.height,
          width: size.width,
          child: const ResponsiveWidget(
            largescreen: ReferralScreen(),
            mediumscreen: ReferralScreen(),
            smallscreen: ReferralScreen(),
          ),
        ),
      ),
    );
  }
}

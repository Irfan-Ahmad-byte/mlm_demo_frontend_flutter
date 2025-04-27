import 'package:flutter/material.dart';
import 'package:mlm_demo_frontend_flutter/app/screens/network/view/screen/network_screen.dart';
import '../../../core/custom_widget/responsive_widget.dart';
import '../../../core/utils/app_colors.dart';

class NetworkPage extends StatelessWidget {
  const NetworkPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Title(
      title: 'Network |GrowBrow',
      color: AppColors.textColor,
      child: Scaffold(
        body: SizedBox(
          height: size.height,
          width: size.width,
          child: ResponsiveWidget(
            largescreen: NetworkScreen(),
            mediumscreen: NetworkScreen(),
            smallscreen: NetworkScreen(),
          ),
        ),
      ),
    );
  }
}

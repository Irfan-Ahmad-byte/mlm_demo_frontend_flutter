import 'package:flutter/material.dart';
import 'package:mlm_demo_frontend_flutter/app/core/custom_widget/responsive_widget.dart';
import 'package:mlm_demo_frontend_flutter/app/screens/index/view/index_screen.dart';

import '../../core/utils/app_colors.dart';

class IndexPage extends StatelessWidget {
  const IndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Title(
      title: 'Index | GrowBrow',
      color: AppColors.textColor,
      child: Scaffold(
        body: SizedBox(
          height: size.height,
          width: size.width,
          child: const ResponsiveWidget(
            largescreen: IndexScreen(),
            mediumscreen: IndexScreen(),
            smallscreen: IndexScreen(),
          ),
        ),
      ),
    );
  }
}

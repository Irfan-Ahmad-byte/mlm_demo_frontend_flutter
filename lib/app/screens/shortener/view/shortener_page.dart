import 'package:flutter/material.dart';
import 'package:mlm_demo_frontend_flutter/app/screens/shortener/view/screen/shortener_screen.dart';
import '../../../core/custom_widget/responsive_widget.dart';
import '../../../core/utils/app_colors.dart';

class ShortenerPage extends StatelessWidget {
  const ShortenerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Title(
      title: 'URL Shortener |GrowBrow',
      color: AppColors.textColor,
      child: Scaffold(
        body: SizedBox(
          height: size.height,
          width: size.width,
          child: const ResponsiveWidget(
            largescreen: ShortenerScreen(),
            mediumscreen: ShortenerScreen(),
            smallscreen: ShortenerScreen(),
          ),
        ),
      ),
    );
  }
}

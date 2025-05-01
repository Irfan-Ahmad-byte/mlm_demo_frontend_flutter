import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mlm_demo_frontend_flutter/app/core/utils/app_colors.dart';
import 'package:mlm_demo_frontend_flutter/app/core/utils/app_spaces.dart';
import 'package:mlm_demo_frontend_flutter/app/core/utils/app_textstyle.dart';
import '../../../core/assets/app_icons.dart';

class ShortenIntroCard extends StatelessWidget {
  const ShortenIntroCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Stack(
        children: [
          // 🔁 Repeated logo pattern
          Positioned.fill(
            child: Opacity(
              opacity: 0.25, // light enough
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Wrap(
                  spacing: 40,
                  runSpacing: 30,
                  children: List.generate(20, (index) {
                    return SvgPicture.asset(
                      AppIcons.logo,
                      height: 30,
                      width: 30,
                      color: AppColors.secondaryColor,
                    );
                  }),
                ),
              ),
            ),
          ),

          // 🔼 Text content
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'URL Shortener Dashboard',
                    style: AppTextstyle.text14.copyWith(
                      fontSize: FontSizeManager.getFontSize(context, 16),
                      fontWeight: FontWeight.bold,
                      color: AppColors.secondaryColor,
                    ),
                  ),
                  height10,
                  Text(
                    'Track, manage and shorten your long links in one click. Clean analytics and simple controls to manage everything.',
                    style: AppTextstyle.text14.copyWith(
                      fontSize: FontSizeManager.getFontSize(context, 10),
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mlm_demo_frontend_flutter/app/core/utils/app_colors.dart';
import 'package:mlm_demo_frontend_flutter/app/core/utils/app_spaces.dart';
import 'package:mlm_demo_frontend_flutter/app/core/utils/app_textstyle.dart';
import 'package:mlm_demo_frontend_flutter/app/screens/shortener/controller/shortener_controller.dart';

import '../../components/recent_links_table.dart';
import '../../components/shorten_form.dart';
import '../../components/shorten_intro_card.dart';
import '../../components/shorten_stats_cards.dart';

class ShortenerScreen extends GetView<ShortenerController> {
  const ShortenerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShortenerController>(
      init: ShortenerController(),
      builder: (controller) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const ShortenIntroCard(),
                height20,
                const ShortenForm(),
                height20,
                const ShortenStatsCards(),
                height20,
                Text(
                  'Recent Links',
                  style: AppTextstyle.text14.copyWith(
                    fontSize: FontSizeManager.getFontSize(context, 16),
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
                height10,
                const RecentLinksTable(),
              ],
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mlm_demo_frontend_flutter/app/core/custom_widget/custom_container.dart';
import 'package:mlm_demo_frontend_flutter/app/core/utils/app_colors.dart';
import 'package:mlm_demo_frontend_flutter/app/core/utils/app_spaces.dart';
import 'package:mlm_demo_frontend_flutter/app/core/utils/app_textstyle.dart';
import 'package:mlm_demo_frontend_flutter/app/screens/shortener/controller/shortener_controller.dart';

class ShortenStatsCards extends StatelessWidget {
  const ShortenStatsCards({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ShortenerController());

    return Obx(() {
      final stats = [
        {
          'label': 'Total Links',
          'value': '${controller.totalLinks.value}',
          'icon': Icons.link
        },
        {
          'label': 'Total Clicks',
          'value': '${controller.totalClicks.value}',
          'icon': Icons.visibility
        },
        {
          'label': 'Shortened Today',
          'value': '${controller.linksToday.value}',
          'icon': Icons.today
        },
      ];

      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: stats.map((item) {
          return Expanded(
            child: CustomContainer(
              margin: EdgeInsets.symmetric(horizontal: 6.w),
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 16.h),
              child: Column(
                children: [
                  Icon(item['icon'] as IconData,
                      color: AppColors.whiteColor, size: 28),
                  height8,
                  Text(
                    item['value'] as String,
                    style: AppTextstyle.text14.copyWith(
                      color: Colors.white,
                      fontSize: FontSizeManager.getFontSize(context, 14),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  height4,
                  Text(
                    item['label'] as String,
                    textAlign: TextAlign.center,
                    style: AppTextstyle.text14.copyWith(
                      color: Colors.white70,
                      fontSize: FontSizeManager.getFontSize(context, 14),
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      );
    });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mlm_demo_frontend_flutter/app/core/custom_widget/custom_container.dart';
import 'package:mlm_demo_frontend_flutter/app/core/utils/app_colors.dart';
import 'package:mlm_demo_frontend_flutter/app/core/utils/app_spaces.dart';
import 'package:mlm_demo_frontend_flutter/app/core/utils/app_textstyle.dart';

class RecentLinksTable extends StatelessWidget {
  const RecentLinksTable({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> links = [
      {
        'original': 'https://flutter.dev/docs/perf/rendering/best-practices/',
        'short': 'https://mlm.io/a7b1x2',
        'date': 'Apr 29, 2025',
      },
      {
        'original': 'https://youtube.com/watch?v=xp3XYbzta90',
        'short': 'https://mlm.io/y89ke3',
        'date': 'Apr 28, 2025',
      },
    ];

    return Column(
      children: links.map((link) {
        return CustomContainer(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          margin: const EdgeInsets.only(bottom: 12),
          backgroundColor: AppColors.whiteColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔗 Original URL
              Text(
                'Original URL:',
                style: AppTextstyle.text14.copyWith(
                  fontSize: FontSizeManager.getFontSize(context, 12),
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                ),
              ),
              height4,
              Text(
                link['original']!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextstyle.text14.copyWith(
                  fontSize: FontSizeManager.getFontSize(context, 12),
                  color: Colors.black87,
                ),
              ),
              height10,

              // ✂️ Short Link
              Row(
                children: [
                  Expanded(
                    child: Text(
                      link['short']!,
                      style: AppTextstyle.text14.copyWith(
                        fontSize: FontSizeManager.getFontSize(context, 14),
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: link['short']!));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Link copied!'),
                          backgroundColor: Colors.green,
                          duration: Duration(seconds: 1),
                        ),
                      );
                    },
                    child: Icon(Icons.copy,
                        size: 20, color: AppColors.secondaryColor),
                  )
                ],
              ),

              height8,

              // 🕒 Date
              Text(
                'Created on ${link['date']}',
                style: AppTextstyle.text14.copyWith(
                  fontSize: FontSizeManager.getFontSize(context, 12),
                  color: AppColors.greyColor,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

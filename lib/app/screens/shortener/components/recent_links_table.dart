import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mlm_demo_frontend_flutter/app/core/custom_widget/custom_container.dart';
import 'package:mlm_demo_frontend_flutter/app/core/custom_widget/custom_snackbar.dart';
import 'package:mlm_demo_frontend_flutter/app/core/utils/app_colors.dart';
import 'package:mlm_demo_frontend_flutter/app/core/utils/app_spaces.dart';
import 'package:mlm_demo_frontend_flutter/app/core/utils/app_textstyle.dart';

import '../controller/shortener_controller.dart';
import '../models/shortened_links_model.dart';

class RecentLinksTable extends StatelessWidget {
  const RecentLinksTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ShortenerController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 🔁 Sort Toggle Button
        Align(
          alignment: Alignment.centerRight,
          child: Obx(() => TextButton.icon(
                onPressed: controller.toggleSortOrder,
                icon: Icon(
                  controller.sortDescending.value
                      ? Icons.arrow_downward
                      : Icons.arrow_upward,
                  size: 18,
                ),
                label: Text(
                  controller.sortDescending.value
                      ? 'Newest First'
                      : 'Oldest First',
                  style: AppTextstyle.text14,
                ),
              )),
        ),
        height12,

        // 📋 Sorted List
        Obx(() {
          final links = controller.filteredLinks;

          if (links.isEmpty) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('No links found.', style: AppTextstyle.text14),
            );
          }

          return Column(
            children: links
                .map((link) => _LinkTile(link: link, context: context))
                .toList(),
          );
        }),
      ],
    );
  }

  // ignore: non_constant_identifier_names
  Widget _LinkTile(
      {required ShortenedLink link, required BuildContext context}) {
    return CustomContainer(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      margin: const EdgeInsets.only(bottom: 12),
      backgroundColor: AppColors.whiteColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Original URL:',
              style: AppTextstyle.text14.copyWith(
                fontSize: FontSizeManager.getFontSize(context, 12),
                color: Colors.black54,
                fontWeight: FontWeight.w500,
              )),
          height4,
          Text(
            link.originalUrl,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextstyle.text14.copyWith(
              fontSize: FontSizeManager.getFontSize(context, 12),
              color: Colors.black87,
            ),
          ),
          height10,
          Row(
            children: [
              Expanded(
                child: Text(
                  link.shortUrl,
                  style: AppTextstyle.text14.copyWith(
                    fontSize: FontSizeManager.getFontSize(context, 14),
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Clipboard.setData(ClipboardData(text: link.shortUrl));
                  CustomSnackBar.show(
                    message: 'Link copied!',
                    backColor: Colors.green,
                  );
                },
                child:
                    Icon(Icons.copy, size: 20, color: AppColors.secondaryColor),
              )
            ],
          ),
          height8,
          Text(
            'Created on ${_formatDate(link.createdAt)}',
            style: AppTextstyle.text14.copyWith(
              fontSize: FontSizeManager.getFontSize(context, 12),
              color: AppColors.greyColor,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }
}

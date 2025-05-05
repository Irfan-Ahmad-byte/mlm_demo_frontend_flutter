import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mlm_demo_frontend_flutter/app/core/custom_widget/app_button.dart';
import 'package:mlm_demo_frontend_flutter/app/core/custom_widget/app_text_field.dart';
import 'package:mlm_demo_frontend_flutter/app/core/custom_widget/custom_container.dart';
import 'package:mlm_demo_frontend_flutter/app/core/utils/app_colors.dart';
import 'package:mlm_demo_frontend_flutter/app/core/utils/app_spaces.dart';
import 'package:mlm_demo_frontend_flutter/app/core/utils/app_textstyle.dart';
import 'package:mlm_demo_frontend_flutter/app/screens/shortener/controller/shortener_controller.dart';

class ShortenForm extends StatefulWidget {
  const ShortenForm({super.key});

  @override
  State<ShortenForm> createState() => _ShortenFormState();
}

class _ShortenFormState extends State<ShortenForm> {
  final TextEditingController _urlController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final ShortenerController _controller = Get.find<ShortenerController>();

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      padding: const EdgeInsets.all(16),
      backgroundColor: AppColors.whiteColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔗 Shorten URL Section
          Text(
            'Enter a long URL to shorten it',
            style: AppTextstyle.text14.copyWith(
              fontSize: FontSizeManager.getFontSize(context, 12),
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),
          height12,
          AppTextField(
            controller: _urlController,
            hint: 'https://your-long-url.com/page/subpage...',
          ),
          height12,
          SizedBox(
            width: double.infinity,
            child: Obx(
              () => AppButton(
                isLoading: _controller.isLoading.value,
                text: 'Shorten URL',
                textColor: AppColors.whiteColor,
                onPressed: () {
                  _controller.shortenerUrl(
                    originalUrl: _urlController.text.trim(),
                    onSuccess: (code) {
                      _codeController.text = code;
                    },
                  );
                },
              ),
            ),
          ),

          height24,

          // 🔍 Resolve Short Code Section
          Text(
            'Enter a short code to resolve it',
            style: AppTextstyle.text14.copyWith(
              fontSize: FontSizeManager.getFontSize(context, 12),
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),
          height12,
          AppTextField(
            controller: _codeController,
            hint: 'e.g. B5OWfW',
          ),
          height12,
          SizedBox(
            width: double.infinity,
            child: Obx(
              () => AppButton(
                isLoading: _controller.isLoading.value,
                text: 'Get Original URL',
                textColor: AppColors.whiteColor,
                onPressed: () {
                  _controller.getOriginalUrlFromCode(
                    shortCode: _codeController.text.trim(),
                    onSuccess: (originalUrl) {
                      _urlController.text = originalUrl;
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

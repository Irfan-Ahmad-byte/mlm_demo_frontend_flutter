import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
import 'package:mlm_demo_frontend_flutter/app/core/custom_widget/app_button.dart';
import 'package:mlm_demo_frontend_flutter/app/core/custom_widget/app_text_field.dart';
import 'package:mlm_demo_frontend_flutter/app/core/custom_widget/custom_container.dart';
import 'package:mlm_demo_frontend_flutter/app/core/utils/app_colors.dart';
import 'package:mlm_demo_frontend_flutter/app/core/utils/app_spaces.dart';
import 'package:mlm_demo_frontend_flutter/app/core/utils/app_textstyle.dart';
// import 'package:mlm_demo_frontend_flutter/app/screens/shortener/controller/shortener_controller.dart';

class ShortenForm extends StatelessWidget {
  const ShortenForm({super.key});

  @override
  Widget build(BuildContext context) {
    // final controller = Get.find<ShortenerController>();

    return CustomContainer(
      padding: const EdgeInsets.all(16),
      backgroundColor: AppColors.whiteColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Enter a long URL to shorten it',
            style: AppTextstyle.text14.copyWith(
              fontSize: FontSizeManager.getFontSize(context, 12),
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),
          height12,
          const AppTextField(
            hint: 'https://your-long-url.com/page/subpage...',
          ),
          height12,
          SizedBox(
            width: double.infinity,
            child: AppButton(
              text: 'Shorten URL',
              textColor: AppColors.whiteColor,
              // onPressed: controller.isLoading ? null : () => controller.shortenUrl(),
              onPressed: () {},
              // controller.isLoading ? null : () => controller.shortenUrl(),
              // style: ElevatedButton.styleFrom(
              //   backgroundColor: AppColors.secondaryColor,
              //   padding: EdgeInsets.symmetric(vertical: 14.h),
              // ),
              // child: controller.isLoading
              //     ? const CircularProgressIndicator(
              //         color: Colors.white,
              //         strokeWidth: 2,
              //       )
              //     : Text(
              //         'Shorten URL',
              //         style: AppTextstyle.text14.copyWith(
              //           fontSize: FontSizeManager.getFontSize(context, 12),
              //           color: Colors.white,
              //           fontWeight: FontWeight.bold,
              //         ),
              //       ),
            ),
          ),
        ],
      ),
    );
  }
}

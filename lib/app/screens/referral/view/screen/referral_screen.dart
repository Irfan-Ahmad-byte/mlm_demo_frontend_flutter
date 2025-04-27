import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mlm_demo_frontend_flutter/app/core/utils/app_colors.dart';
import 'package:mlm_demo_frontend_flutter/app/screens/referral/controller/referral_controller.dart';

class ReferralScreen extends GetView<ReferralController> {
  const ReferralScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReferralController>(
        init: ReferralController(),
        builder: (controller) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
            child: Container(
              height: 40,
              width: 40,
              color: AppColors.whiteColor,
            ),
          );
        });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mlm_demo_frontend_flutter/app/core/utils/app_colors.dart';
import '../../controller/bonus_controller.dart';

class BonusScreen extends GetView<BonusController> {
  const BonusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BonusController>(
        init: BonusController(),
        builder: (controller) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
            child: Container(
              height: 40,
              width: 40,
              color: AppColors.blackColor,
            ),
          );
        });
  }
}

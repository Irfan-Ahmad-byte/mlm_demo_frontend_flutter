import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mlm_demo_frontend_flutter/app/core/utils/app_colors.dart';
import 'package:mlm_demo_frontend_flutter/app/screens/teambonus/controller/teambonus_controller.dart';

class TeambonusScreen extends GetView<TeambonusController> {
  const TeambonusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TeambonusController>(
        init: TeambonusController(),
        builder: (controller) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
            child: Container(
              height: 40,
              width: 40,
              color: AppColors.greyColor,
            ),
          );
        });
  }
}

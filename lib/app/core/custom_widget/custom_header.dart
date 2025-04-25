import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mlm_demo_frontend_flutter/app/core/custom_widget/app_text_field.dart';
import 'package:mlm_demo_frontend_flutter/app/core/custom_widget/app_button.dart';
import 'package:mlm_demo_frontend_flutter/app/core/custom_widget/responsive_widget.dart';
import 'package:mlm_demo_frontend_flutter/app/screens/index/controller/layout_controller.dart';

import '../utils/app_colors.dart';
import '../utils/app_textstyle.dart';

class CustomHeader extends StatelessWidget {
  CustomHeader({super.key});
  final layoutController = Get.put(LayoutController());

  @override
  Widget build(BuildContext context) {
    print(Get.width);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      layoutController.calculateBonusWidth();
    });

    return Stack(
      children: [
        /// Main Background Layer
        Column(
          children: [
            Container(
              color: AppColors.primaryColor.withOpacity(0.8),
              padding: EdgeInsets.only(top: 20.h, bottom: 20.h),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Profile Row
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 24.r,
                          backgroundColor: Colors.purple,
                        ),
                        SizedBox(width: 12.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Username",
                                style: TextStyle(
                                    fontSize: FontSizeManager.getFontSize(
                                        context, 16),
                                    color: AppColors.blackColor)),
                            Text("Account No",
                                style: TextStyle(
                                    fontSize: FontSizeManager.getFontSize(
                                        context, 14),
                                    color: AppColors.blackColor)),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 16.h),

                  ResponsiveWidget.isLargeScreen(context) ||
                          ResponsiveWidget.ismediumscreen(context)
                      ? Divider(
                          color: AppColors.scaffoldColor,
                          thickness: 10,
                        )
                      : Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 2.h),
                          color: AppColors.primaryColor,
                          child: Row(
                            children: [
                              Expanded(
                                child: _mobileBonusCard(context,
                                    title: "Bonus", onPressed: () {}),
                              ),
                              SizedBox(width: 8.w),
                              Expanded(
                                child: _mobileBonusCard(context,
                                    title: "Referal", onPressed: () {}),
                              ),
                              SizedBox(width: 8.w),
                              Expanded(
                                child: _mobileBonusCard(context,
                                    title: "Team Bonus", onPressed: () {}),
                              ),
                            ],
                          ),
                        ),

                  SizedBox(height: 12.h),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Row(
                      children: [
                        /// URL Input
                        const Expanded(
                          child: AppTextField(
                            label: "URL Shortner",
                            hint: "Enter your URL",
                            backgroundColor: AppColors.whiteColor,
                            icon: Icons.link,
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),

                        /// Match Width of Bonus Container
                        ResponsiveWidget.isLargeScreen(context) ||
                                ResponsiveWidget.ismediumscreen(context)
                            ? Obx(() => SizedBox(
                                  width: layoutController.bonusWidth.value == 0
                                      ? 300.w // fallback
                                      : layoutController.bonusWidth.value,
                                ))
                            : const SizedBox.shrink()
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ResponsiveWidget.isLargeScreen(context) ||
                    ResponsiveWidget.ismediumscreen(context)
                ? Container(height: 37.h, color: AppColors.scaffoldColor)
                : const SizedBox.shrink()
          ],
        ),

        ResponsiveWidget.isLargeScreen(context) ||
                ResponsiveWidget.ismediumscreen(context)
            ? Positioned(
                top: 80.h,
                right: 0.w,
                child: FloatingBonusCards(layoutController: layoutController),
              )
            : const SizedBox.shrink()
      ],
    );
  }
}

Widget _buildBonusCard(
  BuildContext context, {
  required String title,
  required String amount,
  String? iconPath,
  bool boxShadow = true,
}) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 3.w),
    decoration: BoxDecoration(
      color: AppColors.containerColor,
      borderRadius: BorderRadius.circular(24.r),
      boxShadow: boxShadow
          ? [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(4, 6),
              ),
            ]
          : [],
    ),
    width: 150,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 20.r,
          backgroundColor: AppColors.secondaryColor,
          child: iconPath != null && iconPath.endsWith('.svg')
              ? SvgPicture.asset(
                  iconPath,
                  width: 20.w,
                  height: 20.h,
                )
              : Text(
                  '\$',
                  style: TextStyle(
                    fontSize: FontSizeManager.getFontSize(context, 12),
                    color: AppColors.blackColor,
                  ),
                ),
        ),
        SizedBox(height: 12.h),
        Text(
          title,
          style: TextStyle(
            fontSize: FontSizeManager.getFontSize(context, 12),
            fontWeight: FontWeight.bold,
            color: AppColors.blackColor,
          ),
        ),
        Text(
          amount,
          style: TextStyle(
            fontSize: FontSizeManager.getFontSize(context, 10),
            color: AppColors.blackColor,
          ),
        ),
        SizedBox(height: 12.h),
        AppButton(
          text: 'Details',
          onPressed: () {},
          width: 50,
          height: 30.h,
          backgroundColor: AppColors.whiteColor,
        )
      ],
    ),
  );
}

Widget _mobileBonusCard(
  BuildContext context, {
  required String title,
  bool boxShadow = true,
  String? iconPath,
  required void Function() onPressed,
}) {
  return StatefulBuilder(
    builder: (context, setState) {
      // 👇 MOVE this outside the builder, to preserve state
      final isHoveredNotifier = ValueNotifier(false);

      return MouseRegion(
        onEnter: (_) => isHoveredNotifier.value = true,
        onExit: (_) => isHoveredNotifier.value = false,
        child: ValueListenableBuilder<bool>(
          valueListenable: isHoveredNotifier,
          builder: (context, isHovered, _) => InkWell(
            onTap: onPressed,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 10.h),
              decoration: BoxDecoration(
                color: isHovered
                    ? AppColors.containerColor.withOpacity(0.2) // define this
                    : AppColors.containerColor,
                borderRadius: BorderRadius.circular(14.r),
                boxShadow: boxShadow
                    ? [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(4, 6),
                        ),
                      ]
                    : [],
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: 15.r,
                      backgroundColor: AppColors.secondaryColor,
                      child: iconPath != null && iconPath.endsWith('.svg')
                          ? SvgPicture.asset(
                              iconPath,
                              width: 15.w,
                              height: 15.h,
                            )
                          : Text(
                              '\$',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1, // limit to 1 line
                              // shows "..." at the end
                              softWrap:
                                  false, // avoid wrapping to the next line
                              style: TextStyle(
                                fontSize:
                                    FontSizeManager.getFontSize(context, 12),
                                color: AppColors.blackColor,
                              ),
                            ),
                    ),
                    SizedBox(width: 4.w),
                    Flexible(
                      child: Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        style: TextStyle(
                          fontSize: FontSizeManager.getFontSize(context, 10),
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}

class FloatingBonusCards extends StatefulWidget {
  final LayoutController layoutController;

  const FloatingBonusCards({super.key, required this.layoutController});

  @override
  State<FloatingBonusCards> createState() => _FloatingBonusCardsState();
}

class _FloatingBonusCardsState extends State<FloatingBonusCards> {
  final GlobalKey _localKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final ctx = _localKey.currentContext;
      if (ctx != null) {
        final box = ctx.findRenderObject() as RenderBox;
        widget.layoutController.bonusWidth.value = box.size.width;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _localKey,
      decoration: BoxDecoration(
        color: AppColors.containerColor,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(4, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          _buildBonusCard(context,
              title: 'Bonus', amount: '1000', boxShadow: false),
          SizedBox(width: 8.w),
          _buildBonusCard(context, title: 'Referral', amount: '500'),
          SizedBox(width: 8.w),
          _buildBonusCard(context, title: 'Team Bonus', amount: '2000'),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mlm_demo_frontend_flutter/app/core/custom_widget/app_text_field.dart';
import 'package:mlm_demo_frontend_flutter/app/core/custom_widget/responsive_widget.dart';
import 'package:mlm_demo_frontend_flutter/app/screens/index/controller/layout_controller.dart';
import '../../screens/index/controller/index_controller.dart';
import '../utils/app_colors.dart';
import '../utils/app_textstyle.dart';
import 'floating_bonus_cards.dart';

class CustomHeader extends StatelessWidget {
  CustomHeader({super.key, required this.controller});
  final LayoutController layoutController = Get.find<LayoutController>();

  final IndexController controller;

  @override
  Widget build(BuildContext context) {
    if (ResponsiveWidget.isSmallScreen(context) ||
        ResponsiveWidget.isCustomScreen(context)) {
      return MobileHeader(layoutController: layoutController);
    } else if (ResponsiveWidget.isMediumScreen(context) ||
        ResponsiveWidget.isLargeScreen(context)) {
      return DesktopHeader(
        layoutController: layoutController,
        controller: controller,
      );
    } else {
      return const SizedBox.shrink(); // fallback
    }
  }
}

// ------------------------------------------------------------------
// 📱 Mobile Header
// ------------------------------------------------------------------
class MobileHeader extends StatelessWidget {
  final LayoutController layoutController;
  const MobileHeader({super.key, required this.layoutController});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: AppColors.primaryColor,
          padding: EdgeInsets.only(
            top: 20.h,
          ),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  children: [
                    CircleAvatar(radius: 24.r, backgroundColor: Colors.purple),
                    SizedBox(width: 12.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Username",
                            style: TextStyle(
                                fontSize:
                                    FontSizeManager.getFontSize(context, 16),
                                color: AppColors.whiteColor)),
                        Text("Account No",
                            style: TextStyle(
                                fontSize:
                                    FontSizeManager.getFontSize(context, 14),
                                color: AppColors.whiteColor)),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16.h),

              // Inline Bonus Buttons
              Container(
                padding: EdgeInsets.symmetric(vertical: 4.h),
                color: AppColors.containerColor.withOpacity(0.8),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Obx(() {
                    final selected = layoutController.selectedBonusTab.value;

                    final defaultButtons = [
                      {'title': "Bonus", 'key': 'bonus'},
                      {'title': "Referral", 'key': 'referral'},
                      {'title': "Team Bonus", 'key': 'teamBonus'},
                    ];

                    final networkButton = {
                      'title': "Network",
                      'key': 'network'
                    };

                    List<Map<String, String>> buttons;

                    if (selected == 'bonus') {
                      buttons = [
                        networkButton,
                        defaultButtons[1],
                        defaultButtons[2],
                      ];
                    } else if (selected == 'referral') {
                      buttons = [
                        defaultButtons[0],
                        networkButton,
                        defaultButtons[2],
                      ];
                    } else if (selected == 'teamBonus') {
                      buttons = [
                        defaultButtons[0],
                        defaultButtons[1],
                        networkButton,
                      ];
                    } else {
                      buttons = defaultButtons;
                    }

                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Row(
                        children: buttons.map((btn) {
                          return Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  right: btn != buttons.last ? 8.w : 0),
                              child: _mobileBonusCard(
                                context,
                                title: btn['title']!,
                                onPressed: () {
                                  layoutController.selectBonusTab(btn['key']!);
                                },
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    );
                  }),
                ),
              ),

              // URL Shortener (Always)
              Padding(
                padding: EdgeInsets.only(
                    top: 10.h, bottom: 10.h, left: 16.w, right: 16.w),
                child: const AppTextField(
                  label: "Referal Link",
                  hint: "Copy Your Link",
                  backgroundColor: AppColors.whiteColor,
                  icon: Icons.link,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ------------------------------------------------------------------
// 🖥️ Desktop Header
// ------------------------------------------------------------------
class DesktopHeader extends StatelessWidget {
  final LayoutController layoutController;
  final IndexController controller;

  const DesktopHeader(
      {super.key, required this.layoutController, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180.h,
      width: double.infinity,
      child: Stack(
        clipBehavior: Clip.none, // 🛑 Important: Allow overflow
        children: [
          /// 🟦 Background Profile + URL + Placeholder
          Container(
            padding: EdgeInsets.only(top: 20.h),
            color: AppColors.primaryColor,
            height: 140.h, // 🛑 Small height for header only
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// 🟣 Profile Info
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 26.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                            radius: 24.r, backgroundColor: Colors.purple),
                        SizedBox(width: 8.h),
                        Column(
                          children: [
                            Text(
                              "Username",
                              style: TextStyle(
                                fontSize:
                                    FontSizeManager.getFontSize(context, 12),
                                color: AppColors.whiteColor,
                              ),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Text(
                              "Account No",
                              style: TextStyle(
                                fontSize:
                                    FontSizeManager.getFontSize(context, 10),
                                color: AppColors.whiteColor,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),

                  SizedBox(width: 20.w),

                  /// 🔵 URL Shortener Field
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: 10.h),
                      child: const AppTextField(
                        labelColors: AppColors.whiteColor,
                        label: "Referal Link",
                        hint: "Copy Your Link",
                        backgroundColor: AppColors.whiteColor,
                        icon: Icons.link,
                      ),
                    ),
                  ),

                  /// 🟢 Placeholder for Floating Cards
                  Obx(() => SizedBox(
                        width: layoutController.bonusWidth.value == 0
                            ? 300.w
                            : layoutController.bonusWidth.value,
                        height: 10.h,
                      )),
                ],
              ),
            ),
          ),

          /// 🟢 Floating Bonus Cards (Animated)
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            top: 20.h, // 🛑 floating outside header
            right: 0.w,
            child: FloatingBonusCards(
              layoutController: layoutController,
              controller: controller,
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            top: 140.h,
            left: 16.w,
            child: Obx(() {
              final labels = {
                IndexScreens.bonus: 'Bonus ',
                IndexScreens.network: 'Network',
                IndexScreens.shortener: 'Shortener',
                IndexScreens.dashboard: 'Dashboard',
              };

              String? label = labels[controller.currentScreen.value];

              if (label == null) {
                return const SizedBox.shrink();
              }

              return Text(
                label,
                style: TextStyle(
                  fontSize: FontSizeManager.getFontSize(context, 24),
                  color: AppColors.secondaryColor,
                  fontWeight: FontWeight.bold,
                ),
              );
            }),
          )
        ],
      ),
    );
  }
}

// ------------------------------------------------------------------
// 📦 Mobile Bonus Card widget
// ------------------------------------------------------------------
Widget _mobileBonusCard(
  BuildContext context, {
  required String title,
  bool boxShadow = true,
  String? iconPath,
  required void Function() onPressed,
}) {
  return StatefulBuilder(
    builder: (context, setState) {
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
                    ? AppColors.containerColor.withOpacity(0.2)
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
                              maxLines: 1,
                              softWrap: false,
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
                          color: AppColors.blackColor,
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

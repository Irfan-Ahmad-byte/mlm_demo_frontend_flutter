import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mlm_demo_frontend_flutter/app/core/utils/app_colors.dart';
import 'package:mlm_demo_frontend_flutter/app/core/custom_widget/responsive_widget.dart';

import '../../screens/index/controller/index_controller.dart';
import '../../screens/index/controller/layout_controller.dart';
import '../utils/app_textstyle.dart';
import 'app_button.dart';

class BonusButtons extends StatelessWidget {
  final IndexController controller;
  final LayoutController layoutController;

  const BonusButtons({
    super.key,
    required this.controller,
    required this.layoutController,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final selected = layoutController.selectedBonusTab.value;

      final defaultButtons = [
        {'title': "Bonus", 'key': 'bonus', 'amount': ""},
        {'title': "Shortener", 'key': 'shortener', 'amount': ""},
        {'title': "Dashboard", 'key': 'dashboard', 'amount': ""},
      ];

      final networkButton = {
        'title': "Network",
        'key': 'network',
        'amount': ""
      };

      // Filter based on selected tab
      List<Map<String, String>> buttons;

      if (selected == 'bonus') {
        buttons = [networkButton, defaultButtons[1], defaultButtons[2]];
      } else if (selected == 'shortener') {
        buttons = [defaultButtons[0], networkButton, defaultButtons[2]];
      } else if (selected == 'dashboard') {
        buttons = [defaultButtons[0], defaultButtons[1], networkButton];
      } else {
        buttons = defaultButtons;
      }

      if (ResponsiveWidget.isSmallScreen(context) ||
          ResponsiveWidget.isCustomScreen(context)) {
        // 🔹 Mobile / Custom: Show wide buttons in a Row with Expanded
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            children: buttons.map((btn) {
              return Expanded(
                child: Padding(
                  padding:
                      EdgeInsets.only(right: btn != buttons.last ? 8.w : 0),
                  child: _mobileBonusCard(
                    context,
                    title: btn['title']!,
                    onPressed: () =>
                        _handleTap(btn['key']!, controller, layoutController),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      } else {
        // 🔸 Desktop / Large: Show cards inside a decorated container
        return Container(
          padding: EdgeInsets.all(8.h),
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
            children: buttons.map((btn) {
              return Row(
                children: [
                  _floatingBonusCard(
                    title: btn['title']!,
                    amount: btn['amount']!,
                    onPressed: () =>
                        _handleTap(btn['key']!, controller, layoutController),
                  ),
                  if (btn != buttons.last) SizedBox(width: 8.w),
                ],
              );
            }).toList(),
          ),
        );
      }
    });
  }

  void _handleTap(String key, IndexController controller,
      LayoutController layoutController) {
    switch (key) {
      case 'network':
        controller.changeIndex(IndexScreens.network.index);
        break;
      case 'bonus':
        controller.changeIndex(IndexScreens.bonus.index);
        layoutController.selectBonusTab(key);
        break;
      case 'shortener':
        controller.changeIndex(IndexScreens.shortener.index);
        layoutController.selectBonusTab(key);
        break;
      case 'dashboard':
        controller.changeIndex(IndexScreens.dashboard.index);
        layoutController.selectBonusTab(key);
        break;
      case 'logout':
        controller.changeIndex(IndexScreens.logout.index);
        break;
    }
  }
}

// ignore: camel_case_types
class _floatingBonusCard extends StatefulWidget {
  final String title;
  final String amount;
  final VoidCallback onPressed;

  const _floatingBonusCard({
    required this.title,
    required this.amount,
    required this.onPressed,
  });

  @override
  State<_floatingBonusCard> createState() => _floatingBonusCardState();
}

// ignore: camel_case_types
class _floatingBonusCardState extends State<_floatingBonusCard> {
  bool isHovered = false;
  double scale = 1.0;
  double blur = 10;
  double shadowOpacity = 0.1;

  void _onEnter(PointerEvent details) {
    setState(() {
      isHovered = true;
      scale = 1.03;
      blur = 14;
      shadowOpacity = 0.2;
    });
  }

  void _onExit(PointerEvent details) {
    setState(() {
      isHovered = false;
      scale = 1.0;
      blur = 10;
      shadowOpacity = 0.1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: _onEnter,
      onExit: _onExit,
      child: AnimatedScale(
        scale: scale,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 140,
          padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 2.w),
          decoration: BoxDecoration(
            color: AppColors.containerColor,
            borderRadius: BorderRadius.circular(24.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(shadowOpacity),
                blurRadius: blur,
                offset: const Offset(4, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 20.r,
                backgroundColor: AppColors.secondaryColor,
                child: Text(
                  '\$',
                  style: TextStyle(
                    fontSize: FontSizeManager.getFontSize(context, 14),
                    color: AppColors.blackColor,
                  ),
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: FontSizeManager.getFontSize(context, 12),
                  fontWeight: FontWeight.bold,
                  color: AppColors.blackColor,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                widget.amount,
                style: TextStyle(
                  fontSize: FontSizeManager.getFontSize(context, 10),
                  color: AppColors.blackColor,
                ),
              ),
              SizedBox(height: 8.h),
              AppButton(
                text: 'Details',
                onPressed: widget.onPressed,
                width: 30,
                height: 30.h,
                backgroundColor: AppColors.whiteColor,
              ),
            ],
          ),
        ),
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
                      radius: 12.r,
                      backgroundColor: AppColors.secondaryColor,
                      child: iconPath != null && iconPath.endsWith('.svg')
                          ? SvgPicture.asset(
                              iconPath,
                              width: 12.w,
                              height: 12.h,
                            )
                          : Text(
                              '\$',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              softWrap: false,
                              style: TextStyle(
                                  fontSize:
                                      FontSizeManager.getFontSize(context, 10),
                                  color: AppColors.blackColor,
                                  fontWeight: FontWeight.w500),
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
                          fontSize: FontSizeManager.getFontSize(context, 12),
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

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mlm_demo_frontend_flutter/app/screens/index/controller/layout_controller.dart';
import '../../screens/index/controller/index_controller.dart';
import '../utils/app_colors.dart';
import '../utils/app_textstyle.dart';
import 'app_button.dart';

class FloatingBonusCards extends StatefulWidget {
  final LayoutController layoutController;
  final IndexController controller;

  const FloatingBonusCards(
      {super.key, required this.layoutController, required this.controller});

  @override
  State<FloatingBonusCards> createState() => _FloatingBonusCardsState();
}

class _FloatingBonusCardsState extends State<FloatingBonusCards> {
  final GlobalKey _localKey = GlobalKey();
  LayoutController get layoutController => widget.layoutController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final ctx = _localKey.currentContext;
      if (ctx != null) {
        final box = ctx.findRenderObject() as RenderBox;
        layoutController.bonusWidth.value = box.size.width;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final selected = layoutController.selectedBonusTab.value;
      final controller = widget.controller;

      final defaultButtons = [
        {'title': "Bonus", 'key': 'bonus', 'amount': "1000"},
        {'title': "Shortener", 'key': 'shortener', 'amount': "500"},
        {'title': "Daashboard", 'key': 'dashboard', 'amount': "2000"},
      ];

      final networkButton = {
        'title': "Network",
        'key': 'network',
        'amount': "9999"
      };

      // Filter based on selection
      List<Map<String, String>> buttons;

      if (selected == 'bonus') {
        buttons = [
          networkButton,
          defaultButtons[1],
          defaultButtons[2],
        ];
      } else if (selected == 'shortener') {
        buttons = [
          defaultButtons[0],
          networkButton,
          defaultButtons[2],
        ];
      } else if (selected == 'dashboard') {
        buttons = [
          defaultButtons[0],
          defaultButtons[1],
          networkButton,
        ];
      } else {
        // Default view
        buttons = defaultButtons;
      }

      return Container(
          key: _localKey,
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
                    onPressed: () {
                      if (btn['key'] == 'network') {
                        // 👇 Navigate to Network screen
                        controller.changeIndex(IndexScreens.network.index);
                      } else if (btn['key'] == 'bonus') {
                        layoutController.selectBonusTab(btn['key']!);
                        // 👇 Navigate to Bonus screen
                        controller.changeIndex(IndexScreens.bonus.index);
                      } else if (btn['key'] == 'shortener') {
                        controller.changeIndex(IndexScreens.shortener.index);
                      } else if (btn['key'] == 'dashboard') {
                        controller.changeIndex(IndexScreens.dashboard.index);
                      } else if (btn['key'] == 'logout') {
                        controller.changeIndex(IndexScreens.logout.index);
                      }
                      // Add any more conditions if you add more buttons
                    },
                  ),
                  if (btn != buttons.last) SizedBox(width: 8.w),
                ],
              );
            }).toList(),
          ));
    });
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

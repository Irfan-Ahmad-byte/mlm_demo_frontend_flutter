import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mlm_demo_frontend_flutter/app/core/custom_widget/app_text_field.dart';
import 'package:mlm_demo_frontend_flutter/app/core/custom_widget/bonus_button.dart';
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
    return Obx(() {
      final userName = controller.userName.value.isEmpty
          ? "Not Available"
          : controller.userName.value;
      final userAccountNo = controller.address.value.isEmpty
          ? "Not Available"
          : controller.address.value;

      if (ResponsiveWidget.isSmallScreen(context) ||
          ResponsiveWidget.isCustomScreen(context)) {
        return MobileHeader(
          onLogout: () {
            controller.logout();
          },
          userName: userName,
          userAccountNo: userAccountNo,
          layoutController: layoutController,
          controller: controller,
        );
      } else if (ResponsiveWidget.isMediumScreen(context) ||
          ResponsiveWidget.isLargeScreen(context)) {
        return DesktopHeader(
          onLogout: () {
            controller.logout();
          },
          userName: userName,
          userAccountNo: userAccountNo,
          layoutController: layoutController,
          controller: controller,
        );
      } else {
        return const SizedBox.shrink(); // fallback
      }
    });
  }
}

// ------------------------------------------------------------------
// 📱 Mobile Header
// ------------------------------------------------------------------
class MobileHeader extends StatelessWidget {
  final LayoutController layoutController;
  final IndexController controller;
  final String? userName;
  final String? userAccountNo;
  final VoidCallback onLogout;
  const MobileHeader({
    super.key,
    required this.layoutController,
    required this.controller,
    this.userName,
    this.userAccountNo,
    required this.onLogout,
  });

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
                  child: userInfoText(context,
                      userName: userName!,
                      userAccountNo: userAccountNo!,
                      onLogout: onLogout)),

              SizedBox(height: 16.h),

              // Inline Bonus Buttons
              Container(
                padding: EdgeInsets.symmetric(vertical: 4.h),
                color: AppColors.containerColor.withOpacity(0.8),
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: BonusButtons(
                        controller: controller,
                        layoutController: layoutController)),
              ),

              // URL Shortener (Always)
              Padding(
                padding: EdgeInsets.only(
                    top: 10.h, bottom: 10.h, left: 16.w, right: 16.w),
                child: referralTextField(
                  context,
                  controller.referralAddressController,
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
  final String? userName;
  final String? userAccountNo;
  final VoidCallback onLogout;

  const DesktopHeader(
      {super.key,
      required this.layoutController,
      required this.controller,
      this.userName,
      this.userAccountNo,
      required this.onLogout});

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
                      child: userInfoText(context,
                          userName: userName!,
                          userAccountNo: userAccountNo!,
                          onLogout: onLogout)),

                  SizedBox(width: 10.w),

                  /// 🔵 URL Shortener Field
                  Get.width >= 1000 || ResponsiveWidget.isLargeScreen(context)
                      ? Flexible(
                          child: Padding(
                              padding: EdgeInsets.only(top: 10.h),
                              child: referralTextField(context,
                                  controller.referralAddressController)),
                        )
                      : SizedBox.shrink(),

                  /// 🟢 Placeholder for Floating Cards
                  Obx(() => SizedBox(
                        width: layoutController.bonusWidth.value == 0
                            ? 200.w
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

Widget userInfoText(
  BuildContext context, {
  required String userName,
  required String userAccountNo,
  required VoidCallback onLogout,
}) {
  return PopupMenuButton<String>(
    onSelected: (value) {
      if (value == 'logout') {
        onLogout();
      }
    },
    offset: Offset(0, 50),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
    color: AppColors.primaryDarkColor,
    itemBuilder: (context) => [
      PopupMenuItem(
        value: 'logout',
        child: Row(
          children: [
            Icon(Icons.person, color: AppColors.whiteColor, size: 18),
            SizedBox(width: 8),
            Text("Root", style: TextStyle(color: AppColors.whiteColor)),
          ],
        ),
      ),
      PopupMenuItem(
        value: 'logout',
        child: Row(
          children: [
            Icon(Icons.logout, color: AppColors.whiteColor, size: 18),
            SizedBox(width: 8),
            Text("Logout", style: TextStyle(color: AppColors.whiteColor)),
          ],
        ),
      ),
    ],
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(radius: 24.r, backgroundColor: Colors.purple),
        SizedBox(width: 8.h),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              userName,
              style: TextStyle(
                fontSize: FontSizeManager.getFontSize(context, 16),
                color: AppColors.whiteColor,
              ),
            ),
            Text(
              userAccountNo,
              style: TextStyle(
                fontSize: FontSizeManager.getFontSize(context, 10),
                color: AppColors.whiteColor,
              ),
            ),
          ],
        ),
        Icon(Icons.arrow_drop_down, color: AppColors.whiteColor),
      ],
    ),
  );
}

Widget referralTextField(
    BuildContext context, TextEditingController controller) {
  return AppTextField(
    controller: controller,
    isReadOnly: true,
    label: "Referral Address",
    hint: "Copy Your Link",
    backgroundColor: AppColors.whiteColor,
    showSuffixIcon: true, // ✅ So the copy icon shows on the right
  );
}

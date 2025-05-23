import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mlm_demo_frontend_flutter/app/core/custom_widget/custom_container.dart';
import 'package:mlm_demo_frontend_flutter/app/core/custom_widget/responsive_widget.dart';
import 'package:mlm_demo_frontend_flutter/app/core/utils/app_spaces.dart';
import 'package:mlm_demo_frontend_flutter/app/screens/dashboard/controller/dashboard_controller.dart';
import 'package:mlm_demo_frontend_flutter/app/screens/index/controller/index_controller.dart';
import 'package:mlm_demo_frontend_flutter/app/screens/network/controller/network_controller.dart';

import '../../../../core/custom_widget/custom_snackbar.dart';
import '../../components/bonus_card.dart';
import '../../components/invite_button.dart';
import '../../components/level_card.dart';
import '../../components/referral_avatars.dart';
import '../../components/referral_card.dart';

class DashboardScreen extends StatelessWidget {
  final dashboardController = Get.put(DashboardController());
  final networkController = Get.put(NetworkController());
  final indexController = Get.put(IndexController());

  DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 230,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CustomContainer(
                      child: ReferralCard(
                        count:
                            dashboardController.getTotalDownlineCountFromModel(
                                networkController.downlines),
                      ),
                    ),
                  ),
                  if (!ResponsiveWidget.isSmallScreen(context)) ...[
                    width12,
                    Expanded(
                      child: BonusCard(
                        amount: (dashboardController
                                    .weeklyReport.value?.totalBonus ??
                                0)
                            .toDouble(),
                        withdrawable: (dashboardController
                                    .weeklyReport.value?.totalBonus ??
                                0)
                            .toDouble(),
                        networkAvg: 1000,
                        percentGrowth: 20,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (ResponsiveWidget.isSmallScreen(context)) ...[
              BonusCard(
                amount:
                    (dashboardController.weeklyReport.value?.totalBonus ?? 0)
                        .toDouble(),
                withdrawable:
                    (dashboardController.weeklyReport.value?.totalBonus ?? 0)
                        .toDouble(),
                networkAvg: 1000,
                percentGrowth: 20,
              ),
            ],
            const LevelCard(
              currentLevel: 1,
              maxLevel: 10,
              showGlow: true,
              nextMilestoneMessage:
                  "Invite 10 users to unlock next level Level ",
            ),
            InviteButton(
              onPressed: () {
                Clipboard.setData(
                  ClipboardData(text: dashboardController.userId.toString()),
                );
                CustomSnackBar.show(message: 'Copied to clipboard');
              },
            ),
            height20,
            const ReferralAvatars(
              referralNames: [
                "Ali",
                "Sara",
                "John",
                "Lina",
                "Meena",
                "Aina",
                "Ahmad",
                "Gloria",
                "Martha",
                "James",
                "Liam",
                "Emma",
                "Olivia",
                "Noah",
                "Ava",
                "Sophia",
                "Isabella",
                "Charlotte",
              ],
              totalUsers: 20,
            ),
          ],
        ),
      );
    });
  }
}

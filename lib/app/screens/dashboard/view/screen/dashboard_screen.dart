import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mlm_demo_frontend_flutter/app/core/custom_widget/custom_container.dart';
import 'package:mlm_demo_frontend_flutter/app/core/custom_widget/responsive_widget.dart';
import 'package:mlm_demo_frontend_flutter/app/screens/dashboard/controller/dashboard_controller.dart';

import '../../components/bonus_card.dart';
import '../../components/invite_button.dart';
import '../../components/level_card.dart';
import '../../components/referral_avatars.dart';
import '../../components/referral_card.dart';

class DashboardScreen extends GetView<DashboardController> {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      init: DashboardController(),
      builder: (controller) {
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 190.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      child: CustomContainer(
                        child: ReferralCard(count: 800),
                      ),
                    ),
                    if (!ResponsiveWidget.isSmallScreen(context)) ...[
                      const SizedBox(width: 12),
                      const Expanded(
                        child: BonusCard(
                          amount: 2350,
                          withdrawable: 240,
                          networkAvg: 1000,
                          percentGrowth: 20,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (ResponsiveWidget.isSmallScreen(context)) ...[
                const BonusCard(
                  amount: 2350,
                  withdrawable: 240,
                  networkAvg: 1000,
                  percentGrowth: 20,
                ),
              ],
              const LevelCard(
                currentLevel: 20,
                maxLevel: 10,
                showGlow: true,
                nextMilestoneMessage: "Invite 10 users to unlock Level 4",
              ),
              const InviteButton(),
              SizedBox(
                height: 20.h,
              ),
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
      },
    );
  }
}

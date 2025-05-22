import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mlm_demo_frontend_flutter/app/core/custom_widget/responsive_widget.dart';
import 'package:mlm_demo_frontend_flutter/app/core/utils/app_spaces.dart';
import 'package:mlm_demo_frontend_flutter/app/screens/bonus/components/list_bonus.dart';
import 'package:mlm_demo_frontend_flutter/app/screens/bonus/components/weekly_report.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_textstyle.dart';
import '../../components/bonus_history_table.dart';
import '../../components/bonus_summary_card.dart';
import '../../controller/bonus_controller.dart';

class BonusScreen extends GetView<BonusController> {
  const BonusScreen({super.key});
  static bool isMobileOrCustomScreen(BuildContext context) {
    return ResponsiveWidget.isSmallScreen(context) ||
        ResponsiveWidget.isCustomScreen(context);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BonusController>(
      init: BonusController(),
      builder: (controller) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// 💰 Summary + Graph
                BonusSummaryCard(),
                Obx(() {
                  final list = controller.bonusList;

                  if (list.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'BONUSES List',
                        style: AppTextstyle.text14.copyWith(
                          fontSize: FontSizeManager.getFontSize(context, 16),
                          color: AppColors.secondaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      height16,
                      ...list.map((bonus) {
                        final level = 'Level ${bonus.level}';
                        final type = bonus.type ?? '';
                        final date =
                            bonus.createdAt?.split('T').first ?? 'Unknown';
                        final amount = '\$${bonus.amount}';
                        final statusColor = bonus.status == 'paid'
                            ? Colors.greenAccent
                            : Colors.orangeAccent;

                        return BonusCard(
                          level: level,
                          type: type,
                          date: date,
                          amount: amount,
                          statusColor: statusColor,
                          onMarkPaid: () {
                            controller.markBonusAsPaid(bonusId: bonus.id!);
                          },
                        );
                      }),
                    ],
                  );
                }),
                height20,

                /// 📊 Breakdown + Timeline
                Obx(() {
                  final report = controller.weeklyReport.value;

                  if (report == null) return const CircularProgressIndicator();

                  return WeeklyBonusReportWidget(
                    totalBonus: report.totalBonus ?? 0,
                    count: report.count ?? 0,
                    bonuses: report.bonuses ?? [],
                  );
                }),

                /// 📜 Timeline for Mobile
                Obx(() {
                  return BonusHistoryTable(
                    entries: controller.bonusHistory.map((entry) {
                      return BonusHistoryEntry(
                        date: entry.createdAt?.split("T").first ?? "N/A",
                        source: entry.id ?? "Unknown",
                        level: entry.level ?? 0,
                        amount: entry.amount ?? 0.0,
                        status: entry.status ?? "Unknown",
                      );
                    }).toList(),
                  );
                })
              ],
            ),
          ),
        );
      },
    );
  }
}

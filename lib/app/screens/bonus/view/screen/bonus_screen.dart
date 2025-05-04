import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mlm_demo_frontend_flutter/app/core/custom_widget/responsive_widget.dart';
import 'package:mlm_demo_frontend_flutter/app/core/utils/app_spaces.dart';
import '../../components/bonus_history_table.dart';
import '../../components/bonus_breakdown_card.dart';
import '../../components/bonus_graph_card.dart';
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
                if (ResponsiveWidget.isSmallScreen(context)) ...[
                  const BonusSummaryCard(
                    amount: 2550,
                    monthlyIncrease: 120,
                  ),
                  height20,
                  const BonusGraphCard(),
                ] else ...[
                  const SizedBox(
                    height: 230,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: BonusSummaryCard(
                            amount: 2550,
                            monthlyIncrease: 120,
                          ),
                        ),
                        VerticalDivider(),
                        Expanded(child: BonusGraphCard()),
                      ],
                    ),
                  ),
                ],

                height20,

                /// 📊 Breakdown + Timeline
                const BonusBreakdownCard(),

                /// 📜 Timeline for Mobile
                BonusHistoryTable(
                  entries: [
                    BonusHistoryEntry(
                        date: "2025-05-01",
                        source: "User123",
                        level: 2,
                        amount: 120.0,
                        status: "Paid"),
                    BonusHistoryEntry(
                        date: "2025-05-02",
                        source: "User456",
                        level: 3,
                        amount: 75.0,
                        status: "Pending"),
                    // Add more entries
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

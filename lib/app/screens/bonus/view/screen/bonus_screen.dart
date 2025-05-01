import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mlm_demo_frontend_flutter/app/core/custom_widget/responsive_widget.dart';
import 'package:mlm_demo_frontend_flutter/app/core/utils/app_spaces.dart';
import '../../components/bonus_activity_table.dart';
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
                  SizedBox(
                    height: 230,
                    child: IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Expanded(
                            child: BonusSummaryCard(
                              amount: 2550,
                              monthlyIncrease: 120,
                            ),
                          ),
                          VerticalDivider(),
                          const Expanded(child: BonusGraphCard()),
                        ],
                      ),
                    ),
                  ),
                ],

                height20,

                /// 📊 Breakdown + Timeline
                SizedBox(
                  height: 520,
                  child: isMobileOrCustomScreen(context)
                      ? const BonusBreakdownCard()
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 240),
                              child: const BonusActivityTimeline(),
                            ),
                            VerticalDivider(),
                            const Expanded(child: BonusBreakdownCard()),
                          ],
                        ),
                ),

                /// 📜 Timeline for Mobile
                if (isMobileOrCustomScreen(context)) ...[
                  height20,
                  const SizedBox(
                    height: 280,
                    child: BonusActivityTimeline(),
                  ),
                ]
              ],
            ),
          ),
        );
      },
    );
  }
}

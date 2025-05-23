import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mlm_demo_frontend_flutter/app/core/assets/app_icons.dart';
import 'package:mlm_demo_frontend_flutter/app/core/custom_widget/custom_container.dart';
import 'package:mlm_demo_frontend_flutter/app/core/utils/app_colors.dart';
import 'package:mlm_demo_frontend_flutter/app/core/utils/app_textstyle.dart';

class BonusHistoryTable extends StatelessWidget {
  final List<BonusHistoryEntry> entries;

  const BonusHistoryTable({super.key, required this.entries});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return isMobile
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "BONUS HISTORY",
                style: AppTextstyle.text14.copyWith(
                  fontSize: FontSizeManager.getFontSize(context, 18),
                  color: AppColors.secondaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 12.h),
              ...entries.map((entry) => _buildMobileCard(entry)).toList(),
            ],
          )
        : CustomContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "BONUS HISTORY",
                  style: AppTextstyle.text14.copyWith(
                    fontSize: FontSizeManager.getFontSize(context, 18),
                    color: AppColors.secondaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 12.h),
                _buildTableHeader(),
                const Divider(color: Colors.white24, thickness: 1),
                ...entries.map((entry) => _buildDesktopRow(entry)).toList(),
              ],
            ),
          );
  }

  Widget _buildTableHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
              flex: 2,
              child: Text(
                textAlign: TextAlign.left,
                "Date",
                style: AppTextstyle.text14.copyWith(
                  fontSize: FontSizeManager.getFontSize(Get.context!, 12),
                  fontWeight: FontWeight.bold,
                  color: Colors.white70,
                ),
              )),
          Expanded(
              flex: 2,
              child: Text(
                textAlign: TextAlign.center,
                "Source",
                style: AppTextstyle.text14.copyWith(
                  fontSize: FontSizeManager.getFontSize(Get.context!, 12),
                  fontWeight: FontWeight.bold,
                  color: Colors.white70,
                ),
              )),
          Expanded(
              flex: 2,
              child: Text(
                textAlign: TextAlign.center,
                "Level",
                style: AppTextstyle.text14.copyWith(
                  fontSize: FontSizeManager.getFontSize(Get.context!, 12),
                  fontWeight: FontWeight.bold,
                  color: Colors.white70,
                ),
              )),
          Expanded(
              flex: 2,
              child: Text(
                textAlign: TextAlign.center,
                "Amount",
                style: AppTextstyle.text14.copyWith(
                  fontSize: FontSizeManager.getFontSize(Get.context!, 12),
                  fontWeight: FontWeight.bold,
                  color: Colors.white70,
                ),
              )),
          Expanded(
              flex: 2,
              child: Text(
                textAlign: TextAlign.center,
                "Status",
                style: AppTextstyle.text14.copyWith(
                  fontSize: FontSizeManager.getFontSize(Get.context!, 12),
                  fontWeight: FontWeight.bold,
                  color: Colors.white70,
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildDesktopRow(BonusHistoryEntry entry) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.white12, width: 0.5)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              textAlign: TextAlign.left,
              entry.date,
              style: AppTextstyle.text14.copyWith(
                fontSize: FontSizeManager.getFontSize(Get.context!, 10),
                fontWeight: FontWeight.w400,
                color: AppColors.whiteColor,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              textAlign: TextAlign.center,
              entry.source,
              style: AppTextstyle.text14.copyWith(
                fontSize: FontSizeManager.getFontSize(Get.context!, 10),
                fontWeight: FontWeight.w400,
                color: AppColors.whiteColor,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              textAlign: TextAlign.center,
              "Level ${entry.level}",
              style: AppTextstyle.text14.copyWith(
                fontSize: FontSizeManager.getFontSize(Get.context!, 10),
                fontWeight: FontWeight.w400,
                color: AppColors.whiteColor,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              textAlign: TextAlign.center,
              "\$${entry.amount.toStringAsFixed(2)}",
              style: AppTextstyle.text14.copyWith(
                fontSize: FontSizeManager.getFontSize(Get.context!, 10),
                fontWeight: FontWeight.w400,
                color: Colors.greenAccent,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: entry.status == "Paid"
                    ? Colors.green.withOpacity(0.15)
                    : Colors.orange.withOpacity(0.15),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                entry.status,
                textAlign: TextAlign.center,
                style: AppTextstyle.text14.copyWith(
                  fontSize: FontSizeManager.getFontSize(Get.context!, 10),
                  fontWeight: FontWeight.w600,
                  color: entry.status == "Paid" ? Colors.green : Colors.orange,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileCard(BonusHistoryEntry entry) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              const BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
            border:
                Border.all(color: AppColors.secondaryColor.withOpacity(0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildMobileRow(Icons.person, "User", entry.source),
              _buildMobileRow(Icons.calendar_today, "Date", entry.date),
              _buildMobileRow(Icons.bar_chart, "Level", "Level ${entry.level}"),
              _buildMobileRow(Icons.attach_money, "Amount",
                  "\$${entry.amount.toStringAsFixed(2)}",
                  valueColor: Colors.greenAccent, isBold: true),
              _buildMobileRow(
                Icons.verified,
                "Status",
                entry.status,
                valueColor:
                    entry.status == "Paid" ? Colors.green : Colors.orange,
                isBold: true,
              ),
            ],
          ),
        ),
        Positioned(
          bottom: -5,
          right: -5,
          child: Opacity(
            opacity: 0.05,
            child: SvgPicture.asset(
              AppIcons.logo,
              height: 80,
              color: AppColors.secondaryColor,
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Container(
            margin: const EdgeInsets.only(top: 8, right: 8),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.purple.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              "Milestone",
              style: TextStyle(
                fontSize: 10,
                color: Colors.purpleAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileRow(IconData icon, String label, String value,
      {Color? valueColor, bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: AppColors.secondaryColor),
          const SizedBox(width: 8),
          Expanded(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "$label: ",
                    style: AppTextstyle.text14.copyWith(
                      fontSize: 12,
                      color: AppColors.secondaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text: value,
                    style: AppTextstyle.text14.copyWith(
                      fontSize: FontSizeManager.getFontSize(Get.context!, 12),
                      fontWeight: isBold ? FontWeight.bold : FontWeight.w400,
                      color: valueColor ?? AppColors.whiteColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BonusHistoryEntry {
  final String date;
  final String source;
  final int level;
  final double amount;
  final String status;

  BonusHistoryEntry({
    required this.date,
    required this.source,
    required this.level,
    required this.amount,
    required this.status,
  });
}

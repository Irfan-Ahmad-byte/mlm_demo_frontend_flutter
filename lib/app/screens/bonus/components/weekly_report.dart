import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mlm_demo_frontend_flutter/app/core/custom_widget/custom_container.dart';
import 'package:mlm_demo_frontend_flutter/app/core/custom_widget/custom_snackbar.dart';
import 'package:mlm_demo_frontend_flutter/app/core/utils/app_textstyle.dart';
import 'package:mlm_demo_frontend_flutter/app/core/utils/app_colors.dart';

import '../models/weekly_report_model.dart';

class WeeklyBonusReportWidget extends StatelessWidget {
  final int totalBonus;
  final int count;
  final List<Bonuses> bonuses;

  const WeeklyBonusReportWidget({
    super.key,
    required this.totalBonus,
    required this.count,
    required this.bonuses,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return CustomContainer(
      border: Border.all(color: AppColors.secondaryColor.withOpacity(0.2)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("WEEKLY BONUS REPORT", style: _headerStyle(context)),
          const SizedBox(height: 12),
          isMobile ? _buildVertical(context) : _buildHorizontal(context),
        ],
      ),
    );
  }

  Widget _buildVertical(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Total Bonus", style: _labelStyle(context)),
        Text("\$$totalBonus", style: _valueStyle(context)),
        const SizedBox(height: 8),
        Text("Count", style: _labelStyle(context)),
        Text(count.toString(), style: _valueStyle(context)),
        const SizedBox(height: 16),
        _buildBonusLayout(context)
      ],
    );
  }

  Widget _buildHorizontal(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left summary panel
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Total Bonus", style: _labelStyle(context)),
              Text("\$$totalBonus", style: _valueStyle(context)),
              const SizedBox(height: 8),
              Text("Count", style: _labelStyle(context)),
              Text(count.toString(), style: _valueStyle(context)),
              const SizedBox(height: 16),
              Text("Level Breakdown", style: _labelStyle(context)),
              ..._getLevelBreakdown(context),
            ],
          ),
        ),

        VerticalDivider(),
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: bonuses.map((b) => _buildBonusCard(b, context)).toList(),
          ),
        )
      ],
    );
  }

  Widget _buildBonusLayout(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width < 600) {
      return _buildMobileLayout(context);
    } else if (width >= 600 && width < 1024) {
      return _buildMediumLayout(context);
    } else {
      return _buildDesktopLayout(context);
    }
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: bonuses.map((b) => _buildBonusCard(b, context)).toList(),
    );
  }

  Widget _buildMediumLayout(BuildContext context) {
    final firstRow = bonuses.take(3).toList(); // Cards 1–3
    final secondRow = bonuses.skip(3).take(2).toList(); // Cards 4–5

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 🟦 First Row — 3 Cards
        Row(
          children: firstRow.map((b) {
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.primaryDarkColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: AppColors.secondaryColor.withOpacity(0.2)),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: _buildBonusFieldsMedium(
                      b, context), // 👈 Use the new layout here
                ),
              ),
            );
          }).toList(),
        ),

        const SizedBox(height: 12),

        // 🟨 Second Row — 2 Cards
        if (secondRow.isNotEmpty)
          Row(
            children: secondRow.map((b) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.primaryDarkColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: AppColors.secondaryColor.withOpacity(0.2)),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: _buildBonusFieldsMedium(b, context), // 👈 Same here
                  ),
                ),
              );
            }).toList(),
          ),
      ],
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: bonuses
          .map((b) => SizedBox(
                width: (width - 100) / 3,
                child: _buildBonusCard(b, context),
              ))
          .toList(),
    );
  }

  List<Widget> _getLevelBreakdown(BuildContext context) {
    final levels = <int, double>{};
    for (final b in bonuses) {
      if (b.level != null && b.amount != null) {
        levels[b.level!] = (levels[b.level!] ?? 0) + b.amount!;
      }
    }

    return levels.entries.map((e) {
      return Text(
        "• Level ${e.key}: \$${e.value.toStringAsFixed(2)}",
        style: _valueStyle(context).copyWith(fontSize: 12),
      );
    }).toList();
  }

  Widget _buildBonusCard(Bonuses b, BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.primaryDarkColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.secondaryColor.withOpacity(0.2)),
      ),
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _buildBonusFields(b, context),
            )
          : Row(
              children: _buildBonusFields(b, context)
                  .map((widget) => Expanded(child: widget))
                  .toList(),
            ),
    );
  }

  Widget _buildBonusFieldsMedium(Bonuses b, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 🔹 First row with Date, Source, Level
        Row(
          children: [
            Expanded(
                child: _row(
                    "Date", b.createdAt?.split("T").first ?? "-", context)),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 4.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Source: ",
                      style: AppTextstyle.text14.copyWith(
                        fontSize: FontSizeManager.getFontSize(context, 10),
                        color: AppColors.secondaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Flexible(
                      child: Tooltip(
                        message: b.sourceUserId ?? "-",
                        child: Text(
                          b.sourceUserId?.substring(0, 8) ?? "-",
                          overflow: TextOverflow.ellipsis,
                          style: AppTextstyle.text14.copyWith(
                            fontSize: FontSizeManager.getFontSize(context, 10),
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    GestureDetector(
                      onTap: () {
                        Clipboard.setData(
                            ClipboardData(text: b.sourceUserId ?? ""));
                        CustomSnackBar.show(message: "Copied to clipboard");
                      },
                      child: Icon(Icons.copy,
                          size: 12, color: AppColors.secondaryColor),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(child: _row("Level", "Level ${b.level ?? '-'}", context)),
          ],
        ),

        const SizedBox(height: 6),

        // 🔹 Second row with Amount and Status
        Row(
          children: [
            Expanded(
              child: _row(
                "Amount",
                "\$${b.amount?.toStringAsFixed(2) ?? '0.00'}",
                context,
                valueColor: Colors.greenAccent,
                isBold: true,
              ),
            ),
            Expanded(
              child: _row(
                "Status",
                b.status ?? "Unknown",
                context,
                valueColor: (b.status ?? "").toLowerCase() == "paid"
                    ? Colors.green
                    : Colors.orange,
                isBold: true,
              ),
            ),
          ],
        ),
      ],
    );
  }

  List<Widget> _buildBonusFields(Bonuses b, BuildContext context) {
    return [
      _row("Date", b.createdAt?.split("T").first ?? "-", context),
      Padding(
        padding: EdgeInsets.symmetric(vertical: 4.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Source: ",
              style: AppTextstyle.text14.copyWith(
                fontSize: FontSizeManager.getFontSize(context, 10),
                color: AppColors.secondaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            Flexible(
              child: Tooltip(
                message: b.sourceUserId ?? "-",
                child: Text(
                  b.sourceUserId?.substring(0, 8) ?? "-",
                  overflow: TextOverflow.ellipsis,
                  style: AppTextstyle.text14.copyWith(
                    fontSize: FontSizeManager.getFontSize(context, 10),
                    color: AppColors.whiteColor,
                  ),
                ),
              ),
            ),
            VerticalDivider(),
            GestureDetector(
              onTap: () {
                Clipboard.setData(ClipboardData(text: b.sourceUserId ?? ""));
                CustomSnackBar.show(message: "Copied to clipboard");
              },
              child:
                  Icon(Icons.copy, size: 12, color: AppColors.secondaryColor),
            ),
          ],
        ),
      ),
      _row("Level", "Level ${b.level ?? '-'}", context),
      _row("Amount", "\$${b.amount?.toStringAsFixed(2) ?? '0.00'}", context,
          valueColor: Colors.greenAccent, isBold: true),
      _row("Status", b.status ?? "Unknown", context,
          valueColor: (b.status ?? "").toLowerCase() == "paid"
              ? Colors.green
              : Colors.orange,
          isBold: true),
    ];
  }

  Widget _row(String label, String value, BuildContext context,
      {Color? valueColor,
      bool isBold = false,
      String? fullValue,
      bool isCopyable = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "$label: ",
            style: AppTextstyle.text14.copyWith(
              fontSize: FontSizeManager.getFontSize(context, 10),
              color: AppColors.secondaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          Expanded(
            child: isCopyable
                ? MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Tooltip(
                      message: fullValue ?? value,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              value,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextstyle.text14.copyWith(
                                fontSize:
                                    FontSizeManager.getFontSize(context, 12),
                                color: valueColor ?? AppColors.whiteColor,
                                fontWeight:
                                    isBold ? FontWeight.bold : FontWeight.w400,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.copy,
                                size: 14, color: AppColors.secondaryColor),
                            onPressed: () {
                              Clipboard.setData(
                                  ClipboardData(text: fullValue ?? value));
                              CustomSnackBar.show(
                                  message: "Copied to clipboard");
                            },
                            tooltip: "Copy full ID",
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                        ],
                      ),
                    ),
                  )
                : Text(
                    value,
                    style: AppTextstyle.text14.copyWith(
                      fontSize: FontSizeManager.getFontSize(context, 10),
                      color: valueColor ?? AppColors.whiteColor,
                      fontWeight: isBold ? FontWeight.bold : FontWeight.w400,
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  TextStyle _headerStyle(BuildContext context) {
    return AppTextstyle.text14.copyWith(
      fontSize: FontSizeManager.getFontSize(context, 16),
      color: AppColors.secondaryColor,
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle _labelStyle(BuildContext context) {
    return AppTextstyle.text14.copyWith(
      fontSize: FontSizeManager.getFontSize(context, 14),
      color: AppColors.secondaryColor,
    );
  }

  TextStyle _valueStyle(BuildContext context) {
    return AppTextstyle.text14.copyWith(
      fontSize: FontSizeManager.getFontSize(context, 16),
      color: AppColors.whiteColor,
      fontWeight: FontWeight.w600,
    );
  }
}

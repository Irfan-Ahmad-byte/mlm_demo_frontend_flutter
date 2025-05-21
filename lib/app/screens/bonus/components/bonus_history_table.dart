import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mlm_demo_frontend_flutter/app/core/assets/app_icons.dart';
import 'package:mlm_demo_frontend_flutter/app/core/custom_widget/custom_container.dart';
import 'package:mlm_demo_frontend_flutter/app/core/utils/app_colors.dart';
import 'package:mlm_demo_frontend_flutter/app/core/utils/app_textstyle.dart';

class BonusHistoryTable extends StatefulWidget {
  final List<BonusHistoryEntry> entries;

  const BonusHistoryTable({super.key, required this.entries});

  @override
  State<BonusHistoryTable> createState() => _BonusHistoryTableState();
}

class _BonusHistoryTableState extends State<BonusHistoryTable> {
  List<BonusHistoryEntry> _sortedEntries = [];
  String _sortKey = 'date';
  bool _isAscending = false;

  @override
  void didUpdateWidget(covariant BonusHistoryTable oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.entries != oldWidget.entries) {
      setState(() {
        _sortedEntries = List.from(widget.entries);
        _sortEntries();
      });
    }
  }

  void _sortEntries() {
    setState(() {
      _sortedEntries.sort((a, b) {
        int comparison;
        switch (_sortKey) {
          case 'amount':
            comparison = a.amount.compareTo(b.amount);
            break;
          case 'level':
            comparison = a.level.compareTo(b.level);
            break;
          default:
            comparison = a.date.compareTo(b.date);
        }
        return _isAscending ? comparison : -comparison;
      });
    });
  }

  void _onHeaderTap(String key) {
    if (_sortKey == key) {
      _isAscending = !_isAscending;
    } else {
      _sortKey = key;
      _isAscending = true;
    }
    _sortEntries();
  }

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
              ..._sortedEntries.asMap().entries.map(
                  (entry) => _buildAnimatedCardRow(entry.value, entry.key)),
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
                ..._sortedEntries
                    .asMap()
                    .entries
                    .map((entry) => _buildAnimatedRow(entry.value, entry.key)),
              ],
            ),
          );
  }

  Widget _buildTableHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          _buildHeaderCell("Date", "date"),
          _buildHeaderCell("Source", "source", sortable: false),
          _buildHeaderCell("Level", "level"),
          _buildHeaderCell("Amount", "amount"),
          _buildHeaderCell("Status", "status", sortable: false),
        ],
      ),
    );
  }

  Widget _buildHeaderCell(String label, String key, {bool sortable = true}) {
    return Expanded(
      flex: 2,
      child: GestureDetector(
        onTap: sortable ? () => _onHeaderTap(key) : null,
        child: Row(
          children: [
            Text(label, style: const TextStyle(color: Colors.white70)),
            if (_sortKey == key)
              Icon(
                _isAscending ? Icons.arrow_upward : Icons.arrow_downward,
                size: 14,
                color: Colors.white54,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedRow(BonusHistoryEntry entry, int index) {
    return TweenAnimationBuilder(
      duration: Duration(milliseconds: 300 + (index * 100)),
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, double value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, (1 - value) * 20),
            child: child,
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.white12, width: 0.5),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Text(entry.date,
                  style: AppTextstyle.text14.copyWith(
                    fontSize: FontSizeManager.getFontSize(context, 10),
                    color: AppColors.whiteColor,
                  )),
            ),
            Expanded(
              flex: 2,
              child: Text(entry.source,
                  style: AppTextstyle.text14.copyWith(
                    fontSize: FontSizeManager.getFontSize(context, 10),
                    color: AppColors.whiteColor,
                  )),
            ),
            Expanded(
              flex: 2,
              child: Text("Level ${entry.level}",
                  style: AppTextstyle.text14.copyWith(
                    fontSize: FontSizeManager.getFontSize(context, 10),
                    color: AppColors.whiteColor,
                  )),
            ),
            Expanded(
              flex: 2,
              child: Text("\$${entry.amount.toStringAsFixed(2)}",
                  style: AppTextstyle.text14.copyWith(
                    fontSize: FontSizeManager.getFontSize(context, 10),
                    fontWeight: FontWeight.bold,
                    color: Colors.greenAccent,
                  )),
            ),
            Expanded(
              flex: 2,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: entry.status == "Paid"
                      ? Colors.green.withOpacity(0.15)
                      : Colors.orange.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  entry.status,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color:
                        entry.status == "Paid" ? Colors.green : Colors.orange,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedCardRow(BonusHistoryEntry entry, int index) {
    return TweenAnimationBuilder(
      duration: Duration(milliseconds: 300 + (index * 100)),
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, double value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, (1 - value) * 20),
            child: child,
          ),
        );
      },
      child: Stack(
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
                _buildMobileRow(
                    Icons.bar_chart, "Level", "Level ${entry.level}"),
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

          /// 🎨 Faint icon watermark
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

          /// 🏅 Milestone badge
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
      ),
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
                      fontSize: 12,
                      color: valueColor ?? AppColors.whiteColor,
                      fontWeight: isBold ? FontWeight.bold : FontWeight.w400,
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

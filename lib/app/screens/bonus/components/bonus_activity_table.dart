import 'package:flutter/material.dart';
import 'package:mlm_demo_frontend_flutter/app/core/custom_widget/custom_container.dart';
import 'package:mlm_demo_frontend_flutter/app/core/utils/app_colors.dart';
import 'package:mlm_demo_frontend_flutter/app/core/utils/app_textstyle.dart';

class BonusHistoryTable extends StatefulWidget {
  final List<BonusHistoryEntry> entries;

  const BonusHistoryTable({super.key, required this.entries});

  @override
  State<BonusHistoryTable> createState() => _BonusHistoryTableState();
}

class _BonusHistoryTableState extends State<BonusHistoryTable>
    with TickerProviderStateMixin {
  late List<BonusHistoryEntry> _sortedEntries;
  String _sortKey = 'date';
  bool _isAscending = false;

  @override
  void initState() {
    super.initState();
    _sortedEntries = List.from(widget.entries);
    _sortEntries();
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
    return CustomContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "BONUS HISTORY",
            style: AppTextstyle.text14.copyWith(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.secondaryColor,
            ),
          ),
          const SizedBox(height: 16),
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
                    style: const TextStyle(color: Colors.white))),
            Expanded(
                flex: 2,
                child: Text(entry.source,
                    style: const TextStyle(color: Colors.white))),
            Expanded(
                flex: 2,
                child: Text("Level ${entry.level}",
                    style: const TextStyle(color: Colors.white))),
            Expanded(
              flex: 2,
              child: Text(
                "\$${entry.amount.toStringAsFixed(2)}",
                style: const TextStyle(
                    color: Colors.greenAccent, fontWeight: FontWeight.bold),
              ),
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

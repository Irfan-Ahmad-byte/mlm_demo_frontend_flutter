import 'package:flutter/material.dart';
import 'package:mlm_demo_frontend_flutter/app/core/custom_widget/custom_container.dart';
import 'package:mlm_demo_frontend_flutter/app/core/utils/app_textstyle.dart';

import '../../../core/utils/app_spaces.dart';

class BonusActivityTimeline extends StatelessWidget {
  const BonusActivityTimeline({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> bonusData = [
      {
        'date': 'Apr 30, 2025',
        'type': 'Direct Bonus',
        'color': Colors.green,
        'amount': 150
      },
      {
        'date': 'Apr 29, 2025',
        'type': 'Team Bonus',
        'color': Colors.blue,
        'amount': 120
      },
      {
        'date': 'Apr 28, 2025',
        'type': 'Level Bonus',
        'color': Colors.orange,
        'amount': 80
      },
    ];

    return CustomContainer(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: List.generate(bonusData.length, (index) {
          final entry = bonusData[index];
          return Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ◉ Timeline dots and vertical line
                Column(
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: entry['color'],
                        shape: BoxShape.circle,
                      ),
                    ),
                    if (index != bonusData.length - 1)
                      Expanded(
                        child: Container(
                          width: 2,
                          color: Colors.white24,
                        ),
                      ),
                  ],
                ),
                width10,
                // 📄 Entry Content
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          entry['type'],
                          style: AppTextstyle.text14.copyWith(
                            fontSize: FontSizeManager.getFontSize(context, 13),
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          entry['date'],
                          style: AppTextstyle.text14.copyWith(
                            fontSize: FontSizeManager.getFontSize(context, 11),
                            color: Colors.white38,
                          ),
                        ),
                        height4,
                        Text(
                          '\$${entry['amount']}',
                          style: AppTextstyle.text14.copyWith(
                            fontSize: FontSizeManager.getFontSize(context, 14),
                            color: entry['color'],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

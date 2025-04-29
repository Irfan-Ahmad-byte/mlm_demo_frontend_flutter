import 'package:flutter/material.dart';
import 'package:mlm_demo_frontend_flutter/app/core/custom_widget/custom_container.dart';
import 'package:mlm_demo_frontend_flutter/app/core/utils/app_colors.dart';

import '../../../core/utils/app_textstyle.dart';

class LevelCard extends StatelessWidget {
  final int currentLevel;
  final int maxLevel;
  final bool isLoading;
  final String? nextMilestoneMessage;
  final bool showGlow;

  const LevelCard({
    super.key,
    required this.currentLevel,
    this.maxLevel = 10,
    this.isLoading = false,
    this.nextMilestoneMessage,
    this.showGlow = false,
  });

  @override
  Widget build(BuildContext context) {
    final progress = (currentLevel / maxLevel).clamp(0.0, 1.0);
    final isMax = currentLevel >= maxLevel;

    return CustomContainer(
      padding: const EdgeInsets.all(16),
      backgroundColor: AppColors.primaryColor,
      child: isLoading
          ? const SizedBox(
              height: 100,
              child: Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'CURRENT LEVEL',
                  style: AppTextstyle.text14.copyWith(
                      fontSize: FontSizeManager.getFontSize(context, 18),
                      color: AppColors.whiteColor,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 16),

                // Progress Bar with optional glow
                Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    Container(
                      height: 18,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 800),
                      height: 18,
                      width: MediaQuery.of(context).size.width * progress,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFD4AF37), Color(0xFFFBE27C)],
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: isMax || showGlow
                            ? [
                                BoxShadow(
                                  color: Colors.amberAccent.withOpacity(0.3),
                                  blurRadius: 14,
                                  spreadRadius: 2,
                                )
                              ]
                            : [],
                      ),
                    ),
                    Positioned.fill(
                      child: Center(
                        child: Text(
                          'Level $currentLevel of $maxLevel',
                          style: AppTextstyle.text14.copyWith(
                            fontSize: FontSizeManager.getFontSize(context, 10),
                            color: AppColors.whiteColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                // Percent Progress
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '${(progress * 100).round()}% complete',
                    style: AppTextstyle.text14.copyWith(
                      fontSize: FontSizeManager.getFontSize(context, 12),
                      color: Colors.white70,
                    ),
                  ),
                ),

                // 🔺 Next milestone
                if (!isMax && nextMilestoneMessage != null) ...[
                  const SizedBox(height: 10),
                  Text(
                    nextMilestoneMessage!,
                    style: AppTextstyle.text14.copyWith(
                      fontSize: FontSizeManager.getFontSize(context, 12),
                      fontStyle: FontStyle.italic,
                      color: AppColors.secondaryColor,
                    ),
                  ),
                ]
              ],
            ),
    );
  }
}

import 'dart:math';
import 'package:flutter/material.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_textstyle.dart';

class ReferralAvatars extends StatelessWidget {
  final int totalUsers;

  const ReferralAvatars(
      {super.key, this.totalUsers = 20, required List<String> referralNames});

  @override
  Widget build(BuildContext context) {
    const double avatarSize = 48;
    const double avatarSpacing = 8;
    const double avatarBlock = avatarSize + avatarSpacing;

    return LayoutBuilder(
      builder: (context, constraints) {
        final double availableWidth = constraints.maxWidth;
        final int maxFit = max(1, (availableWidth / avatarBlock).floor());

        final bool willOverflow = totalUsers > maxFit;
        final int visibleCount = willOverflow ? maxFit - 1 : totalUsers;

        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ✅ Visible avatars
            ...List.generate(
              visibleCount,
              (index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 22,
                    backgroundImage: NetworkImage(
                      'https://i.pravatar.cc/100?img=${index + 1}',
                    ),
                    backgroundColor: Colors.grey.shade200,
                  ),
                ),
              ),
            ),

            // ➕ Overflow avatar
            if (willOverflow)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.amber,
                  child: Text(
                    '+${totalUsers - visibleCount}',
                    style: AppTextstyle.text14.copyWith(
                      fontSize: FontSizeManager.getFontSize(context, 14),
                      fontWeight: FontWeight.bold,
                      color: AppColors.blackColor,
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

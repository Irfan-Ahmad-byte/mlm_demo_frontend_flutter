import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mlm_demo_frontend_flutter/app/core/utils/app_colors.dart';

import '../../../core/utils/app_textstyle.dart'; // for Clipboard

class InviteButton extends StatelessWidget {
  final String? inviteLink;
  final bool isLoading;
  final VoidCallback? onPressed;

  const InviteButton({
    super.key,
    this.inviteLink,
    this.isLoading = false,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 240,
        child: ElevatedButton(
          onPressed: isLoading
              ? null
              : () async {
                  if (inviteLink != null) {
                    await Clipboard.setData(ClipboardData(text: inviteLink!));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Invite link copied!'),
                        backgroundColor: Colors.green,
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                  if (onPressed != null) {
                    onPressed!();
                  }
                },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.secondaryColor, // Gold color
            foregroundColor: AppColors.whiteColor,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            textStyle: AppTextstyle.text14.copyWith(
              fontSize: FontSizeManager.getFontSize(context, 16),
              fontWeight: FontWeight.w600,
            ),
            // const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          ),
          child: isLoading
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                      color: Colors.black, strokeWidth: 2),
                )
              : const Text('Invite New User'),
        ),
      ),
    );
  }
}

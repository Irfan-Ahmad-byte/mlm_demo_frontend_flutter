// import 'package:ebp_flutter/app/core/custom_widgets/custom_snackbar.dart';
// import 'package:ebp_flutter/app/core/utils/app_textstyle.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../utils/app_colors.dart';

// class Loading  {

//   OverlayEntry? _overlayEntry;

//   void showOverlay(BuildContext context) {
//     if (_overlayEntry == null) {
//       _overlayEntry = OverlayEntry(
//         builder: (context) => Material(
//           color: Colors.black.withOpacity(0.5),
//           child: Center(
//             child: CircularProgressIndicator(
//               color: AppColors.secondaryColor,
//             ),
//           ),
//         ),
//       );

//       Overlay.of(context).insert(_overlayEntry!);
//     }
//   }

//   void hideOverlay() {
//     if (_overlayEntry != null) {
//       _overlayEntry!.remove();
//       _overlayEntry = null;
//     }
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/app_colors.dart';
import '../utils/app_textstyle.dart';

class CustomLoading {
  static bool isProgressVisible = false;

  ///common method for showing progress dialog
  static void show({isCancellable = false}) async {
    if (!isProgressVisible) {
      Get.dialog(
        barrierColor: AppColors.blackColor.withOpacity(0.86),
        Center(
          child: Card(
            color: AppColors.whiteColor,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    backgroundColor: Colors.transparent,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.secondaryColor,
                    ), // Dummy color to trigger the gradient
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Loading...",
                  style: AppTextstyle.text10.copyWith(
                      fontSize: FontSizeManager.getFontSize(Get.context!, 15),
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
        ),
        barrierDismissible: isCancellable,
      );
      isProgressVisible = true;
    }
  }

  ///common method for hiding progress dialog
  static void hide() {
    if (isProgressVisible) Get.back();
    isProgressVisible = false;
  }
}

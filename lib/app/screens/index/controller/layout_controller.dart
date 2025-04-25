import 'package:get/get.dart';
import 'package:flutter/material.dart';

class LayoutController extends GetxController {
  final GlobalKey bonusKey = GlobalKey();
  var bonusWidth = 0.0.obs;

  void calculateBonusWidth() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final context = bonusKey.currentContext;
      if (context != null) {
        final box = context.findRenderObject() as RenderBox?;
        if (box != null && box.hasSize) {
          bonusWidth.value = box.size.width;
          print("Bonus container width: ${bonusWidth.value}");
        }
      }
    });
  }
}

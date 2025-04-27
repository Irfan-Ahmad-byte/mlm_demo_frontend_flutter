import 'package:get/get.dart';

class LayoutController extends GetxController {
  final RxDouble bonusWidth = 0.0.obs;
  final RxString selectedBonusTab = ''.obs;
  final RxBool isBonusClicked = false.obs;

  void calculateBonusWidth() {
    // Width calculation handled in FloatingBonusCards after layout
  }

  void selectBonusTab(String tab) {
    selectedBonusTab.value = tab;
    isBonusClicked.value = true;
  }

  void clearBonusTab() {
    selectedBonusTab.value = "";
    isBonusClicked.value = false;
  }
}

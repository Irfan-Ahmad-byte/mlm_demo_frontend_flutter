import 'package:get/get.dart';

import '../controller/bonus_controller.dart';

class BonusBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BonusController());
  }
}

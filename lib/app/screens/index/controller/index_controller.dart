import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mlm_demo_frontend_flutter/app/core/custom_widget/responsive_widget.dart';
import 'package:mlm_demo_frontend_flutter/app/screens/index/controller/layout_controller.dart';

// Your available pages
enum IndexScreens {
  bonus,
  refferal,
  dashboard,
  // weeklyReport,
  network,
  // profile,
  logout,
}

class IndexController extends GetxController {
  late PageController pageController;
  late ScrollController scrollController;
  final layoutController = Get.put(LayoutController());

  final Rx<IndexScreens> currentScreen = IndexScreens.dashboard.obs;

  @override
  @override
  void onInit() {
    super.onInit();

    int initialRoute = IndexScreens.dashboard.index; // 👈 Default to network

    if (initialRoute < 0 || initialRoute >= IndexScreens.values.length) {
      initialRoute = 0;
    }

    pageController = PageController(initialPage: initialRoute);
    currentScreen.value = IndexScreens.values[initialRoute];

    scrollController = ScrollController();

    if (GetPlatform.isWeb) {
      ever(currentScreen, (_) {
        final index = currentScreen.value.index;
        pageController.jumpToPage(index);
      });
    }
  }

  void changeIndex(int index) {
    currentScreen.value = IndexScreens.values[index];
    pageController.jumpToPage(index);

    if (GetPlatform.isWeb) {
      // AppPreferences.setCurrentRoute(index);
      print(GetPlatform.isWeb);
    }

    /// 🛡️ Important: Reset selected bonus tab if not on bonus page
    if (IndexScreens.values[index] != IndexScreens.bonus) {
      layoutController.selectedBonusTab.value = "";
    }

    /// (Optional) Scroll any horizontal tab if attached
    if (scrollController.hasClients) {
      double scrollPosition = ResponsiveWidget.isSmallScreen(Get.context!)
          ? index * 70
          : index * 100;

      scrollController.animateTo(
        scrollPosition,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeOut,
      );
    }
  }

  void previousPage() {
    if (currentScreen.value.index > 0) {
      changeIndex(currentScreen.value.index - 1);
    }
  }

  void nextPage() {
    if (currentScreen.value.index < IndexScreens.values.length - 1) {
      changeIndex(currentScreen.value.index + 1);
    }
  }

  @override
  void onClose() {
    pageController.dispose();
    scrollController.dispose();
    super.onClose();
  }
}

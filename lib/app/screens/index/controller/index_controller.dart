import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mlm_demo_frontend_flutter/app/core/custom_widget/responsive_widget.dart';
import 'package:mlm_demo_frontend_flutter/app/screens/index/controller/layout_controller.dart';
import 'package:mlm_demo_frontend_flutter/app/screens/index/repository/index_repository.dart';

import '../../../api/api_preference.dart';
import '../../../core/custom_widget/custom_snackbar.dart';
import '../../../core/custom_widget/loading.dart';
import '../../../core/utils/app_colors.dart';
import '../../../routes/app_routes.dart';

// Your available pages
enum IndexScreens {
  bonus,
  shortener,
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
  final TextEditingController referralAddressController =
      TextEditingController();

  final Rx<IndexScreens> currentScreen = IndexScreens.dashboard.obs;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getMe(); // ✅ Called after build
    }); // Fetch user info on initialization

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

  final IndexRepository indexRepository = IndexRepository();
  @override
  void onClose() {
    pageController.dispose();
    scrollController.dispose();
    super.onClose();
  }

  var userName = "".obs;
  var address = "".obs;

  void getMe() async {
    try {
      CustomLoading.show();

      final accessToken = await ApiPreference.getApiToken;
      if (accessToken == null || accessToken.isEmpty) {
        CustomSnackBar.show(
          message: "Access token not found. Please login again.",
          backColor: AppColors.errorColor,
        );
        Get.offAllNamed(AppRoutes.login);
        return;
      }

      final response = await indexRepository.getMe({
        "token": accessToken.toString(),
      });

      if (response != null && response['email'] != null) {
        Get.log("User info: $response");
        userName.value = response["email"];
        address.value = response['id'];
        referralAddressController.text = response['id'];
      } else {
        CustomSnackBar.show(
          message: response['detail'] ?? "Unable to fetch user info",
          backColor: AppColors.errorColor,
        );
      }
    } catch (e) {
      Get.log("GetMe failed: $e");
      CustomSnackBar.show(
        message: "Something went wrong. Please try again.",
        backColor: AppColors.errorColor,
      );
    } finally {
      CustomLoading.hide();
    }
  }

  void logout() async {
    try {
      CustomLoading.show();

      // Remove access token from storage
      await ApiPreference.removeApiToken();

      // Reset observable user info
      userName.value = "";
      address.value = "";
      referralAddressController.clear();

      // Optionally show a message
      CustomSnackBar.show(
        message: "Logged out successfully",
        backColor: AppColors.lightGreen,
      );

      // Navigate to login screen
      Get.offAllNamed(AppRoutes.login);
    } catch (e) {
      Get.log("Logout failed: $e");
      CustomSnackBar.show(
        message: "Logout failed. Please try again.",
        backColor: AppColors.errorColor,
      );
    } finally {
      CustomLoading.hide();
    }
  }
}

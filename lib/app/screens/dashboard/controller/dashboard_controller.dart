import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mlm_demo_frontend_flutter/app/api/api_preference.dart';
import 'package:mlm_demo_frontend_flutter/app/screens/bonus/repository/bonus_repository.dart';

import '../../../core/custom_widget/custom_snackbar.dart';
import '../../../core/custom_widget/loading.dart';
import '../../../core/utils/app_colors.dart';
import '../../bonus/models/weekly_report_model.dart';
import '../../network/model/downline_model.dart';

class DashboardController extends GetxController {
  RxBool isLoading = true.obs;

  int totalReferrals = 0;
  double totalBonus = 0;
  int currentLevel = 1;
  final userId = ApiPreference.getUserId;
  final bonusRepository = BonusRepository();

  @override
  void onInit() {
    super.onInit();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchWeeklyReport();
    });
  }

  final Rx<WeeklyReportModel?> weeklyReport = Rx<WeeklyReportModel?>(null);

  void fetchWeeklyReport() async {
    try {
      isLoading.value = true;
      CustomLoading.show();

      final token = await ApiPreference.getApiToken;

      if (token == null || token.isEmpty) {
        CustomSnackBar.show(
          message: "Token not found. Please login again.",
          backColor: AppColors.errorColor,
        );
        return;
      }

      final response = await bonusRepository.getWeeklyReport({
        'token': token,
        'accept': 'application/json',
      });

      if (response != null && response is Map<String, dynamic>) {
        weeklyReport.value = WeeklyReportModel.fromJson(response);
      } else {
        CustomSnackBar.show(
          message: "Invalid response format",
          backColor: AppColors.errorColor,
        );
      }
    } catch (e) {
      Get.log("❌ Fetching weekly report failed: $e");
      CustomSnackBar.show(
        message: "Something went wrong",
        backColor: AppColors.errorColor,
      );
    } finally {
      isLoading.value = false;
      CustomLoading.hide();
    }
  }

  int getTotalDownlineCountFromModel(List<DownlineModel> downlines) {
    int count = 0;

    void countChildren(List<Children>? childrenList) {
      if (childrenList == null || childrenList.isEmpty) return;

      for (var child in childrenList) {
        count++; // ✅ Count this child
        countChildren(child.children); // ✅ Recursively count its children
      }
    }

    for (var root in downlines) {
      countChildren(root.children); // ✅ Start from each root's children
    }

    return count;
  }
  // Future<void> fetchDashboardData() async {
  //   await Future.delayed(const Duration(seconds: 2)); // Simulate API
  //   totalReferrals = 15;
  //   totalBonus = 2350;
  //   currentLevel = 3;
  //   isLoading = false;
  //   update();
  // }
}

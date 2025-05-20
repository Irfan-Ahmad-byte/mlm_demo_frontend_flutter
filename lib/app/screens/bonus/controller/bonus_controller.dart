import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mlm_demo_frontend_flutter/app/screens/bonus/repository/bonus_repository.dart';

import '../../../api/api_preference.dart';
import '../../../core/custom_widget/custom_snackbar.dart';
import '../../../core/custom_widget/loading.dart';
import '../../../core/utils/app_colors.dart';

class BonusController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final RxBool isLoading = false.obs;
  final BonusRepository bonusRepository = BonusRepository();
  final authToken = ApiPreference.getApiToken;

  void distributeReferralBonus() async {
    isLoading.value = true;
    CustomLoading.show();

    final userID = ApiPreference.getUserId;
    print(userID);

    try {
      final response = await bonusRepository.bonusDistribute(body: {
        "source_user_id": userID,
        "trigger_type": "referral",
      });

      final message = response?['detail']?.toString();
      CustomSnackBar.show(
        message: message ?? "Bonus distribution failed",
        backColor:
            message != null ? AppColors.lightGreen : AppColors.errorColor,
      );
    } catch (e) {
      Get.log("Bonus distribution failed: $e");
      CustomSnackBar.show(
        message: "Something went wrong",
        backColor: AppColors.errorColor,
      );
    } finally {
      isLoading.value = false;
      CustomLoading.hide();
    }
  }

  void listBonnus({
    required String sourceUserId,
    required void Function(String message) onSuccess,
  }) async {
    if (sourceUserId.isEmpty) {
      CustomSnackBar.show(
        message: "Missing user ID",
        backColor: AppColors.errorColor,
      );
      return;
    }

    try {
      isLoading.value = true;
      CustomLoading.show();

      final response = await bonusRepository.listBonus();

      if (response != null && response['message'] != null) {
        final msg = response['message'].toString();
        onSuccess(msg); // ✅ Callback after success
        CustomSnackBar.show(
          message: "Bonus List successfully",
          backColor: AppColors.lightGreen,
        );
      } else {
        CustomSnackBar.show(
          message: response['detail'] ?? "Bonus List failed",
          backColor: AppColors.errorColor,
        );
      }
    } catch (e) {
      Get.log("Bonus List failed: $e");
      CustomSnackBar.show(
        message: "Something went wrong",
        backColor: AppColors.errorColor,
      );
    } finally {
      isLoading.value = false;
      CustomLoading.hide();
    }
  }

  void bonusPayAll({
    required String sourceUserId,
    required void Function(String message) onSuccess,
  }) async {
    if (sourceUserId.isEmpty) {
      CustomSnackBar.show(
        message: "Missing user ID",
        backColor: AppColors.errorColor,
      );
      return;
    }

    try {
      isLoading.value = true;
      CustomLoading.show();

      final response = await bonusRepository.bonusPayAll();

      if (response != null && response['message'] != null) {
        final msg = response['message'].toString();
        onSuccess(msg); // ✅ Callback after success
        CustomSnackBar.show(
          message: "Bonus Payed successfully",
          backColor: AppColors.lightGreen,
        );
      } else {
        CustomSnackBar.show(
          message: response['detail'] ?? "Bonus Pay failed",
          backColor: AppColors.errorColor,
        );
      }
    } catch (e) {
      Get.log("Bonus Pay failed: $e");
      CustomSnackBar.show(
        message: "Something went wrong",
        backColor: AppColors.errorColor,
      );
    } finally {
      isLoading.value = false;
      CustomLoading.hide();
    }
  }

  void fetchBonusHistory({
    required void Function(List<dynamic> history) onSuccess,
  }) async {
    try {
      isLoading.value = true;
      CustomLoading.show();

      final response = await bonusRepository.getBonusHistory();

      if (response != null && response['data'] != null) {
        final historyList = response['data'] as List<dynamic>;
        onSuccess(historyList);

        CustomSnackBar.show(
          message: "Bonus history loaded",
          backColor: AppColors.lightGreen,
        );
      } else {
        CustomSnackBar.show(
          message: response['detail'] ?? "Failed to load bonus history",
          backColor: AppColors.errorColor,
        );
      }
    } catch (e) {
      Get.log("Fetching bonus history failed: $e");
      CustomSnackBar.show(
        message: "Something went wrong",
        backColor: AppColors.errorColor,
      );
    } finally {
      isLoading.value = false;
      CustomLoading.hide();
    }
  }

  void fetchWeeklyReport({
    required void Function(List<dynamic> history) onSuccess,
  }) async {
    try {
      isLoading.value = true;
      CustomLoading.show();

      final response = await bonusRepository.getWeeklyReport();

      if (response != null && response['data'] != null) {
        final historyList = response['data'] as List<dynamic>;
        onSuccess(historyList);

        CustomSnackBar.show(
          message: "Bonus Weekly Repor loaded",
          backColor: AppColors.lightGreen,
        );
      } else {
        CustomSnackBar.show(
          message: response['detail'] ?? "Failed to load bonus Weekly Report",
          backColor: AppColors.errorColor,
        );
      }
    } catch (e) {
      Get.log("Fetching bonus Weekly Report failed: $e");
      CustomSnackBar.show(
        message: "Something went wrong",
        backColor: AppColors.errorColor,
      );
    } finally {
      isLoading.value = false;
      CustomLoading.hide();
    }
  }

  void fetchUserRank({
    required void Function(List<dynamic> history) onSuccess,
  }) async {
    try {
      isLoading.value = true;
      CustomLoading.show();

      final response = await bonusRepository.getUserRank();

      if (response != null && response['data'] != null) {
        final historyList = response['data'] as List<dynamic>;
        onSuccess(historyList);

        CustomSnackBar.show(
          message: "Bonus User Rank loaded",
          backColor: AppColors.lightGreen,
        );
      } else {
        CustomSnackBar.show(
          message: response['detail'] ?? "Failed to load bonus User Rank",
          backColor: AppColors.errorColor,
        );
      }
    } catch (e) {
      Get.log("Fetching bonus User Rank failed: $e");
      CustomSnackBar.show(
        message: "Something went wrong",
        backColor: AppColors.errorColor,
      );
    } finally {
      isLoading.value = false;
      CustomLoading.hide();
    }
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mlm_demo_frontend_flutter/app/screens/bonus/models/bonus_history_model.dart';
import 'package:mlm_demo_frontend_flutter/app/screens/bonus/models/markpaid.dart';
import 'package:mlm_demo_frontend_flutter/app/screens/bonus/repository/bonus_repository.dart';

import '../../../api/api_preference.dart';
import '../../../core/custom_widget/custom_snackbar.dart';
import '../../../core/custom_widget/loading.dart';
import '../../../core/utils/app_colors.dart';
import '../models/bonus_list_model.dart';
import '../models/weekly_report_model.dart';

class BonusController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final RxBool isLoading = false.obs;
  final BonusRepository bonusRepository = BonusRepository();
  final authToken = ApiPreference.getApiToken;
  @override
  void onInit() {
    super.onInit();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // fetchUserRank(); // ✅ Called after build
      getBonusHistory();
      // listBonus();
      // bonusPayAll();
      // fetchWeeklyReport();
    });
  }

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

  final RxList<BonusListModel> bonusList = <BonusListModel>[].obs;

  void listBonus() async {
    try {
      isLoading.value = true;
      CustomLoading.show();

      final response = await bonusRepository.listBonus();

      if (response != null && response is List) {
        bonusList.value =
            response.map((item) => BonusListModel.fromJson(item)).toList();
        print(bonusList.length);

        CustomSnackBar.show(
          message: "Bonus listed successfully",
          backColor: AppColors.lightGreen,
        );
      } else {
        final detail = response?['detail'] ?? "Bonus listing failed";
        CustomSnackBar.show(
          message: detail,
          backColor: AppColors.errorColor,
        );
      }
    } catch (e) {
      Get.log("❌ Bonus list failed: $e");
      CustomSnackBar.show(
        message: "Something went wrong",
        backColor: AppColors.errorColor,
      );
    } finally {
      isLoading.value = false;
      CustomLoading.hide();
    }
  }

  final RxList<BonusHistoryModel> bonusHistory = <BonusHistoryModel>[].obs;
  // RxList<WithdrawHistoryData> bonusHistory =
  //     RxList<WithdrawHistoryData>([]);
  Future<void> getBonusHistory() async {
    try {
      final token = await ApiPreference.getApiToken;

      if (token == null || token.isEmpty) {
        CustomSnackBar.show(
          message: "Token not found. Please login again.",
          backColor: AppColors.errorColor,
        );
        return;
      }

      final response = await bonusRepository.getBonusHistory({
        'token': token,
        'accept': 'application/json',
      });

      if (response != null && response is List) {
        bonusHistory.value =
            response.map((item) => BonusHistoryModel.fromJson(item)).toList();
        print("✅ Loaded bonus history: ${bonusHistory.length} items");
      } else {
        Get.log("⚠️ Unexpected response: $response");
      }
    } catch (e) {
      Get.log("❌ Error fetching bonus history: $e");
    }
  }

  void bonusPayAll() async {
    try {
      isLoading.value = true;
      CustomLoading.show();

      final response = await bonusRepository.bonusPayAll();

      if (response != null && response['message'] != null) {
        final msg = response['message'].toString();

        CustomSnackBar.show(
          message: msg.isNotEmpty ? msg : "Bonus paid successfully",
          backColor: AppColors.lightGreen,
        );
      } else {
        final detail = response?['detail'] ?? "Bonus pay failed";
        CustomSnackBar.show(
          message: detail,
          backColor: AppColors.errorColor,
        );
      }
    } catch (e) {
      Get.log("❌ Bonus Pay failed: $e");
      CustomSnackBar.show(
        message: "Something went wrong",
        backColor: AppColors.errorColor,
      );
    } finally {
      isLoading.value = false;
      CustomLoading.hide();
    }
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

        print(
            "✅ Weekly Report loaded: ${weeklyReport.value?.totalBonus} bonus");

        CustomSnackBar.show(
          message: "Weekly report loaded",
          backColor: AppColors.lightGreen,
        );
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

  RxString userRank = ''.obs;
  void fetchUserRank() async {
    isLoading.value = true;
    CustomLoading.show();

    try {
      final token = await ApiPreference.getApiToken;

      if (token == null || token.isEmpty) {
        CustomSnackBar.show(
          message: "Access token not found. Please login again.",
          backColor: AppColors.errorColor,
        );
        return;
      }

      final response = await bonusRepository.getUserRank({
        'token': token, // 👈 matches curl -H 'token: ...'
        'accept': 'application/json', // optional but curl has it
      });
      userRank.value = response["message"];
      print(userRank.value);
      // print("✅ User Rank Response: $response");
    } catch (e) {
      Get.log("❌ Error fetching user rank: $e");
    } finally {
      isLoading.value = false;
      CustomLoading.hide();
    }
  }

  final Rx<Markpaid?> markPaid = Rx<Markpaid?>(null);

  void markBonusAsPaid({
    required String bonusId,
  }) async {
    if (bonusId.isEmpty) {
      CustomSnackBar.show(
        message: "Bonus ID is missing",
        backColor: AppColors.errorColor,
      );
      return;
    }

    try {
      isLoading.value = true;
      CustomLoading.show();

      final response = await bonusRepository.markPaid(bonusId);

      if (response != null && response is Map<String, dynamic>) {
        final msg = response['message']?.toString() ?? "Bonus marked as paid";
        markPaid.value = Markpaid.fromJson(response);
        CustomSnackBar.show(
          message: msg,
          backColor: AppColors.lightGreen,
        );
      } else {
        CustomSnackBar.show(
          message: "Unexpected response format",
          backColor: AppColors.errorColor,
        );
      }
    } catch (e) {
      Get.log("❌ Mark paid failed: $e");
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

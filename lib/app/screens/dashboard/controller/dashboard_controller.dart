import 'package:get/get.dart';

class DashboardController extends GetxController {
  bool isLoading = true;

  int totalReferrals = 0;
  double totalBonus = 0;
  int currentLevel = 1;

  @override
  void onInit() {
    super.onInit();
    fetchDashboardData();
  }

  Future<void> fetchDashboardData() async {
    await Future.delayed(const Duration(seconds: 2)); // Simulate API
    totalReferrals = 15;
    totalBonus = 2350;
    currentLevel = 3;
    isLoading = false;
    update();
  }
}

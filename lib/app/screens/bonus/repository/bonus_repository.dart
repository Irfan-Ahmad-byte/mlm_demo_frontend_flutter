import 'package:mlm_demo_frontend_flutter/app/api/api_endpoints.dart';

import '../../../api/api_client.dart';

class BonusRepository extends ApiClient {
  BonusRepository() : super();

  Future<dynamic> bonusDistribute({
    required Map<String, dynamic> body,
  }) async {
    try {
      return await apiClientRequest(
        endPoint: kBonusDistribute,
        body: body,
        method: "POST",
        useFormEncoding:
            false, // 👈 disable for application/x-www-form-urlencoded
      );
    } catch (error) {
      rethrow;
    }
  }

  Future<dynamic> listBonus() async {
    try {
      return await apiClientRequest(
        endPoint: kBonus,
        method: "POST",
        useFormEncoding:
            false, // 👈 disable for application/x-www-form-urlencoded
      );
    } catch (error) {
      rethrow;
    }
  }

  // Future<dynamic> markPaid({
  //   required Map<String, dynamic> body,
  // }) async {
  //   try {
  //     return await apiClientRequest(
  //       endPoint: kBonusMarkPaid,
  //       body: body,
  //       method: "POST",
  //       useFormEncoding:
  //           false, // 👈 disable for application/x-www-form-urlencoded
  //     );
  //   } catch (error) {
  //     rethrow;
  //   }
  // }

  Future<dynamic> bonusPayAll() async {
    try {
      return await apiClientRequest(
        endPoint: kBonusPayAll,
        method: "POST",
        useFormEncoding:
            false, // 👈 disable for application/x-www-form-urlencoded
      );
    } catch (error) {
      rethrow;
    }
  }

  Future<dynamic> getBonusHistory() async {
    try {
      return await apiClientRequest(
        endPoint: kBonusHistory,
        method: "GET",
        useFormEncoding:
            false, // 👈 disable for application/x-www-form-urlencoded
      );
    } catch (error) {
      Exception(error);
    }
  }

  Future<dynamic> getWeeklyReport() async {
    try {
      return await apiClientRequest(
        endPoint: kBonusWeeklyReport,
        method: "GET",
        useFormEncoding:
            false, // 👈 disable for application/x-www-form-urlencoded
      );
    } catch (error) {
      Exception(error);
    }
  }

  Future<dynamic> getUserRank() async {
    try {
      return await apiClientRequest(
        endPoint: kBonusRank,
        method: "GET",
        useFormEncoding:
            false, // 👈 disable for application/x-www-form-urlencoded
      );
    } catch (error) {
      Exception(error);
    }
  }
}

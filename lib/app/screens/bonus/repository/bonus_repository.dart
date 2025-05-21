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
    return await apiClientRequest(
      endPoint: kBonus,
      method: "POST",
      useFormEncoding: false, // Not x-www-form-urlencoded
      body: {}, // 👈 Empty JSON body
    );
  }

  Future<dynamic> markPaid(String bonusId) async {
    try {
      return await apiClientRequest(
        endPoint: "$kBonusMarkPaid${bonusId}", // 👈 dynamic path
        method: "POST",
        useFormEncoding: false,
        body: {}, // 👈 send empty JSON body
      );
    } catch (error) {
      rethrow;
    }
  }

  Future<dynamic> bonusPayAll() async {
    try {
      return await apiClientRequest(
          endPoint: kBonusPayAll,
          method: "POST",
          useFormEncoding:
              false, // 👈 disable for application/x-www-form-urlencoded
          body: {});
    } catch (error) {
      rethrow;
    }
  }

  Future<dynamic> getBonusHistory(Map<String, String> headers) async {
    return await apiClientRequest(
      endPoint: kBonusHistory,
      method: "GET",
      useFormEncoding: false,
      headers: headers, // ✅ includes token + accept
    );
  }

  Future<dynamic> getWeeklyReport(Map<String, String> headers) async {
    return await apiClientRequest(
      endPoint: kBonusWeeklyReport,
      method: "GET",
      useFormEncoding: false,
      headers: headers, // ✅ token goes here
    );
  }

  Future<dynamic> getUserRank(Map<String, String> headers) async {
    return await apiClientRequest(
      endPoint: kBonusRank,
      method: "GET",
      useFormEncoding: false,
      headers: headers, // 🔐 token header passed here
    );
  }
}

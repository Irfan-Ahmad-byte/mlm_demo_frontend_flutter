import 'package:mlm_demo_frontend_flutter/app/api/api_endpoints.dart';

import '../../../api/api_client.dart';

class LoginRepository extends ApiClient {
  LoginRepository() : super();

  Future<dynamic> loginUser({
    required Map<String, dynamic> body,
  }) async {
    try {
      return await apiClientRequest(
        endPoint: kLogin,
        body: body,
        method: "POST",
        useFormEncoding:
            true, // 👈 enable for application/x-www-form-urlencoded
      );
    } catch (error) {
      rethrow;
    }
  }
}

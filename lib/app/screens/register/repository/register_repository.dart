import 'package:mlm_demo_frontend_flutter/app/api/api_endpoints.dart';

import '../../../api/api_client.dart';

class RegisterRepository extends ApiClient {
  RegisterRepository() : super();

  Future<dynamic> registerUser({
    required Map<String, dynamic> body,
  }) async {
    try {
      return await apiClientRequest(
        endPoint: kSignUp,
        body: body,
        method: "POST",
        useFormEncoding: false, // 👈 disable for application/json
      );
    } catch (error) {
      rethrow;
    }
  }
}

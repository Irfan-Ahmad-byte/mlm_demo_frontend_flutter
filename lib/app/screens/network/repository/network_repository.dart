import 'package:mlm_demo_frontend_flutter/app/api/api_endpoints.dart';

import '../../../api/api_client.dart';

class NetworkRepository extends ApiClient {
  NetworkRepository() : super();

  Future<dynamic> getMe(Map<String, String> headers) async {
    try {
      return await apiClientRequest(
        endPoint: kDownline,
        method: "GET",
        headers: headers, // ✅ Full headers map
      );
    } catch (error) {
      rethrow;
    }
  }
}

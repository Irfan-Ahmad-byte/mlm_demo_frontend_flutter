import '../../../api/api_client.dart';
import '../../../api/api_endpoints.dart';

class IndexRepository extends ApiClient {
  Future<dynamic> getMe(Map<String, String> headers) async {
    try {
      return await apiClientRequest(
        endPoint: kGetMe,
        method: "GET",
        // headers: headers, // ✅ Full headers map
      );
    } catch (error) {
      rethrow;
    }
  }

  Future<dynamic> logOut(Map<String, String> headers) async {
    try {
      return await apiClientRequest(
        endPoint: kLogout,
        method: "GET",
        headers: headers, // ✅ Full headers map
      );
    } catch (error) {
      rethrow;
    }
  }
}

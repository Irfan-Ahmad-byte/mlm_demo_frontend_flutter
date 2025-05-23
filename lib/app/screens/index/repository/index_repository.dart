import '../../../api/api_client.dart';
import '../../../api/api_endpoints.dart';

class IndexRepository extends ApiClient {
 Future<dynamic> getMe(String token) async {
    return await apiClientRequest(
      endPoint: "/auth/me",
      method: "GET",
      headers: {
        "accept": "application/json",
        "token": token, // ✅ Header key as per your curl
      },
    );
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

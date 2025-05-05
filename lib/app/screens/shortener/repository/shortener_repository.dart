import 'package:mlm_demo_frontend_flutter/app/api/api_endpoints.dart';

import '../../../api/api_client.dart';

class ShortenerRepository extends ApiClient {
  ShortenerRepository() : super();

  Future<dynamic> shortUrl({
    required Map<String, dynamic> body,
  }) async {
    try {
      return await apiClientRequest(
        endPoint: kShortenUrl,
        body: body,
        method: "POST",
        useFormEncoding:
            false, // 👈 disable for application/x-www-form-urlencoded
      );
    } catch (error) {
      rethrow;
    }
  }

  Future<dynamic> getShortenCode({
    // required Map<String, dynamic> body,
    required String shortCode,
  }) async {
    try {
      return await apiClientRequest(
        endPoint: "$kGetShortencode$shortCode",
        method: "GET",
        useFormEncoding:
            false, // 👈 disable for application/x-www-form-urlencoded
      );
    } catch (error) {
      Exception(error);
    }
  }
}

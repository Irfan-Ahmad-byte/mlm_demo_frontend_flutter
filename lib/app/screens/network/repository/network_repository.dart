import 'package:mlm_demo_frontend_flutter/app/api/api_endpoints.dart';
import 'package:mlm_demo_frontend_flutter/app/screens/network/model/downline_model.dart';

import '../../../api/api_client.dart';

class NetworkRepository extends ApiClient {
  NetworkRepository() : super();

  Future<List<DownlineModel>> getDownline(Map<String, String> headers) async {
    try {
      final response = await apiClientRequest(
        endPoint: kDownline,
        method: "GET",
        headers: headers,
      );

       if (response is List) {
        return response.map((e) => DownlineModel.fromJson(e)).toList();
      }

      return [];
    } catch (error) {
      rethrow;
    }
  }

}

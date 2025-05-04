import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../core/custom_widget/custom_snackbar.dart';
import '../core/custom_widget/loading.dart';
import '../core/utils/app_colors.dart';

class ApiClient {
  static const String baseUrl = "https://api.irfan-ahmad.com";

  final box = GetStorage();

  /// Helper: builds the full API URL
  String _prepareUrl(String endpoint) {
    final cleanBase = baseUrl.endsWith("/")
        ? baseUrl.substring(0, baseUrl.length - 1)
        : baseUrl;
    final cleanEndpoint =
        endpoint.startsWith("/") ? endpoint.substring(1) : endpoint;
    return "$cleanBase/$cleanEndpoint";
  }

  /// Helper: encodes a map into x-www-form-urlencoded
  String _encodeFormBody(Map<String, dynamic> data) {
    return data.entries
        .map((e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value.toString())}')
        .join('&');
  }

  /// Main request handler
  Future<dynamic> apiClientRequest({
    required String endPoint,
    dynamic body,
    required String method,
    bool useFormEncoding = false,
    Map<String, String>? headers,
  }) async {
    try {
      final url = Uri.parse(_prepareUrl(endPoint));

      /// Default headers
      final defaultHeaders = {
        'Accept': 'application/json',
        if (useFormEncoding)
          'Content-Type': 'application/x-www-form-urlencoded'
        else
          'Content-Type': 'application/json',
      };

      /// Add token if available
      final token = box.read<String>('api_token');
      if (token != null && token.isNotEmpty) {
        defaultHeaders['Authorization'] = 'Bearer $token';
      }

      /// Merge user-provided headers
      if (headers != null) {
        defaultHeaders.addAll(headers);
      }

      /// Remove stale token if form-based request (like login)
      if (useFormEncoding && token != null) {
        box.remove('api_token');
      }

      http.Response response;

      switch (method.toUpperCase()) {
        case 'POST':
          response = await http.post(
            url,
            headers: defaultHeaders,
            body: useFormEncoding ? _encodeFormBody(body) : jsonEncode(body),
          );
          break;
        case 'GET':
          response = await http.get(url, headers: defaultHeaders);
          break;
        case 'PUT':
          response = await http.put(
            url,
            headers: defaultHeaders,
            body: useFormEncoding ? _encodeFormBody(body) : jsonEncode(body),
          );
          break;
        case 'DELETE':
          response = await http.delete(url, headers: defaultHeaders);
          break;
        default:
          throw Exception("Unsupported HTTP method");
      }

      /// Debug
      debugPrint(
          "\u27a1️ [${method.toUpperCase()}] $url\nStatus: ${response.statusCode}\nBody: ${response.body}");

      /// Success
      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      }

      /// Unauthorized – clear token
      if (response.statusCode == 401) {
        box.remove('api_token');
      }

      /// Error handling
      final responseBody = jsonDecode(response.body);
      final message = responseBody['detail'] ??
          responseBody['message'] ??
          'Something went wrong';

      CustomSnackBar.show(message: message, backColor: AppColors.errorColor);
      return Future.error(message);
    } catch (e) {
      debugPrint("\u274c ApiClient Exception: $e");
      CustomSnackBar.show(
          message: "Network error: $e", backColor: AppColors.errorColor);
      return Future.error(e);
    } finally {
      CustomLoading.hide();
    }
  }
}

import 'package:get_storage/get_storage.dart';

const String _apiToken = "api_token";
const String userId = "userId";

class ApiPreference {
  static setApiToken(String value) => GetStorage().write(_apiToken, value);

  /// Get Api Token
  static get getApiToken => GetStorage().read<String>(_apiToken);

  /// Remove Api Token
  static removeApiToken() => GetStorage().remove(_apiToken);
  static setUserId(String value) => GetStorage().write(userId, value);

  /// Get Api Token
  static get getUserId => GetStorage().read<String>(userId);

  /// Remove Api Token
  static removeUserId() => GetStorage().remove(userId);
}

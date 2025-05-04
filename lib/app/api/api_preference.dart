import 'package:get_storage/get_storage.dart';

const String _apiToken = "api_token";

class ApiPreference {
  static setApiToken(String value) => GetStorage().write(_apiToken, value);

  /// Get Api Token
  static get getApiToken => GetStorage().read<String>(_apiToken);

  /// Remove Api Token
  static removeApiToken() => GetStorage().remove(_apiToken);
}

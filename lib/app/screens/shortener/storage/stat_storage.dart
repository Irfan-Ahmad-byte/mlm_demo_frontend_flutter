import 'package:get_storage/get_storage.dart';

class LocalStatsStorage {
  static final _storage = GetStorage();

  static String _key(String baseKey, String userId) => '${baseKey}_$userId';

  static int getTotalLinks(String userId) =>
      _storage.read(_key('total_links', userId)) ?? 0;

  static int getTotalClicks(String userId) =>
      _storage.read(_key('total_clicks', userId)) ?? 0;

  static int getLinksToday(String userId) =>
      _storage.read(_key('links_today', userId)) ?? 0;

  static String? getLastResetDate(String userId) =>
      _storage.read(_key('last_reset_date', userId));

  static void setTotalLinks(String userId, int value) =>
      _storage.write(_key('total_links', userId), value);

  static void setTotalClicks(String userId, int value) =>
      _storage.write(_key('total_clicks', userId), value);

  static void setLinksToday(String userId, int value) =>
      _storage.write(_key('links_today', userId), value);

  static void setLastResetDate(String userId, String date) =>
      _storage.write(_key('last_reset_date', userId), date);

  static void incrementTotalLinks(String userId) =>
      setTotalLinks(userId, getTotalLinks(userId) + 1);

  static void incrementTotalClicks(String userId) =>
      setTotalClicks(userId, getTotalClicks(userId) + 1);

  static void incrementLinksToday(String userId) =>
      setLinksToday(userId, getLinksToday(userId) + 1);

  static void resetIfNewDay(String userId) {
    final today = DateTime.now().toIso8601String().split('T').first;
    if (getLastResetDate(userId) != today) {
      setLinksToday(userId, 0);
      setLastResetDate(userId, today);
    }
  }
}

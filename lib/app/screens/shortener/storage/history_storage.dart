import 'package:get_storage/get_storage.dart';
import '../models/shortened_links_model.dart';

class LinkStorage {
  static final _storage = GetStorage();

  static String _userKey(String uid) => 'shortened_links_$uid';

  static List<ShortenedLink> getAllLinks(String uid) {
    final List<dynamic>? rawList = _storage.read(_userKey(uid));
    if (rawList == null) return [];
    return rawList
        .map((e) => ShortenedLink.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  static void addLink(String uid, ShortenedLink link) {
    final links = getAllLinks(uid);
    links.insert(0, link); // latest first
    _storage.write(_userKey(uid), links.map((e) => e.toJson()).toList());
  }

  static void clearAll(String uid) => _storage.remove(_userKey(uid));
}


import 'package:shared_preferences/shared_preferences.dart';

class FavoritesService {
  static const _key = 'favorite_code_ids';

  Future<Set<String>> load() async {
    final prefs = await SharedPreferences.getInstance();
    return (prefs.getStringList(_key) ?? <String>[]).toSet();
  }

  Future<void> toggle(String id, Set<String> current) async {
    final prefs = await SharedPreferences.getInstance();
    final next = {...current};
    if (!next.add(id)) next.remove(id);
    await prefs.setStringList(_key, next.toList());
  }
}

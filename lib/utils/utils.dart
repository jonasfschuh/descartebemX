import 'package:intl/intl.dart';

class Utils {
  static bool onLineMode = true;
  static String getDateTime() {
    return DateFormat('dd-MM-yyyy kk:mm').format(DateTime.now().toLocal());
  }

  static Map<String, dynamic> addKeyIntoMapValue(Map<String, dynamic> map) {
    map.forEach((key, value) {
      map[key]["key"] = key;
    });
    return Map<String, dynamic>.from(map);
  }
}

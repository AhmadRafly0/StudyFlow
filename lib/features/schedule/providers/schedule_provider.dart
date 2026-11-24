import 'package:flutter/foundation.dart';

class ScheduleProvider extends ChangeNotifier {
  /// Dipanggil saat Logout: kosongkan data & hentikan stream/listener.
  void clear() {
    notifyListeners();
  }
}

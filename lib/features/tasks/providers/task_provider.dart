import 'package:flutter/foundation.dart';

class TaskProvider extends ChangeNotifier {
  /// Dipanggil saat Logout: kosongkan data & hentikan stream/listener.
  void clear() {
    notifyListeners();
  }
}

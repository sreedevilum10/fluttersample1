import 'package:flutter/foundation.dart';

/// CounterProvider holds the counter state.
/// It extends ChangeNotifier so it can broadcast changes to listeners.
class CounterProvider extends ChangeNotifier {
  // ── Private State ──────────────────────────────────────────────
  int _count = 0;

  // ── Public Getter ──────────────────────────────────────────────
  /// Exposes _count as read-only. External code cannot set it directly.
  int get count => _count;

  // ── Public Methods ─────────────────────────────────────────────

  /// Increments the counter by 1 and notifies all listening widgets.
  void increment() {
    _count++;
    notifyListeners(); // ← triggers a rebuild in every listening widget
  }

  /// Decrements the counter (minimum 0) and notifies listeners.
  void decrement() {
    if (_count > 0) {
      _count--;
    }
    notifyListeners();
  }

  /// Resets the counter to 0 and notifies listeners.
  void reset() {
    _count = 0;
    notifyListeners();
  }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  // }
}

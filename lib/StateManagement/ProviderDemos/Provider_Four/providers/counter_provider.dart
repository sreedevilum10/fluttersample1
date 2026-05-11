import 'package:flutter/foundation.dart';

/// Represents a single history entry.
class HistoryEntry {
  final String description;
  final int resultValue;
  final DateTime timestamp;

  HistoryEntry({
    required this.description,
    required this.resultValue,
  }) : timestamp = DateTime.now();
}

/// CounterProvider — full-featured counter with:
///  - configurable step size
///  - min/max limits
///  - operation history (last 10 entries)
///  - undo support
class CounterProvider extends ChangeNotifier {
  // ── State ──────────────────────────────────────────────────────
  int _count = 0;
  int _step = 1;
  final List<HistoryEntry> _history = [];

  static const int maxCount = 100;
  static const int minCount = -100;

  // ── Getters ────────────────────────────────────────────────────
  int get count => _count;
  int get step => _step;
  List<HistoryEntry> get history => List.unmodifiable(_history);
  bool get hasHistory => _history.isNotEmpty;

  /// True when the counter has reached its upper limit.
  bool get isAtMax => _count >= maxCount;

  /// True when the counter has reached its lower limit.
  bool get isAtMin => _count <= minCount;

  // ── Stack for undo support ─────────────────────────────────────
  final List<int> _undoStack = [];

  // ── Public Methods ─────────────────────────────────────────────

  void increment() {
    if (isAtMax) return;
    _pushUndo();
    _count += _step;
    _addHistory('+ $_step  →  $_count');
    notifyListeners();
  }

  void decrement() {
    if (isAtMin) return;
    _pushUndo();
    _count -= _step;
    _addHistory('− $_step  →  $_count');
    notifyListeners();
  }

  void reset() {
    if (_count == 0) return;
    _pushUndo();
    _count = 0;
    _addHistory('Reset  →  0');
    notifyListeners();
  }

  void setStep(int newStep) {
    if (newStep == _step) return;
    _step = newStep;
    notifyListeners();
  }

  /// Undoes the last operation by restoring the previous count.
  void undo() {
    if (_undoStack.isEmpty) return;
    _count = _undoStack.removeLast();
    if (_history.isNotEmpty) _history.removeAt(0);
    notifyListeners();
  }

  void clearHistory() {
    _history.clear();
    notifyListeners();
  }

  // ── Private Helpers ────────────────────────────────────────────
  void _pushUndo() {
    _undoStack.add(_count);
    if (_undoStack.length > 20) _undoStack.removeAt(0);
  }

  void _addHistory(String description) {
    _history.insert(0, HistoryEntry(description: description, resultValue: _count));
    if (_history.length > 10) _history.removeLast();
  }
}

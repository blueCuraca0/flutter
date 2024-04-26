import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants/c_colors.dart';

class Habit {
  late final String _name;
  late final Color _color;
  // late Map<DateTime, bool> _wasDone;
  late Map<DateTime, bool> _wasDone;
  late String _docID = "";

  Habit({
    required String name,
    Color color = CColors.orange,
    Map<DateTime, bool>? wasDone,
    String? docID
  }) {
    _name = name;
    _color = color;

    if (wasDone != null) {
      _wasDone = wasDone;
    } else {
      _wasDone = {
        DateTime.now().subtract(const Duration(days: 2)): false,
        DateTime.now().subtract(const Duration(days: 1)): false,
        DateTime.now(): false,
      };
    }

    if (docID != null) {
      _docID = docID;
    }
  }

  String get name => _name;

  Color get color => _color;

  Map<DateTime, bool> get wasDone => _wasDone;

  String get docID => _docID;

  void newDate() {
    _wasDone[DateTime.now()] = false;
  }
}

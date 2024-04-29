import 'dart:ui';

import 'package:monumental_habits/services/converter.dart';
import '../constants/c_colors.dart';

class Habit {
  late final String _name;
  late final Color _color;
  late Map<String, bool> _wasDone;
  late String _docID = "";

  Habit({
    required String name,
    Color color = CColors.orange,
    Map<String, bool>? wasDone,
    String? docID
  }) {
    _name = name;
    _color = color;

    if (wasDone != null) {
      _wasDone = wasDone;
    } else {
      _wasDone = {
        Converter.datetimeToString(DateTime.now().subtract(const Duration(days: 2))): false,
        Converter.datetimeToString(DateTime.now().subtract(const Duration(days: 1))): false,
        Converter.datetimeToString(DateTime.now()): false,
      };
    }

    if (docID != null) {
      _docID = docID;
    }
  }

  String get name => _name;

  Color get color => _color;

  Map<String, bool> get wasDone => _wasDone;

  String get docID => _docID;

  void newDate() {
    _wasDone[Converter.datetimeToString(DateTime.now())] = false;
  }
}

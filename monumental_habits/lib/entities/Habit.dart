import 'dart:ui';

import '../constants/c_colors.dart';

class Habit {
  late final String _name;
  late final Color _color;
  late final List<bool> _wasDone;

  Habit({required String name, Color color = CColors.orange}) {
    _name = name;
    _color = color;
    _wasDone = [false, false, false];
  }

  String get name => _name;

  Color get color => _color;

  List<bool> get wasDone => _wasDone;

  void newDate() {
    _wasDone.add(false);
  }
}

class Habit {
  late final String _name;
  late final List<bool> _wasDone;

  Habit({required String name}) {
    _name = name;
    _wasDone = [false, false, false];
  }

  String get name => _name;

  List<bool> get wasDone => _wasDone;

  void newDate() {
    _wasDone.add(false);
  }
}

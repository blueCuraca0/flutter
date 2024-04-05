class Habit {
  late final String _name;
  late final List<bool> _wasDone;

  Habit({
    required String name,
    required List<bool> wasDone
  }) {
    _name = name;
    _wasDone = wasDone;
  }

  void newDate() {
    _wasDone.add(false);
  }

  void changeWasDone() {
    _wasDone.last = !_wasDone.last;
  }

  String get name => _name;

  List<bool> get wasDone => _wasDone;
}

import 'package:flutter/material.dart';
import 'package:monumental_habits/widgets/HabitList.dart';
import 'entities/Habit.dart';

class Model extends ChangeNotifier {
  final List<Habit> _habits = [];
  List<Habit> get habits => _habits;

  final List<HabitTile> _habitTiles = [];
  List<HabitTile> get habitTiles => _habitTiles;

  void addHabitAndTile (Habit habit) {
    _habits.add(habit);
    _habitTiles.add(HabitTile(habit));
    notifyListeners();
    // printHabits();
  }

  // для тестування
  void printHabits() {
    print(" > PRINTING HABITS . . .  (length is ${_habits.length} OR ${_habitTiles.length})");
    for (int i = 0; i < _habits.length; i++) {
      print(" > ID: $i - ${_habits[i].name} - ${_habits[i].wasDone}");
    }
  }


  DateTime _currentDate = DateTime.now();
  DateTime get currentDate => _currentDate;

  void resetCurrentDate () {
    var now = DateTime.now();
    if (_currentDate != now) {
      _currentDate = now;
      notifyListeners();
    }
    // TODO: додати логіку зсуву habitSquare
  }

}
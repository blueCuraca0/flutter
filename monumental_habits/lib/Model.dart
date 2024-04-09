import 'package:flutter/material.dart';
import 'package:monumental_habits/widgets/HabitList.dart';
import 'constants/CColors.dart';
import 'entities/Habit.dart';

class Model extends ChangeNotifier {

  // HABITS

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



  // DATE

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



  // TABS (4 pages in the PageView)

  // 0 - HomePage, 1 - CoursesPage, 2 - CommunityPage, 3 - SettingsPage
  int _currentTab = 0;
  int get currentTab => _currentTab;
  PageController _pageController = PageController();
  PageController get pageController => _pageController;

  void setCurrentTab (index) {
    _currentTab = index;
    // TODO чому анімація така дивна?
    _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeIn
    );
    _pageController.jumpToPage(index);
    notifyListeners();
  }



  // PAGES

  // 0 - Introduction page, 1 - Homepage, 2 - New Habit
  int _currentPage = 0;
  int get currentPage => _currentPage;

  void setCurrentPage (index) {
    _currentPage = index;
    notifyListeners();
  }



  // LIGHT & DARK THEME
  bool _isDarkTheme = false;
  bool get isDarkTheme => _isDarkTheme;

  void setIsDarkTheme (flag) {
    _isDarkTheme = flag;
    resetMainColors();
    notifyListeners();
  }

  Color _primaryColor = Colors.white;
  Color get primaryColor => _primaryColor;

  Color _secondaryColor = CColors.darkThemePrimary;
  Color get secondaryColor => _secondaryColor;

  Color _textColor = CColors.purple;
  Color get textColor => _textColor;

  void resetMainColors () {
    if (_isDarkTheme) {
      _primaryColor = CColors.darkThemePrimary;
      _secondaryColor = Colors.white;
      _textColor = Colors.white;
    } else {
      _primaryColor = Colors.white;
      _secondaryColor = CColors.darkThemePrimary;
      _textColor = CColors.purple;
    }

    notifyListeners();
  }
}

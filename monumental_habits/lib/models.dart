import 'package:flutter/material.dart';
import 'package:monumental_habits/services/converter.dart';
import 'package:monumental_habits/user_shared_preferences.dart';
import 'constants/c_colors.dart';

// DATE
class DateNotifier extends ChangeNotifier {
  String _currentDate = Converter.datetimeToString(DateTime.now());
  String get currentDate => _currentDate;

  void resetCurrentDate() {
    String now = Converter.datetimeToString(DateTime.now());
    if (_currentDate != now) {
      _currentDate = now;
      notifyListeners();
    }
  }
}

// LIGHT & DARK THEM
class ThemeNotifier extends ChangeNotifier {
  bool _isDarkTheme = false;
  bool get isDarkTheme => _isDarkTheme;

  void setIsDarkTheme (flag) {
    _isDarkTheme = flag;
    resetMainColors();
    notifyListeners();
    UserSharedPreferences.setTheme(flag);
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
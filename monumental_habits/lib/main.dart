import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:monumental_habits/pages/HomePage.dart';
import 'package:monumental_habits/pages/IntroductionPage.dart';
import 'package:monumental_habits/widgets/HabitList.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  late final List<Widget> _pages;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  int _currentPage = 0;

  void _setCurrentPage(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  void initState() {
    super.initState();
    widget._pages = [
      IntroductionPage(_setCurrentPage),
      HomePage()
    ];
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark
      )
    );
    return MaterialApp(
        title: 'Monumental Habits',
        debugShowCheckedModeBanner: false,
        home: widget._pages[_currentPage]
    );
  }
}

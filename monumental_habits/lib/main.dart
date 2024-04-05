import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:monumental_habits/pages/HomePage.dart';
import 'package:monumental_habits/pages/IntroductionPage.dart';
import 'package:monumental_habits/pages/NewHabit.dart';
import 'Model.dart';


void main () {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  late final List<Widget> _pages;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  // 0 - Introduction page, 1 - Homepage, 2 - New Habit
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
      HomePage(_setCurrentPage),
      NewHabit(_setCurrentPage)
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
    return ChangeNotifierProvider(
      create: (context) => Model(),
      builder: (context, child) {
        return MaterialApp(
            title: 'Monumental Habits',
            debugShowCheckedModeBanner: false,
            home: widget._pages[_currentPage]
        );
      },
    );
  }
}

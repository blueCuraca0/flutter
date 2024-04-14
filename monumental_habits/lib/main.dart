import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:monumental_habits/pages/MainScreen.dart';
import 'package:monumental_habits/pages/IntroductionScreen.dart';
import 'package:monumental_habits/pages/NewHabitScreen.dart';
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

  @override
  void initState() {
    super.initState();
    widget._pages = [
      IntroductionScreen(),
      MainScreen(),
      NewHabitScreen()
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
            home: Pages(widget._pages)
        );
      },
    );
  }
}

class Pages extends StatelessWidget {
  final List<Widget> _pages;
  const Pages(this._pages, {super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Model>(
      builder: (context, model, child) {
        return _pages[model.currentPage];
      },
    );
  }
}


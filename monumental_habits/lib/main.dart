import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:monumental_habits/UserSharedPreferences.dart';
import 'package:provider/provider.dart';

import 'package:monumental_habits/screens/MainScreen.dart';
import 'package:monumental_habits/screens/IntroductionScreen.dart';
import 'package:monumental_habits/screens/NewHabitScreen.dart';
import 'Model.dart';


void main () async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserSharedPreferences.init();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  late final List<Widget> _screens;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    widget._screens = [
      const IntroductionScreen(),
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HabitNotifier(),),
        ChangeNotifierProvider(create: (context) => DateNotifier(),),
        ChangeNotifierProvider(create: (context) => ScreenNotifier(),),
        ChangeNotifierProvider(create: (context) => TabNotifier(),),
        ChangeNotifierProvider(create: (context) => ThemeNotifier(),),
      ],
      builder: (context, child) {
        Provider.of<ThemeNotifier>(context, listen: false)
            .setIsDarkTheme(UserSharedPreferences.getTheme());
        // якщо це перший раз в нашому застосунку, то юзера направить на ознайомчий екран
        Provider.of<ScreenNotifier>(context, listen: false)
            .setCurrentPage(UserSharedPreferences.getFirstTime() ? 0 : 1);
        UserSharedPreferences.setFirstTime(false);
        return MaterialApp(
            title: 'Monumental Habits',
            debugShowCheckedModeBanner: false,
            home: Screens(widget._screens)
        );
      },
    );
  }
}

class Screens extends StatelessWidget {
  final List<Widget> _screens;
  const Screens(this._screens, {super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ScreenNotifier>(
      builder: (context, model, child) {
        return _screens[model.currentPage];
      },
    );
  }
}


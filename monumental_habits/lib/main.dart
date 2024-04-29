import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:monumental_habits/constants/c_routes.dart';
import 'package:monumental_habits/firebase_options.dart';
import 'package:monumental_habits/user_shared_preferences.dart';
import 'package:provider/provider.dart';

import 'package:monumental_habits/screens/main_screen.dart';
import 'package:monumental_habits/screens/introduction_screen.dart';
import 'package:monumental_habits/screens/new_habit_screen.dart';
import 'models.dart';


void main () async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserSharedPreferences.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform) ;

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late String initialRoute;

  @override
  void initState() {
    super.initState();
    initialRoute = UserSharedPreferences.getFirstTime()
        ? CRoutes.routeIntroductionPage
        : CRoutes.routeMainPage;
    UserSharedPreferences.setFirstTime(false);
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
        ChangeNotifierProvider(create: (context) => DateNotifier(),),
        ChangeNotifierProvider(create: (context) => ThemeNotifier()
          ..setIsDarkTheme(UserSharedPreferences.getTheme())),
      ],
      builder: (context, child) {
        return MaterialApp(
          title: 'Monumental Habits',
          debugShowCheckedModeBanner: false,
          initialRoute: initialRoute,
          routes: {
            CRoutes.routeIntroductionPage: (context) => const IntroductionScreen(),
            CRoutes.routeMainPage: (context) => MainScreen(),
            CRoutes.routeNewHabit: (context) => NewHabitScreen()
          },
        );
      },
    );
  }
}
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../constants/c_routes.dart';
import '../models.dart';
import '../constants/c_colors.dart';
import '../constants/c_strings.dart';
import '../widgets/bottom_nav_bar.dart';
import '../tabs/home_page.dart';
import '../tabs/community_page.dart';
import '../tabs/courses_page.dart';
import '../tabs/settings_page.dart';

class MainScreen extends StatelessWidget {
  final _navigatorKey = GlobalKey<NavigatorState>();
  int currentPageIndex = 0;
  List<String> routes = [
    CRoutes.routeHomePage,
    CRoutes.routeCourses,
    CRoutes.routeCommunity,
    CRoutes.routeSettings,
  ];

  MainScreen({super.key});

  Route _onGenerateRoute (RouteSettings settings) {
    late Widget page;

    switch (settings.name) {
      case CRoutes.routeHomePage:
        page = HomePage();
      case CRoutes.routeCourses:
        page = const CoursesPage();
      case CRoutes.routeCommunity:
        page = const CommunityPage();
      case CRoutes.routeSettings:
        page = const SettingsPage();
      default:
        print(" U N K N O W N   R O U T E");
        page = const Placeholder();
    }

    return MaterialPageRoute<dynamic>(
      builder: (context) => page,
      settings: settings,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Consumer<ThemeNotifier>(
              builder: (context, theme, child) {
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      "lib/images/Homepage.png",
                      fit: BoxFit.fitWidth,
                    ),
                    Container(
                      color: Colors.black.withOpacity(theme.isDarkTheme ? 0.5 : 0),
                    )
                  ]
                );
              },
            ),
          ),

          Navigator(
            key: _navigatorKey,
            initialRoute: CRoutes.routeHomePage,
            onGenerateRoute: _onGenerateRoute,
          ),

          Column(
            children: [
              const Expanded(child: SizedBox()),
              BottomNavBar(
                _navigatorKey,
                () {
                  Navigator.pushNamed(context, CRoutes.routeNewHabit);
                },
                const Icon(
                  Icons.add_rounded,
                  size: 35,
                  color: CColors.purple,
                )
              )
            ],
          )
        ],
      ),
    );
  }
}
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../constants/c_routes.dart';
import '../entities/habit.dart';
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
        page = const HomePage();
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
                    children: [
                      Image.asset(
                        "lib/images/Homepage.png",
                        fit: BoxFit.cover,
                      ),
                      Container(
                        color: Colors.black.withOpacity(theme.isDarkTheme ? 0.5 : 0),
                      )
                    ]
                );
              },
            ),
          ),

          GestureDetector(
            // onHorizontalDragEnd: (DragEndDetails dragEndDetails) {
            //   print(" s w i p e   right");
            // },
            // onHorizontalDragStart: (DragStartDetails dragStartDetails) {
            //   print(" s w i p e   left");
            // },
            child: Navigator(
              key: _navigatorKey,
              initialRoute: CRoutes.routeHomePage,
              onGenerateRoute: _onGenerateRoute,
            ),
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

class InspiringQuote extends StatelessWidget {
  const InspiringQuote({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          color: Colors.white,
          height: 130,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                    bottom: 20,
                    left: 15,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        CStrings.inspiringQuotes[
                        Random().nextInt(CStrings.inspiringQuotes.length)],
                        style: const TextStyle(
                          color: CColors.purple,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        CStrings.quoteAuthor,
                        style: TextStyle(
                            color: CColors.purple.withOpacity(0.5),
                            fontWeight: FontWeight.w500,
                            fontSize: 12),
                      )
                    ],
                  ),
                ),
              ),
              Image.asset("lib/images/Quote girl.png")
            ],
          ),
        ),
      ),
    );
  }
}

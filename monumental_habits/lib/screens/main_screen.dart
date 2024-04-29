import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../constants/c_routes.dart';
import '../models.dart';
import '../constants/c_colors.dart';
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
        page = const Placeholder();
    }

    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: PopScope(
        canPop: false,
        child: Stack(
          children: [
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
      ),
    );
  }
}
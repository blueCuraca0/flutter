import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../Model.dart';
import '../constants/CColors.dart';
import '../constants/CStrings.dart';
import '../widgets/BottomNavBar.dart';
import '../tabs/HomePage.dart';
import '../tabs/CommunityPage.dart';
import '../tabs/CoursesPage.dart';
import '../tabs/SettingsPage.dart';

class MainScreen extends StatefulWidget {
  late List<Widget> _tabs;

  MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final controller = PageController(initialPage: 0);

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    widget._tabs = [
      HomePage(),
      CoursesPage(),
      CommunityPage(),
      SettingsPage()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

          Consumer<TabNotifier>(
            builder: (context, tabModel, child) {
              return PageView(
                controller: tabModel.pageController,
                onPageChanged: (tab) {
                  tabModel.setCurrentTab(tab);
                },
                children: widget._tabs,
              );
            },
          ),

          Column(
            children: [
              const Expanded(child: SizedBox()),
              Consumer<ScreenNotifier>(
                builder: (context, screen, child) {
                  return BottomNavBar(
                    () { screen.setCurrentPage(2); },
                    const Icon(
                      Icons.add_rounded,
                      size: 35,
                      color: CColors.purple,
                    )
                  );
                },
              ),
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
